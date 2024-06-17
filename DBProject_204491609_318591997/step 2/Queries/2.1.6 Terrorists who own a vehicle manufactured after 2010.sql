SELECT 
    h.First_Name,
    h.Last_Name,
    v.License_plate,
    v.Color,
    v.Car_Company,
    v.Date_Manuacturing,
    i.Event_Time,
    i.Casualties,
    i.Location
FROM 
    Humen h
JOIN 
    Hold ho ON h.Id = ho.Id
JOIN 
    vehicle v ON ho.License_plate = v.License_plate
LEFT JOIN 
    Incrimination i ON h.Id = i.Id
WHERE 
    v.Date_Manuacturing > DATE '2010-01-01'
ORDER BY 
    v.Date_Manuacturing DESC, h.Last_Name;