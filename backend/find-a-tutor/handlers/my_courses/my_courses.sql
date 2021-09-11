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
left join cte_total on cte_total.course_id = c.id
inner join courses_categories cat on cat.id = c.category_id
left join reviews r on r.course_id = c.id
inner join courses_users cu on cu.course_id = c.id 
where cu.user_id = :user_id
group by c.id, c.name, c.short_description, c.image, c.price, category_name, reviews;