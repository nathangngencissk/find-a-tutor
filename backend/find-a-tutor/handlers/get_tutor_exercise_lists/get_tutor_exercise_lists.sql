select el.*
from exercise_lists el
where el.creator_id = :user_id;