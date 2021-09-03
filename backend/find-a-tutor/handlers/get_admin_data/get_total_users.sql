select count(*)
from courses_users cu
inner join courses c on c.id = cu.course_id;