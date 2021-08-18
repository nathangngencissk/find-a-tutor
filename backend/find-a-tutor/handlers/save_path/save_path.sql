insert into users_paths (user_id, path_id, created_at, updated_at)
values (:user_id, :path_id, :created_at, :updated_at)
on conflict (user_id, path_id) 
do nothing;