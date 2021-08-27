import json
import os
from datetime import datetime

from utils.database import Database
from utils import DateTimeEncoder
from models.forum_post_comment.ForumPostComment import ForumPostComment

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    now = datetime.now()

    arguments = {
        "content": event["arguments"]["content"],
        "user_id": event["arguments"]["user_id"],
        "post_id": event["arguments"]["post_id"],
        "created_at": now.strftime("%Y-%m-%d %H:%M:%S"),
        "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
    }

    fpc = ForumPostComment(**arguments)

    db.add(fpc)

    fpc.__dict__.pop("_sa_instance_state")

    response = json.dumps(fpc.__dict__, cls=DateTimeEncoder)

    return response
