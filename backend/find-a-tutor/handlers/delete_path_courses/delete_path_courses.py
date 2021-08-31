import json
import os

from utils.database import Database
from models.path_course.PathCourse import PathCourse

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    courses = json.loads(event["arguments"]["courses"])

    for course in courses:

        deleted_course = PathCourse(id=course["id"])

        db.delete(deleted_course)

    response = "path courses deleted successfully."

    return response
