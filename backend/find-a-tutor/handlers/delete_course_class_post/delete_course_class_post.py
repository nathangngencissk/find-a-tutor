import os

from utils.database import Database
from models.course_class_post.CourseClassPost import CourseClassPost

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    deleted_post = CourseClassPost(id=event["arguments"]["id"])

    db.delete(deleted_post)

    response = "course class post deleted successfully."

    return response
