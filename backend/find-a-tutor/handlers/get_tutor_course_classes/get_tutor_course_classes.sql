select cc.*
from course_classes cc
inner join courses c on c.id = cc.course_id 
where c.owner_id = :user_id;