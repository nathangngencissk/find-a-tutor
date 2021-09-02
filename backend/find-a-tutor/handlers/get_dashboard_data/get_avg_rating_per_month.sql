SELECT distinct to_char(r.updated_at, 'Mon') as month_name, avg(r.rating)
OVER (PARTITION BY to_char(r.updated_at, 'Mon')
ORDER BY to_char(r.updated_at, 'Mon')) AS cum_amt
FROM   reviews r
inner join courses c on c.id = r.course_id
where c.owner_id = :user_id
ORDER  BY month_name;