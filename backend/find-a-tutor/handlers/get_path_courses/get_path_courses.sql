with 
cte_total as (
	select count(*) as total, course_id from reviews group by course_id
)

select c.id,
       c.name,
       c.short_description,
       c.image,
       c.price,
       cat.name as category_name,
	   cte_total.total as reviews,
	   avg(r.rating) as avg_rating,
	   pc.order,
	   pc.section_name
from courses c
join cte_total on cte_total.course_id = c.id
inner join courses_categories cat on cat.id = c.category_id
left join reviews r on r.course_id = c.id
inner join paths_courses pc on pc.course_id = c.id
where  pc.path_id = :path_id
group by c.id,
         c.name,
         c.short_description,
         c.image,
         c.price,
         category_name,
	     reviews,
	     pc.order,
	     pc.section_name