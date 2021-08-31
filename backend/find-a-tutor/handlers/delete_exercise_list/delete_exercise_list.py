import json
import os

from utils.database import Database
from models.exercise_list.ExerciseList import ExerciseList

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    deleted_el = ExerciseList(id=event["arguments"]["id"])

    db.delete(deleted_el)

    response = "exercise list deleted successfully."

    return response
