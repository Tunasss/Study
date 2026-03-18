-- 24521943 - Tran Anh Tuan

CREATE DATABASE BAITHI;
USE BAITHI;

-- Question 1:

DROP TABLE IF EXISTS Skill;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Training;
DROP TABLE IF EXISTS Work_On;
DROP TABLE IF EXISTS Assessment;

CREATE TABLE Skill (
    SkillID VARCHAR(10) PRIMARY KEY,
    SkillName NVARCHAR(100) NOT NULL,
    DifficultyLevel INT CHECK (DifficultyLevel BETWEEN 1 AND 10),
    SkillType NVARCHAR(50) NOT NULL
);

CREATE TABLE Employee (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    EmployeeName NVARCHAR(100) NOT NULL,
    DOB DATE,
    JoinDate DATE NOT NULL,
    DeptName NVARCHAR(100),
);

CREATE TABLE Project (
    ProjectID VARCHAR(10) PRIMARY KEY,
    ProjectName NVARCHAR(100) NOT NULL,
    NumWorkers INT NOT NULL,
    Status NVARCHAR(50) NOT NULL
);

CREATE TABLE Training (
    EmployeeID VARCHAR(10) NOT NULL,
    SkillID VARCHAR(10) NOT NULL,
    AttemptNo INT NOT NULL,
    Score INT CHECK (Score BETWEEN 0 AND 100),
    TrainingStatus NVARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    ENDDate DATE NOT NULL,

    PRIMARY KEY (EmployeeID, SkillID, AttemptNo),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (SkillID) REFERENCES Skill(SkillID)
);

CREATE TABLE Work_On (
    EmployeeID VARCHAR(10) NOT NULL,
    ProjectID VARCHAR(10) NOT NULL,
    HoursWorked INT NOT NULL,
    Role NVARCHAR(100) NOT NULL,
    AssignedDate DATE NOT NULL,

    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

CREATE TABLE Assessment (
    AssessmentID VARCHAR(10) PRIMARY KEY,
    EmployeeID VARCHAR(10) NOT NULL,
    ReviewerID VARCHAR(10),
    AssessmentDate DATE NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),

    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ReviewerID) REFERENCES Employee(EmployeeID)
);

-- Question 2: 

INSERT INTO Skill (SkillID, SkillName, DifficultyLevel, SkillType) VALUES
('S001', 'Cloud Architecture', 9, 'Technical'),
('S002', 'Strategic Planning', 6, 'Leadership'),
('S003', 'Time Management', 2, 'Soft');

INSERT INTO Employee (EmployeeID, EmployeeName, DOB, JoinDate, DeptName) VALUES
('E001', 'Grace Hopper', '1990-12-09', '2021-05-10', 'Engineering'),
('E002', 'Alan Turing', '1982-06-23', '2019-03-15', 'Research'),
('E003', 'Ada Lovelace', '1995-12-10', '2023-01-20', 'Prodeuct Management');

INSERT INTO Project (ProjectID, ProjectName, NumWorkers, Status) VALUES
('P001', 'Project Enigma', 15, 'In Progress'),
('P002', 'Internal Audit', 3, 'On Hold'),
('P003', 'Product Launch', 8, 'Proposed');

INSERT INTO Training (EmployeeID, SkillID, AttemptNo, Score, TrainingStatus, StartDate, ENDDate) VALUES
('E001', 'S001', 1, 58, 'Failed', '2025-02-01', '2025-03-01'),
('E001', 'S001', 2, 94, 'Passed', '2025-04-01', '2025-05-01'),
('E002', 'S002', 1, 89, 'Passed', '2023-06-15', '2025-07-01');

INSERT INTO Work_On (EmployeeID, ProjectID, HoursWorked, Role, AssignedDate) VALUES
('E001', 'P001', 160, 'System Architect', '2023-05-15'),
('E002', 'P001', 200, 'Principal Scientist', '2025-03-20'),
('E003', 'P003', 45, 'Product Owner', '2025-11-01');

INSERT INTO Assessment (AssessmentID, EmployeeID, ReviewerID, AssessmentDate, Rating) VALUES
('A001', 'E001', 'E002', '2025-12-01', 5),
('A002', 'E002', 'E001', '2025-11-15', 4),
('A003', 'E003', 'E002', '2025-12-20', 4);

SELECT * FROM Skill;
SELECT * FROM Employee;
SELECT * FROM Project;
SELECT * FROM Training;
SELECT * FROM Work_On;
SELECT * FROM Assessment;   

-- Question 3:
ALTER TABLE Training
ADD CONSTRAINT CK_TRAINING_SCORE_STATUS CHECK (
    (TrainingStatus = 'In Progress' AND Score IS NULL) OR
    (TrainingStatus <> 'In Progress' AND Score BETWEEN 0 AND 100)
);

