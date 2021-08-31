import json
import os

from utils.database import Database
from utils import DateTimeEncoder
from models.step.Step import Step

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    steps = json.loads(event["arguments"]["steps"])

    updated_steps = []

    for step in steps:

        updated_step = Step(**step)

        db.add(updated_step)

        updated_step.__dict__.pop("_sa_instance_state")

        updated_steps.append(updated_step.__dict__)

    response = json.dumps(updated_steps, cls=DateTimeEncoder)

    return response
