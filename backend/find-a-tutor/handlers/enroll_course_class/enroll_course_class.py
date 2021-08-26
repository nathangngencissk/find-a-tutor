import json
import os

from utils.database import Database
from utils import DateTimeEncoder
from models.course_class_user.CourseClassUser import CourseClassUser

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    arguments = {
        "course_class_id": event["arguments"]["course_class_id"],
        "user_id": event["arguments"]["user_id"],
        "status": "ONGOING",
        "created_at": event["arguments"]["created_at"],
        "updated_at": event["arguments"]["updated_at"],
    }

    ccu = CourseClassUser(**arguments)

    db.add(ccu)

    ccu.__dict__.pop("_sa_instance_state")

    response = json.dumps(ccu.__dict__, cls=DateTimeEncoder)

    return response
