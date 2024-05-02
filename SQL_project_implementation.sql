CREATE DATABASE HOSPITAL;
CREATE TABLE Staff (
    SSN VARCHAR(11) PRIMARY KEY,
    FirstName VARCHAR(10) NOT NULL,
    LastName VARCHAR(15) NOT NULL,
    BirthDate DATE NOT NULL,
    Gender ENUM('male', 'female') NOT NULL,
    YearsOfExperience INT CHECK (YearsOfExperience >= 0),
    Email VARCHAR(25) UNIQUE,
    PhoneNumber VARCHAR(13),
    Department VARCHAR(10),
    Salary INT CHECK (Salary >= 0)
);
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    Specialty VARCHAR(10) NOT NULL,
    StaffSSN VARCHAR(11) UNIQUE,
    FOREIGN KEY (StaffSSN) REFERENCES Staff(SSN)
);
CREATE TABLE Secretaries (
    SecretaryID INT PRIMARY KEY,
    StaffSSN VARCHAR(11) UNIQUE,
    FOREIGN KEY (StaffSSN) REFERENCES Staff(SSN)
);
CREATE TABLE TrainingPrograms (
    TrainingID INT PRIMARY KEY,
    CourseName VARCHAR(10) NOT NULL,
    CertificationStatus varchar(12) NOT NULL,
    CompletionDate DATE
);
CREATE TABLE Financial_Records (
    Record_ID INT PRIMARY KEY,
    Amount DECIMAL(15, 2) NOT NULL,
    Type VARCHAR(11) NOT NULL,
    Date DATE NOT NULL
);
CREATE TABLE Equipment (
    Equipment_ID INT PRIMARY KEY,
    Name VARCHAR(15) NOT NULL,
    Category VARCHAR(10) NOT NULL,
    Manufacturer VARCHAR(15),
    Expiry_Date DATE
);
CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    Patient_Gender ENUM('male', 'female') NOT NULL,
    P_FirstName VARCHAR(15) NOT NULL,
    P_LastName VARCHAR(15) NOT NULL,
    P_PhoneNumber VARCHAR(15),
    P_Birthday DATE NOT NULL,
    City VARCHAR(10),
    Street VARCHAR(10),
    Building VARCHAR(12)
);
CREATE TABLE Interactions (
    Interaction_ID INT PRIMARY KEY,
    Interaction_Location VARCHAR(20),
    Interaction_Date DATE NOT NULL,
    Interaction_Time TIME,
    Doctor_ID INT,
    Secretary_ID INT,
    Patient_ID INT NOT NULL,
    Interaction_Outcome TEXT,
    Interaction_Description TEXT,
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
    FOREIGN KEY (Secretary_ID) REFERENCES Secretary(Secretary_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);
CREATE TABLE Room (
    Room_Number INT PRIMARY KEY,
    Room_Type VARCHAR(15) NOT NULL,
    Capacity INT CHECK (Capacity > 0),
    Room_Location VARCHAR(15),
    Status VARCHAR(10) NOT NULL
);
CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY,
    Appointment_Date DATE NOT NULL,
    Appointment_Time TIME,
    Secretary_ID INT NOT NULL,
    Patient_ID INT NOT NULL,
    FOREIGN KEY (Secretary_ID) REFERENCES Secretary(Secretary_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);
CREATE TABLE Maintenance (
    Maintenance_ID INT PRIMARY KEY,
    Maintenance_Type VARCHAR(25) NOT NULL,
    Maintenance_Date DATE,
    Maintenance_Details TEXT
);
CREATE TABLE Feedback (
    Feedback_ID INT PRIMARY KEY,
    Feedback_Date DATE NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 10 ),
    Comments TEXT,
    Patient_ID INT NOT NULL,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);
CREATE TABLE Medical_Test (
    Test_ID INT PRIMARY KEY,
    Test_Name VARCHAR(15) NOT NULL,
    Description TEXT
);
CREATE TABLE Test_Result (
    Result_ID INT PRIMARY KEY,
    Test_ID INT NOT NULL,
    Result_Outcome TEXT,
    FOREIGN KEY (Test_ID) REFERENCES Medical_Test(Test_ID)
);

CREATE TABLE Insurance (
    Insurance_ID INT PRIMARY KEY,
    Policy_Number VARCHAR(10) NOT NULL,
    Provider VARCHAR(15) NOT NULL,
    Coverage_Details TEXT,
    Patient_ID INT NOT NULL,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);
CREATE TABLE Medical_Records (
    RecordNumber INT PRIMARY KEY,
    Patient_ID INT NOT NULL,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);