-- Question 4:
-- Trigger 1: Enforce rating constraint on insert
GO
CREATE TRIGGER trg_CheckRatingOnInsert
ON Assessment
AFTER INSERT
AS
BEGIN
    DECLARE @trainingCount INT;
    DECLARE @EmployeeID VARCHAR(10);
    DECLARE @Rating INT;

    SELECT @EmployeeID = EmployeeID, @Rating = Rating FROM inserted;

    SELECT @trainingCount = COUNT(*)
    FROM Training
    WHERE EmployeeID = @EmployeeID
      AND TrainingStatus = 'Passed'
      AND AttemptNo = 1;

    IF @trainingCount > 3 AND @Rating < 3
    BEGIN
        RAISERROR('Rating must be at least 3 if more than three training records are passed on the first attempt.', 16, 1);
    END;
END;
GO

-- Trigger 2: Enforce rating constraint on update
GO
CREATE TRIGGER trg_CheckRatingOnUpdate
ON Assessment
AFTER UPDATE
AS
BEGIN
    DECLARE @trainingCount INT;
    DECLARE @EmployeeID VARCHAR(10);
    DECLARE @Rating INT;

    SELECT @EmployeeID = EmployeeID, @Rating = Rating FROM inserted;

    SELECT @trainingCount = COUNT(*)
    FROM Training
    WHERE EmployeeID = @EmployeeID
      AND TrainingStatus = 'Passed'
      AND AttemptNo = 1;

    IF @trainingCount > 3 AND @Rating < 3
    BEGIN
        RAISERROR('Rating must be at least 3 if more than three training records are passed on the first attempt.', 16, 1);
    END;
END;
GO

-- Trigger 3: Enforce rating constraint on both insert and update
GO
CREATE TRIGGER trg_CheckRatingBeforeAssessment
ON Assessment
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @trainingCount INT;
    DECLARE @EmployeeID VARCHAR(10);
    DECLARE @Rating INT;

    SELECT @EmployeeID = EmployeeID, @Rating = Rating FROM inserted;

    SELECT @trainingCount = COUNT(*)
    FROM Training
    WHERE EmployeeID = @EmployeeID
      AND TrainingStatus = 'Passed'
      AND AttemptNo = 1;

    IF @trainingCount > 3 AND @Rating < 3
    BEGIN
        RAISERROR('Rating must be at least 3 if more than three training records are passed on the first attempt.', 16, 1);
    END;
END;
GO

-- Question 5: 
SELECT E.EmployeeID, E.EmployeeName
FROM Employee E
JOIN Work_On W ON E.EmployeeID = W.EmployeeID
WHERE YEAR(E.JoinDate) = 2023
    AND W.ProjectID = 'P001'
    AND W.Role = 'System Architect';

-- Question 6:
SELECT E.EmployeeID, E.EmployeeName
FROM Employee E
LEFT JOIN Training T ON E.EmployeeID = T.EmployeeID
WHERE T.EmployeeID IS NULL
    OR (E.DeptName = 'Research' AND E.EmployeeID IN (
       SELECT W.EmployeeID
       FROM Work_On W
       WHERE W.ProjectID = 'P002'
    )
);

-- Question 7:  
SELECT A.EmployeeID, E.EmployeeName
FROM Assessment A
JOIN Employee E ON E.EmployeeID = A.EmployeeID
WHERE YEAR(A.AssessmentDate) = 2025
    AND A.EmployeeID IN (
        SELECT W.EmployeeID
        FROM Work_On W
        WHERE YEAR(W.AssignedDate) = 2025
        GROUP BY W.EmployeeID
        HAVING COUNT(*) = (
            SELECT MAX(ProjectCount)
            FROM (
                SELECT COUNT(*) AS ProjectCount
                FROM Work_On W2
                WHERE YEAR(W2.AssignedDate) = 2025
                GROUP BY W2.EmployeeID
            ) AS ProjectCounts
        )
    )
    AND A.Rating = (
        SELECT MIN(A2.Rating)
        FROM Assessment A2
        WHERE YEAR(A2.AssessmentDate) = 2025
            AND A2.EmployeeID IN (
                SELECT W.EmployeeID
                FROM Work_On W
                WHERE YEAR(W.AssignedDate) = 2025
                GROUP BY W.EmployeeID
                HAVING COUNT(*) = (
                    SELECT MAX(ProjectCount)
                    FROM (
                        SELECT COUNT(*) AS ProjectCount
                        FROM Work_On W3
                        WHERE YEAR(W3.AssignedDate) = 2025
                        GROUP BY W3.EmployeeID
                    ) AS ProjectCounts2
                )
            )
);


-- Question 8:
SELECT E.EmployeeID, E.EmployeeName
FROM Employee E
WHERE NOT EXISTS (
    SELECT P.ProjectID
    FROM Project P
    WHERE P.NumWorkers >= 5
        AND NOT EXISTS (
            SELECT W.EmployeeID
            FROM Work_On W
            WHERE W.EmployeeID = E.EmployeeID
                AND W.ProjectID = P.ProjectID
                AND W.Role = 'System Architect'
            )
);