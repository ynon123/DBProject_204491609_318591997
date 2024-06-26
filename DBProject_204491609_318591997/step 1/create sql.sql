CREATE TABLE Humen
(
  Id INT NOT NULL,
  First_Name varchar2(30) NOT NULL,
  Last_Name varchar2(30) NOT NULL,
  Birth_Day Date NOT NULL,
  Gender varchar2(1) NOT NULL,
  PRIMARY KEY (Id)
);

CREATE TABLE Terror_Organization
(
  Organization_Name varchar2(40) NOT NULL,
  Leader varchar2(40) NOT NULL,
  Foundation_Year Date,
  Id INT NOT NULL,
  PRIMARY KEY (Organization_Name),
  FOREIGN KEY (Id) REFERENCES Humen(Id)
);

CREATE TABLE Phone
(
  Phone_Number varchar2(30) NOT NULL,
  Tel_Company varchar2(20) NOT NULL,
  Smartphone INT,
  Id INT NOT NULL,
  PRIMARY KEY (Phone_Number),
  FOREIGN KEY (Id) REFERENCES Humen(Id)
);

CREATE TABLE vehicle
(
  License_plate varchar2(10) NOT NULL,
  Color varchar2(10) NOT NULL,
  Car_Company varchar2(10) NOT NULL,
  Date_Manuacturing Date NOT NULL,
  PRIMARY KEY (License_plate)
);

CREATE TABLE Phone_Calls
(
  A_Side varchar2(30) NOT NULL,
  B_Side varchar2(30) NOT NULL,
  Start_Time Date NOT NULL,
  PRIMARY KEY (A_Side, B_Side, Start_Time)
);

CREATE TABLE Incrimination
(
  Event_Time Date NOT NULL,
  Casualties INT NOT NULL,
  Location varchar2(50) NOT NULL,
  Id INT NOT NULL,
  PRIMARY KEY (Event_Time),
  FOREIGN KEY (Id) REFERENCES Humen(Id)
);

CREATE TABLE Weapon
(
  Model varchar2(50) NOT NULL,
  Serial INT NOT NULL,
  Company varchar2(50) NOT NULL,
  Weight varchar2(20),
  Id INT NOT NULL,
  PRIMARY KEY (Serial),
  FOREIGN KEY (Id) REFERENCES Humen(Id)
);

CREATE TABLE Arrest
(
  Arrest_Date Date NOT NULL,
  Investigator_Name varchar2(50) NOT NULL,
  Location varchar2(50) NOT NULL,
  Prison_Number INT NOT NULL,
  Id INT NOT NULL,
  PRIMARY KEY (Prison_Number),
  FOREIGN KEY (Id) REFERENCES Humen(Id)
);

CREATE TABLE Hold
(
  Id INT NOT NULL,
  License_plate varchar2(10) NOT NULL,
  PRIMARY KEY (Id, License_plate),
  FOREIGN KEY (Id) REFERENCES Humen(Id),
  FOREIGN KEY (License_plate) REFERENCES vehicle(License_plate)
);

CREATE TABLE Live_In
(
  Id INT NOT NULL,
  PRIMARY KEY (Id),
  FOREIGN KEY (Id) REFERENCES Humen(Id)
);

CREATE TABLE Calls
(
  Phone_Number varchar2(30) NOT NULL,
  A_Side varchar2(30) NOT NULL,
  B_Side varchar2(30) NOT NULL,
  Start_Time Date NOT NULL,
  PRIMARY KEY (Phone_Number),
  FOREIGN KEY (Phone_Number) REFERENCES Phone(Phone_Number),
  FOREIGN KEY (A_Side, B_Side, Start_Time) REFERENCES Phone_Calls(A_Side, B_Side, Start_Time)
);z

CREATE TABLE House
(
  District varchar2(40) NOT NULL,
  Rooms_Numbers INT NOT NULL,
  Floor INT NOT NULL,
  Datum_Point varchar2(100) NOT NULL,
  Family_Name varchar2(30) NOT NULL,
  Id INT NOT NULL,
  PRIMARY KEY (Datum_Point, Family_Name),
  FOREIGN KEY (Id) REFERENCES Live_In(Id)
);
