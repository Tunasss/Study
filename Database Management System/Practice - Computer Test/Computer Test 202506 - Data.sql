CREATE TABLE PATIENT (
    PatientID CHAR(5) PRIMARY KEY,
    PatientName NVARCHAR2(50),
    DateOfBirth DATE,
    NationalID NVARCHAR2(12),
    HealthInsuranceNo NVARCHAR2(15),
    InsuranceCoverage FLOAT,
    Address NVARCHAR2(100)
);
CREATE TABLE DOCTOR (
    DoctorID CHAR(5) PRIMARY KEY,
    DoctorName NVARCHAR2(50),
    StartDate DATE,
    Specialty NVARCHAR2(50)
);
CREATE TABLE MEDICAL_EXAM (
    ExamID CHAR(5) PRIMARY KEY,
    PatientID CHAR(5),
    DoctorID CHAR(5),
    ExamDate DATE,
    Symptoms NVARCHAR2(255),
    Diagnosis NVARCHAR2(255),
    FollowUpInDays NUMBER(5),

    CONSTRAINT fk_exam_patient FOREIGN KEY (PatientID) REFERENCES PATIENT(PatientID),
    CONSTRAINT fk_exam_doctor FOREIGN KEY (DoctorID) REFERENCES DOCTOR(DoctorID)
);
CREATE TABLE MEDICINE (
    MedicineID CHAR(5) PRIMARY KEY,
    MedicineName NVARCHAR2(50),
    MedicineType NVARCHAR2(50),
    Unit NVARCHAR2(20),
    UnitPrice NUMBER(15,2)
);
CREATE TABLE PRESCRIPTION (
    PrescriptionID CHAR(5) PRIMARY KEY,
    ExamID CHAR(5),
    TotalValue NUMBER(15,2),
    InsuranceCoverage FLOAT,
    PrescriptionDate DATE,
    PatientPayment NUMBER(15,2),
    PrescriptionStatus NVARCHAR2(30),

    CONSTRAINT fk_prescription_exam FOREIGN KEY (ExamID) REFERENCES MEDICAL_EXAM(ExamID)
);
CREATE TABLE PRESCRIPTION_DETAIL (
    PrescriptionID CHAR(5),
    MedicineID CHAR(5),
    Quantity NUMBER(5),
    Amount NUMBER(15,2),

    PRIMARY KEY (PrescriptionID, MedicineID),
    CONSTRAINT fk_detail_prescription FOREIGN KEY (PrescriptionID) REFERENCES PRESCRIPTION(PrescriptionID),
    CONSTRAINT fk_detail_medicine FOREIGN KEY (MedicineID) REFERENCES MEDICINE(MedicineID)
);


-- PATIENT
INSERT INTO PATIENT (PatientID, PatientName, DateOfBirth, NationalID, HealthInsuranceNo, InsuranceCoverage, Address) VALUES ('BN001', 'Nguyen Van Anh', TO_DATE('1985-02-15', 'YYYY-MM-DD'), '748942819283', 'BHYT001', 0.15, 'Ho Chi Minh City');
INSERT INTO PATIENT (PatientID, PatientName, DateOfBirth, NationalID, HealthInsuranceNo, InsuranceCoverage, Address) VALUES ('BN002', 'Tran Thi Binh', TO_DATE('1990-06-20', 'YYYY-MM-DD'), '746382904712', NULL, 0, 'Ho Chi Minh City');
INSERT INTO PATIENT (PatientID, PatientName, DateOfBirth, NationalID, HealthInsuranceNo, InsuranceCoverage, Address) VALUES ('BN003', 'Le Van Cuong', TO_DATE('1982-12-10', 'YYYY-MM-DD'), '742836728987', 'BHYT003', 0.25, 'Ho Chi Minh City');
INSERT INTO PATIENT (PatientID, PatientName, DateOfBirth, NationalID, HealthInsuranceNo, InsuranceCoverage, Address) VALUES ('BN004', 'Pham Thi Duong', TO_DATE('1978-03-25', 'YYYY-MM-DD'), '764738927728', 'BHYT004', 0.15, 'Can Tho');
INSERT INTO PATIENT (PatientID, PatientName, DateOfBirth, NationalID, HealthInsuranceNo, InsuranceCoverage, Address) VALUES ('BN005', 'Nguyen Van Bao', TO_DATE('1995-09-15', 'YYYY-MM-DD'), '745839872712', NULL, 0, 'Dong Nai');
INSERT INTO PATIENT (PatientID, PatientName, DateOfBirth, NationalID, HealthInsuranceNo, InsuranceCoverage, Address) VALUES ('BN006', 'Tran Van Trung', TO_DATE('1988-11-22', 'YYYY-MM-DD'), '736378927762', 'BHYT006', 0.15, 'Binh Duong');
INSERT INTO PATIENT (PatientID, PatientName, DateOfBirth, NationalID, HealthInsuranceNo, InsuranceCoverage, Address) VALUES ('BN007', 'Pham Thi Giang', TO_DATE('2000-01-01', 'YYYY-MM-DD'), '763512536847', 'BHYT007', 0.35, 'Ho Chi Minh City');
INSERT INTO PATIENT (PatientID, PatientName, DateOfBirth, NationalID, HealthInsuranceNo, InsuranceCoverage, Address) VALUES ('BN008', 'Nguyen Thi Huyen', TO_DATE('1986-07-30', 'YYYY-MM-DD'), '784391823154', 'BHYT008', 0.25, 'Binh Dinh');
INSERT INTO PATIENT (PatientID, PatientName, DateOfBirth, NationalID, HealthInsuranceNo, InsuranceCoverage, Address) VALUES ('BN009', 'Le Van Trinh', TO_DATE('1993-10-05', 'YYYY-MM-DD'), '748927736275', 'BHYT009', 0.15, 'Ho Chi Minh City');
INSERT INTO PATIENT (PatientID, PatientName, DateOfBirth, NationalID, HealthInsuranceNo, InsuranceCoverage, Address) VALUES ('BN010', 'Nguyen Thi Trang', TO_DATE('1984-04-18', 'YYYY-MM-DD'), '744343235675', 'BHYT010', 0.25, 'Tay Ninh');
select * from PATIENT;

