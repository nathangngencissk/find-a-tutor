INSERT INTO notes
(user_id, course_id, title, "content", created_at, updated_at, fixed)
VALUES(:user_id, :course_id, :title, :content, :created_at, :updated_at, :fixed)
on conflict (user_id, course_id, title, content, fixed) 
do update set content = :content, title = :title, fixed = :fixed, updated_at = :updated_at;