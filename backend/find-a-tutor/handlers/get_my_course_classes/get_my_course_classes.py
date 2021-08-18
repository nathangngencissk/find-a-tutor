import json
import os
from datetime import datetime, timedelta

from croniter import croniter_range

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_my_course_classes.sql", "r") as f:
        query = f.read()

    arguments = {"user_id": event["arguments"]["id"]}

    my_course_classes = db.query(query=query, arguments=arguments)

    now = datetime.now()
    start = now - timedelta(days=now.weekday())
    end = start + timedelta(days=6)

    with open("get_my_course_classes.sql", "r") as f:
        query = f.read()

    arguments = {"user_id": event["arguments"]["id"]}

    my_course_classes = db.query(query=query, arguments=arguments)

    ongoing_classes = [cc for cc in my_course_classes if cc["status"] == "ONGOING"]

    history = [cc for cc in my_course_classes if cc not in ongoing_classes]

    current_week_classes = []

    for course_class in ongoing_classes:
        schedule = course_class["schedule"]
        for dt in croniter_range(start, end, schedule):
            current_week_classes.append(
                {
                    "class_name": course_class["name"],
                    "class_start": dt.strftime("%Y-%m-%d %H:%M:%S"),
                    "class_end": (
                        dt + timedelta(hours=course_class["duration"])
                    ).strftime("%Y-%m-%d %H:%M:%S"),
                }
            )

    result = {
        "ongoing_classes": ongoing_classes,
        "history": history,
        "current_week_classes": current_week_classes,
    }

    response = json.dumps(result, cls=DateTimeEncoder)

    return response