-- DOCTOR
INSERT INTO DOCTOR (DoctorID, DoctorName, StartDate, Specialty) VALUES ('BS001', 'Do Van An', TO_DATE('2017-05-15', 'YYYY-MM-DD'), 'Otolaryngology');
INSERT INTO DOCTOR (DoctorID, DoctorName, StartDate, Specialty) VALUES ('BS002', 'Nguyen Van Bach', TO_DATE('2017-08-22', 'YYYY-MM-DD'), 'Internal Medicine');
INSERT INTO DOCTOR (DoctorID, DoctorName, StartDate, Specialty) VALUES ('BS003', 'Pham Van Truong', TO_DATE('2018-11-30', 'YYYY-MM-DD'), 'Surgery');
INSERT INTO DOCTOR (DoctorID, DoctorName, StartDate, Specialty) VALUES ('BS004', 'Tran Thi My', TO_DATE('2019-03-05', 'YYYY-MM-DD'), 'Otolaryngology');
INSERT INTO DOCTOR (DoctorID, DoctorName, StartDate, Specialty) VALUES ('BS005', 'Le Van Chinh', TO_DATE('2019-07-10', 'YYYY-MM-DD'), 'Surgery');
select * from DOCTOR;

-- MEDICAL_EXAM
INSERT INTO MEDICAL_EXAM (ExamID, PatientID, DoctorID, ExamDate, Symptoms, Diagnosis, FollowUpInDays) VALUES ('KB001', 'BN001', 'BS001', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'High fever, cough', 'Pharyngitis', 3);
INSERT INTO MEDICAL_EXAM (ExamID, PatientID, DoctorID, ExamDate, Symptoms, Diagnosis, FollowUpInDays) VALUES ('KB002', 'BN002', 'BS001', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'Headache, fatigue', 'Flu', 3);
INSERT INTO MEDICAL_EXAM (ExamID, PatientID, DoctorID, ExamDate, Symptoms, Diagnosis, FollowUpInDays) VALUES ('KB003', 'BN003', 'BS002', TO_DATE('2024-12-02', 'YYYY-MM-DD'), 'Hoarseness, cough', 'Bronchitis', 6);
INSERT INTO MEDICAL_EXAM (ExamID, PatientID, DoctorID, ExamDate, Symptoms, Diagnosis, FollowUpInDays) VALUES ('KB004', 'BN004', 'BS002', TO_DATE('2024-12-02', 'YYYY-MM-DD'), 'Stomach ache', 'Digestive disorder', 6);
INSERT INTO MEDICAL_EXAM (ExamID, PatientID, DoctorID, ExamDate, Symptoms, Diagnosis, FollowUpInDays) VALUES ('KB005', 'BN001', 'BS001', TO_DATE('2024-12-05', 'YYYY-MM-DD'), 'Skin rash', 'Allergy', 12);
INSERT INTO MEDICAL_EXAM (ExamID, PatientID, DoctorID, ExamDate, Symptoms, Diagnosis, FollowUpInDays) VALUES ('KB006', 'BN002', 'BS001', TO_DATE('2024-12-05', 'YYYY-MM-DD'), 'Sore throat', 'Pharyngitis', 3);
INSERT INTO MEDICAL_EXAM (ExamID, PatientID, DoctorID, ExamDate, Symptoms, Diagnosis, FollowUpInDays) VALUES ('KB007', 'BN005', 'BS003', TO_DATE('2024-12-05', 'YYYY-MM-DD'), 'High fever', 'Viral fever', 6);
INSERT INTO MEDICAL_EXAM (ExamID, PatientID, DoctorID, ExamDate, Symptoms, Diagnosis, FollowUpInDays) VALUES ('KB008', 'BN003', 'BS002', TO_DATE('2024-12-07', 'YYYY-MM-DD'), 'Swollen lymph nodes', 'Lymphadenitis', 6);
INSERT INTO MEDICAL_EXAM (ExamID, PatientID, DoctorID, ExamDate, Symptoms, Diagnosis, FollowUpInDays) VALUES ('KB009', 'BN006', 'BS004', TO_DATE('2024-12-07', 'YYYY-MM-DD'), 'Knee pain', 'Knee arthritis', 12);
INSERT INTO MEDICAL_EXAM (ExamID, PatientID, DoctorID, ExamDate, Symptoms, Diagnosis, FollowUpInDays) VALUES ('KB010', 'BN005', 'BS002', TO_DATE('2024-12-09', 'YYYY-MM-DD'), 'Itchy rash', 'Skin rash', 3);
select * from MEDICAL_EXAM;


