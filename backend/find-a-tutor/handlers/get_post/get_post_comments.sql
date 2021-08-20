select fpc.*,
       fpcl.value as like
from   forum_posts_comments fpc
left   join forum_posts_comments_likes fpcl on fpc.id = fpcl.post_comment_id
where  fpcl.user_id = :user_id;