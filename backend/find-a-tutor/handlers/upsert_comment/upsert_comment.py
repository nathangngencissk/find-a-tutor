import json
import os
from datetime import datetime

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("upsert_comment.sql", "r") as f:
        query = f.read()

    now = datetime.now()

    arguments = {
        "parent_comment_id": event["arguments"]["parent_comment_id"],
        "post_id": event["arguments"]["post_id"],
        "content": event["arguments"]["content"],
        "user_id": event["arguments"]["user_id"],
        "id": event["arguments"]["id"],
        "created_at": now.strftime("%Y-%m-%d %H:%M:%S"),
        "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
    }

    result = db.query(query=query, arguments=arguments)

    response = json.dumps(result, cls=DateTimeEncoder)

    return response
