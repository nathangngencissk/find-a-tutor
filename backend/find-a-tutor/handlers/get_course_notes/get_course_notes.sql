select *
from   notes n 
where  n.user_id = :user_id
and n.course_id = :course_id;