-- Insert data into Humen table
INSERT ALL
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (442801609, 'Sana', 'Taheri', TO_DATE('1980-01-25', 'YYYY-MM-DD'), 'F')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (105099652, 'Mohammed', 'Habibi', TO_DATE('1974-04-09', 'YYYY-MM-DD'), 'M')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (834194682, 'Ali', 'Habibi', TO_DATE('1999-09-22', 'YYYY-MM-DD'), 'M')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (623422634, 'Ahmad', 'Taheri', TO_DATE('1989-05-13', 'YYYY-MM-DD'), 'M')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (531492522, 'Mohammed', 'Al-Fayed', TO_DATE('1995-05-01', 'YYYY-MM-DD'), 'M')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (474638539, 'Layla', 'Al-Fayed', TO_DATE('1986-10-05', 'YYYY-MM-DD'), 'F')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (708178579, 'Sana', 'Al-Fayed', TO_DATE('1982-02-28', 'YYYY-MM-DD'), 'F')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (350841285, 'Ali', 'Al-Fayed', TO_DATE('1992-10-20', 'YYYY-MM-DD'), 'M')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (586297529, 'Huda', 'Qureshi', TO_DATE('1991-01-13', 'YYYY-MM-DD'), 'F')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (406078515, 'Layla', 'Taheri', TO_DATE('1980-11-06', 'YYYY-MM-DD'), 'F')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (369772246, 'Layla', 'Al-Fayed', TO_DATE('1973-12-04', 'YYYY-MM-DD'), 'F')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (630720215, 'Fatima', 'Al-Fayed', TO_DATE('1986-07-20', 'YYYY-MM-DD'), 'F')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (409040385, 'Sana', 'Habibi', TO_DATE('1999-12-22', 'YYYY-MM-DD'), 'F')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (933452704, 'Sana', 'Al-Fayed', TO_DATE('1961-05-29', 'YYYY-MM-DD'), 'M')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (425051159, 'Omar', 'Taheri', TO_DATE('1996-06-23', 'YYYY-MM-DD'), 'M')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (568689857, 'Aisha', 'Qureshi', TO_DATE('1988-04-08', 'YYYY-MM-DD'), 'F')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (777761253, 'Ali', 'Al-Fayed', TO_DATE('2000-07-20', 'YYYY-MM-DD'), 'M')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (699531509, 'Ahmad', 'Al-Fayed', TO_DATE('1999-03-22', 'YYYY-MM-DD'), 'M')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (506422538, 'Omar', 'Sabbagh', TO_DATE('2003-12-26', 'YYYY-MM-DD'), 'M')
  INTO Humen (ID, FIRST_NAME, LAST_NAME, BIRTH_DAY, GENDER) VALUES (151841708, 'Yusuf', 'Habibi', TO_DATE('2001-07-02', 'YYYY-MM-DD'), 'M')
SELECT * FROM dual;

