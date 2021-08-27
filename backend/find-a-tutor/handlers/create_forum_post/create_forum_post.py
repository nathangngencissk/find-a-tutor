import json
import os
from datetime import datetime

from utils.database import Database
from utils import DateTimeEncoder
from models.forum_post.ForumPost import ForumPost

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    now = datetime.now()

    arguments = {
        "title": event["arguments"]["title"],
        "description": event["arguments"]["description"],
        "category_id": event["arguments"]["category_id"],
        "creator_id": event["arguments"]["creator_id"],
        "created_at": now.strftime("%Y-%m-%d %H:%M:%S"),
        "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
    }

    post = ForumPost(**arguments)

    db.add(post)

    post.__dict__.pop("_sa_instance_state")

    response = json.dumps(post.__dict__, cls=DateTimeEncoder)

    return response
