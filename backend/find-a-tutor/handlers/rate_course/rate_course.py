import json
import os
from datetime import datetime

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("rate_course.sql", "r") as f:
        query = f.read()

    now = datetime.now()

    arguments = {
        "user_id": event["arguments"]["user_id"],
        "course_id": event["arguments"]["course_id"],
        "rating": event["arguments"]["rating"],
        "content": event["arguments"]["content"],
        "created_at": event["arguments"]["created_at"],
        "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
    }

    result = db.query(query=query, arguments=arguments)

    response = json.dumps(result, cls=DateTimeEncoder)

    return response
