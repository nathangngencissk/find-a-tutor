import json
import os

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_exercise_list.sql", "r") as f:
        query = f.read()

    arguments = {
        "exercise_list_id": event["arguments"]["id"],
        "user_id": event["arguments"]["user_id"],
    }

    exercise_list = db.query(query=query, arguments=arguments)

    exercises_id = ",".join([str(ex["id"]) for ex in exercise_list])

    query = f"""
        select eo.id,
            eo.exercise_id,
            eo.description
        from exercises_options eo
        inner join exercises e on e.id = eo.exercise_id
        where eo.exercise_id in ({exercises_id})
    """

    exercise_list_options = db.query(query=query)

    for ex in exercise_list:
        ex["options"] = [
            option
            for option in exercise_list_options
            if option["exercise_id"] == ex["id"]
        ]

    response = json.dumps(exercise_list, cls=DateTimeEncoder)

    return response
