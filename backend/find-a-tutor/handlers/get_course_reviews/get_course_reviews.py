import json
import os

import boto3

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]
USER_POOL_ID = os.environ["USER_POOL_ID"]

db = Database(conn_string=CONN_STRING)

cognito_idp = boto3.client("cognito-idp", region_name="us-east-1")


def handle(event, context):

    with open("get_course_reviews.sql", "r") as f:
        query = f.read()

    arguments = {"course_id": event["arguments"]["id"]}

    results = db.query(query=query, arguments=arguments)

    reviews = []

    for result in results:
        review = dict(result)
        response_user = cognito_idp.admin_get_user(
            UserPoolId=USER_POOL_ID, Username=review["user_id"]
        )

        user = {}

        for attribute in response_user["UserAttributes"]:
            user[attribute["Name"]] = attribute["Value"]

        review["reviewer_name"] = f'{user["name"]} {user["family_name"]}'
        review["reviewer_picture"] = user["picture"]
        review["reviewer_username"] = response_user["Username"]

        reviews.append(review)

    response = json.dumps(reviews, cls=DateTimeEncoder)

    return response
