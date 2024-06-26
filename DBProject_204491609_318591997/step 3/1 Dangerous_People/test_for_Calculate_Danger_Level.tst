PL/SQL Developer Test script 3.0
17
DECLARE
  v_danger_level INT;
  v_id Humen.Id%TYPE;
  CURSOR c_humen IS
    SELECT Id
    FROM Humen;
BEGIN
  FOR r_humen IN c_humen LOOP
    v_id := r_humen.Id;
    v_danger_level := Calculate_Danger_Level(v_id);

    IF v_danger_level = 50 THEN
      DBMS_OUTPUT.PUT_LINE('Person with Id ' || v_id || ' has a danger level of 50.');
    END IF;
  END LOOP;
END;
/
0
0
