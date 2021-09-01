select p.*
from payments p
where p.user_id = :user_id 
and p.status = 'APPROVED';