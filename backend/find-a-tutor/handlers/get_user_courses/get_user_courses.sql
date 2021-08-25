select c.id
from courses c 
inner join courses_users cu on cu.course_id = c.id
where cu.user_id = :user_id;