import json
import os

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_popular_courses.sql", "r") as f:
        query = f.read()

    popular_courses = db.query(query=query)

    results = []

    for course in popular_courses:
        course = dict(course)

        arguments = {"id": course["id"]}

        with open("get_course_classes.sql", "r") as f:
            query_classes = f.read()

        course_classes = db.query(query=query_classes, arguments=arguments)

        course["classes"] = course_classes

        results.append(course)

    response = json.dumps(results, cls=DateTimeEncoder)

    return response
