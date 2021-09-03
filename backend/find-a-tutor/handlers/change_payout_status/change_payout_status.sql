update payouts 
set updated_at = :updated_at,
    status = :status
where id = :id;