CREATE TABLE Pharmacy (
    Pharmacy_Name VARCHAR(17) PRIMARY KEY,
    Pharmacy_Location VARCHAR(9),
    Operating_Hours_From TIME,
    Operating_Hours_To TIME
);
CREATE TABLE Medicine (
    Medicine_ID INT PRIMARY KEY,
    Medicine_Name VARCHAR(25) NOT NULL,
    Form VARCHAR(50),
    Medicine_Description TEXT,
    Expiry_Date DATE,
    Price DECIMAL(10, 2)
);
CREATE TABLE Patient_Diagnosis (
    Diagnosis_ID INT PRIMARY KEY,
    Record_Number INT NOT NULL,
    Prognosis TEXT,
    Diagnosis_Date DATE NOT NULL,
    Results TEXT,
    FOREIGN KEY (Record_Number) REFERENCES Medical_Records(Record_Number)
);
CREATE TABLE Treatment_Plan (
    Treatment_ID INT PRIMARY KEY,
    Record_Number INT NOT NULL,
    Diagnosis_ID INT NOT NULL,
    Medicine_ID INT,
    Procedures TEXT,
    Start DATE,
    End DATE,
    FOREIGN KEY (Record_Number) REFERENCES Medical_Records(RecordNumber),
    FOREIGN KEY (Diagnosis_ID) REFERENCES Patient_Diagnosis(Diagnosis_ID),
    FOREIGN KEY (Medicine_ID) REFERENCES Medicine(Medicine_ID)
);
CREATE TABLE Treats (
    SSN VARCHAR(11) NOT NULL,
    Doc_ID INT NOT NULL,
    Patient_ID INT NOT NULL,
    FOREIGN KEY (SSN) REFERENCES Staff(SSN),
    FOREIGN KEY (Doc_ID) REFERENCES Doctor(Doctor_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    PRIMARY KEY (SSN, Doc_ID, Patient_ID)
);
CREATE TABLE Undergoes (
    Room_Number INT NOT NULL,
    Maintenance_ID INT NOT NULL,
    FOREIGN KEY (Room_Number) REFERENCES Room(Room_Number),
    FOREIGN KEY (Maintenance_ID) REFERENCES Maintenance(Maintenance_ID),
    PRIMARY KEY (Room_Number, Maintenance_ID)
);
CREATE TABLE Assigns (
    Doctor_ID INT NOT NULL,
    Room_Number INT NOT NULL,
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
    FOREIGN KEY (Room_Number) REFERENCES Room(Room_Number),
    PRIMARY KEY (Doctor_ID, Room_Number)
);
CREATE TABLE Undertakes (
    Test_ID INT NOT NULL,
    Patient_ID INT NOT NULL,
    Date DATE NOT NULL,
    FOREIGN KEY (Test_ID) REFERENCES Medical_Test(Test_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    PRIMARY KEY (Test_ID, Patient_ID, Date)
);
CREATE TABLE Access (
    Patient_ID INT NOT NULL,
    Pharmacy_Name VARCHAR(9) NOT NULL,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Pharmacy_Name) REFERENCES Pharmacy(Pharmacy_Name),
    PRIMARY KEY (Patient_ID, Pharmacy_Name)
);
CREATE TABLE Includes (
    Pharmacy_Name VARCHAR(9) NOT NULL,
    Medicine_ID INT NOT NULL,
    FOREIGN KEY (Pharmacy_Name) REFERENCES Pharmacy(Pharmacy_Name),
    FOREIGN KEY (Medicine_ID) REFERENCES Medicine(Medicine_ID),
    PRIMARY KEY (Pharmacy_Name, Medicine_ID)
);CREATE TABLE Engage (
    SSN VARCHAR(11) NOT NULL,
    Training_ID INT NOT NULL,
    FOREIGN KEY (SSN) REFERENCES Staff(SSN),
    FOREIGN KEY (Training_ID) REFERENCES Training(Training_ID),
    PRIMARY KEY (SSN, Training_ID)
);
CREATE TABLE Cover (
    Record_ID INT NOT NULL,
    Equipment_ID INT NOT NULL,
    Maintenance_ID INT NOT NULL,
    SSN VARCHAR(11) NOT NULL,
    FOREIGN KEY (Record_ID) REFERENCES Financial_Records(Record_ID),
    FOREIGN KEY (Equipment_ID) REFERENCES Equipment(Equipment_ID),
    FOREIGN KEY (Maintenance_ID) REFERENCES Maintenance(Maintenance_ID),
    FOREIGN KEY (SSN) REFERENCES Staff(SSN),
    PRIMARY KEY (Record_ID, Equipment_ID, Maintenance_ID, SSN)
);
INSERT INTO STAFF VALUES ('123-45-6789', 'John', 'Doe', '1985-07-12', 'Male', 8, 'johndoe@email.com', '+1 (123) 456-7890', 'Cardiology', 60000);
INSERT INTO STAFF VALUES ('234-56-7890', 'Jane', 'Smith', '1990-03-25', 'Female', 5, 'janesmith@email.com', '+1 (234) 567-8901', 'Oncology', 55000);
INSERT INTO STAFF VALUES ('345-67-8901', 'David', 'Johnson', '1980-11-05', 'Male', 12, 'davidjohnson@email.com', '+1 (345) 678-9012', 'Neurology', 75000);
INSERT INTO STAFF VALUES ('456-78-9012', 'Emily', 'Williams', '1992-09-18', 'Female', 3, 'emilywilliams@email.com', '+1 (456) 789-0123', 'Pediatrics', 52000);
INSERT INTO STAFF VALUES ('567-89-0123', 'Michael', 'Brown', '1988-04-30', 'Male', 7, 'michaelbrown@email.com', '+1 (567) 890-1234', 'Radiology', 62000);
INSERT INTO STAFF VALUES ('678-90-1234', 'Sarah', 'Miller', '1995-12-08', 'Female', 2, 'sarahmiller@email.com', '+1 (678) 901-2345', 'Orthopedics', 48000);
INSERT INTO STAFF VALUES ('789-01-2345', 'Christopher', 'Davis', '1983-06-22', 'Male', 10, 'christopherdavis@email.com', '+1 (789) 012-3456', 'Emergency Department', 80000);
INSERT INTO STAFF VALUES ('890-12-3456', 'Olivia', 'Wilson', '1987-02-14', 'Female', 6, 'oliviawilson@email.com', '+1 (890) 123-4567', 'Gastroenterology', 58000);
INSERT INTO STAFF VALUES ('901-23-4567', 'Daniel', 'Taylor', '1993-10-10', 'Male', 4, 'danieltaylor@email.com', '+1 (901) 234-5678', 'Dermatology', 51000);
INSERT INTO STAFF VALUES ('012-34-5678', 'Ava', 'Anderson', '1989-08-27', 'Female', 9, 'avaanderson@email.com', '+1 (012) 345-6789', 'Psychiatry', 67000);
INSERT INTO STAFF VALUES ('143-42-4789', 'Liam', 'Martinez', '1986-07-03', 'Male', 11, 'liammartinez@email.com', '+1 (123) 456-7890', 'Anesthesiology', 82000);
INSERT INTO STAFF VALUES ('214-56-7890', 'Sophia', 'Garcia', '1991-04-15', 'Female', 5, 'sophiagarcia@email.com', '+1 (234) 567-8901', 'Rheumatology', 54000);
INSERT INTO STAFF VALUES ('345-63-8231', 'Noah', 'Lopez', '1981-11-20', 'Male', 15, 'noahlopez@email.com', '+1 (345) 678-9012', 'Pathology', 90000);
INSERT INTO STAFF VALUES ('456-78-3412', 'Emma', 'Hernandez', '1994-09-10', 'Female', 3, 'emmahernandez@email.com', '+1 (456) 789-0123', 'Ophthalmology', 50000);
INSERT INTO STAFF VALUES ('567-89-0873', 'James', 'Rivera', '1987-05-05', 'Male', 8, 'jamesrivera@email.com', '+1 (567) 890-1234', 'Nephrology', 59000);
INSERT INTO STAFF VALUES ('678-90-9874', 'Mia', 'Gonzalez', '1996-12-29', 'Female', 1, 'miagonzalez@email.com', '+1 (678) 901-2345', 'Hematology', 48000);
INSERT INTO STAFF VALUES ('789-01-1115', 'Alexander', 'Perez', '1984-08-12', 'Male', 13, 'alexanderperez@email.com', '+1 (789) 012-3456', 'Intensive Care Unit', 85000);
INSERT INTO STAFF VALUES ('892-88-3456', 'Chloe', 'Torres', '1990-03-07', 'Female', 6, 'chloetorres@email.com', '+1 (890) 123-4567', 'Infectious Diseases', 64000);
INSERT INTO STAFF VALUES ('991-23-4567', 'Ethan', 'Nguyen', '1993-10-30', 'Male', 4, 'ethannguyen@email.com', '+1 (901) 234-5678', 'Geriatrics', 52000);
INSERT INTO STAFF VALUES ('012-34-8372', 'Isabella', 'Collins', '1988-09-22', 'Female', 7, 'isabellacollins@email.com', '+1 (012) 345-6789', 'Plastic Surgery', 75000);
INSERT INTO STAFF VALUES ('123-45-6129', 'William', 'Adams', '1982-06-17', 'Male', 10, 'williamadams@email.com', '+1 (123) 456-7890', 'Physical Therapy', 72000);
INSERT INTO STAFF VALUES ('234-56-1224', 'Grace', 'Hall', '1991-05-12', 'Female', 5, 'gracehall@email.com', '+1 (234) 567-8901', 'Nutrition and Dietetics', 58000);
INSERT INTO STAFF VALUES ('345-67-9889', 'Benjamin', 'Young', '1980-12-25', 'Male', 14, 'benjaminyoung@email.com', '+1 (345) 678-9012', 'Pharmacy', 69000);
INSERT INTO STAFF VALUES ('456-78-1023', 'Avery', 'Lee', '1995-08-05', 'Female', 2, 'averylee@email.com', '+1 (456) 789-0123', 'Administration', 50000);
INSERT INTO STAFF VALUES ('567-89-9976', 'Michael', 'Rodriguez', '1986-04-28', 'Male', 9, 'michaelrodriguez@email.com', '+1 (567) 890-1234', 'Pulmonology', 78000);
INSERT INTO Doctors VALUES (1, 'Cardiologist', '123-45-6789');
INSERT INTO Doctors VALUES (2, 'Oncologist', '234-56-7890');
INSERT INTO Doctors VALUES (3, 'Neurologist', '345-67-8901');
INSERT INTO Doctors VALUES (4, 'Pediatrician', '456-78-9012');
INSERT INTO Doctors VALUES (5, 'Radiologist', '567-89-0123');
INSERT INTO Doctors VALUES (6, 'Orthopedist', '678-90-1234');
INSERT INTO Doctors VALUES (7, 'Emergency Medicine', '789-01-2345');
INSERT INTO Doctors VALUES (8, 'Gastroenterologist', '890-12-3456');
INSERT INTO Doctors VALUES (9, 'Dermatologist', '901-23-4567');
INSERT INTO Doctors VALUES (10, 'Psychiatrist', '012-34-5678');
INSERT INTO Doctors VALUES (11, 'Anesthesiologist', '143-42-4789');
INSERT INTO Doctors VALUES (12, 'Rheumatologist', '214-56-7890');
INSERT INTO Doctors VALUES (13, 'Pathologist', '345-63-8231');
INSERT INTO Doctors VALUES (14, 'Ophthalmologist', '456-78-3412');
INSERT INTO Doctors VALUES (15, 'Nephrologist', '567-89-0873');
INSERT INTO Doctors VALUES (16, 'Hematologist', '678-90-9874');
INSERT INTO Doctors VALUES (17, 'Intensivist', '789-01-1115');
INSERT INTO Doctors VALUES (18, 'Infectious Disease', '892-88-3456');
INSERT INTO Doctors VALUES (19, 'Geriatrician', '991-23-4567');
INSERT INTO Doctors VALUES (20, 'Plastic Surgeon', '012-34-8372');
INSERT INTO Doctors VALUES (21, 'Physical Therapist', '123-45-6129');
INSERT INTO Doctors VALUES (22, 'Dietitian', '234-56-1224');
INSERT INTO Doctors VALUES (23, 'Pharmacist', '345-67-9889');
INSERT INTO Doctors VALUES (24, 'Administrator', '456-78-1023');
INSERT INTO Doctors VALUES (25, 'Pulmonologist', '567-89-9976');
INSERT INTO SECRETARY VALUES (2001, '567-89-0873');
INSERT INTO SECRETARY VALUES (2002, '678-90-9874');
INSERT INTO SECRETARY VALUES (2003, '1984-08-12');
INSERT INTO SECRETARY VALUES (2004, '892-88-3456');
INSERT INTO SECRETARY VALUES (2005, '991-23-4567');
INSERT INTO SECRETARY VALUES (2006, '012-34-8372');
INSERT INTO SECRETARY VALUES (2007, '123-45-6129');
INSERT INTO SECRETARY VALUES (2008, '234-56-1224');
INSERT INTO SECRETARY VALUES (2009, '345-67-9889');
INSERT INTO SECRETARY VALUES (2010, '567-89-9976');
INSERT INTO SECRETARY VALUES (2011, ‘123-45-6782’);
INSERT INTO SECRETARY VALUES (2012, ‘234-56-7821’);
INSERT INTO SECRETARY VALUES (2013, ‘345-67-8444’);
INSERT INTO SECRETARY VALUES (2014, ‘956-78-0123’);
INSERT INTO SECRETARY VALUES (2015, ‘567-89-1232’);
INSERT INTO SECRETARY VALUES (2016, ‘632-90-2322’);
INSERT INTO SECRETARY VALUES (2017, ‘789-01-3489’);
INSERT INTO SECRETARY VALUES (2018, ‘890-02-4522’);
INSERT INTO SECRETARY VALUES (2019, ‘901-23-5642’);
INSERT INTO SECRETARY VALUES (2020, ‘012-45-6722’);
INSERT INTO SECRETARY VALUES (2021, ‘123-25-6722’);
INSERT INTO SECRETARY VALUES (2022, ‘234-56-7833’);
INSERT INTO SECRETARY VALUES (2023, ‘335-67-8022’);
INSERT INTO SECRETARY VALUES (2024, ‘256-78-0122’);
INSERT INTO SECRETARY VALUES (2025, ‘557-89-1222’);
INSERT INTO TrainingPrograms VALUES (1001, 'Cardio101', 'Completed', '2023-06-15');
INSERT INTO TrainingPrograms VALUES (1002, 'Oncology', 'InProgress', '2023-07-10');
INSERT INTO TrainingPrograms VALUES (1003, 'Neuro202', 'Completed', '2023-05-20');
INSERT INTO TrainingPrograms VALUES (1004, 'Pediatr3', 'NotStarted', '2023-11-01');
INSERT INTO TrainingPrograms VALUES (1005, 'Radiolog', 'Completed', '2023-01-29');
INSERT INTO TrainingPrograms VALUES (1006, 'Ortho101', 'InProgress', '2023-08-17');
INSERT INTO TrainingPrograms VALUES (1007, 'EmergMed', 'NotStarted', '2023-12-05');
INSERT INTO TrainingPrograms VALUES (1008, 'Gastro', 'Completed', '2023-04-18');
INSERT INTO TrainingPrograms VALUES (1009, 'Dermato', 'InProgress', '2023-09-21');
INSERT INTO TrainingPrograms VALUES (1010, 'Psych101', 'Completed', '2023-03-22');
INSERT INTO TrainingPrograms VALUES (1011, 'Anesthe', 'Completed', '2023-07-30');
INSERT INTO TrainingPrograms VALUES (1012, 'Rheumat', 'NotStarted', '2023-10-15');
INSERT INTO TrainingPrograms VALUES (1013, 'Patho201', 'InProgress', '2023-06-03');
INSERT INTO TrainingPrograms VALUES (1014, 'Ophthal', 'Completed', '2023-02-11');
INSERT INTO TrainingPrograms VALUES (1015, 'Nephro', 'NotStarted', '2023-12-20');
INSERT INTO TrainingPrograms VALUES (1016, 'Hemato', 'Completed', '2023-08-05');
INSERT INTO TrainingPrograms VALUES (1017, 'ICUCare', 'InProgress', '2023-07-25');
INSERT INTO TrainingPrograms VALUES (1018, 'InfectD', 'NotStarted', '2023-11-30');
INSERT INTO TrainingPrograms VALUES (1019, 'Geriatr', 'Completed', '2023-09-09');
INSERT INTO TrainingPrograms VALUES (1020, 'PlastS', 'InProgress', '2023-08-12');
INSERT INTO TrainingPrograms VALUES (1021, 'PhysTh', 'NotStarted', '2023-10-28');
INSERT INTO TrainingPrograms VALUES (1022, 'DietNut', 'Completed', '2023-10-13');
INSERT INTO TrainingPrograms VALUES (1023, 'Pharma', 'InProgress', '2023-09-05');
INSERT INTO TrainingPrograms VALUES (1024, 'Admin', 'NotStarted', '2023-12-10');
INSERT INTO TrainingPrograms VALUES (1025, 'Pulmon', 'Completed', '2023-11-20');
INSERT INTO Financial_Records VALUES (3001, 5000.00, 'Maintenance', '2023-01-15');
INSERT INTO Financial_Records VALUES (3002, 12000.50, 'Equipment Purchase', '2023-02-10');
INSERT INTO Financial_Records VALUES (3003, 800.75, 'Utility Bills', '2023-03-05');
INSERT INTO Financial_Records VALUES (3004, 4500.00, 'Staff Training', '2023-04-20');
INSERT INTO Financial_Records VALUES (3005, 25000.00, 'Medical Supplies', '2023-05-25');
INSERT INTO Financial_Records VALUES (3006, 15000.00, 'New Technology', '2023-06-30');
INSERT INTO Financial_Records VALUES (3007, 3200.00, 'Cleaning Services', '2023-07-12');
INSERT INTO Financial_Records VALUES (3008, 500.00, 'Office Supplies', '2023-08-17');
INSERT INTO Financial_Records VALUES (3009, 7500.00, 'Software Upgrade', '2023-09-21');
INSERT INTO Financial_Records VALUES (3010, 22250.35, 'Building Renovation', '2023-10-10');
INSERT INTO Financial_Records VALUES (3011, 4800.00, 'Staff Salaries', '2023-11-15');
INSERT INTO Financial_Records VALUES (3012, 3700.00, 'Insurance Premiums', '2023-12-20');
INSERT INTO Financial_Records VALUES (3013, 8250.00, 'Legal Fees', '2023-01-22');
INSERT INTO Financial_Records VALUES (3014, 6500.00, 'Consultancy Fees', '2023-02-28');
INSERT INTO Financial_Records VALUES (3015, 10000.00, 'Research Grants', '2023-03-18');
INSERT INTO Financial_Records VALUES (3016, 5500.00, 'Health Programs', '2023-04-08');
INSERT INTO Financial_Records VALUES (3017, 2000.00, 'Staff Bonuses', '2023-05-13');
INSERT INTO Financial_Records VALUES (3018, 11000.00, 'Emergency Funds', '2023-06-19');
INSERT INTO Financial_Records VALUES (3019, 300.00, 'Miscellaneous', '2023-07-27');
INSERT INTO Financial_Records VALUES (3020, 9000.00, 'Patient Care', '2023-08-05');
INSERT INTO Financial_Records VALUES (3021, 4350.00, 'Equipment Repair', '2023-09-15');
INSERT INTO Financial_Records VALUES (3022, 1200.00, 'Advertising', '2023-10-22');
INSERT INTO Financial_Records VALUES (3023, 1600.00, 'Health Campaigns', '2023-11-30');
INSERT INTO Financial_Records VALUES (3024, 7200.00, 'IT Services', '2023-12-11');
INSERT INTO Financial_Records VALUES (3025, 4850.00, 'Staff Training', '2023-01-09');
INSERT INTO Equipment VALUES (4001, 'Ultrasound', 'Medical', 'MediTech', '2027-03-15');
INSERT INTO Equipment VALUES (4002, 'X-Ray Machine', 'Medical', 'HealthScan', '2028-07-20');
INSERT INTO Equipment VALUES (4003, 'EKG Monitor', 'Medical', 'CardioCare', '2029-01-10');
INSERT INTO Equipment VALUES (4004, 'Defibrillator', 'Medical', 'LifeSaver', '2030-05-05');
INSERT INTO Equipment VALUES (4005, 'Ventilator', 'Medical', 'AirAid', '2031-08-30');
INSERT INTO Equipment VALUES (4006, 'MRI Scanner', 'Medical', 'ScanPro', '2027-12-25');
INSERT INTO Equipment VALUES (4007, 'CT Scanner', 'Medical', 'ImagingInc', '2028-11-17');
INSERT INTO Equipment VALUES (4008, 'Infusion Pump', 'Medical', 'PumpIt', '2029-09-09');
INSERT INTO Equipment VALUES (4009, 'Anesthesia', 'Medical', 'SleepWell', '2030-10-13');
INSERT INTO Equipment VALUES (4010, 'Dialysis Machine', 'Medical', 'KidneyPro', '2031-06-21');
INSERT INTO Equipment VALUES (4011, 'Surgical Table', 'Surgical', 'OperateEase', '2027-04-18');
INSERT INTO Equipment VALUES (4012, 'Endoscope', 'Medical', 'ViewInside', '2028-02-22');
INSERT INTO Equipment VALUES (4013, 'Pacemaker', 'Medical', 'HeartSync', '2029-07-30');
INSERT INTO Equipment VALUES (4014, 'Laser', 'Surgical', 'PrecisionLaser', '2030-03-14');
INSERT INTO Equipment VALUES (4015, 'Autoclave', 'Sterilize', 'Cleanster', '2031-11-29');
INSERT INTO Equipment VALUES (4016, 'Microscope', 'Lab', 'MicroZoom', '2027-05-23');
INSERT INTO Equipment VALUES (4017, 'Centrifuge', 'Lab', 'SpinFast', '2028-08-16');
INSERT INTO Equipment VALUES (4018, 'Sphygmomanometer', 'Medical', 'PressureCheck', '2029-12-12');
INSERT INTO Equipment VALUES (4019, 'Oxygen Tank', 'Medical', 'OxyFlow', '2030-04-27');
INSERT INTO Equipment VALUES (4020, 'Thermometer', 'Medical', 'TempTrack', '2031-10-05');
INSERT INTO Equipment VALUES (4021, 'Stethoscope', 'Medical', 'HeartListen', '2027-07-07');
INSERT INTO Equipment VALUES (4022, 'Treadmill', 'Rehab', 'WalkFit', '2028-09-19');
INSERT INTO Equipment VALUES (4023, 'Suction Device', 'Medical', 'ClearPath', '2029-11-11');
INSERT INTO Equipment VALUES (4024, 'Blood Analyzer', 'Lab', 'AnalyzeIt', '2030-02-20');
INSERT INTO Equipment VALUES (4025, 'Refrigerator', 'Storage', 'CoolStore', '2031-01-01');
INSERT INTO Patient VALUES (5001, 'male', 'John', 'Smith', '+1 (555) 101-2020', '1985-04-12', 'Rivertown', 'Oak St', 'Bldg 101');
INSERT INTO Patient VALUES (5002, 'female', 'Emily', 'Johnson', '+1 (555) 202-3030', '1990-07-22', 'Greenville', 'Maple Ave', 'Bldg 202');
INSERT INTO Patient VALUES (5003, 'male', 'Michael', 'Brown', '+1 (555) 303-4040', '1975-11-15', 'Lakewood', 'Elm Dr', 'Bldg 301');
INSERT INTO Patient VALUES (5004, 'female', 'Sophia', 'Garcia', '+1 (555) 404-5050', '2000-03-09', 'Hillside', 'Pine Rd', 'Bldg 402');
INSERT INTO Patient VALUES (5005, 'male', 'James', 'Miller', '+1 (555) 505-6060', '1988-08-23', 'Sandview', 'Cedar Ln', 'Bldg 503');
INSERT INTO Patient VALUES (5006, 'female', 'Olivia', 'Wilson', '+1 (555) 606-7070', '1995-05-19', 'Mountain', 'Birch St', 'Bldg 604');
INSERT INTO Patient VALUES (5007, 'male', 'William', 'Davis', '+1 (555) 707-8080', '1970-12-31', 'Seaside', 'Willow Ct', 'Bldg 705');
INSERT INTO Patient VALUES (5008, 'female', 'Isabella', 'Martinez', '+1 (555) 808-9090', '2003-09-14', 'Eastview', 'Spruce Pl', 'Bldg 806');
INSERT INTO Patient VALUES (5009, 'male', 'David', 'Hernandez', '+1 (555) 909-1010', '1992-06-07', 'Westville', 'Aspen Way', 'Bldg 907');
INSERT INTO Patient VALUES (5010, 'female', 'Mia', 'Gonzalez', '+1 (555) 100-1111', '2005-01-21', 'Northtown', 'Fir Blvd', 'Bldg 1008');
INSERT INTO Patient VALUES (5011, 'male', 'Ethan', 'Lee', '+1 (555) 111-2222', '1983-10-30', 'Southville', 'Holly St', 'Bldg 1109');
INSERT INTO Patient VALUES (5012, 'female', 'Ava', 'Perez', '+1 (555) 222-3333', '1998-02-27', 'Cliffside', 'Juniper Rd', 'Bldg 1210');
INSERT INTO Patient VALUES (5013, 'male', 'Daniel', 'Young', '+1 (555) 333-4444', '1965-05-15', 'Riverbend', 'Magnolia Ln', 'Bldg 1311');
INSERT INTO Patient VALUES (5014, 'female', 'Emma', 'Torres', '+1 (555) 444-5555', '2002-07-18', 'Lakeshore', 'Alder St', 'Bldg 1412');
INSERT INTO Patient VALUES (5015, 'male', 'Christopher', 'Nguyen', '+1 (555) 555-6666', '1978-09-04', 'Brookside', 'Sequoia Tr', 'Bldg 1513');
INSERT INTO Patient VALUES (5016, 'female', 'Grace', 'Collins', '+1 (555) 666-7777', '1993-12-08', 'Meadowland', 'Cherry Ave', 'Bldg 1614');
INSERT INTO Patient VALUES (5017, 'male', 'Benjamin', 'Adams', '+1 (555) 777-8888', '2006-04-22', 'Sunset', 'Dogwood Ct', 'Bldg 1715');
INSERT INTO Patient VALUES (5018, 'female', 'Charlotte', 'Hall', '+1 (555) 888-9999', '1989-11-13', 'Ridgeview', 'Redwood Ln', 'Bldg 1816');
INSERT INTO Patient VALUES (5019, 'male', 'Lucas', 'Scott', '+1 (555) 999-0000', '1972-03-06', 'Clearview', 'Ivy Rd', 'Bldg 1917');
INSERT INTO Patient VALUES (5020, 'female', 'Amelia', 'Wright', 'NULL', '2007-08-29', 'Hilltop', 'Larch St', 'Bldg 2018');
INSERT INTO Patient VALUES (5021, 'male', 'Alexander', 'Lopez', 'NULL', '1986-01-16', 'Springfield', 'Cypress Cir', 'Bldg 2119');
INSERT INTO Patient VALUES (5022, 'female', 'Sofia', 'Hill', 'NULL', '1997-10-03', 'Oakridge', 'Sycamore Tr', 'Bldg 2220');
INSERT INTO Patient VALUES (5023, 'male', 'Jacob', 'Sanchez', 'NULL', '1974-06-21', 'Pineview', 'Elmwood Ave', 'Bldg 2321');
INSERT INTO Patient VALUES (5024, 'female', 'Lily', 'Morales', 'NULL', '2004-12-30', 'Forest', 'Cedar Ct', 'Bldg 2422');
INSERT INTO Patient VALUES (5025, 'male', 'Noah', 'Rivera', 'NULL', '1981-08-15', 'Lakeview', 'Beech Rd', 'Bldg 2523');
INSERT INTO Interactions VALUES (6001, 'Consultation Room 101', '2023-03-15', '10:30:00', 1, 2001, 5001, 'Patient diagnosed with hypertension', 'Routine check-up and blood pressure measurement');
INSERT INTO Interactions VALUES (6002, 'Examination Room 5', '2023-04-20', '14:15:00', 2, 2002, 5002, 'Allergy tests conducted', 'Discussion about allergy symptoms and potential triggers');
INSERT INTO Interactions VALUES (6003, 'Surgical Theater 3', '2023-05-10', '09:00:00', 3, 2003, 5003, 'Successful knee surgery', 'Knee replacement procedure due to severe arthritis');
INSERT INTO Interactions VALUES (6004, 'Pediatric Ward', '2023-06-22', '11:45:00', 4, 2004, 5004, 'Child vaccination completed', 'Routine childhood vaccination and growth monitoring');
INSERT INTO Interactions VALUES (6005, 'Radiology Department', '2023-07-30', '16:00:00', 5, 2005, 5005, 'MRI results normal', 'MRI scan to investigate chronic headaches');
INSERT INTO Interactions VALUES (6006, 'Orthopedics Department', '2023-08-18', '08:30:00', 6, 2006, 5006, 'Physical therapy session scheduled', 'Evaluation for physical therapy after shoulder injury');
INSERT INTO Interactions VALUES (6007, 'ER Room 2', '2023-09-05', '23:00:00', 7, 2007, 5007, 'Treated for minor laceration', 'Emergency treatment for a cut sustained during a fall');
INSERT INTO Interactions VALUES (6008, 'Gastroenterology Clinic', '2023-10-13', '15:20:00', 8, 2008, 5008, 'Endoscopy scheduled', 'Consultation for recurring abdominal pain');
INSERT INTO Interactions VALUES (6009, 'Dermatology Office', '2023-11-21', '10:00:00', 9, 2009, 5009, 'Skin biopsy taken', 'Examination of a suspicious mole on the skin');
INSERT INTO Interactions VALUES (6010, 'Psychiatry Ward', '2023-12-19', '13:30:00', 10, 2010, 5010, 'Therapy session for anxiety', 'Regular follow-up for anxiety management');
INSERT INTO Interactions VALUES (6011, 'Anesthesiology', '2024-01-11', '09:45:00', 11, 2011, 5011, 'Pre-surgery consultation', 'Discussion about anesthesia for upcoming surgery');
INSERT INTO Interactions VALUES (6012, 'Rheumatology Office', '2024-02-07', '14:00:00', 12, 2012, 5012, 'Arthritis treatment plan', 'Assessment of rheumatoid arthritis symptoms');
INSERT INTO Interactions VALUES (6013, 'Pathology Lab', '2024-03-20', '11:15:00', 13, 2013, 5013, 'Biopsy results discussed', 'Review of pathology results for tissue biopsy');
INSERT INTO Interactions VALUES (6014, 'Ophthalmology Clinic', '2024-04-18', '10:30:00', 14, 2014, 5014, 'Eye examination completed', 'Annual eye check-up and vision test');
INSERT INTO Interactions VALUES (6015, 'Nephrology Department', '2024-05-22', '15:45:00', 15, 2015, 5015, 'Kidney function tests ordered', 'Evaluation for chronic kidney disease');
INSERT INTO Interactions VALUES (6016, 'Hematology Lab', '2024-06-16', '09:00:00', 16, 2016, 5016, 'Blood disorder consultation', 'Discussion about abnormal blood test results');
INSERT INTO Interactions VALUES (6017, 'ICU', '2024-07-13', '22:30:00', 17, 2017, 5017, 'Critical patient stabilized', 'Intensive care for severe respiratory distress');
INSERT INTO Interactions VALUES (6018, 'Infectious Disease Office', '2024-08-09', '11:00:00', 18, 2018, 5018, 'Treatment for tropical disease', 'Follow-up for treatment of dengue fever');
INSERT INTO Interactions VALUES (6019, 'Geriatrics Clinic', '2024-09-15', '14:15:00', 19, 2019, 5019, 'Alzheimer’s care plan', 'Management of Alzheimer’s disease symptoms');
INSERT INTO Interactions VALUES (6020, 'Plastic Surgery', '2024-10-12', '13:00:00', 20, 2020, 5020, 'Post-operative check', 'Assessment after cosmetic surgery');
INSERT INTO Interactions VALUES (6021, 'Physical Therapy', '2024-11-23', '16:30:00', 21, 2021, 5021, 'Rehabilitation session', 'Physical therapy for back pain recovery'); 
INSERT INTO Interactions VALUES (6022, 'Nutrition Clinic', '2024-12-10', '10:00:00', 22, 2022, 5022, 'Diet plan for diabetes', 'Consultation about dietary changes for diabetes');
INSERT INTO Interactions VALUES (6023, 'Pharmacy', '2025-01-19', '09:45:00', 23, 2023, 5023, 'Medication prescription', 'Prescription of new medication for hypertension');
INSERT INTO Interactions VALUES (6024, 'Administration Office', '2025-02-17', '15:00:00', 24, 2024, 5024, 'Insurance paperwork', 'Assistance with health insurance claim forms');
INSERT INTO Interactions VALUES (6025, 'Pulmonology Ward', '2025-03-25', '14:30:00', 25, 2025, 5025, 'Asthma management plan', 'Review of asthma treatment and inhaler technique');
INSERT INTO Room VALUES (101, 'Examination', 2, 'First Floor', 'Occupied');
INSERT INTO Room VALUES (102, 'Surgical', 1, 'Second Floor', 'Vacant');
INSERT INTO Room VALUES (103, 'ICU', 1, 'Third Floor', 'Occupied');
INSERT INTO Room VALUES (104, 'Recovery', 3, 'Fourth Floor', 'Under Maintenance');
INSERT INTO Room VALUES (105, 'Maternity', 2, 'Fifth Floor', 'Occupied');
INSERT INTO Room VALUES (106, 'Radiology', 1, 'First Floor', 'Vacant');
INSERT INTO Room VALUES (107, 'Pediatric', 4, 'Second Floor', 'Occupied');
INSERT INTO Room VALUES (108, 'Psychiatry', 2, 'Third Floor', 'Vacant');
INSERT INTO Room VALUES (109, 'Dialysis', 4, 'Fourth Floor', 'Occupied');
INSERT INTO Room VALUES (110, 'Orthopedic', 3, 'Fifth Floor', 'Vacant');
INSERT INTO Room VALUES (111, 'Oncology', 2, 'First Floor', 'Occupied');
INSERT INTO Room VALUES (112, 'Cardiology', 2, 'Second Floor', 'Under Maintenance');
INSERT INTO Room VALUES (113, 'Neurology', 1, 'Third Floor', 'Occupied');
INSERT INTO Room VALUES (114, 'Gastroenterology', 3, 'Fourth Floor', 'Vacant');
INSERT INTO Room VALUES (115, 'Dermatology', 1, 'Fifth Floor', 'Occupied');
INSERT INTO Room VALUES (116, 'General Ward', 6, 'First Floor', 'Occupied');
INSERT INTO Room VALUES (117, 'Emergency', 2, 'Second Floor', 'Occupied');
INSERT INTO Room VALUES (118, 'Laboratory', 2, 'Third Floor', 'Vacant');
INSERT INTO Room VALUES (119, 'Storage', 2, 'Fourth Floor', 'Vacant');
INSERT INTO Room VALUES (120, 'Pharmacy', 1, 'Fifth Floor', 'Occupied');
INSERT INTO Room VALUES (121, 'Consultation', 1, 'First Floor', 'Vacant');
INSERT INTO Room VALUES (122, 'Administration', 3, 'Second Floor', 'Occupied');
INSERT INTO Room VALUES (123, 'Staff Lounge', 4, 'Third Floor', 'Vacant');
INSERT INTO Room VALUES (124, 'Meeting Room', 10, 'Fourth Floor', 'Occupied');
INSERT INTO Room VALUES (125, 'Physical Therapy', 3, 'Fifth Floor', 'Under Maintenance');
INSERT INTO Appointment VALUES (7001, '2023-03-15', '10:30:00', 2001, 5001);
INSERT INTO Appointment VALUES (7002, '2023-03-20', '09:00:00', 2002, 5002);
INSERT INTO Appointment VALUES (7003, '2023-03-22', '11:45:00', 2003, 5003);
INSERT INTO Appointment VALUES (7004, '2023-03-25', '14:30:00', 2004, 5004);
INSERT INTO Appointment VALUES (7005, '2023-03-28', '08:15:00', 2005, 5005);
INSERT INTO Appointment VALUES (7006, '2023-04-02', '10:00:00', 2006, 5006);
INSERT INTO Appointment VALUES (7007, '2023-04-05', '16:00:00', 2007, 5007);
INSERT INTO Appointment VALUES (7008, '2023-04-10', '13:00:00', 2008, 5008);
INSERT INTO Appointment VALUES (7009, '2023-04-12', '15:30:00', 2009, 5009);
INSERT INTO Appointment VALUES (7010, '2023-04-17', '09:30:00', 2010, 5010);
INSERT INTO Appointment VALUES (7011, '2023-04-20', '11:00:00', 2011, 5011);
INSERT INTO Appointment VALUES (7012, '2023-04-23', '14:45:00', 2012, 5012);
INSERT INTO Appointment VALUES (7013, '2023-04-27', '08:30:00', 2013, 5013);
INSERT INTO Appointment VALUES (7014, '2023-05-01', '10:15:00', 2014, 5014);
INSERT INTO Appointment VALUES (7015, '2023-05-04', '15:00:00', 2015, 5015);
INSERT INTO Appointment VALUES (7016, '2023-05-08', '09:45:00', 2016, 5016);
INSERT INTO Appointment VALUES (7017, '2023-05-11', '13:30:00', 2017, 5017);
INSERT INTO Appointment VALUES (7018, '2023-05-15', '16:15:00', 2018, 5018);
INSERT INTO Appointment VALUES (7019, '2023-05-18', '14:00:00', 2019, 5019);
INSERT INTO Appointment VALUES (7020, '2023-05-22', '11:30:00', 2020, 5020);
INSERT INTO Appointment VALUES (7021, '2023-05-25', '08:00:00', 2021, 5021);
INSERT INTO Appointment VALUES (7022, '2023-05-29', '12:00:00', 2022, 5022);
INSERT INTO Appointment VALUES (7023, '2023-06-02', '15:45:00', 2023, 5023);
INSERT INTO Appointment VALUES (7024, '2023-06-05', '10:30:00', 2024, 5024);
INSERT INTO Appointment VALUES (7025, '2023-06-08', '09:15:00', 2025, 5025);
INSERT INTO Maintenance VALUES (8001, 'Routine Cleaning', '2023-03-15', 'Regular cleaning and sanitization of hospital wards.');
INSERT INTO Maintenance VALUES (8002, 'HVAC System Check', '2023-03-20', 'Inspection and maintenance of heating, ventilation, and air conditioning systems.');
INSERT INTO Maintenance VALUES (8003, 'Electrical Inspection', '2023-03-25', 'Routine electrical systems check to ensure safety and efficiency.');
INSERT INTO Maintenance VALUES (8004, 'Plumbing Repair', '2023-04-01', 'Fixing leaks and clogs in hospital plumbing systems.');
INSERT INTO Maintenance VALUES (8005, 'Elevator Service', '2023-04-10', 'Annual maintenance of hospital elevators for safety and reliability.');
INSERT INTO Maintenance VALUES (8006, 'Medical Equipment Calibration', '2023-04-15', 'Calibration of medical equipment to ensure accuracy and functionality.');
INSERT INTO Maintenance VALUES (8007, 'Fire Safety Check', '2023-04-20', 'Inspection and testing of fire alarms and extinguishers.');
INSERT INTO Maintenance VALUES (8008, 'IT Systems Update', '2023-05-05', 'Updating and maintaining hospital information technology systems.');
INSERT INTO Maintenance VALUES (8009, 'Security Systems Upgrade', '2023-05-15', 'Enhancement of security cameras and access control systems.');
INSERT INTO Maintenance VALUES (8010, 'Painting and Renovation', '2023-05-25', 'Repainting wards and renovating patient rooms.');
INSERT INTO Maintenance VALUES (8011, 'Landscape Maintenance', '2023-06-01', 'Gardening and upkeep of hospital grounds.');
INSERT INTO Maintenance VALUES (8012, 'Pest Control', '2023-06-10', 'Routine pest control to maintain a hygienic environment.');
INSERT INTO Maintenance VALUES (8013, 'Flooring Repair', '2023-06-20', 'Repair and replacement of damaged flooring in corridors.');
INSERT INTO Maintenance VALUES (8014, 'Window Cleaning', '2023-07-01', 'Cleaning of exterior windows and glass surfaces.');
INSERT INTO Maintenance VALUES (8015, 'Roof Inspection', '2023-07-15', 'Inspection of the hospital roof for leaks or damage.');
INSERT INTO Maintenance VALUES (8016, 'Emergency Generator Testing', '2023-07-25', 'Testing of backup generators for power outage readiness.');
INSERT INTO Maintenance VALUES (8017, 'Furniture Replacement', '2023-08-05', 'Updating worn-out furniture in patient rooms and waiting areas.');
INSERT INTO Maintenance VALUES (8018, 'Signage Update', '2023-08-15', 'Replacing and updating informational and directional signs.');
INSERT INTO Maintenance VALUES (8019, 'Lighting Fixtures Maintenance', '2023-08-25', 'Maintenance of lighting fixtures and replacement of bulbs.');
INSERT INTO Maintenance VALUES (8020, 'Water System Check', '2023-09-01', 'Inspection of water heating and cooling systems.');
INSERT INTO Maintenance VALUES (8021, 'Air Quality Assessment', '2023-09-10', 'Testing indoor air quality for pollutants and allergens.');
INSERT INTO Maintenance VALUES (8022, 'Sterilization Equipment Check', '2023-09-20', 'Maintenance of autoclaves and other sterilization equipment.');
INSERT INTO Maintenance VALUES (8023, 'Parking Lot Repaving', '2023-10-01', 'Repaving and line marking of the hospital parking lot.');
INSERT INTO Maintenance VALUES (8024, 'Laundry Equipment Servicing', '2023-10-15', 'Service and maintenance of industrial laundry machines.');
INSERT INTO Maintenance VALUES (8025, 'Waste Disposal System Upgrade', '2023-10-25', 'Upgrading waste disposal and management systems.');
INSERT INTO PHARMACY VALUES (‘Hospital Pharmacy’, '1st floor', '08:00:00', '18:00:00');
INSERT INTO Feedback VALUES (9001, '2023-03-15', 8, 'Very satisfied with the medical care received.', 5001);
INSERT INTO Feedback VALUES (9002, '2023-03-20', 7, 'Good service but long waiting times.', 5002);
INSERT INTO Feedback VALUES (9003, '2023-03-25', 9, 'Exceptional care and attention from the nursing staff.', 5003);
INSERT INTO Feedback VALUES (9004, '2023-04-01', 6, 'Satisfactory experience, although the facility needs updating.', 5004);
INSERT INTO Feedback VALUES (9005, '2023-04-10', 10, 'Outstanding professionalism from the doctors.', 5005);
INSERT INTO Feedback VALUES (9006, '2023-04-15', 5, 'Average service, unremarkable experience.', 5006);
INSERT INTO Feedback VALUES (9007, '2023-04-20', 4, 'Disappointed with the administrative process.', 5007);
INSERT INTO Feedback VALUES (9008, '2023-05-05', 7, 'Clean and well-maintained rooms.', 5008);
INSERT INTO Feedback VALUES (9009, '2023-05-15', 8, 'Efficient and caring staff, made me feel comfortable.', 5009);
INSERT INTO Feedback VALUES (9010, '2023-05-25', 6, 'Decent care but the staff seemed overworked.', 5010);
INSERT INTO Feedback VALUES (9011, '2023-06-01', 9, 'Very attentive to patient needs.', 5011);
INSERT INTO Feedback VALUES (9012, '2023-06-10', 8, 'Positive experience during my visit.', 5012);
INSERT INTO Feedback VALUES (9013, '2023-06-20', 7, 'Good medical care, but the facilities could be better.', 5013);
INSERT INTO Feedback VALUES (9014, '2023-07-01', 10, 'Excellent treatment and friendly staff.', 5014);
INSERT INTO Feedback VALUES (9015, '2023-07-15', 5, 'Average experience, nothing exceptional.', 5015);
INSERT INTO Feedback VALUES (9016, '2023-07-25', 4, 'Long wait times and unorganized appointment scheduling.', 5016);
INSERT INTO Feedback VALUES (9017, '2023-08-05', 6, 'Fair service, but could improve in patient communication.', 5017);
INSERT INTO Feedback VALUES (9018, '2023-08-15', 9, 'Impressed with the medical expertise.', 5018);
INSERT INTO Feedback VALUES (9019, '2023-08-25', 8, 'Friendly and efficient, but the waiting area is cramped.', 5019);
INSERT INTO Feedback VALUES (9020, '2023-09-01', 7, 'Good overall, but some delays in service.', 5020);
INSERT INTO Feedback VALUES (9021, '2023-09-10', 5, 'Mediocre service, unimpressed with the facility cleanliness.', 5021);
INSERT INTO Feedback VALUES (9022, '2023-09-20', 6, 'Satisfactory healthcare but lack of parking space.', 5022);
INSERT INTO Feedback VALUES (9023, '2023-10-01', 7, 'Pleasant staff, but the wait time was too long.', 5023);
INSERT INTO Feedback VALUES (9024, '2023-10-15', 8, 'Very helpful and compassionate care.', 5024);
INSERT INTO Feedback VALUES (9025, '2023-10-25', 9, 'Professional and efficient treatment.', 5025);
INSERT INTO Medical_Test VALUES (10001, 'Blood Test', 'A general test to check for various conditions and diseases.');
INSERT INTO Medical_Test VALUES (10002, 'MRI Scan', 'Magnetic Resonance Imaging to create detailed images of the organs and tissues.');
INSERT INTO Medical_Test VALUES (10003, 'CT Scan', 'Computed Tomography scan used to create cross-sectional images of the body.');
INSERT INTO Medical_Test VALUES (10004, 'X-Ray', 'Radiation-based test to view the inside of the body, especially bones.');
INSERT INTO Medical_Test VALUES (10005, 'Echocardiogram', 'Ultrasound of the heart to visualize the heart chambers.');
INSERT INTO Medical_Test VALUES (10006, 'Ultrasound', 'Sound wave imaging used for monitoring pregnancies and diagnosing certain conditions.');
INSERT INTO Medical_Test VALUES (10007, 'Biopsy', 'A procedure involving the removal of tissue to examine for disease.');
INSERT INTO Medical_Test VALUES (10008, 'Electrocardiogram', 'A test that measures the electrical activity of the heartbeat.');
INSERT INTO Medical_Test VALUES (10009, 'Mammography', 'An X-ray of the breast used to detect and diagnose breast disease.');
INSERT INTO Medical_Test VALUES (10010, 'Colonoscopy', 'An exam used to detect changes or abnormalities in the large intestine.');
INSERT INTO Medical_Test VALUES (10011, 'Skin Allergy Test', 'Testing for allergic reactions to substances on the skin.');
INSERT INTO Medical_Test VALUES (10012, 'Thyroid Function Test', 'Blood test to measure the functioning of the thyroid gland.');
INSERT INTO Medical_Test VALUES (10013, 'Liver Function Test', 'Blood test to assess the health and functioning of the liver.');
INSERT INTO Medical_Test VALUES (10014, 'Lung Function Test', 'Tests to measure how well the lungs work.');
INSERT INTO Medical_Test VALUES (10015, 'Hearing Test', 'Examination to evaluate a person ability to hear various sounds.');
INSERT INTO Medical_Test VALUES (10016, 'Eye Test', 'Various tests to evaluate vision and diagnose eye conditions.');
INSERT INTO Medical_Test VALUES (10017, 'Stress Test', 'Measures the heart activity during physical exertion.');
INSERT INTO Medical_Test VALUES (10018, 'Bone Density Scan', 'A form of X-ray to detect weakening of bones.');
INSERT INTO Medical_Test VALUES (10019, 'HIV Test', 'Blood test to detect the presence of HIV infection.');
INSERT INTO Medical_Test VALUES (10020, 'Pap Smear', 'Test for cervical cancer in women.');
INSERT INTO Medical_Test VALUES (10021, 'Cholesterol Test', 'Blood test to evaluate cholesterol levels.');
INSERT INTO Medical_Test VALUES (10022, 'PSA Test', 'Blood test to screen for prostate cancer.');
INSERT INTO Medical_Test VALUES (10023, 'Glucose Test', 'Blood sugar test for diabetes.');
INSERT INTO Medical_Test VALUES (10024, 'Hepatitis Panel', 'Series of blood tests used to detect hepatitis infection.');
INSERT INTO Medical_Test VALUES (10025, 'Tuberculosis Test', 'Test for the detection of tuberculosis bacteria.');
INSERT INTO Test_Result VALUES (14001, 10001, 'Blood cell counts within normal range.');
INSERT INTO Test_Result VALUES (14002, 10002, 'MRI shows no signs of abnormalities.');
INSERT INTO Test_Result VALUES (14003, 10003, 'CT scan indicates a minor fracture.');
INSERT INTO Test_Result VALUES (14004, 10004, 'X-Ray reveals clear lung fields.');
INSERT INTO Test_Result VALUES (14005, 10005, 'Echocardiogram shows healthy heart function.');
INSERT INTO Test_Result VALUES (14006, 10006, 'Ultrasound confirms a healthy pregnancy.');
INSERT INTO Test_Result VALUES (14007, 10007, 'Biopsy results suggest benign growth.');
INSERT INTO Test_Result VALUES (14008, 10008, 'Electrocardiogram indicates normal heart rhythm.');
INSERT INTO Test_Result VALUES (14009, 10009, 'Mammography shows no signs of malignancy.');
INSERT INTO Test_Result VALUES (14010, 10010, 'Colonoscopy results confirm polyps removed.');
INSERT INTO Test_Result VALUES (14011, 10011, 'Skin allergy test identifies pollen allergy.');
INSERT INTO Test_Result VALUES (14012, 10012, 'Thyroid function test results within normal limits.');
INSERT INTO Test_Result VALUES (14013, 10013, 'Liver function tests indicate elevated enzymes.');
INSERT INTO Test_Result VALUES (14014, 10014, 'Lung function test shows decreased capacity.');
INSERT INTO Test_Result VALUES (14015, 10015, 'Hearing test indicates mild hearing loss.');
INSERT INTO Test_Result VALUES (14016, 10016, 'Eye test results suggest need for prescription glasses.');
INSERT INTO Test_Result VALUES (14017, 10017, 'Stress test shows good physical response to exercise.');
INSERT INTO Test_Result VALUES (14018, 10018, 'Bone density scan indicates early signs of osteoporosis.');
INSERT INTO Test_Result VALUES (14019, 10019, 'HIV test results are negative.');
INSERT INTO Test_Result VALUES (14020, 10020, 'Pap smear results are normal.');
INSERT INTO Test_Result VALUES (14021, 10021, 'Cholesterol levels are slightly elevated.');
INSERT INTO Test_Result VALUES (14022, 10022, 'PSA levels within the normal range.');
INSERT INTO Test_Result VALUES (14023, 10023, 'Glucose test indicates normal blood sugar levels.');
INSERT INTO Test_Result VALUES (14024, 10024, 'Hepatitis panel shows no signs of infection.');
INSERT INTO Test_Result VALUES (14025, 10025, 'Tuberculosis test is negative.');
INSERT INTO Insurance VALUES (11001, 'POL12345', 'HealthFirst', 'Full coverage including emergency and surgical procedures.', 5001);
INSERT INTO Insurance VALUES (11002, 'POL23456', 'MediCare', 'Covers up to 80% of medical expenses excluding cosmetic surgeries.', 5002);
INSERT INTO Insurance VALUES (11003, 'POL34567', 'LifeShield', 'Comprehensive coverage including outpatient services.', 5003);
INSERT INTO Insurance VALUES (11004, 'POL45678', 'WellnessPlan', 'Includes general check-ups, vaccinations, and emergency services.', 5004);
INSERT INTO Insurance VALUES (11005, 'POL56789', 'SecureHealth', 'Covers major surgeries and inpatient care with a low deductible.', 5005);
INSERT INTO Insurance VALUES (11006, 'POL67890', 'FamilyCare', 'Covers all family members for most medical procedures.', 5006);
INSERT INTO Insurance VALUES (11007, 'POL78901', 'GlobalMed', 'International coverage including travel vaccines.', 5007);
INSERT INTO Insurance VALUES (11008, 'POL89012', 'CarePlus', 'Extended coverage for chronic illnesses and therapy sessions.', 5008);
INSERT INTO Insurance VALUES (11009, 'POL90123', 'PrimeLife', 'High coverage for senior citizens, includes home care services.', 5009);
INSERT INTO Insurance VALUES (11010, 'POL01234', 'NextGen', 'Specialized for young adults, includes mental health services.', 5010);
INSERT INTO Insurance VALUES (11011, 'POL11111', 'HealthGuard', 'Coverage for a wide range of medical tests and prescription drugs.', 5011);
INSERT INTO Insurance VALUES (11012, 'POL22222', 'PulseCare', 'Includes heart-related procedures and regular cardiology check-ups.', 5012);
INSERT INTO Insurance VALUES (11013, 'POL33333', 'MediTrust', 'Provides benefits for long-term hospitalization.', 5013);
INSERT INTO Insurance VALUES (11014, 'POL44444', 'VitalCover', 'Focused on critical illness coverage and emergency care.', 5014);
INSERT INTO Insurance VALUES (11015, 'POL55555', 'HarmonyHealth', 'Emphasizes on holistic care, including alternative treatments.', 5015);
INSERT INTO Insurance VALUES (11016, 'POL66666', 'CareFirst', 'Comprehensive plan with a focus on preventive care.', 5016);
INSERT INTO Insurance VALUES (11017, 'POL77777', 'HealthNet', 'Covers both inpatient and outpatient mental health services.', 5017);
INSERT INTO Insurance VALUES (11018, 'POL88888', 'PeakLife', 'Geared towards athletes, covers sports injuries and rehabilitation.', 5018);
INSERT INTO Insurance VALUES (11019, 'POL99999', 'SecureFuture', 'Long-term care insurance, including disability and retirement health plans.', 5019);
INSERT INTO Insurance VALUES (11020, 'POL00000', 'WellCare', 'Offers a range of benefits for general wellness and screenings.', 5020);
INSERT INTO Insurance VALUES (11021, 'POL12321', 'FlexiHealth', 'Flexible plan, allows adjustments to coverage as needed.', 5021);
INSERT INTO Insurance VALUES (11022, 'POL23232', 'EcoHealth', 'Environmentally conscious health plan, includes green living benefits.', 5022);
INSERT INTO Insurance VALUES (11023, 'POL34343', 'QuickCover', 'Focused on quick claim settlements and emergency coverage.', 5023);
INSERT INTO Insurance VALUES (11024, 'POL45454', 'TruHealth', 'Emphasizes on accurate and truthful coverage, no hidden clauses.', 5024);
INSERT INTO Insurance VALUES (11025, 'POL56565', 'CompleteCare', 'All-inclusive plan covering a wide spectrum of health services.', 5025);
INSERT INTO Medical_Records VALUES (12001, 5001);
INSERT INTO Medical_Records VALUES (12002, 5002);
INSERT INTO Medical_Records VALUES (12003, 5003);
INSERT INTO Medical_Records VALUES (12004, 5004);
INSERT INTO Medical_Records VALUES (12005, 5005);
INSERT INTO Medical_Records VALUES (12006, 5006);
INSERT INTO Medical_Records VALUES (12007, 5007);
INSERT INTO Medical_Records VALUES (12008, 5008);
INSERT INTO Medical_Records VALUES (12009, 5009);
INSERT INTO Medical_Records VALUES (12010, 5010);
INSERT INTO Medical_Records VALUES (12011, 5011);
INSERT INTO Medical_Records VALUES (12012, 5012);
INSERT INTO Medical_Records VALUES (12013, 5013);
INSERT INTO Medical_Records VALUES (12014, 5014);
INSERT INTO Medical_Records VALUES (12015, 5015);
INSERT INTO Medical_Records VALUES (12016, 5016);
INSERT INTO Medical_Records VALUES (12017, 5017);
INSERT INTO Medical_Records VALUES (12018, 5018);
INSERT INTO Medical_Records VALUES (12019, 5019);
INSERT INTO Medical_Records VALUES (12020, 5020);
INSERT INTO Medical_Records VALUES (12021, 5021);
INSERT INTO Medical_Records VALUES (12022, 5022);
INSERT INTO Medical_Records VALUES (12023, 5023);
INSERT INTO Medical_Records VALUES (12024, 5024);
INSERT INTO Medical_Records VALUES (12025, 5025);
INSERT INTO Medicine VALUES (13001, 'Acetaminophen', 'Tablet', 'Pain reliever and fever reducer.', '2025-05-01', 5.99);
INSERT INTO Medicine VALUES (13002, 'Ibuprofen', 'Capsule', 'Nonsteroidal anti-inflammatory drug for pain relief.', '2024-08-15', 7.50);
INSERT INTO Medicine VALUES (13003, 'Amoxicillin', 'Liquid', 'Antibiotic used to treat various bacterial infections.', '2023-12-30', 15.20);
INSERT INTO Medicine VALUES (13004, 'Lisinopril', 'Tablet', 'Used to treat high blood pressure and heart failure.', '2025-07-22', 12.00);
INSERT INTO Medicine VALUES (13005, 'Metformin', 'Tablet', 'Medication for type 2 diabetes.', '2024-11-10', 8.75);
INSERT INTO Medicine VALUES (13006, 'Omeprazole', 'Capsule', 'Used to treat gastroesophageal reflux disease.', '2023-10-05', 10.50);
INSERT INTO Medicine VALUES (13007, 'Cetirizine', 'Liquid', 'Antihistamine for allergy relief.', '2024-09-19', 6.30);
INSERT INTO Medicine VALUES (13008, 'Simvastatin', 'Tablet', 'Lowers cholesterol and triglyceride levels.', '2025-08-30', 18.00);
INSERT INTO Medicine VALUES (13009, 'Aspirin', 'Tablet', 'Used to reduce fever, pain, and inflammation.', '2023-06-15', 4.50);
INSERT INTO Medicine VALUES (13010, 'Albuterol', 'Inhaler', 'Treats bronchospasm in asthma and COPD patients.', '2025-03-27', 25.00);
INSERT INTO Medicine VALUES (13011, 'Gabapentin', 'Capsule', 'Used for nerve pain and seizures.', '2024-12-22', 20.75);
INSERT INTO Medicine VALUES (13012, 'Atorvastatin', 'Tablet', 'Helps lower bad cholesterol and fats.', '2025-04-18', 15.50);
INSERT INTO Medicine VALUES (13013, 'Furosemide', 'Liquid', 'Diuretic used to treat fluid retention.', '2023-08-09', 9.40);
INSERT INTO Medicine VALUES (13014, 'Prednisone', 'Tablet', 'Steroid used to reduce inflammation.', '2024-05-13', 12.10);
INSERT INTO Medicine VALUES (13015, 'Insulin', 'Injection', 'Regulates blood sugar in diabetics.', '2025-01-01', 45.00);
INSERT INTO Medicine VALUES (13016, 'Warfarin', 'Tablet', 'Anticoagulant to prevent blood clots.', '2024-07-07', 16.80);
INSERT INTO Medicine VALUES (13017, 'Hydrochlorothiazide', 'Capsule', 'Treats high blood pressure and fluid retention.', '2023-11-20', 7.60);
INSERT INTO Medicine VALUES (13018, 'Fluoxetine', 'Liquid', 'Antidepressant belonging to the SSRI class.', '2025-02-15', 22.00);
INSERT INTO Medicine VALUES (13019, 'Ranitidine', 'Tablet', 'Used to treat and prevent ulcers.', '2024-04-04', 9.90);
INSERT INTO Medicine VALUES (13020, 'Losartan', 'Tablet', 'Treats high blood pressure and kidney disease.', '2025-06-25', 14.50);
INSERT INTO Medicine VALUES (13021, 'Amlodipine', 'Capsule', 'Calcium channel blocker for high blood pressure.', '2024-10-10', 11.00);
INSERT INTO Medicine VALUES (13022, 'Tamsulosin', 'Capsule', 'Used to treat enlarged prostate.', '2023-09-05', 19.75);
INSERT INTO Medicine VALUES (13023, 'Diphenhydramine', 'Liquid', 'Antihistamine used to treat allergy symptoms.', '2025-03-20', 5.45);
INSERT INTO Medicine VALUES (13024, 'Glucosamine', 'Tablet', 'Supplement for joint health.', '2024-01-17', 17.30);
INSERT INTO Medicine VALUES (13025, 'Vitamin D', 'Capsule', 'Supplement to help maintain bone health.', '2025-05-31', 8.25);
INSERT INTO Patient_Diagnosis VALUES (15001, 12001, 'Stable', '2023-03-15', 'Diagnosed with Type 2 Diabetes.');
INSERT INTO Patient_Diagnosis VALUES (15002, 12002, 'Improving', '2023-03-20', 'Acute Bronchitis.');
INSERT INTO Patient_Diagnosis VALUES (15003, 12003, 'Requires Monitoring', '2023-03-25', 'Hypertension detected.');
INSERT INTO Patient_Diagnosis VALUES (15004, 12004, 'Good', '2023-04-01', 'Recovery from viral infection.');
INSERT INTO Patient_Diagnosis VALUES (15005, 12005, 'Stable', '2023-04-10', 'Asthma, regular treatment recommended.');
INSERT INTO Patient_Diagnosis VALUES (15006, 12006, 'Critical', '2023-04-15', 'Coronary heart disease.');
INSERT INTO Patient_Diagnosis VALUES (15007, 12007, 'Under Treatment', '2023-04-20', 'Osteoarthritis diagnosed.');
INSERT INTO Patient_Diagnosis VALUES (15008, 12008, 'Regular Check-up Needed', '2023-05-05', 'Chronic kidney disease.');
INSERT INTO Patient_Diagnosis VALUES (15009, 12009, 'Positive Response to Treatment', '2023-05-15', 'Treated for skin cancer.');
INSERT INTO Patient_Diagnosis VALUES (15010, 12010, 'Stable under Medication', '2023-05-25', 'Rheumatoid arthritis.');
INSERT INTO Patient_Diagnosis VALUES (15011, 12011, 'Monitor Regularly', '2023-06-01', 'Diagnosed with glaucoma.');
INSERT INTO Patient_Diagnosis VALUES (15012, 12012, 'Stable', '2023-06-10', 'Thyroid disorder.');
INSERT INTO Patient_Diagnosis VALUES (15013, 12013, 'Improving', '2023-06-20', 'Recovery from surgical procedure.');
INSERT INTO Patient_Diagnosis VALUES (15014, 12014, 'Rehabilitation', '2023-07-01', 'Hip replacement surgery.');
INSERT INTO Patient_Diagnosis VALUES (15015, 12015, 'Stable with Treatment', '2023-07-15', 'Chronic migraines.');
INSERT INTO Patient_Diagnosis VALUES (15016, 12016, 'Requires Follow-up', '2023-07-25', 'Gastroesophageal reflux disease.');
INSERT INTO Patient_Diagnosis VALUES (15017, 12017, 'Progressing', '2023-08-05', 'Undergoing chemotherapy for lymphoma.');
INSERT INTO Patient_Diagnosis VALUES (15018, 12018, 'Stable', '2023-08-15', 'Diabetes mellitus, well-controlled.');
INSERT INTO Patient_Diagnosis VALUES (15019, 12019, 'Regular Monitoring', '2023-08-25', 'Multiple sclerosis.');
INSERT INTO Patient_Diagnosis VALUES (15020, 12020, 'Good Prognosis', '2023-09-01', 'Appendicitis post-surgery.');
INSERT INTO Patient_Diagnosis VALUES (15021, 12021, 'Under Observation', '2023-09-10', 'Suspected case of Lyme disease.');
INSERT INTO Patient_Diagnosis VALUES (15022, 12022, 'Improving', '2023-09-20', 'Tuberculosis treatment ongoing.');
INSERT INTO Patient_Diagnosis VALUES (15023, 12023, 'Recovery', '2023-10-01', 'Post-fracture rehabilitation.');
INSERT INTO Patient_Diagnosis VALUES (15024, 12024, 'Stable', '2023-10-15', 'Managed hypertension.');
INSERT INTO Patient_Diagnosis VALUES (15025, 12025, 'Ongoing Treatment', '2023-10-25', 'Treatment for chronic liver disease.');
INSERT INTO Treatment_Plan VALUES (16001, 12001, 15001, 13001, 'Regular blood sugar monitoring', '2023-03-15', '2023-09-15');
INSERT INTO Treatment_Plan VALUES (16002, 12002, 15002, 13002, 'Physical therapy for bronchitis recovery', '2023-03-20', '2023-06-20');
INSERT INTO Treatment_Plan VALUES (16003, 12003, 15003, NULL, 'Diet and exercise plan for hypertension', '2023-03-25', '2023-09-25');
INSERT INTO Treatment_Plan VALUES (16004, 12004, 15004, 13003, 'Antiviral medication', '2023-04-01', '2023-05-01');
INSERT INTO Treatment_Plan VALUES (16005, 12005, 15005, 13004, 'Asthma management with inhalers', '2023-04-10', '2023-10-10');
INSERT INTO Treatment_Plan VALUES (16006, 12006, 15006, 13005, 'Heart-healthy diet and regular exercise', '2023-04-15', '2023-10-15');
INSERT INTO Treatment_Plan VALUES (16007, 12007, 15007, 13006, 'Physical therapy for osteoarthritis', '2023-04-20', '2023-10-20');
INSERT INTO Treatment_Plan VALUES (16008, 12008, 15008, 13007, 'Regular kidney function tests', '2023-05-05', '2023-11-05');
INSERT INTO Treatment_Plan VALUES (16009, 12009, 15009, 13008, 'Follow-up skin examinations', '2023-05-15', '2023-08-15');
INSERT INTO Treatment_Plan VALUES (16010, 12010, 15010, 13009, 'Rheumatoid arthritis medication', '2023-05-25', '2023-11-25');
INSERT INTO Treatment_Plan VALUES (16011, 12011, 15011, 13010, 'Regular eye pressure tests', '2023-06-01', '2023-12-01');
INSERT INTO Treatment_Plan VALUES (16012, 12012, 15012, 13011, 'Thyroid hormone therapy', '2023-06-10', '2023-12-10');
INSERT INTO Treatment_Plan VALUES (16013, 12013, 15013, 13012, 'Post-surgery rehabilitation exercises', '2023-06-20', '2023-09-20');
INSERT INTO Treatment_Plan VALUES (16014, 12014, 15014, 13013, 'Hip exercises and pain management', '2023-07-01', '2023-10-01');
INSERT INTO Treatment_Plan VALUES (16015, 12015, 15015, 13014, 'Migraine medication and stress management', '2023-07-15', '2023-10-15');
INSERT INTO Treatment_Plan VALUES (16016, 12016, 15016, 13015, 'GERD medication and dietary adjustments', '2023-07-25', '2023-10-25');
INSERT INTO Treatment_Plan VALUES (16017, 12017, 15017, 13016, 'Chemotherapy and nutritional support', '2023-08-05', '2024-02-05');
INSERT INTO Treatment_Plan VALUES (16018, 12018, 15018, 13017, 'Diabetes management with insulin therapy', '2023-08-15', '2024-02-15');
INSERT INTO Treatment_Plan VALUES (16019, 12019, 15019, 13018, 'MS medication and physical therapy', '2023-08-25', '2024-02-25');
INSERT INTO Treatment_Plan VALUES (16020, 12020, 15020, 13019, 'Post-appendectomy care', '2023-09-01', '2023-10-01');
INSERT INTO Treatment_Plan VALUES (16021, 12021, 15021, 13020, 'Antibiotics and regular check-ups for Lyme disease', '2023-09-10', '2023-12-10');
INSERT INTO Treatment_Plan VALUES (16022, 12022, 15022, 13021, 'Tuberculosis treatment regimen', '2023-09-20', '2024-03-20');
INSERT INTO Treatment_Plan VALUES (16023, 12023, 15023, 13022, 'Rehabilitation program for fracture recovery', '2023-10-01', '2024-01-01');
INSERT INTO Treatment_Plan VALUES (16024, 12024, 15024, 13023, 'Hypertension medication and lifestyle changes', '2023-10-15', '2024-04-15');
INSERT INTO Treatment_Plan VALUES (16025, 12025, 15025, 13024, 'Liver disease medication and regular liver function tests', '2023-10-25', '2024-04-25');
INSERT INTO Treats VALUES (1, 5001);
INSERT INTO Treats VALUES (2, 5002);
INSERT INTO Treats VALUES (3, 5003);
INSERT INTO Treats VALUES (4, 5004);
INSERT INTO Treats VALUES (5, 5005);
INSERT INTO Treats VALUES (6, 5006);
INSERT INTO Treats VALUES (7, 5007);
INSERT INTO Treats VALUES (8, 5008);
INSERT INTO Treats VALUES (9, 5009);
INSERT INTO Treats VALUES (10, 5010);
INSERT INTO Treats VALUES (11, 5011);
INSERT INTO Treats VALUES (12, 5012);
INSERT INTO Treats VALUES (13, 5013);
INSERT INTO Treats VALUES (14, 5014);
INSERT INTO Treats VALUES (15, 5015);
INSERT INTO Treats VALUES (16, 5016);
INSERT INTO Treats VALUES (17, 5017);
INSERT INTO Treats VALUES (18, 5018);
INSERT INTO Treats VALUES (19, 5019);
INSERT INTO Treats VALUES (20, 5020);
INSERT INTO Treats VALUES (21, 5021);
INSERT INTO Treats VALUES (22, 5022);
INSERT INTO Treats VALUES (23, 5023);
INSERT INTO Treats VALUES (24, 5024);
INSERT INTO Treats VALUES (25, 5025);
INSERT INTO Undergoes VALUES (101, 8001);
INSERT INTO Undergoes VALUES (102, 8002);
INSERT INTO Undergoes VALUES (103, 8003);
INSERT INTO Undergoes VALUES (104, 8004);
INSERT INTO Undergoes VALUES (105, 8005);
INSERT INTO Undergoes VALUES (106, 8006);
INSERT INTO Undergoes VALUES (107, 8007);
INSERT INTO Undergoes VALUES (108, 8008);
INSERT INTO Undergoes VALUES (109, 8009);
INSERT INTO Undergoes VALUES (110, 8010);
INSERT INTO Undergoes VALUES (111, 8011);
INSERT INTO Undergoes VALUES (112, 8012);
INSERT INTO Undergoes VALUES (113, 8013);
INSERT INTO Undergoes VALUES (114, 8014);
INSERT INTO Undergoes VALUES (115, 8015);
INSERT INTO Undergoes VALUES (116, 8016);
INSERT INTO Undergoes VALUES (117, 8017);
INSERT INTO Undergoes VALUES (118, 8018);
INSERT INTO Undergoes VALUES (119, 8019);
INSERT INTO Undergoes VALUES (120, 8020);
INSERT INTO Undergoes VALUES (121, 8021);
INSERT INTO Undergoes VALUES (122, 8022);
INSERT INTO Undergoes VALUES (123, 8023);
INSERT INTO Undergoes VALUES (124, 8024);
INSERT INTO Undergoes VALUES (125, 8025);
INSERT INTO Assigns VALUES (1, 101);
INSERT INTO Assigns VALUES (2, 102);
INSERT INTO Assigns VALUES (3, 103);
INSERT INTO Assigns VALUES (4, 104);
INSERT INTO Assigns VALUES (5, 105);
INSERT INTO Assigns VALUES (6, 106);
INSERT INTO Assigns VALUES (7, 107);
INSERT INTO Assigns VALUES (8, 108);
INSERT INTO Assigns VALUES (9, 109);
INSERT INTO Assigns VALUES (10, 110);
INSERT INTO Assigns VALUES (11, 111);
INSERT INTO Assigns VALUES (12, 112);
INSERT INTO Assigns VALUES (13, 113);
INSERT INTO Assigns VALUES (14, 114);
INSERT INTO Assigns VALUES (15, 115);
INSERT INTO Assigns VALUES (16, 116);
INSERT INTO Assigns VALUES (17, 117);
INSERT INTO Assigns VALUES (18, 118);
INSERT INTO Assigns VALUES (19, 119);
INSERT INTO Assigns VALUES (20, 120);
INSERT INTO Assigns VALUES (21, 121);
INSERT INTO Assigns VALUES (22, 122);
INSERT INTO Assigns VALUES (23, 123);
INSERT INTO Assigns VALUES (24, 124);
INSERT INTO Assigns VALUES (25, 125);
INSERT INTO Undertakes VALUES (10001, 5001, '2023-03-15');
INSERT INTO Undertakes VALUES (10002, 5002, '2023-03-20');
INSERT INTO Undertakes VALUES (10003, 5003, '2023-03-25');
INSERT INTO Undertakes VALUES (10004, 5004, '2023-04-01');
INSERT INTO Undertakes VALUES (10005, 5005, '2023-04-10');
INSERT INTO Undertakes VALUES (10006, 5006, '2023-04-15');
INSERT INTO Undertakes VALUES (10007, 5007, '2023-04-20');
INSERT INTO Undertakes VALUES (10008, 5008, '2023-05-05');
INSERT INTO Undertakes VALUES (10009, 5009, '2023-05-15');
INSERT INTO Undertakes VALUES (10010, 5010, '2023-05-25');
INSERT INTO Undertakes VALUES (10011, 5011, '2023-06-01');
INSERT INTO Undertakes VALUES (10012, 5012, '2023-06-10');
INSERT INTO Undertakes VALUES (10013, 5013, '2023-06-20');
INSERT INTO Undertakes VALUES (10014, 5014, '2023-07-01');
INSERT INTO Undertakes VALUES (10015, 5015, '2023-07-15');
INSERT INTO Undertakes VALUES (10016, 5016, '2023-07-25');
INSERT INTO Undertakes VALUES (10017, 5017, '2023-08-05');
INSERT INTO Undertakes VALUES (10018, 5018, '2023-08-15');
INSERT INTO Undertakes VALUES (10019, 5019, '2023-08-25');
INSERT INTO Undertakes VALUES (10020, 5020, '2023-09-01');
INSERT INTO Undertakes VALUES (10021, 5021, '2023-09-10');
INSERT INTO Undertakes VALUES (10022, 5022, '2023-09-20');
INSERT INTO Undertakes VALUES (10023, 5023, '2023-10-01');
INSERT INTO Undertakes VALUES (10024, 5024, '2023-10-15');
INSERT INTO Undertakes VALUES (10025, 5025, '2023-10-25');
INSERT INTO Access VALUES (5001, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5002, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5003, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5004, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5005, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5006, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5007, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5008, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5009, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5010, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5011, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5012, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5013, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5014, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5015, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5016, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5017, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5018, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5019, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5020, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5021, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5022, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5023, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5024, 'Hospital Pharmacy');
INSERT INTO Access VALUES (5025, 'Hospital Pharmacy');
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13001);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13002);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13003);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13004);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13005);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13006);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13007);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13008);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13009);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13010);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13011);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13012);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13013);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13014);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13015);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13016);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13017);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13018);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13019);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13020);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13021);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13022);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13023);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13024);
INSERT INTO Includes VALUES ('Hospital Pharmacy', 13025);
INSERT INTO Engage VALUES ('123-45-6789', 101);
INSERT INTO Engage VALUES ('234-56-7890', 102);
INSERT INTO Engage VALUES ('345-67-8901', 103);
INSERT INTO Engage VALUES ('456-78-9012', 104);
INSERT INTO Engage VALUES ('567-89-0123', 105);
INSERT INTO Engage VALUES ('678-90-1234', 106);
INSERT INTO Engage VALUES ('789-01-2345', 107);
INSERT INTO Engage VALUES ('890-12-3456', 108);
INSERT INTO Engage VALUES ('901-23-4567', 109);
INSERT INTO Engage VALUES ('012-34-5678', 110);
INSERT INTO Engage VALUES ('143-42-4789', 111);
INSERT INTO Engage VALUES ('214-56-7890', 112);
INSERT INTO Engage VALUES ('345-63-8231', 113);
INSERT INTO Engage VALUES ('456-78-3412', 114);
INSERT INTO Engage VALUES ('567-89-0873', 115);
INSERT INTO Engage VALUES ('678-90-9874', 116);
INSERT INTO Engage VALUES ('789-01-1115', 117);
INSERT INTO Engage VALUES ('892-88-3456', 118);
INSERT INTO Engage VALUES ('991-23-4567', 119);
INSERT INTO Engage VALUES ('012-34-8372', 120);
INSERT INTO Engage VALUES ('123-45-6129', 121);
INSERT INTO Engage VALUES ('234-56-1224', 122);
INSERT INTO Engage VALUES ('345-67-9889', 123);
INSERT INTO Engage VALUES ('456-78-1023', 124);
INSERT INTO Engage VALUES ('567-89-9976', 125);
INSERT INTO Cover VALUES (3001, 4001, 8001, '123-45-6789');
INSERT INTO Cover VALUES (3002, 4002, 8002, '234-56-7890');
INSERT INTO Cover VALUES (3003, 4003, 8003, '345-67-8901');
INSERT INTO Cover VALUES (3004, 4004, 8004, '456-78-9012');
INSERT INTO Cover VALUES (3005, 4005, 8005, '567-89-0123');
INSERT INTO Cover VALUES (3006, 4006, 8006, '678-90-1234');
INSERT INTO Cover VALUES (3007, 4007, 8007, '789-01-2345');
INSERT INTO Cover VALUES (3008, 4008, 8008, '890-12-3456');
INSERT INTO Cover VALUES (3009, 4009, 8009, '901-23-4567');
INSERT INTO Cover VALUES (3010, 4010, 8010, '012-34-5678');
INSERT INTO Cover VALUES (3011, 4011, 8011, '143-42-4789');
INSERT INTO Cover VALUES (3012, 4012, 8012, '214-56-7890');
INSERT INTO Cover VALUES (3013, 4013, 8013, '345-63-8231');
INSERT INTO Cover VALUES (3014, 4014, 8014, '456-78-3412');
INSERT INTO Cover VALUES (3015, 4015, 8015, '567-89-0873');
INSERT INTO Cover VALUES (3016, 4016, 8016, '678-90-9874');
INSERT INTO Cover VALUES (3017, 4017, 8017, '789-01-1115');
INSERT INTO Cover VALUES (3018, 4018, 8018, '892-88-3456');
INSERT INTO Cover VALUES (3019, 4019, 8019, '991-23-4567');
INSERT INTO Cover VALUES (3020, 4020, 8020, '012-34-8372');
INSERT INTO Cover VALUES (3021, 4021, 8021, '123-45-6129');
INSERT INTO Cover VALUES (3022, 4022, 8022, '234-56-1224');
INSERT INTO Cover VALUES (3023, 4023, 8023, '345-67-9889');
INSERT INTO Cover VALUES (3024, 4024, 8024, '456-78-1023');
INSERT INTO Cover VALUES (3025, 4025, 8025, '567-89-9976');
SELECT * 
FROM Staff, Room;
SELECT * 
FROM Doctor, Patient_Diagnosis;
SELECT *
FROM Staff NATURAL JOIN Doctors;
SELECT *
FROM Medical_Records NATURAL JOIN Patient;
SELECT *
FROM Medical_Records JOIN Patient_Diagnosis
USING (RecordNumber)
WHERE Medical_Records.RecordNumber < Patient_Diagnosis.Record_Number;
SELECT *
FROM Financial_Records JOIN Maintenance
USING (Maintenance_Date)
WHERE Financial_Records.Maintenance_Date >= Maintenance.Maintenance_Date;
SELECT *
FROM Financial_Records JOIN Maintenance
ON Financial_Records.Amount >= Maintenance.Maintenance_ID;
SELECT *
FROM Equipment JOIN Cover
ON Equipment.Category = Cover.Maintenance_Type;
SELECT p1.Patient_ID AS Patient1_ID, p1.P_LastName AS Patient1_LastName,
       p2.Patient_ID AS Patient2_ID, p2.P_LastName AS Patient2_LastName
