import json
import os

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_exercises_for_approval.sql", "r") as f:
        query = f.read()

    results = db.query(query=query)

    exercises_lists = []

    for result in results:
        exercise_list = dict(result)

        with open("get_list_exercises.sql", "r") as f:
            query = f.read()

        exercises_results = db.query(
            query=query, arguments={"exercise_list_id": exercise_list["id"]}
        )

        exercise_list["exercises"] = []

        for exercise_result in exercises_results:
            exercise = dict(exercise_result)

            with open("get_exercise_options.sql", "r") as f:
                query = f.read()

            exercise_options = db.query(
                query=query, arguments={"exercise_id": exercise["id"]}
            )

            exercise["options"] = exercise_options

            exercise_list["exercises"].append(exercise)

        exercises_lists.append(exercise_list)

    response = json.dumps(exercises_lists, cls=DateTimeEncoder)

    return response
