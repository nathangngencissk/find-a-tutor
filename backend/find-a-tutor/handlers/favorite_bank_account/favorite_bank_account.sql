insert into forum_posts_comments_likes (user_id, post_comment_id, value, created_at, updated_at)
values (:user_id, :post_comment_id, :value, :created_at, :updated_at)
on conflict (user_id, post_comment_id) 
do update set value = :value, updated_at = :updated_at;