import json
import os

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    keywords = event["arguments"].get("keywords", None)
    order_by = event["arguments"].get("order_by", None)
    min_eval = event["arguments"].get("min_eval", None)
    max_eval = event["arguments"].get("max_eval", None)

    query = """
        with 
        cte_total as (
            select count(*) as total, path_id from paths_reviews group by path_id
        )

        select p.id,
            p.name,
            p.description,
            p.image,
            cte_total.total as reviews,
            avg(pr.rating) as avg_rating
        from   paths p 
        inner join paths_reviews pr on pr.path_id = p.id
        inner join cte_total on cte_total.path_id = p.id
        where 1 = 1
    """

    if keywords:
        keywords = " & ".join(keywords)
        event["arguments"]["keywords"] = keywords
        query += (
            " and to_tsvector(p.name || ' ' || p.description) @@ to_tsquery(:keywords)"
        )

    query += " group by p.id, p.name, p.description, p.image, reviews"

    if min_eval or max_eval:
        query += " having 1 = 1"

    if min_eval:
        query += " and avg(pr.rating) >= :min_eval"

    if max_eval:
        query += " and avg(pr.rating) <= :max_eval"

    if order_by:
        query += " order by case when :order_by = 'reviews' then count(pr.*) end desc, case when :order_by = 'avg_rating' then avg(pr.rating) end desc"

    arguments = {arg: event["arguments"][arg] for arg in event["arguments"]}

    result = db.query(query=query, arguments=arguments)

    response = json.dumps(result, cls=DateTimeEncoder)

    return response