FROM Patient p1 JOIN Patient p2
ON p1.P_LastName = p2.P_LastName
WHERE p1.Patient_ID < p2.Patient_ID;
SELECT m1.RecordNumber AS RecordNumber1, m1.Patient_ID AS Patient1_ID, m1.Diagnosis_Date AS Diagnosis_Date1,
       m2.RecordNumber AS RecordNumber2, m2.Patient_ID AS Patient2_ID, m2.Diagnosis_Date AS Diagnosis_Date2
FROM Medical_Records m1 JOIN Medical_Records m2
ON m1.Diagnosis_Date = m2.Diagnosis_Date
WHERE m1.RecordNumber < m2.RecordNumber;
SELECT DISTINCT Department
FROM Staff;
SELECT DISTINCT Medicine_Name
FROM Medicine;
SELECT *
FROM Staff
WHERE LastName LIKE 'Sm%';
SELECT *
FROM Patient
WHERE P_PhoneNumber LIKE '%555%';
SELECT DoctorID, Specialty
FROM Doctors
ORDER BY Specialty ASC;
SELECT RecordNumber, Patient_ID
FROM Medical_Records
ORDER BY Patient_ID DESC;
SELECT FirstName, LastName, 'Doctor' AS Role
FROM Doctors
UNION
SELECT FirstName, LastName, 'Secretary' AS Role
FROM Secretaries;
SELECT DISTINCT Category AS Equipment_Category
FROM Equipment
UNION
SELECT DISTINCT Form AS Medication_Form
FROM Medicine;
SELECT Patient_ID
FROM Medical_Records
WHERE Patient_ID IN (SELECT Patient_ID FROM Insurance);
SELECT DISTINCT d.StaffSSN AS SSN
FROM Doctors d
JOIN Staff s ON d.StaffSSN = s.SSN;
SELECT DISTINCT M.Patient_ID
FROM Medical_Records M
LEFT JOIN Insurance I ON M.Patient_ID = I.Patient_ID
WHERE I.Patient_ID IS NULL;
SELECT DISTINCT S.SSN
FROM Staff S
LEFT JOIN Doctors D ON S.SSN = D.StaffSSN
WHERE D.StaffSSN IS NULL;
SELECT P_FirstName, P_LastName
FROM Patient
ORDER BY P_LastName ASC;
SELECT P_FirstName, P_LastName
FROM Patient
ORDER BY P_LastName ASC;
SELECT COUNT(*) AS TotalStaffMembers
FROM Staff;
SELECT AVG(YearsOfExperience) AS AverageExperience
FROM Staff
WHERE SSN IN (SELECT StaffSSN FROM Doctors);
SELECT Secretary_ID, COUNT(*) AS TotalAppointments
FROM Appointment
GROUP BY Secretary_ID;
SELECT Department, AVG(Salary) AS AverageSalary
FROM Staff
GROUP BY Department;
SELECT Department, AVG(Salary) AS AverageSalary
FROM Staff
GROUP BY Department
HAVING AVG(Salary) > 60000;
SELECT Department, COUNT(*) AS StaffCount
FROM Staff
GROUP BY Department
HAVING COUNT(*) >= 3;
SELECT DISTINCT P.Patient-ID, P.P_FirstName, P.P_LastName
FROM Patient P
JOIN Undertakes U ON P.Patient-ID = U.Patient_ID
WHERE U.Test_ID IN (
    SELECT U2.Test_ID
    FROM Undertakes U2
    JOIN Patient P2 ON U2.Patient_ID = P2.Patient-ID
    WHERE P2.City = 'New York'
);
SELECT D.Doctor-ID, D.SSN, D.Specialty
FROM Doctor D
WHERE D.Specialty IN (
    SELECT D2.Specialty
    FROM Doctor D2
    JOIN Staff S ON D2.SSN = S.SSN
    WHERE S.Salary > 100000
);
SELECT D.Doctor-ID, D.SSN, S.Department, S.Salary
FROM Doctor D
JOIN Staff S ON D.SSN = S.SSN
WHERE S.Salary >= ALL (
    SELECT S2.Salary
    FROM Staff S2
    WHERE S2.Department = S.Department
);
SELECT SSN, St_FirstName, St_LastName, Salary
FROM Staff
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Staff AS S
    WHERE S.Department = Staff.Department
);
SELECT Doctor_ID
FROM Doctor
WHERE (
    SELECT COUNT(DISTINCT Patient_ID)
    FROM Treats
    WHERE Treats.Doc_ID = Doctor.Doctor_ID
) > 5;
SELECT PD.Patient_ID, COUNT(PD.Diagnosis-ID) AS NumberOfDiagnoses
FROM Patient_Diagnosis PD
GROUP BY PD.Patient_ID
HAVING COUNT(PD.Diagnosis-ID) > (
    SELECT AVG(DiagnosisCount) FROM (
        SELECT COUNT(PD2.Diagnosis-ID) AS DiagnosisCount
        FROM Patient_Diagnosis PD2
        GROUP BY PD2.Patient_ID
    ) AS AverageDiagnoses
);
SELECT D.Doctor-ID, D.SSN, D.Specialty
FROM Doctor D
WHERE D.Specialty IN (
    SELECT D2.Specialty
    FROM Doctor D2
    WHERE D2.Specialty IN (
        SELECT D3.Specialty
        FROM Doctor D3
        JOIN Staff S3 ON D3.SSN = S3.SSN
        GROUP BY D3.Specialty
        HAVING COUNT(D3.Specialty) > (
            SELECT AVG(SpecialtyCount) FROM (
                SELECT COUNT(*) AS SpecialtyCount
                FROM Doctor
                GROUP BY Specialty
            ) AS SpecialtyAvg
        )
    )
    AND D2.SSN IN (
        SELECT S4.SSN
        FROM Staff S4
        WHERE S4.Salary > (
            SELECT AVG(Salary) FROM Staff
        )
    )
);
SELECT P.Patient-ID, P.P_FirstName, P.P_LastName
FROM Patient P
WHERE P.Patient-ID IN (
    SELECT I.Patient_ID
    FROM Insurance I
    WHERE I.Provider = 'ABC Health'
)
AND (
    SELECT COUNT(U.Test_ID)
    FROM Undertakes U
    WHERE U.Patient_ID = P.Patient-ID
) > (
    SELECT AVG(TestCount) FROM (
        SELECT COUNT(U2.Test_ID) AS TestCount
        FROM Patient P2
        JOIN Undertakes U2 ON P2.Patient-ID = U2.Patient_ID
        WHERE P2.City = P.City
        GROUP BY P2.Patient-ID
    ) AS CityAverage
);
SELECT P.Patient_ID, P.P_FirstName, P.P_LastName
FROM Patient P
WHERE NOT EXISTS (
    SELECT 1
    FROM Medical_Test MT
    LEFT JOIN Undertakes U ON MT.Test_ID = U.Test_ID AND U.Patient_ID = P.Patient_ID
    WHERE U.Test_ID IS NULL
);
SELECT P.Patient_ID, P.P_FirstName, P.P_LastName
FROM Patient P
WHERE NOT EXISTS (
    SELECT MT.Test_ID
    FROM Medical_Test MT
    WHERE MT.Test_ID NOT IN (
        SELECT U.Test_ID
        FROM Undertakes U
        WHERE U.Patient_ID = P.Patient_ID
    )
);
SELECT DepartmentInfo.Department, DepartmentInfo.AvgSalary, DepartmentInfo.StaffCount
FROM (
    SELECT S.Department, AVG(S.Salary) AS AvgSalary, COUNT(*) AS StaffCount
    FROM Staff S
    GROUP BY S.Department
) AS DepartmentInfo;
SELECT P.Patient-ID, P.P_FirstName, P.P_LastName, LatestAppointments.LatestAppointmentDate
FROM Patient P
JOIN (
    SELECT A.Patient-ID, MAX(A.Appointment_Date) AS LatestAppointmentDate
    FROM Appointment A
    GROUP BY A.Patient-ID
) AS LatestAppointments ON P.Patient-ID = LatestAppointments.Patient-ID;
SELECT 
    P.Patient-ID, 
    P.P_FirstName, 
    P.P_LastName, 
    (SELECT COUNT(*) FROM Undertakes U WHERE U.Patient_ID = P.Patient-ID) AS TestCount
