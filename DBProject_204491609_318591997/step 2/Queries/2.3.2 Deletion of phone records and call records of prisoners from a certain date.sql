UPDATE 
    Weapon w
SET 
    w.Weight = TO_CHAR(TO_NUMBER(REGEXP_SUBSTR(w.Weight, '^[0-9]+')) * 1.10) || ' kg'
WHERE 
    w.Id IN (
        SELECT 
            a.Id
        FROM 
            Arrest a
        WHERE 
            a.Location = 'Ofer'
    );


SELECT 
    w.Model,
    w.Serial,
    w.Company,
    a.Arrest_Date,
    a.Investigator_Name,
    a.Location,
    TO_NUMBER(REGEXP_SUBSTR(w.Weight, '^[0-9]+')) AS Current_Weight
FROM 
    Weapon w
JOIN 
    Arrest a ON w.Id = a.Id
where location = 'Ofer'
ORDER BY 
    a.Arrest_Date, w.Serial;
