import json
import os

from utils.database import Database
from utils import DateTimeEncoder
from models.bank_account.BankAccount import BankAccount

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    id = event["arguments"]["id"]

    account = BankAccount(id=id)

    db.delete(account)

    message = f"{id} deleted successfully."

    response = json.dumps(message, cls=DateTimeEncoder)

    return response
