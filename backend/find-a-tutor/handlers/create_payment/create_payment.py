import os
from datetime import datetime

from paypalcheckoutsdk.core import PayPalHttpClient, SandboxEnvironment
from paypalcheckoutsdk.orders import OrdersCreateRequest
from paypalhttp import HttpError

from utils.database import Database
from utils import DateTimeEncoder
from models.payment.Payment import Payment

CONN_STRING = os.environ["CONN_STRING"]
PAYPAL_CLIENT_ID = os.environ["PAYPAL_CLIENT_ID"]
PAYPAL_CLIENT_SECRET = os.environ["PAYPAL_CLIENT_SECRET"]

db = Database(conn_string=CONN_STRING)

environment = SandboxEnvironment(
    client_id=PAYPAL_CLIENT_ID, client_secret=PAYPAL_CLIENT_SECRET
)
client = PayPalHttpClient(environment)


def handle(event, context):

    request = OrdersCreateRequest()

    request.prefer("return=representation")

    request.request_body(
        {
            "intent": "CAPTURE",
            "purchase_units": [
                {
                    "amount": {
                        "currency_code": "BRL",
                        "value": event["arguments"]["value"],
                    }
                }
            ],
        }
    )

    try:
        response = client.execute(request)

        payment_link = response.result.links[1].href

        now = datetime.now()

        arguments = {
            "order_id": response.result.id,
            "value": event["arguments"]["value"],
            "status": response.result.status,
            "user_id": event["arguments"]["user_id"],
            "created_at": now.strftime("%Y-%m-%d %H:%M:%S"),
            "updated_at": now.strftime("%Y-%m-%d %H:%M:%S"),
        }

        payment = Payment(**arguments)

        db.add(payment)

        payment.__dict__.pop("_sa_instance_state")

        return payment_link

    except IOError as ioe:
        if isinstance(ioe, HttpError):
            print(ioe.status_code)
            return ioe
