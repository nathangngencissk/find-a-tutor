import json
import os

from utils.database import Database
from utils import DateTimeEncoder
from models.course_category.CourseCategory import CourseCategory

CONN_STRING = os.environ["CONN_STRING"]


def handle(event, context):

    db = Database(conn_string=CONN_STRING)
    courses_categories = db.get_all(CourseCategory, as_dict=True)

    response = json.dumps(courses_categories, cls=DateTimeEncoder)

    return response
