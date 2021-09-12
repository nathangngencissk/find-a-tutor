import json
import os
from datetime import datetime
from math import ceil

from utils.database import Database
from utils import DateTimeEncoder
from models.payout.Payout import Payout

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_payments.sql", "r") as f:
        query_payments = f.read()

    with open("get_payouts.sql", "r") as f:
        query_payouts = f.read()

    arguments = {"user_id": event["arguments"]["user_id"]}

    result_payments = db.query(query=query_payments, arguments=arguments)
    result_payouts = db.query(query=query_payouts, arguments=arguments)

    balance = 0.0

    for payment in result_payments:
        balance += ceil(float(payment["price"]) * 0.66)

    for payout in result_payouts:
        balance -= float(payout["value"])

    if balance < float(event["arguments"]["value"]):
        return None

    now = datetime.now()

    arguments = {
        "status": "EM ANDAMENTO",
        "value": event["arguments"]["value"],
        "user_id": event["arguments"]["user_id"],
        "created_at": now.strftime("%Y-%m-%d %H:%M:%S"),
        "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
    }

    payout = Payout(**arguments)

    db.add(payout)

    payout.__dict__.pop("_sa_instance_state")

    response = json.dumps(payout.__dict__, cls=DateTimeEncoder)

    return response
