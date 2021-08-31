select c.*,
	   string_agg(distinct CONCAT(cc.start_date::varchar, ' - ', cc.schedule), '|') as classes,
	   cat.name as category_name,
	   count(r.*) as reviews,
	   avg(r.rating) as avg_rating
from courses c
left join course_classes cc on cc.course_id = c.id
inner join courses_categories cat on cat.id = c.category_id
left join reviews r on r.course_id = c.id
where c.status = 'APROVADO'
group by c.id, c.name, c.description, c.short_description, c.image, c.status, c.category_id, c.owner_id, c.created_at, c.updated_at, category_name
limit 5;