-- Insert data into vehicle table
INSERT ALL
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('694-02-245', 'blue', 'Mazda', TO_DATE('2011-06-26', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('15-900-42', 'green', 'Hyundai', TO_DATE('2005-01-30', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('56-824-17', 'blue', 'Hyundai', TO_DATE('2008-02-26', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('428-14-654', 'black', 'Mazda', TO_DATE('2014-02-09', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('187-75-517', 'white', 'Kia', TO_DATE('2003-12-12', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('60-452-29', 'white', 'Toyota', TO_DATE('2012-10-11', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('113-30-601', 'white', 'Hyundai', TO_DATE('2013-05-26', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('77-936-15', 'green', 'Mazda', TO_DATE('2007-06-28', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('92-635-11', 'black', 'Toyota', TO_DATE('2000-12-09', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('31-764-30', 'black', 'Kia', TO_DATE('2007-05-07', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('137-65-821', 'white', 'Kia', TO_DATE('2020-04-14', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('29-668-75', 'red', 'Mazda', TO_DATE('2016-12-16', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('38-930-55', 'white', 'Toyota', TO_DATE('2010-12-13', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('824-92-694', 'blue', 'Mazda', TO_DATE('2016-01-03', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('180-13-204', 'red', 'Mazda', TO_DATE('2000-07-08', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('52-275-86', 'green', 'Mazda', TO_DATE('2018-01-10', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('918-91-634', 'green', 'Mazda', TO_DATE('2018-03-20', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('76-993-00', 'black', 'Hyundai', TO_DATE('2006-03-11', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('89-451-74', 'green', 'Kia', TO_DATE('2010-04-21', 'YYYY-MM-DD'))
  INTO vehicle (LICENSE_PLATE, COLOR, CAR_COMPANY, DATE_MANUACTURING) VALUES ('66-022-34', 'green', 'Hyundai', TO_DATE('2011-05-14', 'YYYY-MM-DD'))
SELECT * FROM dual;

-- Insert data into Phone table
INSERT ALL
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('035109032', 'Partner', 0, 442801609)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('03-7300-869', 'Pelephone', 1, 105099652)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('03-4131-456', 'Cellcom', 1, 834194682)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('04-0870-916', 'Hot Mobile', 0, 623422634)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('084579230', 'Partner', 0, 531492522)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('04-2584-197', 'Cellcom', 0, 474638539)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('04-0769-845', 'Partner', 0, 708178579)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('054 280 7150', 'Cellcom', 1, 350841285)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('092375945', 'Pelephone', 1, 586297529)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('044661093', 'Cellcom', 1, 406078515)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('052-337-6960', 'Cellcom', 0, 369772246)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('059 602 7142', 'Cellcom', 1, 630720215)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('058 7890075', 'Pelephone', 1, 409040385)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('09-7063-812', 'Cellcom', 1, 933452704)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('026650300', 'Cellcom', 0, 425051159)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('03-3193-442', 'Pelephone', 1, 568689857)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('03-7610-471', 'Hot Mobile', 1, 777761253)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('092851240', 'Partner', 1, 699531509)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('02-0348-559', 'Partner', 0, 506422538)
  INTO Phone (PHONE_NUMBER, TEL_COMPANY, SMARTPHONE, ID) VALUES ('02-9776-582', 'Cellcom', 1, 151841708)
SELECT * FROM dual;


-- Insert data into Phone_Calls table
INSERT ALL
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('02-0762-791', '045609767', TO_DATE('2001-08-07', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('03-7200-992', '051-853-6710', TO_DATE('2020-10-04', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('059 5194264', '03-8306-753', TO_DATE('2015-07-01', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('051 007-4089', '083188684', TO_DATE('2003-11-10', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('046961161', '03-6207-660', TO_DATE('2016-11-23', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('054-151-1505', '052 035-1923', TO_DATE('2000-02-10', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('081045093', '042717542', TO_DATE('2000-12-13', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('085574485', '04-9118-942', TO_DATE('2012-10-24', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('042358332', '09-5602-906', TO_DATE('2002-08-26', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('032648629', '054-5137580', TO_DATE('2012-10-22', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('050-6573547', '032141892', TO_DATE('2015-03-07', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('052 662 3758', '045717340', TO_DATE('2015-04-13', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('050 3414892', '057-1738640', TO_DATE('2004-02-10', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('090046896', '051 4543910', TO_DATE('2002-05-25', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('094851832', '036448298', TO_DATE('2007-02-26', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('03-6864-475', '042116697', TO_DATE('2004-09-30', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('09-5763-778', '057-074-2709', TO_DATE('2007-05-04', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('025760811', '050 501 9044', TO_DATE('2007-09-18', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('049431675', '052 566 2728', TO_DATE('2010-10-03', 'YYYY-MM-DD'))
  INTO Phone_Calls (A_Side, B_Side, Start_Time) VALUES ('043275667', '053 373 9060', TO_DATE('2007-12-18', 'YYYY-MM-DD'))
SELECT 1 FROM DUAL;


-- Insert data into Live_In table
INSERT ALL
  INTO Live_In (Id) VALUES (442801609)
  INTO Live_In (Id) VALUES (105099652)
  INTO Live_In (Id) VALUES (834194682)
  INTO Live_In (Id) VALUES (623422634)
  INTO Live_In (Id) VALUES (531492522)
  INTO Live_In (Id) VALUES (474638539)
  INTO Live_In (Id) VALUES (708178579)
  INTO Live_In (Id) VALUES (350841285)
  INTO Live_In (Id) VALUES (586297529)
  INTO Live_In (Id) VALUES (406078515)
  INTO Live_In (Id) VALUES (369772246)
  INTO Live_In (Id) VALUES (630720215)
  INTO Live_In (Id) VALUES (409040385)
  INTO Live_In (Id) VALUES (933452704)
  INTO Live_In (Id) VALUES (425051159)
  INTO Live_In (Id) VALUES (568689857)
  INTO Live_In (Id) VALUES (777761253)
  INTO Live_In (Id) VALUES (699531509)
  INTO Live_In (Id) VALUES (506422538)
  INTO Live_In (Id) VALUES (151841708)
SELECT 1 FROM DUAL;


-- Insert data into Terror_Organization table
INSERT ALL
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Al-Qaeda', 'Ahmad', TO_DATE('2012-08-28', 'YYYY-MM-DD'), 442801609)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Al-Qaeda', 'Omar', TO_DATE('2005-10-19', 'YYYY-MM-DD'), 105099652)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Hamas', 'Omar', TO_DATE('2011-04-25', 'YYYY-MM-DD'), 834194682)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Hamas', 'Mohammed', TO_DATE('2014-07-01', 'YYYY-MM-DD'), 623422634)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Hamas', 'Omar', TO_DATE('2002-02-11', 'YYYY-MM-DD'), 531492522)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('ISIS', 'Ali', TO_DATE('2003-06-04', 'YYYY-MM-DD'), 474638539)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Hezbollah', 'Omar', TO_DATE('2004-12-23', 'YYYY-MM-DD'), 708178579)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Hezbollah', 'Yusuf', TO_DATE('2007-06-11', 'YYYY-MM-DD'), 350841285)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('ISIS', 'Ali', TO_DATE('2001-07-16', 'YYYY-MM-DD'), 586297529)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('ISIS', 'Omar', TO_DATE('2019-07-11', 'YYYY-MM-DD'), 406078515)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Islamic Jihad', 'Omar', TO_DATE('2018-03-05', 'YYYY-MM-DD'), 369772246)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Hezbollah', 'Ahmad', TO_DATE('2020-06-27', 'YYYY-MM-DD'), 630720215)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Al-Qaeda', 'Ali', TO_DATE('2002-07-08', 'YYYY-MM-DD'), 409040385)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Hamas', 'Mohammed', TO_DATE('2000-11-27', 'YYYY-MM-DD'), 933452704)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Hamas', 'Mohammed', TO_DATE('2004-03-26', 'YYYY-MM-DD'), 425051159)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Islamic Jihad', 'Yusuf', TO_DATE('2006-05-31', 'YYYY-MM-DD'), 568689857)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Hamas', 'Mohammed', TO_DATE('2020-08-18', 'YYYY-MM-DD'), 777761253)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Al-Qaeda', 'Mohammed', TO_DATE('2019-08-06', 'YYYY-MM-DD'), 699531509)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Hamas', 'Mohammed', TO_DATE('2004-01-27', 'YYYY-MM-DD'), 506422538)
  INTO Terror_Organization (Organization_Name, Leader, Foundation_Year, Id) VALUES ('Al-Qaeda', 'Mohammed', TO_DATE('2013-04-23', 'YYYY-MM-DD'), 151841708)
SELECT 1 FROM DUAL;


-- Insert data into Incrimination table
INSERT ALL
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2002-11-18', 'YYYY-MM-DD'), 14, 'Beit Hanoun', 442801609)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2006-05-09', 'YYYY-MM-DD'), 26, 'Beit Lahia', 105099652)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2012-05-15', 'YYYY-MM-DD'), 21, 'Beit Hanoun', 834194682)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2001-12-09', 'YYYY-MM-DD'), 41, 'Jabalia', 623422634)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2005-11-24', 'YYYY-MM-DD'), 25, 'Beit Lahia', 531492522)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2007-12-06', 'YYYY-MM-DD'), 1, 'Beit Lahia', 474638539)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2020-10-12', 'YYYY-MM-DD'), 41, 'Nuseirat', 708178579)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2010-02-14', 'YYYY-MM-DD'), 38, 'Jabalia', 350841285)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2020-11-02', 'YYYY-MM-DD'), 32, 'Beit Hanoun', 586297529)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2002-12-12', 'YYYY-MM-DD'), 33, 'Bureij', 406078515)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2017-06-04', 'YYYY-MM-DD'), 42, 'Beit Hanoun', 369772246)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2009-09-04', 'YYYY-MM-DD'), 38, 'Bureij', 630720215)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2012-01-05', 'YYYY-MM-DD'), 47, 'Beit Hanoun', 409040385)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2013-12-31', 'YYYY-MM-DD'), 40, 'Bureij', 933452704)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2015-08-05', 'YYYY-MM-DD'), 1, 'Beit Lahia', 425051159)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2001-11-01', 'YYYY-MM-DD'), 48, 'Nuseirat', 568689857)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2017-07-24', 'YYYY-MM-DD'), 39, 'Beit Hanoun', 777761253)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2018-08-14', 'YYYY-MM-DD'), 46, 'Beit Hanoun', 699531509)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2014-08-26', 'YYYY-MM-DD'), 8, 'Nuseirat', 506422538)
  INTO Incrimination (Event_Time, Casualties, Location, Id) VALUES (TO_DATE('2019-10-07', 'YYYY-MM-DD'), 23, 'Beit Lahia', 151841708)
SELECT 1 FROM DUAL;

-- Insert data into Weapon table
INSERT ALL
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('HK416', 4233, 'Rafael', '22 kg', 442801609)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('AR-15', 8951, 'Rafael', '7 kg', 105099652)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('HK416', 1715, 'Rafael', '24 kg', 834194682)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('Ak-47', 4100, 'IWI', '19 kg', 623422634)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('Desert Eagle', 9408, 'Elbit Systems', '7 kg', 531492522)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('M4 Carbine', 1167, 'IWI', '29 kg', 474638539)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('Glock 19', 6088, 'Rafael', '12 kg', 708178579)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('Desert Eagle', 3777, 'IMI', '29 kg', 350841285)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('MP5', 8472, 'IWI', '29 kg', 586297529)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('Uzi', 1209, 'Rafael', '27 kg', 406078515)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('HK416', 1288, 'Rafael', '9 kg', 369772246)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('Glock 19', 7236, 'Elbit Systems', '9 kg', 630720215)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('Ak-47', 8159, 'Elbit Systems', '14 kg', 409040385)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('Glock 19', 8033, 'IWI', '27 kg', 933452704)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('M4 Carbine', 6941, 'Elbit Systems', '22 kg', 425051159)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('AR-15', 1032, 'Rafael', '21 kg', 568689857)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('Glock 19', 2286, 'IMI', '28 kg', 777761253)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('HK416', 2079, 'IMI', '14 kg', 699531509)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('Desert Eagle', 9239, 'Elbit Systems', '21 kg', 506422538)
  INTO Weapon (Model, Serial, Company, Weight, Id) VALUES ('Ak-47', 7996, 'IMI', '24 kg', 151841708)
SELECT 1 FROM DUAL;


-- Insert data into Arrest table
INSERT ALL
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2018-12-23', 'YYYY-MM-DD'), 'Omar', 'Megiddo', 809831, 442801609)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2007-07-09', 'YYYY-MM-DD'), 'Ahmad', 'Ofer', 983901, 105099652)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2015-06-09', 'YYYY-MM-DD'), 'Ali', 'Ramon', 728814, 834194682)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2006-07-24', 'YYYY-MM-DD'), 'Ahmad', 'Ofer', 736153, 623422634)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2011-07-21', 'YYYY-MM-DD'), 'Mohammed', 'Ktziot', 528598, 531492522)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2020-09-11', 'YYYY-MM-DD'), 'Yusuf', 'Damon', 887455, 474638539)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2003-06-25', 'YYYY-MM-DD'), 'Yusuf', 'Ofer', 331822, 708178579)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2020-08-18', 'YYYY-MM-DD'), 'Ahmad', 'Damon', 879419, 350841285)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2002-11-30', 'YYYY-MM-DD'), 'Yusuf', 'Megiddo', 998355, 586297529)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2010-11-08', 'YYYY-MM-DD'), 'Ahmad', 'Ramon', 220120, 406078515)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2010-12-27', 'YYYY-MM-DD'), 'Mohammed', 'Ofer', 578395, 369772246)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2018-03-26', 'YYYY-MM-DD'), 'Ali', 'Megiddo', 243262, 630720215)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2015-07-04', 'YYYY-MM-DD'), 'Ali', 'Ramon', 750427, 409040385)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2011-01-23', 'YYYY-MM-DD'), 'Mohammed', 'Ofer', 242687, 933452704)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2008-09-10', 'YYYY-MM-DD'), 'Yusuf', 'Ramon', 314458, 425051159)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2000-12-24', 'YYYY-MM-DD'), 'Omar', 'Ofer', 170051, 568689857)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2017-10-05', 'YYYY-MM-DD'), 'Ali', 'Ofer', 956167, 777761253)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2001-07-05', 'YYYY-MM-DD'), 'Ali', 'Ktziot', 125317, 699531509)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2006-06-20', 'YYYY-MM-DD'), 'Mohammed', 'Megiddo', 517922, 506422538)
  INTO Arrest (Arrest_Date, Investigator_Name, Location, Prison_Number, Id) VALUES (TO_DATE('2012-07-18', 'YYYY-MM-DD'), 'Ali', 'Damon', 492658, 151841708)
SELECT 1 FROM DUAL;


-- Insert data into Hold table
INSERT ALL
  INTO Hold (Id, License_plate) VALUES (442801609, '694-02-245')
  INTO Hold (Id, License_plate) VALUES (105099652, '15-900-42')
  INTO Hold (Id, License_plate) VALUES (834194682, '56-824-17')
  INTO Hold (Id, License_plate) VALUES (623422634, '428-14-654')
  INTO Hold (Id, License_plate) VALUES (531492522, '187-75-517')
  INTO Hold (Id, License_plate) VALUES (474638539, '60-452-29')
  INTO Hold (Id, License_plate) VALUES (708178579, '113-30-601')
  INTO Hold (Id, License_plate) VALUES (350841285, '77-936-15')
  INTO Hold (Id, License_plate) VALUES (586297529, '92-635-11')
  INTO Hold (Id, License_plate) VALUES (406078515, '31-764-30')
  INTO Hold (Id, License_plate) VALUES (369772246, '137-65-821')
  INTO Hold (Id, License_plate) VALUES (630720215, '29-668-75')
  INTO Hold (Id, License_plate) VALUES (409040385, '38-930-55')
  INTO Hold (Id, License_plate) VALUES (933452704, '824-92-694')
  INTO Hold (Id, License_plate) VALUES (425051159, '180-13-204')
  INTO Hold (Id, License_plate) VALUES (568689857, '52-275-86')
  INTO Hold (Id, License_plate) VALUES (777761253, '918-91-634')
  INTO Hold (Id, License_plate) VALUES (699531509, '76-993-00')
  INTO Hold (Id, License_plate) VALUES (506422538, '89-451-74')
  INTO Hold (Id, License_plate) VALUES (151841708, '66-022-34')
SELECT 1 FROM DUAL;


-- Insert data into Calls table
INSERT ALL
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('035109032', '02-0762-791', '045609767', TO_DATE('2001-08-07', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('03-7300-869', '03-7200-992', '051-853-6710', TO_DATE('2020-10-04', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('03-4131-456', '059 5194264', '03-8306-753', TO_DATE('2015-07-01', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('04-0870-916', '051 007-4089', '083188684', TO_DATE('2003-11-10', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('084579230', '046961161', '03-6207-660', TO_DATE('2016-11-23', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('04-2584-197', '054-151-1505', '052 035-1923', TO_DATE('2000-02-10', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('04-0769-845', '081045093', '042717542', TO_DATE('2000-12-13', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('054 280 7150', '085574485', '04-9118-942', TO_DATE('2012-10-24', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('092375945', '042358332', '09-5602-906', TO_DATE('2002-08-26', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('044661093', '032648629', '054-5137580', TO_DATE('2012-10-22', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('052-337-6960', '050-6573547', '032141892', TO_DATE('2015-03-07', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('059 602 7142', '052 662 3758', '045717340', TO_DATE('2015-04-13', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('058 7890075', '050 3414892', '057-1738640', TO_DATE('2004-02-10', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('09-7063-812', '090046896', '051 4543910', TO_DATE('2002-05-25', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('026650300', '094851832', '036448298', TO_DATE('2007-02-26', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('03-3193-442', '03-6864-475', '042116697', TO_DATE('2004-09-30', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('03-7610-471', '09-5763-778', '057-074-2709', TO_DATE('2007-05-04', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('092851240', '025760811', '050 501 9044', TO_DATE('2007-09-18', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('02-0348-559', '049431675', '052 566 2728', TO_DATE('2010-10-03', 'YYYY-MM-DD'))
  INTO Calls (Phone_Number, A_Side, B_Side, Start_Time) VALUES ('02-9776-582', '043275667', '053 373 9060', TO_DATE('2007-12-18', 'YYYY-MM-DD'))
SELECT 1 FROM DUAL;


-- Insert data into House table
INSERT ALL
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Bureij', 4, 17, 'Rafah Border Line Rd, Southern Gaza, House #7', 'Habibi', 442801609)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Beit Lahia', 10, 7, 'Al-Bureij Main St, Gaza, Apartment #28', 'Sabbagh', 105099652)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Bureij', 5, 12, 'Sheikh Radwan Neighborhood, Gaza City, Apartment #75', 'Habibi', 834194682)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Beit Lahia', 1, 14, 'Al-Zahra City Center, Gaza, Apartment #19', 'Taheri', 623422634)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Nuseirat', 2, 15, 'Jabalia Camp Alley, Northern Gaza, House #98', 'Taheri', 531492522)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Jabalia', 2, 5, 'Khan Younis Blvd, Southern Gaza, Apartment #14', 'Taheri', 474638539)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Jabalia', 8, 18, 'Khan Younis Blvd, Southern Gaza, House #72', 'Sabbagh', 708178579)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Bureij', 7, 1, 'Sheikh Radwan Neighborhood, Gaza City, Apartment #18', 'Al-Fayed', 350841285)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Nuseirat', 1, 8, 'Beit Hanoun Community Rd, Northern Gaza, House #75', 'Qureshi', 586297529)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Bureij', 6, 5, 'Al-Maghazi Camp Avenue, Central Gaza, House #34', 'Qureshi', 406078515)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Nuseirat', 1, 7, 'Al-Maghazi Camp Avenue, Central Gaza, Apartment #31', 'Sabbagh', 369772246)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Bureij', 2, 19, 'Rafah Border Line Rd, Southern Gaza, House #98', 'Al-Fayed', 630720215)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Jabalia', 8, 9, 'Al-Zahra City Center, Gaza, Apartment #38', 'Al-Fayed', 409040385)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Nuseirat', 9, 17, 'Beit Hanoun Community Rd, Northern Gaza, Apartment #37', 'Habibi', 933452704)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Bureij', 6, 7, 'Al-Nuseirat Refugee Camp, Central Gaza, House #50', 'Habibi', 425051159)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Bureij', 5, 13, 'Rafah Border Line Rd, Southern Gaza, House #19', 'Al-Fayed', 568689857)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Bureij', 4, 5, 'Al-Nuseirat Refugee Camp, Central Gaza, House #89', 'Habibi', 777761253)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Bureij', 4, 9, 'Al-Nuseirat Refugee Camp, Central Gaza, House #13', 'Habibi', 699531509)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Bureij', 6, 17, 'Rafah Border Line Rd, Southern Gaza, House #26', 'Habibi', 506422538)
  INTO House (District, Rooms_Numbers, Floor, Datum_Point, Family_Name, Id) VALUES ('Jabalia', 1, 4, 'Sheikh Radwan Neighborhood, Gaza City, Apartment #20', 'Habibi', 151841708)
SELECT 1 FROM DUAL;

