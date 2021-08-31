import json
import os

from utils.database import Database
from models.course_class_post.CourseClassPost import CourseClassPost

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    posts = json.loads(event["arguments"]["posts"])

    for post in posts:

        deleted_post = CourseClassPost(id=post["id"])

        db.delete(deleted_post)

    response = "course class posts deleted successfully."

    return response
