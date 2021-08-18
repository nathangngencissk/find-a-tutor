import json
import os

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_my_saved_paths.sql", "r") as f:
        query = f.read()

    arguments = {"user_id": event["arguments"]["id"]}

    result = db.query(query=query, arguments=arguments)

    response = json.dumps(result, cls=DateTimeEncoder)

    return response
