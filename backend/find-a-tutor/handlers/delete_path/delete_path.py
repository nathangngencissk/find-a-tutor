import os

from utils.database import Database
from models.path.Path import Path

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    deleted_path = Path(id=event["arguments"]["id"])

    db.delete(deleted_path)

    response = "path deleted successfully."

    return response
