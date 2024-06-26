-- Create a function to calculate the danger level
CREATE OR REPLACE FUNCTION Calculate_Danger_Level(p_id INT) RETURN INT IS
  v_danger_level INT := 0;
  v_terror_count INT;
  v_weapon_count INT;
  v_incrim_count INT;
  v_datum_point VARCHAR2(100);
  v_distance_grade NUMBER;
BEGIN
  -- Check if the person is in a terror organization
  SELECT COUNT(*) INTO v_terror_count FROM Terror_Organization WHERE Id = p_id;
  IF v_terror_count > 0 THEN
    v_danger_level := v_danger_level + 3;
  END IF;

  -- Check if the person has a weapon
  SELECT COUNT(*) INTO v_weapon_count
  FROM Weapon
  WHERE Id = p_id and model in ('HK416', 'AR-15', 'Ak-47', 'Desert Eagle', 'M4 Carbine', 'Glock 19', 'MP5', 'Uzi');
  IF v_weapon_count > 0 THEN
    v_danger_level := v_danger_level + 10;
  END IF;

  -- Check if the person has incriminations and sum the casualties
  SELECT SUM(Casualties) INTO v_incrim_count FROM Incrimination WHERE Id = p_id AND Casualties > 0;
  IF v_incrim_count > 0 THEN
    v_danger_level := v_danger_level + v_incrim_count;
  END IF;
  
  -- Fetch the datum_point and calculate the distance grade
  BEGIN
    SELECT Datum_Point INTO v_datum_point 
    FROM House 
    WHERE Id = p_id;
    
    v_distance_grade := Calculate_Distance(v_datum_point);
    v_danger_level := v_danger_level + v_distance_grade;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_distance_grade := 0; -- Default value if no datum_point found
  END;

  RETURN v_danger_level;
EXCEPTION
  WHEN OTHERS THEN
    -- Handle unexpected errors and ensure a return value
    RETURN v_danger_level;
END Calculate_Danger_Level;
/
