import json
import os

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_courses.sql", "r") as f:
        query = f.read()

    arguments = {"user_id": event["arguments"]["user_id"]}
    results = db.query(query=query, arguments=arguments)

    with open("get_course_steps.sql", "r") as f:
        query = f.read()

    courses = []

    for result in results:
        course = dict(result)
        arguments = {"course_id": course["id"]}
        steps = db.query(query=query, arguments=arguments)
        course["steps"] = steps
        courses.append(course)

    response = json.dumps(courses, cls=DateTimeEncoder)

    return response
