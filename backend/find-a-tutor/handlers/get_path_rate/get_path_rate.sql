select pr.rating
from   paths_reviews pr
where  pr.user_id = :user_id
and    pr.path_id = :path_id