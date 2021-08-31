import json
import os

from utils.database import Database
from models.step.Step import Step

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    steps = json.loads(event["arguments"]["steps"])

    for step in steps:

        deleted_step = Step(id=step["id"])

        db.delete(deleted_step)

    response = "course steps deleted successfully."

    return response
