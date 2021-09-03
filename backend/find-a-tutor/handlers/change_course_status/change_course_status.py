import json
import os
from datetime import datetime

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("change_course_status.sql", "r") as f:
        query = f.read()

    now = datetime.now()

    arguments = {
        "id": event["arguments"]["id"],
        "status": event["arguments"]["status"],
        "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
    }

    result = db.query(query=query, arguments=arguments)

    response = json.dumps(result, cls=DateTimeEncoder)

    return response