-- MEDICINE
INSERT INTO MEDICINE (MedicineID, MedicineName, MedicineType, Unit, UnitPrice) VALUES ('TH001', 'Paracetamol 500mg', 'Pain reliever', 'Tablet', 5000);
INSERT INTO MEDICINE (MedicineID, MedicineName, MedicineType, Unit, UnitPrice) VALUES ('TH002', 'Amoxicillin 250mg', 'Antibiotic', 'Tablet', 10000);
INSERT INTO MEDICINE (MedicineID, MedicineName, MedicineType, Unit, UnitPrice) VALUES ('TH003', 'Ibuprofen 400mg', 'Anti-inflammatory', 'Tablet', 15000);
INSERT INTO MEDICINE (MedicineID, MedicineName, MedicineType, Unit, UnitPrice) VALUES ('TH004', 'Loratadine 10mg', 'Antihistamine', 'Box', 120000);
INSERT INTO MEDICINE (MedicineID, MedicineName, MedicineType, Unit, UnitPrice) VALUES ('TH005', 'Cefuroxime 500mg', 'Antibiotic', 'Tablet', 20000);
INSERT INTO MEDICINE (MedicineID, MedicineName, MedicineType, Unit, UnitPrice) VALUES ('TH006', 'Omeprazole 20mg', 'Stomach medicine', 'Tablet', 8000);
INSERT INTO MEDICINE (MedicineID, MedicineName, MedicineType, Unit, UnitPrice) VALUES ('TH007', 'Vitamin C 1000mg', 'Nutritional supplement', 'Tablet', 7000);
INSERT INTO MEDICINE (MedicineID, MedicineName, MedicineType, Unit, UnitPrice) VALUES ('TH008', 'Diclofenac 50mg', 'Pain reliever', 'Box', 180000);
INSERT INTO MEDICINE (MedicineID, MedicineName, MedicineType, Unit, UnitPrice) VALUES ('TH009', 'Dextromethorphan 15mg', 'Cough suppressant', 'Tablet', 6000);
INSERT INTO MEDICINE (MedicineID, MedicineName, MedicineType, Unit, UnitPrice) VALUES ('TH010', 'Cetirizine 10mg', 'Antihistamine', 'Tablet', 11000);
select * from MEDICINE;