FROM 
    Patient P;
SELECT 
    R.Room_Number, 
    R.Room_Type, 
    (SELECT MAX(M.Maintenance_Data) FROM Maintenance M JOIN Undergoes U ON M.Maintenance_ID = U.Maintenance_ID WHERE U.Room_Number = R.Room_Number) AS LatestMaintenanceDate
FROM 
    Room R;
UPDATE Staff
SET Salary = CASE 
    WHEN Department = 'Cardiology' THEN Salary * 1.05
    WHEN Department = 'Neurology' THEN Salary * 1.07
    ELSE Salary * 1.03
END
WHERE Department IN ('Cardiology', 'Neurology', 'General');
UPDATE Patient
SET Category = CASE 
    WHEN TIMESTAMPDIFF(YEAR, P_Birthday, CURDATE()) < 18 THEN 'Minor'
    WHEN TIMESTAMPDIFF(YEAR, P_Birthday, CURDATE()) BETWEEN 18 AND 65 THEN 'Adult'
    ELSE 'Senior'
END;
SELECT 
    D.Doctor-ID, 
    D.SSN, 
    D.Specialty, 
    A.Room_Number, 
    R.Room_Type
FROM 
    Doctor D
LEFT OUTER JOIN Assigns A ON D.Doctor-ID = A.Doctor_ID 
LEFT OUTER JOIN Room R ON A.Room_Number = R.Room_Number;
SELECT 
    P.Patient_ID, 
    P.P_FirstName, 
    P.P_LastName, 
    I.Policy_Number, 
    I.Provider
