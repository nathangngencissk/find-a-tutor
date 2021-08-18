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

    with open("get_path.sql", "r") as f:
        query = f.read()

    arguments = {"path_id": event["arguments"]["id"]}

    result = db.query(query=query, arguments=arguments)

    path = dict(result[0])

    response_user = cognito_idp.admin_get_user(
        UserPoolId=USER_POOL_ID, Username=path["creator_id"]
    )

    user = {
        "username": response_user["Username"],
        "created_at": response_user["UserCreateDate"].strftime("%d/%m/%Y"),
        "updated_at": response_user["UserLastModifiedDate"].strftime("%d/%m/%Y"),
    }

    for attribute in response_user["UserAttributes"]:
        user[attribute["Name"]] = attribute["Value"]

    path["owner_name"] = f'{user["name"]} {user["family_name"]}'
    path["owner_picture"] = user["picture"]

    response = json.dumps(path, cls=DateTimeEncoder)

    return response
