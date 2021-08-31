import os

from utils.database import Database
from models.exercise.Exercise import Exercise

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    deleted_ex = Exercise(id=event["arguments"]["id"])

    db.delete(deleted_ex)

    response = "exercise deleted successfully."

    return response
