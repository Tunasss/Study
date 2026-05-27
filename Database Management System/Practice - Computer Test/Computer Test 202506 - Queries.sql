-- Queries for Computer Test 202506 dataset
-- File: Computer Test 202506 - Queries.sql

-- 1) Patients with insurance
SELECT PatientID, PatientName, HealthInsuranceNo, InsuranceCoverage
FROM PATIENT
WHERE HealthInsuranceNo IS NOT NULL AND InsuranceCoverage > 0;

-- 2) Total prescription value and patient payment per patient
SELECT p.PatientID, p.PatientName,
       SUM(r.TotalValue) AS TotalPrescriptionValue,
       SUM(r.PatientPayment) AS TotalPatientPayment
FROM PATIENT p
JOIN MEDICAL_EXAM e ON e.PatientID = p.PatientID
JOIN PRESCRIPTION r ON r.ExamID = e.ExamID
GROUP BY p.PatientID, p.PatientName
ORDER BY p.PatientID;

-- 3) Total revenue per doctor (sum of prescriptions for their exams)
SELECT d.DoctorID, d.DoctorName,
       SUM(r.TotalValue) AS SumTotalValue,
       SUM(r.PatientPayment) AS SumPatientPayment
FROM DOCTOR d
JOIN MEDICAL_EXAM e ON e.DoctorID = d.DoctorID
JOIN PRESCRIPTION r ON r.ExamID = e.ExamID
GROUP BY d.DoctorID, d.DoctorName
ORDER BY d.DoctorID;

-- 4) Top 5 medicines by total quantity prescribed
SELECT m.MedicineID, m.MedicineName, SUM(pd.Quantity) AS TotalQty
FROM MEDICINE m
JOIN PRESCRIPTION_DETAIL pd ON pd.MedicineID = m.MedicineID
GROUP BY m.MedicineID, m.MedicineName
ORDER BY TotalQty DESC
FETCH FIRST 5 ROWS ONLY;

-- 5) Prescription details for a given PrescriptionID (example: 'DT003')
SELECT r.PrescriptionID, r.ExamID, r.TotalValue, r.InsuranceCoverage, r.PatientPayment, r.PrescriptionDate, r.PrescriptionStatus,
       pd.MedicineID, m.MedicineName, pd.Quantity, pd.Amount
FROM PRESCRIPTION r
JOIN PRESCRIPTION_DETAIL pd ON pd.PrescriptionID = r.PrescriptionID
JOIN MEDICINE m ON m.MedicineID = pd.MedicineID
WHERE r.PrescriptionID = 'DT003';

-- 6) Validate prescription totals against detail sums
SELECT r.PrescriptionID,
       r.TotalValue,
       NVL(SUM(pd.Amount),0) AS DetailSum,
       CASE WHEN r.TotalValue = NVL(SUM(pd.Amount),0) THEN 'OK' ELSE 'MISMATCH' END AS Check
FROM PRESCRIPTION r
LEFT JOIN PRESCRIPTION_DETAIL pd ON pd.PrescriptionID = r.PrescriptionID
GROUP BY r.PrescriptionID, r.TotalValue;
