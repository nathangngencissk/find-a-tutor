select p.*
from payouts p
where p.user_id = :user_id
and p.status <> 'NEGADO';