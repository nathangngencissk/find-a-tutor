INSERT INTO notes
(user_id, course_id, title, "content", created_at, updated_at, id, fixed)
VALUES(:user_id, :course_id, :title, :content, :created_at, :updated_at, :id, :fixed)
on conflict (id) 
do update set content = :content, title = :title, fixed = :fixed, updated_at = :updated_at;