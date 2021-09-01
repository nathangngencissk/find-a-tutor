import os
from datetime import datetime

from paypalcheckoutsdk.core import PayPalHttpClient, SandboxEnvironment
from paypalcheckoutsdk.orders import OrdersGetRequest
from paypalhttp import HttpError

from utils.database import Database
from utils import DateTimeEncoder
from models.payment.Payment import Payment
from models.course_user.CourseUser import CourseUser

CONN_STRING = os.environ["CONN_STRING"]
PAYPAL_CLIENT_ID = os.environ["PAYPAL_CLIENT_ID"]
PAYPAL_CLIENT_SECRET = os.environ["PAYPAL_CLIENT_SECRET"]

db = Database(conn_string=CONN_STRING)

environment = SandboxEnvironment(
    client_id=PAYPAL_CLIENT_ID, client_secret=PAYPAL_CLIENT_SECRET
)
client = PayPalHttpClient(environment)


def handle(event, context):

    try:
        request = OrdersGetRequest(event["arguments"]["order_id"])
        response = client.execute(request)

        now = datetime.now()

        arguments = {
            "id": event["arguments"]["id"],
            "order_id": response.result.id,
            "value": response.result.purchase_units[0].amount.value,
            "status": response.result.status,
            "user_id": event["arguments"]["user_id"],
            "created_at": now.strftime("%Y-%m-%d %H:%M:%S"),
            "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
        }

        payment = Payment(**arguments)

        db.update(payment)

        payment.__dict__.pop("_sa_instance_state")

        with open("get_payment_orders.sql", "r") as f:
            query = f.read()

        arguments_orders = {"payment_id": payment["id"]}

        results = db.query(query=query, arguments=arguments_orders)

        for result in results:
            course = dict(result)

            arguments_course_user = {
                "course_id": course["id"],
                "user_id": event["arguments"]["user_id"],
                "created_at": now.strftime("%Y-%m-%d %H:%M:%S"),
                "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
            }

            course_user = CourseUser(**arguments_course_user)

            db.add(course_user)

            course_user.__dict__.pop("_sa_instance_state")

        return "payment confirmed successfully!"

    except IOError as ioe:
        if isinstance(ioe, HttpError):
            print(ioe.status_code)
            return ioe
