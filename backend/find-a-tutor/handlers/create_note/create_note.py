import json
import os

from utils.database import Database
from utils import DateTimeEncoder
from models.note.Note import Note

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    arguments = {
        "id": event["arguments"]["id"],
        "title": event["arguments"]["title"],
        "content": event["arguments"]["content"],
        "fixed": event["arguments"]["fixed"],
        "user_id": event["arguments"]["user_id"],
        "course_id": event["arguments"]["course_id"],
        "created_at": event["arguments"]["created_at"],
        "updated_at": event["arguments"]["updated_at"],
    }

    note = Note(**arguments)

    db.add(note)

    note.__dict__.pop("_sa_instance_state")

    response = json.dumps(note.__dict__, cls=DateTimeEncoder)

    return response
