select p.*
from payments p
inner join orders o on o.payment_id = p.id 
inner join courses c on c.id = o.course_id
where c.owner_id = :user_id 
and p.status = 'APPROVED';