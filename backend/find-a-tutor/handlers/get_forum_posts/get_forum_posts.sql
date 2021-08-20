
select fp.id,
	   fp.title,
 	   fp.description,
 	   fp.creator_id,
 	   cc.name as category_name,
 	   (select count(*) from forum_posts_comments fpc where fpc.post_id = fp.id) as post_comments_count,
 	   (select max(created_at) from forum_posts_comments fpc where fpc.post_id = fp.id) as last_comments_timestamp
from   forum_posts fp
inner  join courses_categories cc on cc.id = fp.category_id;