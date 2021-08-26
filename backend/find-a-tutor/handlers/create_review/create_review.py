import json
import os

from utils.database import Database
from utils import DateTimeEncoder
from models.review.Review import Review

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    arguments = {
        "rating": event["arguments"]["rating"],
        "content": event["arguments"]["content"],
        "user_id": event["arguments"]["user_id"],
        "course_id": event["arguments"]["course_id"],
        "created_at": event["arguments"]["created_at"],
        "updated_at": event["arguments"]["updated_at"],
    }

    review = Review(**arguments)

    db.add(review)

    review.__dict__.pop("_sa_instance_state")

    response = json.dumps(review.__dict__, cls=DateTimeEncoder)

    return response
