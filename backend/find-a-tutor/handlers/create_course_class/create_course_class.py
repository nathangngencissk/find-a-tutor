import json
import os
from datetime import datetime

from utils.database import Database
from utils import DateTimeEncoder
from models.course_class.CourseClass import CourseClass

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    now = datetime.now()

    arguments = {
        "name": event["arguments"]["name"],
        "description": event["arguments"]["description"],
        "image": event["arguments"]["image"],
        "start_date": event["arguments"]["start_date"],
        "end_date": event["arguments"]["end_date"],
        "schedule": event["arguments"]["schedule"],
        "how_to_access": event["arguments"]["how_to_access"],
        "course_id": event["arguments"]["course_id"],
        "duration": event["arguments"]["duration"],
        "created_at": now.strftime("%Y-%m-%d %H:%M:%S"),
        "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
    }

    cc = CourseClass(**arguments)

    db.add(cc)

    cc.__dict__.pop("_sa_instance_state")

    response = json.dumps(cc.__dict__, cls=DateTimeEncoder)

    return response
