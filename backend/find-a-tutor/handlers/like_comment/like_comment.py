import json
import os
from datetime import datetime

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("like_comment.sql", "r") as f:
        query = f.read()

    now = datetime.now()

    arguments = {
        "user_id": event["arguments"]["user_id"],
        "post_comment_id": event["arguments"]["post_comment_id"],
        "value": event["arguments"]["value"],
        "created_at": now.strftime("%Y-%m-%d %H:%M:%S"),
        "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
    }

    result = db.query(query=query, arguments=arguments)

    response = json.dumps(result, cls=DateTimeEncoder)

    return response
