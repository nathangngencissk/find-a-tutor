import json
import os
from datetime import datetime

from utils.database import Database
from utils import DateTimeEncoder
from models.payout.Payout import Payout

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    now = datetime.now()

    arguments = {
        "id": event["arguments"]["id"],
        "status": "COMPLETO",
        "value": event["arguments"]["value"],
        "user_id": event["arguments"]["user_id"],
        "created_at": now.strftime("%Y-%m-%d %H:%M:%S"),
        "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
    }

    payout = Payout(**arguments)

    db.update(payout)

    payout.__dict__.pop("_sa_instance_state")

    response = json.dumps(payout.__dict__, cls=DateTimeEncoder)

    return response
