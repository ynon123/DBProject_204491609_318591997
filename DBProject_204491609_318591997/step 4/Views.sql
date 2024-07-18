CREATE OR REPLACE VIEW MilitaryUnitOverview AS
SELECT 
    u.unitid,
    u.unitlocation,
    u.unitname,
    e.excellencetype,
    e.excellenceyear,
    e.have_money,
    r.resourceid,
    r.resourcename,
    r.resourcestype,
    r.quantity,
    p.personid,
    p.personname,
    p.personrole,
    p.personrank,
    pr.projectid,
    pr.projectname,
    pr.begindate AS project_begindate,
    pr.enddate AS project_enddate,
    pr.status AS project_status,
    pr.budget,
    ti.taskid,
    ti.begindate AS task_begindate,
    ti.enddate AS task_enddate,
    ti.status AS task_status
FROM 
    Unit u
LEFT JOIN 
    Excellence e ON u.unitid = e.unitid
LEFT JOIN 
    Resources r ON u.unitid = r.unitid
LEFT JOIN 
    Person p ON u.unitid = p.unitid
LEFT JOIN 
    inProject ip ON p.personid = ip.personid
LEFT JOIN 
    Projects pr ON ip.projectid = pr.projectid
LEFT JOIN 
    Task ti ON pr.projectid = ti.projectid







SELECT 
    unitid, 
    unitname, 
    total_soldiers, 
    total_resources
FROM (
    SELECT 
        unitid, 
        unitname, 
        COUNT(DISTINCT personid) AS total_soldiers,
        COUNT(DISTINCT resourceid) AS total_resources
    FROM 
        MilitaryUnitOverview
    GROUP BY 
        unitid, 
        unitname
    ORDER BY 
        Total_soldiers DESC, 
        total_resources DESC
)
 WHERE ROWNUM <= 5






SELECT 
    unitid, 
    unitname, 
    COUNT(DISTINCT resourceid) AS resource_count,
    COUNT(DISTINCT personid) AS employee_count,
    project_status
FROM 
    MilitaryUnitOverview
GROUP BY 
    unitid, 
    unitname,
    project_status;








CREATE OR REPLACE VIEW CriminalIntelDashboard AS
SELECT 
    h.id AS person_id,
    h.first_name,
    h.last_name,
    h.birth_day,
    h.gender,
    a.arrest_date,
    a.investigator_name,
    a.location AS arrest_location,
    a.prison_number,
    ho.license_plate,
    i.event_time,
    i.casualties,
    i.location AS incrimination_location,
    p.phone_number,
    p.tel_company,
    p.smartphone,
    t.organization_name,
    t.leader,
    t.foundation_year,
    w.model AS weapon_model,
    w.serial AS weapon_serial,
    w.company AS weapon_company,
    c.a_side,
    c.b_side,
    c.start_time AS call_start_time,
    v.license_plate AS vehicle_license_plate,
    v.color AS vehicle_color,
    v.car_company AS vehicle_company,
    v.Date_Manuacturing AS vehicle_date_manufacturing,
    hs.district,
    hs.rooms_numbers,
    hs.floor,
    hs.datum_point,
    hs.family_name
FROM 
    HUMEN h
LEFT JOIN 
    ARREST a ON h.id = a.id
LEFT JOIN 
    HOLD ho ON h.id = ho.id
LEFT JOIN 
    INCRIMINATION i ON h.id = i.id
LEFT JOIN 
    PHONE p ON h.id = p.id
LEFT JOIN 
    TERROR_ORGANIZATION t ON h.id = t.id
LEFT JOIN 
    WEAPON w ON h.id = w.id
LEFT JOIN 
    CALLS c ON p.phone_number = c.phone_number
LEFT JOIN 
    HOUSE hs ON h.id = hs.id
LEFT JOIN 
    VEHICLE v ON ho.license_plate = v.license_plate;






SELECT 
    person_id, 
    first_name, 
    last_name, 
    arrest_date, 
    investigator_name, 
    arrest_location, 
    call_start_time, 
    a_side, 
    b_side
FROM 
    CriminalIntelDashboard
WHERE 
    arrest_date IS NOT NULL 
    AND call_start_time IS NOT NULL;







SELECT 
    person_id, 
    first_name, 
    last_name, 
    weapon_model, 
    weapon_serial, 
    weapon_company, 
    event_time, 
    incrimination_location
FROM 
    CriminalIntelDashboard
WHERE 
    weapon_serial IS NOT NULL 
    AND incrimination_location IN ('Beit Lahia', 'Bureij');