FROM 
    Patient P
LEFT OUTER JOIN Insurance I ON P.Patient_ID = I.Patient_ID;
CREATE VIEW DoctorDetails AS
SELECT 
    D.Doctor-ID, 
    D.SSN, 
    D.Specialty, 
    S.St_FirstName, 
    S.St_LastName, 
    S.Department, 
    S.Salary
FROM 
    Doctor D
JOIN 
    Staff S ON D.SSN = S.SSN;
DELIMITER $$
CREATE TRIGGER UpdatePatientStatus
AFTER INSERT ON Test_Result
FOR EACH ROW
BEGIN
    IF NEW.Result_Outcome = 'Positive' THEN
        UPDATE Patient 
        SET Status = 'Requires Follow-Up'
        WHERE Patient_ID IN (
            SELECT Patient_ID 
            FROM Undertakes 
            WHERE Test_ID = NEW.Test_ID
        );
    END IF;
END$$
DELIMITER ;
DELIMITER $$
CREATE FUNCTION CalculatePatientAge(birthday DATE)
RETURNS INT
BEGIN
    DECLARE today DATE;
    SET today = CURDATE();
    RETURN TIMESTAMPDIFF(YEAR, birthday, today);
END$$
DELIMITER ;
DELIMITER $$
CREATE PROCEDURE ScheduleAppointment(
    IN patientID INT,
    IN doctorID INT,
    IN appDate DATE,
    IN appTime TIME,
    OUT appointmentID INT
)
BEGIN
    DECLARE secretaryID INT;
    IF NOT EXISTS (
        SELECT 1 
        FROM Appointment 
        WHERE Doctor_ID = doctorID AND Appointment_Date = appDate AND Appointment_Time = appTime
    ) THEN
        SELECT Secretary_ID INTO secretaryID
        FROM Secretary
        ORDER BY RAND()
        LIMIT 1;
        INSERT INTO Appointment(Appointment_Date, Appointment_Time, Doctor_ID, Secretary_ID, Patient_ID)
        VALUES (appDate, appTime, doctorID, secretaryID, patientID);
        SET appointmentID = LAST_INSERT_ID();
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Doctor not available at the selected time.';
    END IF;
END$$
DELIMITER ;

