
--Retrieve the personal details, car details, and the weapon details of the leader of the input terror organization 
select id, first_name, last_name, organization_name, model, license_plate, car_company, color
from terror_organization natural join humen natural join weapon natural join vehicle natural join hold
where &<name = "terror organization name:"  list="'Hamas', 'Islamic Jihad', 'Hezbollah', 'ISIS'"> =  organization_name
