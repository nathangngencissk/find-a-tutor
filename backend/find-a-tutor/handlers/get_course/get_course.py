import json
import os

from cron_descriptor import get_description, Options

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

options = Options()
options.locale_code = "pt_PT"

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_course.sql", "r") as f:
        query = f.read()

    arguments = {"course_id": event["arguments"]["id"]}

    result = db.query(query=query, arguments=arguments)

    course = dict(result[0])
    course_classes = []
    for c in course["classes"].split("|"):
        start_date, schedule = c.split(" - ")
        course_classes.append(
            {
                "start_date": start_date,
                "schedule": get_description(schedule, options=options),
            }
        )

    course["classes"] = course_classes

    response = json.dumps(course, cls=DateTimeEncoder)

    return response
