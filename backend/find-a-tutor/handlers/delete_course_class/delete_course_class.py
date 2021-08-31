import json
import os

from utils.database import Database
from models.course_class.CourseClass import CourseClass

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    deleted_cc = CourseClass(id=event["arguments"]["id"])

    db.delete(deleted_cc)

    response = "course class deleted successfully."

    return response
