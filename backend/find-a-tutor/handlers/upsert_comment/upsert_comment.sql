INSERT INTO forum_posts_comments
(parent_comment_id, post_id, "content", user_id, created_at, updated_at, id)
VALUES(:parent_comment_id, :post_id, :content, :user_id, :created_at, :updated_at, :id);
on conflict (id) 
do update set content = :content, updated_at = :updated_at;