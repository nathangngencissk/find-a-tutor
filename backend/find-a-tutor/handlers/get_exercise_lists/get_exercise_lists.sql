with 
cte_total_user as (
	select e.exercise_list_id as list_id, count(*) as total_user 
	from exercises e 
	inner join exercises_users eu on e.id = eu.exercise_id 
	where eu.user_id = :user_id
	group by e.id
),
cte_total as (
	select e.exercise_list_id as list_id, count(*) as total 
	from exercises e 
	inner join exercises_users eu on e.id = eu.exercise_id
	group by e.id
)

select el.id,
	   el.title, 
	   el.tags, 
	   el.description,
	   ctu.total_user as total_user,
	   ct.total as total,
	   case when total_user = total then 'Feita'
	   		when total_user = 0 then null
	   		else 'Em Andamento' end as status
from exercise_lists el
inner join cte_total_user ctu on ctu.list_id = el.id
inner join cte_total ct on ct.list_id = ctu.list_id;
