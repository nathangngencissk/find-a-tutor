select cc.id,
	   cc.name,
	   c.name,
	   cc.image,
	   cc.start_date,
	   cc.end_date,
	   cc.description,
	   cc.schedule,
       cc.duration,
	   ccu.status
from   course_classes cc
inner join courses c on c.id = cc.course_id
inner join course_class_users ccu on ccu.course_class_id = cc.id 
where ccu.user_id = :user_id;