-- phones that calls armed and terrorist people
with bad_people_id as  -- id pf people's that hold weapon or made terror attack
     (select id 
     from humen natural join weapon natural join incrimination)
            
select phone_number,id, first_name, last_name -- all pople hold phone's that made phone-calls to phones bad people 
from phone natural join humen 
where id in

      (Select id -- id of bad people phone's or of people's that calls to bad people's
      from phone natural join phone_calls
      where phone.id in (select id from bad_people_id)
      or phone_calls.a_side in(select id from bad_people_id))