-- PRESCRIPTION
INSERT INTO PRESCRIPTION (PrescriptionID, ExamID, TotalValue, InsuranceCoverage, PrescriptionDate, PatientPayment, PrescriptionStatus) VALUES ('DT001', 'KB001', 84000, 0.15, TO_DATE('2024-12-01', 'YYYY-MM-DD'), 71400, 'Paid');
INSERT INTO PRESCRIPTION (PrescriptionID, ExamID, TotalValue, InsuranceCoverage, PrescriptionDate, PatientPayment, PrescriptionStatus) VALUES ('DT002', 'KB002', 130000, 0, TO_DATE('2024-12-01', 'YYYY-MM-DD'), 130000, 'Paid');
INSERT INTO PRESCRIPTION (PrescriptionID, ExamID, TotalValue, InsuranceCoverage, PrescriptionDate, PatientPayment, PrescriptionStatus) VALUES ('DT003', 'KB003', 344000, 0.25, TO_DATE('2024-12-02', 'YYYY-MM-DD'), 258000, 'Paid');
INSERT INTO PRESCRIPTION (PrescriptionID, ExamID, TotalValue, InsuranceCoverage, PrescriptionDate, PatientPayment, PrescriptionStatus) VALUES ('DT004', 'KB004', 78000, 0.15, TO_DATE('2024-12-02', 'YYYY-MM-DD'), 66300, 'Paid');
INSERT INTO PRESCRIPTION (PrescriptionID, ExamID, TotalValue, InsuranceCoverage, PrescriptionDate, PatientPayment, PrescriptionStatus) VALUES ('DT005', 'KB005', 142000, 0.15, TO_DATE('2024-12-02', 'YYYY-MM-DD'), 120700, 'Paid');
INSERT INTO PRESCRIPTION (PrescriptionID, ExamID, TotalValue, InsuranceCoverage, PrescriptionDate, PatientPayment, PrescriptionStatus) VALUES ('DT006', 'KB006', 60000, 0, TO_DATE('2024-12-03', 'YYYY-MM-DD'), 60000, 'Paid');
INSERT INTO PRESCRIPTION (PrescriptionID, ExamID, TotalValue, InsuranceCoverage, PrescriptionDate, PatientPayment, PrescriptionStatus) VALUES ('DT007', 'KB007', 300000, 0, TO_DATE('2024-12-03', 'YYYY-MM-DD'), 300000, 'Paid');
select * from PRESCRIPTION;


-- PRESCRIPTION_DETAIL
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT001', 'TH001', 4, 20000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT001', 'TH002', 4, 40000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT001', 'TH009', 4, 24000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT002', 'TH001', 3, 15000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT002', 'TH003', 3, 45000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT002', 'TH007', 10, 70000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT003', 'TH003', 4, 60000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT003', 'TH005', 4, 80000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT003', 'TH008', 1, 180000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT003', 'TH009', 4, 24000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT004', 'TH001', 6, 30000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT004', 'TH006', 6, 48000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT005', 'TH004', 1, 120000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT005', 'TH010', 2, 22000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT006', 'TH009', 10, 60000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT007', 'TH001', 10, 50000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT007', 'TH002', 10, 100000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT007', 'TH006', 10, 80000);
INSERT INTO PRESCRIPTION_DETAIL (PrescriptionID, MedicineID, Quantity, Amount) VALUES ('DT007', 'TH007', 10, 70000);
select * from PRESCRIPTION_DETAIL;

--1
SELECT d.DoctorID, d.DoctorName, p.PatientID, p.PatientName
FROM DOCTOR d
JOIN MEDICAL_EXAM e ON e.DoctorID = d.DoctorID
JOIN PATIENT p ON p.PatientID = e.PatientID
WHERE d.Specialty = 'Otolaryngology' AND EXTRACT(YEAR FROM e.ExamDate) = 2024
ORDER BY d.DoctorID, p.PatientID;   

--2
CREATE OR REPLACE PROCEDURE GetPatientInfo (
    p_PatientID IN CHAR
) AS
    v_PatientName NVARCHAR2(50);
    v_NationalID NVARCHAR2(12);
    v_Address NVARCHAR2(100);
    v_ExamCount NUMBER;
BEGIN
    SELECT p.PatientName, p.NationalID, p.Address, COUNT(e.PatientID)
    INTO v_PatientName, v_NationalID, v_Address, v_ExamCount
    FROM PATIENT p
    LEFT JOIN MEDICAL_EXAM e ON e.PatientID = p.PatientID
    WHERE p.PatientID = p_PatientID
    GROUP BY p.PatientID, p.PatientName, p.NationalID, p.Address;   
    DBMS_OUTPUT.PUT_LINE('Patient ID: ' || p_PatientID);
    DBMS_OUTPUT.PUT_LINE('Patient Name: ' || v_PatientName);
    DBMS_OUTPUT.PUT_LINE('National ID: ' || v_NationalID);
    DBMS_OUTPUT.PUT_LINE('Address: ' || v_Address);
    DBMS_OUTPUT.PUT_LINE('Number of Medical Examinations: ' || v_ExamCount);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Patient with the given ID was not found.');
