import json
import os

import boto3
from cron_descriptor import get_description, Options

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

options = Options()
options.locale_code = "pt_PT"

db = Database(conn_string=CONN_STRING)

cognito_idp = boto3.client("cognito-idp", region_name="us-east-1")


def handle(event, context):

    response_user = cognito_idp.admin_get_user(
        UserPoolId="us-east-1_bJZNUFkda", Username=event["arguments"]["user_id"]
    )

    user = {
        "username": response_user["Username"],
        "created_at": response_user["UserCreateDate"].strftime("%d/%m/%Y"),
        "updated_at": response_user["UserLastModifiedDate"].strftime("%d/%m/%Y"),
    }

    for attribute in response_user["Username"]["UserAttributes"]:
        user[attribute["Name"]] = attribute["Value"]

    with open("get_course.sql", "r") as f:
        query = f.read()

    arguments = {"course_id": event["arguments"]["id"], "user_id": user["username"]}

    result = db.query(query=query, arguments=arguments)

    course = dict(result[0])
    course_classes = []
    for c in course["classes"].split("|"):
        start_date, schedule = c.split(" - ")
        course_classes.append(
            {
                "start_date": start_date,
                "schedule": get_description(schedule, options=options),
            }
        )

    course["classes"] = course_classes
    course["owner_name"] = f'{user["name"]} {user["family_name"]}'

    response = json.dumps(course, cls=DateTimeEncoder)

    return response
