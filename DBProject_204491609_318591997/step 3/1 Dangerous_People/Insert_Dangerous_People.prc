CREATE OR REPLACE PROCEDURE Insert_Dangerous_People IS
  v_danger_level INT;
  v_operation_id INT := 1;
  v_location VARCHAR2(50);
BEGIN
  FOR rec IN (SELECT Id FROM (
                 SELECT Id, ROW_NUMBER() OVER (ORDER BY Calculate_Danger_Level(Id) DESC) AS rn
                 FROM Humen
            ) WHERE rn <= 100)
  LOOP
    v_danger_level := Calculate_Danger_Level(rec.Id);
    
    BEGIN
      -- Find the location of the person
      SELECT Location INTO v_location FROM Incrimination WHERE Id = rec.Id AND ROWNUM = 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        v_location := 'Unknown';
    END;
      
    -- Insert into Dangerous_People_Operations table
    INSERT INTO Dangerous_People_Operations (Operation_Id, Person_Id, Danger_Level, Location)
    VALUES (v_operation_id, rec.Id, v_danger_level, v_location);
      
    v_operation_id := v_operation_id + 1;
  END LOOP;
END Insert_Dangerous_People;
/
