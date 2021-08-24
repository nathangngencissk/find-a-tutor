import json
import os

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_main_course_categories.sql", "r") as f:
        query = f.read()

    result = db.query(query=query)

    response = json.dumps(result, cls=DateTimeEncoder)

    return response
