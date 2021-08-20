select e.id,
	   e.description,
       e.justification,
       e.right_option_id,
       case when eu.user_id is not null then true
       		else false end as done
from   exercises e
left join exercises_users eu on e.id = eu.exercise_id
inner join exercise_lists el on el.id = e.exercise_list_id
where el.id = :exercise_list_id;