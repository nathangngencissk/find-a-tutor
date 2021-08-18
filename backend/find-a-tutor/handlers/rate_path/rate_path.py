import json
import os
from datetime import datetime

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("rate_path.sql", "r") as f:
        query = f.read()

    now = datetime.now()

    arguments = {
        "user_id": event["arguments"]["user_id"],
        "path_id": event["arguments"]["path_id"],
        "rating": event["arguments"]["rating"],
        "created_at": now.strftime("%Y-%m-%d %H:%M:%S"),
        "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
    }

    result = db.query(query=query, arguments=arguments)

    response = json.dumps(result, cls=DateTimeEncoder)

    return response
