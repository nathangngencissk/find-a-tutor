import json
import os

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    with open("get_avg_rating_per_month.sql", "r") as f:
        query_avg_rating_per_month = f.read()

    with open("get_count_per_month.sql", "r") as f:
        query_count_per_month = f.read()

    with open("get_sum_per_month.sql", "r") as f:
        query_sum_per_month = f.read()

    with open("get_total_users.sql", "r") as f:
        query_total_users = f.read()

    arguments = {"user_id": event["arguments"]["user_id"]}

    result_avg_rating_per_month = db.query(
        query=query_avg_rating_per_month, arguments=arguments
    )
    result_count_per_month = db.query(query=query_count_per_month, arguments=arguments)
    result_sum_per_month = db.query(query=query_sum_per_month, arguments=arguments)
    result_total_users = db.query(query=query_total_users, arguments=arguments)

    total_sum = 0.0

    for result_sum in result_sum_per_month:
        result_sum["total_month"] = float(result_sum["total_month"]) * 0.66
        total_sum += result_sum["total_month"]

    total_count = 0

    for result_count in result_count_per_month:
        total_count += result_count["count_month"]

    result = {
        "avg_rating_per_month": result_avg_rating_per_month,
        "count_per_month": result_count_per_month,
        "total_count": total_count,
        "sum_per_month": result_sum_per_month,
        "total_sum": total_sum,
        "total_users": result_total_users,
        "last_average": result_avg_rating_per_month[-1]["cum_amt"],
    }

    response = json.dumps(result, cls=DateTimeEncoder)

    return response
