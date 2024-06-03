-- Retrieve all details and car information,
-- from 18-year-old individuals who have been in jail and possess a weapon.
-- the query get the minimal age from the user.

SELECT DISTINCT id, first_name, last_name, birth_day, license_plate, car_company, color
FROM vehicle NATURAL JOIN hold NATURAL JOIN humen NATURAL JOIN weapon NATURAL JOIN arrest
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, birth_day) / 12) >= &age_input
ORDER BY id
