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

    with open("get_popular_courses.sql", "r") as f:
        query = f.read()

    popular_courses = db.query(query=query)

    results = []

    for course in popular_courses:
        course = dict(course)
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
        results.append(course)

    response = json.dumps(results, cls=DateTimeEncoder)

    return response
