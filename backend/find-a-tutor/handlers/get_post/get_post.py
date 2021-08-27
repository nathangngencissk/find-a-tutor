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

    with open("get_post.sql", "r") as f:
        query = f.read()

    arguments = {"post_id": event["arguments"]["id"]}

    result_post = db.query(query=query, arguments=arguments)

    with open("get_post_comments.sql", "r") as f:
        query = f.read()

    arguments = {
        "user_id": event["arguments"]["user_id"],
        "post_id": event["arguments"]["id"],
    }

    post_comments = db.query(query=query, arguments=arguments)

    for comment in post_comments:
        response_user = cognito_idp.admin_get_user(
            UserPoolId=USER_POOL_ID, Username=comment["user_id"]
        )

        user = {
            "username": response_user["Username"],
            "created_at": response_user["UserCreateDate"].strftime("%d/%m/%Y"),
            "updated_at": response_user["UserLastModifiedDate"].strftime("%d/%m/%Y"),
        }

        for attribute in response_user["UserAttributes"]:
            user[attribute["Name"]] = attribute["Value"]

        comment["creator_name"] = f'{user["name"]} {user["family_name"]}'
        comment["creator_picture"] = user["picture"]

    post = dict(result_post[0])

    post["comments"] = post_comments

    response_user = cognito_idp.admin_get_user(
        UserPoolId=USER_POOL_ID, Username=post["creator_id"]
    )

    user = {
        "username": response_user["Username"],
        "created_at": response_user["UserCreateDate"].strftime("%d/%m/%Y"),
        "updated_at": response_user["UserLastModifiedDate"].strftime("%d/%m/%Y"),
    }

    for attribute in response_user["UserAttributes"]:
        user[attribute["Name"]] = attribute["Value"]

    post["owner_name"] = f'{user["name"]} {user["family_name"]}'
    post["owner_picture"] = user["picture"]

    response = json.dumps(post, cls=DateTimeEncoder)

    return response
