import json
import os
from datetime import datetime

from utils.database import Database
from utils import DateTimeEncoder
from models.course.Course import Course

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    now = datetime.now()

    arguments = {
        "id": event["arguments"]["id"],
        "name": event["arguments"]["name"],
        "description": event["arguments"]["description"],
        "short_description": event["arguments"]["short_description"],
        "image": event["arguments"]["image"],
        "price": event["arguments"]["price"],
        "status": "EM AVALIAÇÃO",
        "category_id": event["arguments"]["category_id"],
        "owner_id": event["arguments"]["owner_id"],
        "created_at": event["arguments"]["created_at"],
        "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
    }

    course = Course(**arguments)

    db.update(course)

    course.__dict__.pop("_sa_instance_state")

    response = json.dumps(course.__dict__, cls=DateTimeEncoder)

    return response
