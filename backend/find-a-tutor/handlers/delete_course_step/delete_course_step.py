import json
import os

from utils.database import Database
from models.step.Step import Step

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    deleted_step = Step(id=event["arguments"]["step_id"])

    db.delete(deleted_step)

    response = "course step deleted successfully."

    return response
