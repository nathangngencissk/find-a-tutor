import json
import os

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_tutor_exercise_lists.sql", "r") as f:
        query = f.read()

    arguments = {"user_id": event["arguments"]["user_id"]}
    results = db.query(query=query, arguments=arguments)

    with open("get_list_exercises.sql", "r") as f:
        query = f.read()

    with open("get_exercise_options.sql", "r") as f:
        query_options = f.read()

    exercise_lists = []

    for result in results:
        exercise_list = dict(result)
        arguments = {"exercise_list_id": exercise_list["id"]}
        exercises_results = db.query(query=query, arguments=arguments)
        exercise_list["exercises"] = []

        for exercise_result in exercises_results:
            exercise = dict(exercise_result)
            arguments_options = {"exercise_id": exercise["id"]}
            options = db.query(query=query_options, arguments=arguments_options)
            exercise["options"] = options
            exercise_list["exercises"].append(exercise)

        exercise_lists.append(exercise_list)

    response = json.dumps(exercise_lists, cls=DateTimeEncoder)

    return response
