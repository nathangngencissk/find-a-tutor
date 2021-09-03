select pc.path_id,
       pc.order,
       pc.section_name,
       pc.id as id,
       pc.created_at as pc_created_at,
       pc.updated_at as pc_updated_at,
       c.id as course_id,
       c.name as name,
       c.image as image,
       c.created_at,
       c.updated_at
from paths_courses pc 
inner join courses c on pc.course_id = c.id
where pc.path_id = :path_id
and c.status = 'APROVADO';