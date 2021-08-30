import json
import os

from utils.database import Database
from utils import DateTimeEncoder
from models.bank_account.BankAccount import BankAccount

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    arguments = {
        "id": event["arguments"]["id"],
        "bank_code": event["arguments"]["bank_code"],
        "bank_name": event["arguments"]["bank_name"],
        "account_type": event["arguments"]["account_type"],
        "agencia": event["arguments"]["agencia"],
        "conta": event["arguments"]["conta"],
        "favorite": event["arguments"]["favorite"],
        "user_id": event["arguments"]["user_id"],
        "created_at": event["arguments"]["created_at"],
        "updated_at": event["arguments"]["updated_at"],
    }

    account = BankAccount(**arguments)

    db.update(account)

    account.__dict__.pop("_sa_instance_state")

    response = json.dumps(account.__dict__, cls=DateTimeEncoder)

    return response
