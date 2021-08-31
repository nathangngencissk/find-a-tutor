import json
import os

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_tutor_paths.sql", "r") as f:
        query = f.read()

    arguments = {"user_id": event["arguments"]["user_id"]}
    results = db.query(query=query, arguments=arguments)

    with open("get_path_courses.sql", "r") as f:
        query = f.read()

    paths = []

    for result in results:
        path = dict(result)
        arguments = {"path_id": path["id"]}
        courses = db.query(query=query, arguments=arguments)
        path["courses"] = courses
        paths.append(path)

    response = json.dumps(paths, cls=DateTimeEncoder)

    return response
