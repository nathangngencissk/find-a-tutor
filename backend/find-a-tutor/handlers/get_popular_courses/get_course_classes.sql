select cc.*
from course_classes cc
inner join courses c on c.id = cc.course_id
where c.id = :user_id
and cc.end_date > current_date;