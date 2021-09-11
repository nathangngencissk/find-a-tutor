with 
cte_total as (
	select count(*) as total, path_id from paths_reviews group by path_id
)

select p.id,
       p.name,
	   p.description,
       p.image,
       p.creator_id,
       cte_total.total as reviews,
       avg(pr.rating) as avg_rating
from   paths p 
left join paths_reviews pr on pr.path_id = p.id
left join cte_total on cte_total.path_id = p.id
where p.id = :path_id
group by p.id,
         p.name,
	     p.description,
         p.image,
         p.creator_id,
         reviews;