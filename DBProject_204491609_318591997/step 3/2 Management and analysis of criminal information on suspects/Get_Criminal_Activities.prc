CREATE OR REPLACE PROCEDURE Get_Criminal_Activities (
  p_Start_Date DATE,
  p_End_Date DATE,
  p_RefCursor OUT SYS_REFCURSOR
) IS
BEGIN
  -- פתיחת Ref Cursor להחזרת המידע על החשודים, ארגוני הטרור וכלי הנשק
  OPEN p_RefCursor FOR
    SELECT 
      h.Id AS Suspect_Id, 
      h.First_Name, 
      h.Last_Name, 
      h.Birth_Day, 
      h.Gender,
      i.Event_Time,
      i.Casualties, 
      i.Location,
      t.Organization_Name, 
      t.Leader,
      w.Model AS Weapon_Model, 
      w.Serial AS Weapon_Serial, 
      w.Company AS Weapon_Company
    FROM Humen h
    JOIN Incrimination i ON h.Id = i.Id
    LEFT JOIN Terror_Organization t ON h.Id = t.Id
    LEFT JOIN Weapon w ON h.Id = w.Id
    WHERE i.Event_Time BETWEEN p_Start_Date AND p_End_Date
    ORDER BY i.Event_Time DESC;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No criminal activities found between ' || TO_CHAR(p_Start_Date, 'YYYY-MM-DD') || ' and ' || TO_CHAR(p_End_Date, 'YYYY-MM-DD'));
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/
