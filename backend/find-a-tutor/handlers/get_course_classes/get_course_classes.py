import json
import os
from datetime import datetime, timedelta

from croniter import croniter_range

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_course_classes.sql", "r") as f:
        query = f.read()

    arguments = {
        "course_id": event["arguments"]["course_id"],
        "user_id": event["arguments"]["user_id"],
    }

    result = db.query(query=query, arguments=arguments)

    response = json.dumps(result, cls=DateTimeEncoder)

    return response
