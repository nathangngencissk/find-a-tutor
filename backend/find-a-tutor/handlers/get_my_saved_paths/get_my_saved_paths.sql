select p.id, p.name
from paths p
inner join users_paths up ON up.path_id = p.id
where up.user_id = :user_id;