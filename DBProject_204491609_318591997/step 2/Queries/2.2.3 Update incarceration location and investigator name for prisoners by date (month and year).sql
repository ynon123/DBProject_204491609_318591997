UPDATE 
    Arrest a
SET 
    a.Location = 'Hadarim prison',
    a.Investigator_Name = 'nadav zimerman'
WHERE 
    EXTRACT(MONTH FROM a.Arrest_Date) = 2
    AND EXTRACT(YEAR FROM a.Arrest_Date) = 2020;


SELECT 
    a.Id,
    a.Arrest_Date,
    a.Location,
    a.Investigator_Name
FROM 
    Arrest a
WHERE 
    EXTRACT(MONTH FROM a.Arrest_Date) = 2
    AND EXTRACT(YEAR FROM a.Arrest_Date) = 2020;
