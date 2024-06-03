ALTER TABLE phone
ADD CONSTRAINT phone_consraint CHECK(phone_number LIKE '0%' or phone_number LIKE '+%' )
