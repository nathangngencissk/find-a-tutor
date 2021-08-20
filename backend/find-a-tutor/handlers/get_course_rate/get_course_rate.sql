select rating,
       content
from reviews
where user_id = :user_id
and course_id = :course_id;