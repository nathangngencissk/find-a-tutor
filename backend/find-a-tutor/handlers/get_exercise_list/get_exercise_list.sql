select e.id,
	   e.description,
       e.justification,
       e.right_option_id,
       case when eu.user_id = :user_id then true
       		else false end as done
from   exercises e
inner join exercise_lists el on el.id = e.exercise_list_id
left join exercises_users eu on e.id = eu.exercise_id
                             and eu.user_id = :user_id
where el.id = :exercise_list_id;