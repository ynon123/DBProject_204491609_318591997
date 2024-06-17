-- car company's that use the most armed and terorist
with id_bad_people as( -- armed and terorist id
     select  id 
     from humen natural join weapon natural join incrimination) 

select car_company, count(car_company) as num_company
from humen natural join vehicle natural join hold
where id in (select id from id_bad_people)
group by car_company
order by num_company desc
