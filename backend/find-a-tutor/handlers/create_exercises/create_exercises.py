import json
import os

from utils.database import Database
from utils import DateTimeEncoder
from models.exercise.Exercise import Exercise
from models.exercise_option.ExerciseOption import ExerciseOption

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    exercises = json.loads(event["arguments"]["exercises"])

    new_exercises = []

    for exercise in exercises:

        exercise_options = exercise.pop("options")

        new_exercise = Exercise(**exercise)

        db.add(new_exercise)

        new_exercise.__dict__.pop("_sa_instance_state")

        new_exercise.__dict__["options"] = []

        for option in exercise_options:

            new_option = ExerciseOption(**option)

            db.add(new_option)

            new_option.__dict__.pop("_sa_instance_state")

            new_exercise.__dict__["options"].append(new_option.__dict__)

        new_exercises.append(new_exercise.__dict__)

    response = json.dumps(new_exercises, cls=DateTimeEncoder)

    return response
