-- Create the Dangerous_People_Operations table
CREATE TABLE Dangerous_People_Operations
(
  Operation_Id INT PRIMARY KEY,
  Person_Id INT NOT NULL,
  Danger_Level INT NOT NULL,
  Location VARCHAR2(50) NOT NULL,
  FOREIGN KEY (Person_Id) REFERENCES Humen(Id)
);
