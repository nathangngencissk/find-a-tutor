import json
import os
from datetime import datetime

from utils.database import Database
from utils import DateTimeEncoder
from models.exercise_list.ExerciseList import ExerciseList

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    now = datetime.now()

    arguments = {
        "id": event["arguments"]["id"],
        "creator_id": event["arguments"]["creator_id"],
        "title": event["arguments"]["title"],
        "tags": event["arguments"]["tags"],
        "status": event["arguments"]["status"],
        "description": event["arguments"]["description"],
        "created_at": event["arguments"]["created_at"],
        "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
    }

    ex = ExerciseList(**arguments)

    db.update(ex)

    ex.__dict__.pop("_sa_instance_state")

    response = json.dumps(ex.__dict__, cls=DateTimeEncoder)

    return response
