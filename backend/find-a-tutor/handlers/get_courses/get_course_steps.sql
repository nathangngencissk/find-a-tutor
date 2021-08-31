select *
from courses_steps cs
where cs.course_id = :course_id
order by cs.order asc;