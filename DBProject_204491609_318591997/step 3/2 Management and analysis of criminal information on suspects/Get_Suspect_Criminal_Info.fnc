CREATE OR REPLACE FUNCTION Get_Suspect_Criminal_Info (
  p_Suspect_Id INT
) RETURN SYS_REFCURSOR IS
  v_RefCursor SYS_REFCURSOR;
BEGIN
  -- פתיחת Ref Cursor להחזרת המידע על החשודים, כלי הרכב והפעילויות הפליליות
  OPEN v_RefCursor FOR
    SELECT 
      h.Id AS Suspect_Id, 
      h.First_Name, 
      h.Last_Name, 
      h.Birth_Day, 
      h.Gender,
      a.Arrest_Date,
      v.License_plate, 
      v.Car_Company, 
      v.Color,
      i.Event_Time, 
      i.Casualties, 
      i.Location
    FROM Humen h
    JOIN Arrest a ON h.Id = a.Id
    LEFT JOIN Hold ho ON h.Id = ho.Id
    LEFT JOIN vehicle v ON ho.License_plate = v.License_plate
    LEFT JOIN Incrimination i ON h.Id = i.Id
    WHERE h.Id = p_Suspect_Id
    ORDER BY a.Arrest_Date DESC;
  
  RETURN v_RefCursor;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No criminal information found for suspect ID ' || p_Suspect_Id);
    RETURN NULL;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
    RETURN NULL;
END;
/
