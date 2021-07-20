import json

from utils.database import Database
from models.course import Course


def handle(event, context):
    db = Database()
    courses = db.get_all(Course, as_dict=True)

    response = {
        'statusCode': 200,
        'body': json.dumps(courses),
    }

    return response