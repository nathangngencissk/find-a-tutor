import json
import os

from utils.database import Database
from utils import DateTimeEncoder
from models.course_class_post.CourseClassPost import CourseClassPost

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    posts = json.loads(event["arguments"]["posts"])

    updated_posts = []

    for post in posts:

        updated_post = CourseClassPost(**post)

        db.update(updated_posts)

        updated_post.__dict__.pop("_sa_instance_state")

        updated_posts.append(updated_post.__dict__)

    response = json.dumps(updated_posts, cls=DateTimeEncoder)

    return response
