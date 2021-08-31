import json
import os
from datetime import datetime

from utils.database import Database
from utils import DateTimeEncoder
from models.path.Path import Path

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    now = datetime.now()

    arguments = {
        "name": event["arguments"]["name"],
        "description": event["arguments"]["description"],
        "image": event["arguments"]["image"],
        "creator_id": event["arguments"]["creator_id"],
        "created_at": now.strftime("%Y-%m-%d %H:%M:%S"),
        "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
    }

    path = Path(**arguments)

    db.add(path)

    path.__dict__.pop("_sa_instance_state")

    response = json.dumps(path.__dict__, cls=DateTimeEncoder)

    return response
