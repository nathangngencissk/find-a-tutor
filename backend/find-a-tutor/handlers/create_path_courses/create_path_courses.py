import json
import os

from utils.database import Database
from utils import DateTimeEncoder
from models.path_course.PathCourse import PathCourse

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    courses = json.loads(event["arguments"]["courses"])

    created_path_courses = []

    for course in courses:

        created_path_course = PathCourse(**course)

        db.add(created_path_course)

        created_path_course.__dict__.pop("_sa_instance_state")

        created_path_courses.append(created_path_course.__dict__)

    response = json.dumps(created_path_courses, cls=DateTimeEncoder)

    return response
