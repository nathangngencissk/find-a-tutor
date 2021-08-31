import json
import os

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_tutor_course_classes.sql", "r") as f:
        query = f.read()

    arguments = {"user_id": event["arguments"]["user_id"]}
    results = db.query(query=query, arguments=arguments)

    with open("get_class_posts.sql", "r") as f:
        query = f.read()

    course_classes = []

    for result in results:
        course_class = dict(result)
        arguments = {"course_class_id": result["id"]}
        posts = db.query(query=query, arguments=arguments)
        course_class["posts"] = posts
        course_classes.append(course_class)

    response = json.dumps(course_classes, cls=DateTimeEncoder)

    return response
