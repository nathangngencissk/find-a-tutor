import json
import os

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_others_are_studying.sql", "r") as f:
        query = f.read()

    others_are_studying = db.query(query=query)

    response = json.dumps(others_are_studying, cls=DateTimeEncoder)

    return response
