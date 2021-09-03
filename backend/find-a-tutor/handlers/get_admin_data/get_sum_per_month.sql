SELECT sum(c.price) AS total_month, to_char(p.updated_at, 'Mon') as month_name
FROM payments p
inner join orders o on o.payment_id = p.id 
inner join courses c on c.id = o.course_id
where p.status = 'APPROVED'
GROUP BY month_name;