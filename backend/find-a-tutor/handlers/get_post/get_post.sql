select fp.id,
	   fp.title,
 	   fp.description,
 	   fp.creator_id
from   forum_posts fp
where  fp.id = :post_id;