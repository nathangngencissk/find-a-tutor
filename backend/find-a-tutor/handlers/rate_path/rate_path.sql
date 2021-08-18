insert into paths_reviews (user_id, path_id, rating, created_at, updated_at)
values (:user_id, :path_id, :rating, :created_at, :updated_at)
on conflict (user_id, path_id) 
do update set rating = :rating, updated_at = :updated_at;