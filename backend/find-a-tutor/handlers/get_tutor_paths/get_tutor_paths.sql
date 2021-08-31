select p.*
from paths p
where p.creator_id = :user_id;