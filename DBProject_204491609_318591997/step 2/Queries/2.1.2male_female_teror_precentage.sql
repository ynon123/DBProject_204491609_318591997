-- Retrieve the presentage of the male and female whoe commit terror attack and who didnt 
SELECT gender, round(g1/(g1+g3), 3) is_terorist, round(g3/(g1+g3), 3) is_not_terorist
from
        (select gender, count(gender) as g1
        FROM humen h left outer join incrimination i on h.id = i.id
        where i.id is not null
        group by gender) -- all terorist in both humen and incrimination tables 
natural join
        (select gender, count(gender) as g2
        FROM humen natural join incrimination
        group by gender)-- terorist in both humen,incrimination and civilians 
natural join
        (select gender, count(gender) as g3
        FROM humen h left outer join incrimination i on h.id = i.id
        where i.id is  null -- civilians who isn't terorist
        group by gender)
