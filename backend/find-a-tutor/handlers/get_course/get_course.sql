with 
cte_total as (
	select count(*) as total, course_id from reviews group by course_id
),

cte_reviews as (
	select  count(CASE WHEN rating = 1 THEN 1 END) AS rating_1,
			count(CASE WHEN rating = 2 THEN 1 END) AS rating_2,
			count(CASE WHEN rating = 3 THEN 1 END) AS rating_3,
			count(CASE WHEN rating = 4 THEN 1 END) AS rating_4,
			count(CASE WHEN rating = 5 THEN 1 END) AS rating_5,
			course_id
	from	reviews
	group by course_id
)

select c.id, 
       c.name, 
       c.description, 
       c.short_description, 
       c.image, 
       c.status, 
       c.category_id,
       c.price,
       c.owner_id as owner,
	   cat.name as category_name,
	   cte_total.total as reviews,
	   cte_reviews.rating_1 as rating_1,
	   cte_reviews.rating_2 as rating_2,
	   cte_reviews.rating_3 as rating_3,
	   cte_reviews.rating_4 as rating_4,
	   cte_reviews.rating_5 as rating_5,
	   avg(r.rating) as avg_rating,
       (select avg(r.rating) from reviews r inner join courses on courses.id = r.course_id where courses.owner_id = c.owner_id) as avg_rating_owner,
       (select count(*) from courses where courses.owner_id = c.owner_id) as count_user_courses
from courses c
left join cte_total on cte_total.course_id = c.id
left join cte_reviews on cte_reviews.course_id = c.id
left join course_classes cc on cc.course_id = c.id
inner join courses_categories cat on cat.id = c.category_id
left join reviews r on r.course_id = c.id
where c.id = :course_id
group by c.id, c.name, c.description, c.short_description, c.image, c.status, c.category_id, c.owner_id, c.price, category_name, reviews, rating_1, rating_2, rating_3, rating_4, rating_5;