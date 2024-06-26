CREATE OR REPLACE PROCEDURE Main_Procedure IS
  v_total_inserted INT;
  v_cursor SYS_REFCURSOR;
  v_id INT;
  v_danger_level INT;
  v_location VARCHAR2(50);
  v_operation_id INT := 1;
  
BEGIN
  DBMS_OUTPUT.PUT_LINE('Procedure started.');
  BEGIN
    -- Insert_Dangerous_People ����� ��������� 
    Insert_Dangerous_People;

    -- Dangerous_People_Operations :����� ������ ������ ������� ����� ���� 
    OPEN v_cursor FOR 
    SELECT Operation_Id, Person_Id, Danger_Level, Location 
    FROM Dangerous_People_Operations;
    
    -- v_cursor :���� �� ���� ����� ��� ��� ���� ������ �"� ������ 
    LOOP
      FETCH v_cursor INTO v_operation_id, v_id, v_danger_level, v_location;
      EXIT WHEN v_cursor%NOTFOUND;
      
      -- ����� ���� ���� ����
      DBMS_OUTPUT.PUT_LINE('Operation ID: ' || v_operation_id || ', Person ID: ' || v_id || ', Danger Level: ' || v_danger_level || ', Location: ' || v_location);
    END LOOP;

    CLOSE v_cursor;

  EXCEPTION
    WHEN OTHERS THEN
      -- ����� ������� ����� ����� ������
      DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM || ' at ' || TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS.FF'));
      RAISE;
  END;

  -- ����� ���� ������ �������
  SELECT COUNT(*) INTO v_total_inserted FROM Dangerous_People_Operations;
  DBMS_OUTPUT.PUT_LINE('Total number of dangerous people inserted: ' || v_total_inserted);
  
  -- ���� ����� ���� ������
  DBMS_OUTPUT.PUT_LINE('Dangerous people insertion completed successfully.');
EXCEPTION
  WHEN OTHERS THEN
    
    -- ����� ������� ����� ����� ����� ������
    DBMS_OUTPUT.PUT_LINE('Unexpected error occurred: ' || SQLERRM || ' at ' || TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS.FF'));
    RAISE;
END Main_Procedure;
/
