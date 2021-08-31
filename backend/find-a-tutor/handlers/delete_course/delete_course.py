import os

from utils.database import Database
from models.course.Course import Course

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    course = Course(id=event["arguments"]["course_id"])

    db.delete(course)

    response = "course deleted successfully."

    return response
