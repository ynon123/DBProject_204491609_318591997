CREATE OR REPLACE PROCEDURE MainProcedure AS
BEGIN
  -- קריאה לפרוצדורה לקבלת מידע על פעילות פלילית של חשודים במהלך תקופה מסוימת
  DECLARE
    v_RefCursor SYS_REFCURSOR;
    v_Suspect_Id INT;
    v_First_Name VARCHAR2(30);
    v_Last_Name VARCHAR2(30);
    v_Birth_Day DATE;
    v_Gender VARCHAR2(1);
    v_Event_Time DATE;
    v_Casualties INT;
    v_Location VARCHAR2(50);
    v_Organization_Name VARCHAR2(40);
    v_Leader VARCHAR2(40);
    v_Weapon_Model VARCHAR2(50);
    v_Weapon_Serial INT;
    v_Weapon_Company VARCHAR2(50);
  BEGIN
    -- קריאה לפרוצדורה Get_Criminal_Activities
    DBMS_OUTPUT.PUT_LINE('Calling Get_Criminal_Activities...');
    Get_Criminal_Activities(DATE '2023-01-01', DATE '2023-05-31', v_RefCursor);
    
    LOOP
      FETCH v_RefCursor INTO v_Suspect_Id, v_First_Name, v_Last_Name, v_Birth_Day, v_Gender, v_Event_Time, v_Casualties, v_Location, v_Organization_Name, v_Leader, v_Weapon_Model, v_Weapon_Serial, v_Weapon_Company;
      EXIT WHEN v_RefCursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(
        'Suspect ID: ' || v_Suspect_Id || 
        ', Name: ' || v_First_Name || ' ' || v_Last_Name || 
        ', Birth Day: ' || TO_CHAR(v_Birth_Day, 'YYYY-MM-DD') || 
        ', Gender: ' || v_Gender || 
        ', Event Time: ' || TO_CHAR(v_Event_Time, 'YYYY-MM-DD HH24:MI:SS') || 
        ', Casualties: ' || v_Casualties || 
        ', Location: ' || v_Location || 
        ', Organization: ' || v_Organization_Name || 
        ', Leader: ' || v_Leader || 
        ', Weapon Model: ' || v_Weapon_Model || 
        ', Serial: ' || v_Weapon_Serial || 
        ', Company: ' || v_Weapon_Company
      );
    END LOOP;
    
    CLOSE v_RefCursor;
  END;

  -- קריאה לפונקציה לקבלת מידע על פעילויות פליליות של חשוד לפי מספר זיהוי
  DECLARE
    v_Suspect_Criminal_RefCursor SYS_REFCURSOR;
    v_Suspect_Id INT;
    v_First_Name VARCHAR2(30);
    v_Last_Name VARCHAR2(30);
    v_Birth_Day DATE;
    v_Gender VARCHAR2(1);
    v_Arrest_Date DATE;
    v_License_plate VARCHAR2(10);
    v_Car_Company VARCHAR2(10);
    v_Color VARCHAR2(10);
    v_Event_Time DATE;
    v_Casualties INT;
    v_Location VARCHAR2(50);
  BEGIN
    -- קריאה לפונקציה Get_Suspect_Criminal_Info
    DBMS_OUTPUT.PUT_LINE('Calling Get_Suspect_Criminal_Info...');
    v_Suspect_Criminal_RefCursor := Get_Suspect_Criminal_Info(1); -- נניח שה-ID של החשוד הוא 1
    
    LOOP
      FETCH v_Suspect_Criminal_RefCursor INTO v_Suspect_Id, v_First_Name, v_Last_Name, v_Birth_Day, v_Gender, v_Arrest_Date, v_License_plate, v_Car_Company, v_Color, v_Event_Time, v_Casualties, v_Location;
      EXIT WHEN v_Suspect_Criminal_RefCursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(
        'Suspect ID: ' || v_Suspect_Id || 
        ', Name: ' || v_First_Name || ' ' || v_Last_Name || 
        ', Birth Day: ' || TO_CHAR(v_Birth_Day, 'YYYY-MM-DD') || 
        ', Gender: ' || v_Gender || 
        ', Arrest Date: ' || TO_CHAR(v_Arrest_Date, 'YYYY-MM-DD') || 
        ', License Plate: ' || v_License_plate || 
        ', Car Company: ' || v_Car_Company || 
        ', Color: ' || v_Color || 
        ', Event Time: ' || TO_CHAR(v_Event_Time, 'YYYY-MM-DD HH24:MI:SS') || 
        ', Casualties: ' || v_Casualties || 
        ', Location: ' || v_Location
      );
    END LOOP;
    
    CLOSE v_Suspect_Criminal_RefCursor;
  END;
END;
