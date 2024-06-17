SELECT 
    v.License_plate,
    v.Color,
    v.Car_Company,
    v.Date_Manuacturing,
    h.First_Name,
    h.Last_Name,
    ho.Id AS Owner_Id
FROM 
    vehicle v
JOIN 
    Hold ho ON v.License_plate = ho.License_plate
JOIN 
    Humen h ON ho.Id = h.Id
WHERE 
    v.Color = '&car_color'
ORDER BY 
    v.License_plate;
