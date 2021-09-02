update bank_accounts 
set updated_at = :updated_at,
    favorite = case when id = :id then true 
						        else false end
where user_id = :user_id;