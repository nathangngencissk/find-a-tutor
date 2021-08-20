select rating,
       content,
       user_id
from reviews
where course_id = :course_id;