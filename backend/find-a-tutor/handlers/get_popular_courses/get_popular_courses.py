import json
import os

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]


def handle(event, context):

    with open("get_popular_courses.sql", "r") as f:
        query = f.read()

    db = Database(conn_string=CONN_STRING)
    popular_courses = db.query(query=query)

    response = json.dumps(popular_courses, cls=DateTimeEncoder)

    return response
