SELECT course_class_id, title, body, created_at, updated_at, id
FROM course_class_posts
where course_class_id = :course_class_id;
