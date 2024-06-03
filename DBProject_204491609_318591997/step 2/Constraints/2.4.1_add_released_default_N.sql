ALTER TABLE arrest
ADD released CHAR(1)DEFAULT 'N' 
ADD CONSTRAINT released_consraint CHECK(released= 'Y' or released= 'N')