END;
/

SET SERVEROUTPUT ON;
DECLARE
    v_InputID CHAR(10) := '&Nhap_Patient_ID'; 
BEGIN
    GetPatientInfo(v_InputID);
END;
/


--3
CREATE OR REPLACE PROCEDURE GetDoctorExams (
    p_DoctorID IN CHAR
) AS
    v_DoctorName NVARCHAR2(50);
    v_DoctorExists NUMBER := 0;
    v_HasExams BOOLEAN := FALSE;
BEGIN
    SELECT COUNT(*) INTO v_DoctorExists 
    FROM DOCTOR 
    WHERE DoctorID = p_DoctorID;
    
    IF v_DoctorExists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Doctor with the given ID was not found.');
    ELSE
        SELECT DoctorName INTO v_DoctorName FROM DOCTOR WHERE DoctorID = p_DoctorID;
        
        DBMS_OUTPUT.PUT_LINE('Doctor ID: ' || p_DoctorID);
        DBMS_OUTPUT.PUT_LINE('Doctor Name: ' || v_DoctorName);
        DBMS_OUTPUT.PUT_LINE('Medical Examinations:');
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
        
        FOR rec IN (
            SELECT e.ExamID, e.ExamDate, p.PatientName, e.Symptoms, e.Diagnosis
            FROM MEDICAL_EXAM e
            JOIN PATIENT p ON p.PatientID = e.PatientID
            WHERE e.DoctorID = p_DoctorID
        ) LOOP
            v_HasExams := TRUE;
            DBMS_OUTPUT.PUT_LINE('Exam ID: ' || rec.ExamID);
            DBMS_OUTPUT.PUT_LINE('Exam Date: ' || TO_CHAR(rec.ExamDate, 'YYYY-MM-DD'));
            DBMS_OUTPUT.PUT_LINE('Patient Name: ' || rec.PatientName);
            DBMS_OUTPUT.PUT_LINE('Symptoms: ' || rec.Symptoms);
            DBMS_OUTPUT.PUT_LINE('Diagnosis: ' || rec.Diagnosis);
            DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
        END LOOP;
        
        IF NOT v_HasExams THEN
            DBMS_OUTPUT.PUT_LINE('No medical examinations found for this doctor.');
        END IF;
    END IF;
END;
/

SET SERVEROUTPUT ON;

DECLARE
    v_InputID CHAR(10) := '&Nhap_Doctor_ID';
BEGIN
    GetDoctorExams(v_InputID);
END;
/

--4
CREATE OR REPLACE FUNCTION GetTotalPatientPayment (
    p_PatientID IN CHAR
) RETURN NUMBER AS
    v_PatientExists NUMBER := 0;
    v_TotalPayment NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_PatientExists 
    FROM PATIENT 
    WHERE PatientID = p_PatientID;
    
    IF v_PatientExists = 0 THEN
        RETURN -1;
    END IF;

    SELECT NVL(SUM(r.PatientPayment), 0)
    INTO v_TotalPayment
    FROM MEDICAL_EXAM e
    JOIN PRESCRIPTION r ON r.ExamID = e.ExamID
    WHERE e.PatientID = p_PatientID;
    
    RETURN v_TotalPayment;
END;
/

SET SERVEROUTPUT ON;

DECLARE
    v_PatientID CHAR(10) := '&Nhap_Patient_ID';
    v_TotalPayment NUMBER;
BEGIN
    v_TotalPayment := GetTotalPatientPayment(v_PatientID);
    
    DBMS_OUTPUT.PUT_LINE('Patient ID: ' || v_PatientID);
    IF v_TotalPayment = -1 THEN
        DBMS_OUTPUT.PUT_LINE('Patient with the given ID was not found.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total amount paid by the patient: ' || v_TotalPayment);
    END IF; 
END;
/

--5
CREATE OR REPLACE TRIGGER trg_check_medicine_count
AFTER INSERT OR UPDATE ON PRESCRIPTION_DETAIL
DECLARE
    v_ExceededPrescription NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_ExceededPrescription
    FROM (
        SELECT PrescriptionID
        FROM PRESCRIPTION_DETAIL
        GROUP BY PrescriptionID
        HAVING COUNT(DISTINCT MedicineID) > 10
    ) WHERE ROWNUM = 1;

    IF v_ExceededPrescription > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'A prescription cannot include more than 10 different types of medicine.');
    END IF;
END;
/
