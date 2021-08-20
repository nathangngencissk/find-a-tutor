select eo.id,
	   eo.exercise_id,
	   eo.description
from exercises_options eo
inner join exercises e on e.id = eo.exercise_id
where eo.exercise_id in (:exercises_id)