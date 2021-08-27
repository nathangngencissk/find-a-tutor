insert into exercises_users (user_id, exercise_id, created_at, updated_at)
values (:user_id, :exercise_id, :created_at, :updated_at)
on conflict (user_id, exercise_id) 
do update set updated_at = :updated_at;