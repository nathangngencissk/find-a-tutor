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

    with open("get_forum_posts.sql", "r") as f:
        query = f.read()

    posts = db.query(query=query)

    for post in posts:
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

        post["creator_name"] = f'{user["name"]} {user["family_name"]}'
        post["creator_picture"] = user["picture"]
        post["username"] = user["username"]

        if len(post["description"]) > 200:
            post["short_description"] = f'{post["description"][0:200]}...'
        else:
            post["short_description"] = post["description"]

    response = json.dumps(posts, cls=DateTimeEncoder)

    return response
