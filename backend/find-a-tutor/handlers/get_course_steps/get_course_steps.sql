select cs.id,
	   cs.name,
	   cs.description,
	   cs.video
from courses_steps cs
where cs.course_id :course_id;