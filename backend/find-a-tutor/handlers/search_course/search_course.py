import json
import os

from utils.database import Database
from utils import DateTimeEncoder

CONN_STRING = os.environ["CONN_STRING"]

db = Database(conn_string=CONN_STRING)


def handle(event, context):

    keywords = event["arguments"].get("keywords", None)
    category_id = event["arguments"].get("category_id", None)
    order_by = event["arguments"].get("order_by", None)
    min_eval = event["arguments"].get("min_eval", None)
    max_eval = event["arguments"].get("max_eval", None)
    min_price = event["arguments"].get("min_price", None)
    max_price = event["arguments"].get("max_price", None)

    query = """
        with 
        cte_total as (
            select count(*) as total, course_id from reviews group by course_id
        )

        select c.id, 
            c.name,
            c.image,
            c.price,
            c.short_description,
            cat.name as category_name,
            cte_total.total as reviews,
            avg(r.rating) as avg_rating
        from courses c
        join cte_total on cte_total.course_id = c.id
        inner join courses_categories cat on cat.id = c.category_id
        inner join reviews r on r.course_id = c.id
        where c.status = 'APROVADO'
    """

    if keywords:
        keywords = " & ".join(keywords)
        event["arguments"]["keywords"] = keywords
        query += (
            " and to_tsvector(c.name || ' ' || c.description) @@ to_tsquery(:keywords)"
        )

    if category_id:
        query += " and c.category_id = :category_id"

    if min_price:
        query += " and c.price >= :min_price"

    if max_price:
        query += " and c.price <= :max_price"

    query += (
        " group by c.id, c.name, c.short_description, c.image, category_name, reviews"
    )

    if min_eval or max_eval:
        query += " having 1 = 1"

    if min_eval:
        query += " and avg(r.rating) >= :min_eval"

    if max_eval:
        query += " and avg(r.rating) <= :max_eval"

    if order_by:
        query += " order by case when :order_by = 'reviews' then count(r.*) end desc, case when :order_by = 'avg_rating' then avg(r.rating) end desc, case when :order_by = 'price' then c.price end desc"

    arguments = {arg: event["arguments"][arg] for arg in event["arguments"]}

    result = db.query(query=query, arguments=arguments)

    response = json.dumps(result, cls=DateTimeEncoder)

    return response
