INSERT INTO reviews
(user_id, course_id, "content", rating, created_at, updated_at)
VALUES(:user_id, :course_id, :content, :rating, :created_at, :updated_at);
on conflict (user_id, course_id) 
do update set rating = :rating, content = :content, updated_at = :updated_at;