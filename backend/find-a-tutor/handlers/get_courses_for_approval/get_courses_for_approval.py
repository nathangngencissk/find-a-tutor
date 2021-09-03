import json
import os

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_courses_for_approval.sql", "r") as f:
        query = f.read()

    results = db.query(query=query)

    courses = []

    for result in results:
        course = dict(result)

        with open("get_course_steps.sql", "r") as f:
            query = f.read()

        course_steps = db.query(query=query, arguments={"course_id": course["id"]})

        course["steps"] = course_steps

        courses.append(course)

    response = json.dumps(courses, cls=DateTimeEncoder)

    return response
