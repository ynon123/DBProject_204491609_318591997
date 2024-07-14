-- 1. make the unitops table 
create table unitOps
(
  id INT NOT NULL,
  unitID INT NOT NULL,
  PRIMARY KEY (unitID, id),
  FOREIGN KEY (id) REFERENCES humen(ID),
  FOREIGN KEY (unitID) REFERENCES Unit(unitID)
);


-- 2. insert value into unitops table
-- הכנסת נתונים לטבלת unitops עם שילובים רנדומליים
INSERT INTO unitops (ID, unitID)  -- הכנסת נתונים לטבלה
SELECT h.Id, u.unitID  -- בחירת העמודות Id ו-unitID מהשילוב הרנדומלי
FROM (
  -- בחירת מזהי אנשים מסוכנים
  SELECT person_id AS Id
  FROM dangerous_people_operations
  WHERE danger_level > 50  -- רק אנשים עם רמת סיכון מעל 50
) h  -- מתן שם לטבלה הזמנית כ-h

CROSS JOIN (
  -- בחירת 200 יחידות באופן רנדומלי
  SELECT unitID
  FROM (
    SELECT unitID
    FROM Unit
    ORDER BY DBMS_RANDOM.VALUE  -- סידור רשומות היחידות באופן רנדומלי
  )
  WHERE ROWNUM <= 5  -- בחירת 5 היחידות באופן רנדומלי
) u  -- מתן שם לטבלה הזמנית כ-u
WHERE ROWNUM <= 3000;  --  הגבלת התוצאה ל3000 הרשומות הראשונות

