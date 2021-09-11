select cc.id,
	   cc.name,
	   c.name,
	   cc.image,
	   cc.start_date,
	   cc.end_date,
	   cc.description,
	   cc.schedule,
       cc.duration,
       case when ccu.user_id is not null then true
       else false end as enrolled
from   course_classes cc
inner join courses c on c.id = cc.course_id
left join course_class_users ccu on ccu.course_class_id = cc.id
                                 and ccu.user_id = :user_id
where cc.course_id = :course_id
and cc.end_date > current_date;