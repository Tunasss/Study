CREATE DATABASE Assignment_03;

DROP TABLE IF EXISTS building;
DROP TABLE IF EXISTS faculty;
DROP TABLE IF EXISTS lecturer;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS section;
DROP TABLE IF EXISTS grade_report;
DROP TABLE IF EXISTS enrollment;
DROP TABLE IF EXISTS prerequisite;

CREATE TABLE building (
    Building_id INT NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL
);

CREATE TABLE faculty (
    Faculty_id INT NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Head_id INT NOT NULL,
    Office_location VARCHAR(50),
    Phone VARCHAR(15)
);

CREATE TABLE lecturer (
    Lecturer_id INT NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Faculty_id INT NOT NULL,
    Office_location VARCHAR(50),
    Phone VARCHAR(15),
    DOB DATE NOT NULL,
    Join_date DATE NOT NULL
);

ALTER TABLE faculty
ADD CONSTRAINT FK_faculty_head
FOREIGN KEY (Head_id) REFERENCES lecturer(Lecturer_id);

CREATE TABLE student (
    Student_number INT NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Class TINYINT NOT NULL,
    Faculty_id INT NOT NULL,
    DOB DATE NOT NULL,
    FOREIGN KEY (Faculty_id) REFERENCES faculty(Faculty_id)
);


CREATE TABLE course (
    Course_number VARCHAR(20) NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Credit_hours TINYINT NOT NULL
);


CREATE TABLE section (
    Section_identifier INT NOT NULL PRIMARY KEY,
    Course_number VARCHAR(20) NOT NULL,
    Semester VARCHAR(20) NOT NULL,
    Year INT NOT NULL,
    Lecturer_id INT NOT NULL,
    Faculty_id INT NULL,
    Building_id INT NOT NULL,
    Room_number VARCHAR(10) NOT NULL,
    Time_slot VARCHAR(50) NOT NULL,
    Capacity INT NOT NULL,
    FOREIGN KEY (Course_number) REFERENCES course(Course_number),
    FOREIGN KEY (Lecturer_id) REFERENCES lecturer(Lecturer_id),
    FOREIGN KEY (Faculty_id) REFERENCES faculty(Faculty_id),
    FOREIGN KEY (Building_id) REFERENCES building(Building_id)
);

CREATE TABLE grade_report (
    Student_number INT NOT NULL,
    Section_identifier INT NOT NULL,
    Grade VARCHAR(2) NOT NULL,
    Grade_point DECIMAL(3,2) NOT NULL,
    PRIMARY KEY (Student_number, Section_identifier),
    FOREIGN KEY (Student_number) REFERENCES student(Student_number),
    FOREIGN KEY (Section_identifier) REFERENCES section(Section_identifier)
);

CREATE TABLE enrollment (
    Student_number INT NOT NULL,
    Section_identifier INT NOT NULL,
    Enrollment_date DATE NOT NULL,
    PRIMARY KEY (Student_number, Section_identifier),
    FOREIGN KEY (Student_number) REFERENCES student(Student_number),
    FOREIGN KEY (Section_identifier) REFERENCES section(Section_identifier)
);


CREATE TABLE prerequisite (
    Course_number VARCHAR(20) NOT NULL,
    Prerequisite_course_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (Course_number, Prerequisite_course_number),
    FOREIGN KEY (Course_number) REFERENCES course(Course_number),
    FOREIGN KEY (Prerequisite_course_number) REFERENCES course(Course_number)
);

INSERT INTO building (Building_id, Name, Address) VALUES
(1, 'Science Hall', '123 University Ave, City, ST 12345'),
(2, 'Lecture Center', '456 Campus Rd, City, ST 12345'),
(3, 'Engineering Tower', '789 Tech Dr, City, ST 12345'),
(4, 'Library Annex', '101 Library Ln, City, ST 12345'),
(5, 'Arts Building', '202 Creative Way, City, ST 12345'),
(6, 'Business School', '303 Commerce St, City, ST 12345'),
(7, 'Student Union', '404 Union Blvd, City, ST 12345'),
(8, 'Health Sciences', '505 Medical Rd, City, ST 12345'),
(9, 'Physics Hall', '606 Science Pkwy, City, ST 12345'),
(10, 'Chemistry Lab', '707 Chem Ave, City, ST 12345'),
(11, 'Social Sciences Hall', '808 Society St, City, ST 12345'),
(12, 'Language Center', '909 Lingua Rd, City, ST 12345');

INSERT INTO course (Course_number, Name, Credit_hours) VALUES
('CS101', 'Introduction to Programming', 3),
('CS201', 'Data Structures', 3),
('MATH101', 'Calculus I', 4),
('ENG101', 'Mechanics', 3),
('PHY101', 'Introduction to Physics', 4),
('CHEM101', 'General Chemistry', 4),
('BUS101', 'Principles of Management', 3),
('ART101', 'Art History', 3),
('BIO101', 'Biology Fundamentals', 4),
('HIST101', 'World History', 3),
('ECON101', 'Microeconomics', 3);

INSERT INTO faculty (Faculty_id, Name, Head_id, Office_location, Phone) VALUES
(1, 'Computer Science', 1, 'Science Hall 301', '555-0101'),
(2, 'Mathematics', 3, 'Science Hall 401', '555-0102'),
(3, 'Engineering', 4, 'Engineering Tower 501', '555-0103'),
(4, 'Physics', 5, 'Physics Hall 201', '555-0104'),
(5, 'Chemistry', 6, 'Chemistry Lab 301', '555-0105'),
(6, 'Business', 7, 'Business School 401', '555-0106'),
(7, 'Arts', 8, 'Arts Building 101', '555-0107'),
(8, 'Biology', 9, 'Health Sciences 601', '555-0108'),
(9, 'Economics', 10, 'Business School 402', '555-0109'),
(10, 'History', 11, 'Library Annex 202', '555-0110');

INSERT INTO lecturer (Lecturer_id, Name, Faculty_id, Office_location, Phone, DOB, Join_date) VALUES
(1, 'Dr. Alice Smith', 1, 'Science Hall 302', '555-0201', '1975-03-15', '2010-08-01'),
(2, 'Dr. Bob Johnson', 1, 'Science Hall 303', '555-0202', '1980-06-22', '2015-09-01'),
(3, 'Dr. Carol White', 2, 'Science Hall 402', '555-0203', '1978-11-10', '2012-01-15'),
(4, 'Dr. David Lee', 3, 'Engineering Tower 502', '555-0204', '1972-07-18', '2008-08-15'),
(5, 'Dr. Emma Brown', 4, 'Physics Hall 202', '555-0205', '1985-02-10', '2018-01-10'),
(6, 'Dr. Frank Green', 5, 'Chemistry Lab 302', '555-0206', '1979-09-05', '2013-09-01'),
(7, 'Dr. Grace Kim', 6, 'Business School 403', '555-0207', '1982-12-15', '2016-07-01'),
(8, 'Dr. Henry Patel', 7, 'Arts Building 102', '555-0208', '1976-03-22', '2010-08-01'),
(9, 'Dr. Irene Wong', 8, 'Health Sciences 602', '555-0209', '1980-11-30', '2014-01-15'),
(10, 'Dr. James Carter', 9, 'Business School 404', '555-0210', '1974-06-25', '2009-09-01'),
(11, 'Dr. Karen Adams', 10, 'Library Annex 203', '555-0211', '1973-04-12', '2011-08-01'),
(12, 'Dr. Laura Evans', 2, 'Science Hall 403', '555-0212', '1981-05-20', '2017-09-01'),
(13, 'Dr. Michael Brown', 1, 'Science Hall 304', '555-0213', '1977-08-10', '2019-01-15'),
(14, 'Dr. Susan Clark', 2, 'Science Hall 404', '555-0214', '1983-04-25', '2020-08-01'),
(15, 'Dr. Thomas Wilson', 3, 'Engineering Tower 503', '555-0215', '1974-12-05', '2016-09-01'),
(16, 'Dr. Rachel Lee', 4, 'Physics Hall 203', '555-0216', '1986-07-18', '2021-01-10'),
(17, 'Dr. Peter Davis', 5, 'Chemistry Lab 303', '555-0217', '1980-03-30', '2018-07-01');

INSERT INTO student (Student_number, Name, Class, Faculty_id, DOB) VALUES
(1001, 'John Doe', 2, 1, '2003-04-12'),
(1002, 'Jane Roe', 3, 1, '2002-09-25'),
(1003, 'Mike Brown', 1, 2, '2004-01-30'),
(1004, 'Sarah Davis', 4, 3, '2001-05-20'),
(1005, 'Tom Wilson', 2, 4, '2003-08-14'),
(1006, 'Lisa Taylor', 3, 5, '2002-02-28'),
(1007, 'Mark Evans', 1, 6, '2004-10-10'),
(1008, 'Emily Clark', 2, 7, '2003-07-03'),
(1009, 'Ryan Harris', 4, 8, '2001-12-15'),
(1010, 'Anna Lee', 3, 9, '2002-06-08'),
(1011, 'Chris Martinez', 2, 10, '2003-03-17'),
(1012, 'Sophie Turner', 1, 1, '2004-11-22');

INSERT INTO prerequisite (Course_number, Prerequisite_course_number) VALUES
('CS201', 'CS101'),
('ENG101', 'MATH101'),
('PHY101', 'MATH101'),
('CHEM101', 'MATH101'),
('BUS101', 'ECON101'),
('ART101', 'HIST101'),
('BIO101', 'CHEM101'),
('ECON101', 'MATH101'),
('CS101', 'MATH101'),
('HIST101', 'ENG101'),
('CS201', 'MATH101'),
('PHY101', 'CHEM101');

INSERT INTO section (Section_identifier, Course_number, Semester, Year, Lecturer_id, Building_id, Room_number, Time_slot, Capacity) VALUES
(1, 'CS101', 'Spring', 2025, 1, 1, '101', 'Mon/Wed 10:00-11:30', 50),
(2, 'MATH101', 'Spring', 2025, 3, 2, '201', 'Tue/Thu 13:00-14:30', 40),
(3, 'CS201', 'Spring', 2025, 2, 1, '102', 'Mon/Wed 13:00-14:30', 40),
(4, 'ENG101', 'Spring', 2025, 4, 3, '301', 'Tue/Thu 09:00-10:30', 50),
(5, 'PHY101', 'Fall', 2025, 5, 9, '101', 'Mon/Wed 11:00-12:30', 45),
(6, 'CHEM101', 'Fall', 2025, 6, 10, '201', 'Tue/Thu 14:00-15:30', 40),
(7, 'BUS101', 'Spring', 2025, 7, 6, '401', 'Mon/Wed 15:00-16:30', 50),
(8, 'ART101', 'Spring', 2025, 8, 5, '103', 'Fri 10:00-12:00', 30),
(9, 'BIO101', 'Fall', 2025, 9, 8, '601', 'Tue/Thu 11:00-12:30', 35),
(10, 'ECON101', 'Spring', 2025, 10, 6, '402', 'Mon/Wed 09:00-10:30', 50),
(11, 'HIST101', 'Fall', 2025, 11, 4, '301', 'Mon/Wed 14:00-15:30', 40),
(12, 'CS101', 'Fall', 2025, 13, 1, '103', 'Tue/Thu 10:00-11:30', 50);

INSERT INTO enrollment (Student_number, Section_identifier, Enrollment_date) VALUES
(1001, 1, '2025-01-10'), 
(1002, 1, '2025-01-10'), 
(1003, 2, '2025-01-11'), 
(1004, 4, '2025-01-12'), 
(1005, 5, '2025-08-10'), 
(1006, 6, '2025-08-11'), 
(1007, 7, '2025-01-13'), 
(1008, 8, '2025-01-14'), 
(1009, 9, '2025-08-12'), 
(1010, 10, '2025-01-15'), 
(1011, 11, '2025-08-13'), 
(1012, 12, '2025-08-14'); 

INSERT INTO grade_report (Student_number, Section_identifier, Grade, Grade_point) VALUES
(1001, 1, 'A', 4.00), 
(1002, 1, 'B+', 3.33), 
(1003, 2, 'A-', 3.67), 
(1004, 4, 'B', 3.00), 
(1005, 5, 'A', 4.00), 
(1006, 6, 'C+', 2.33), 
(1007, 7, 'A-', 3.67), 
(1008, 8, 'B+', 3.33), 
(1009, 9, 'A', 4.00), 
(1010, 10, 'B-', 2.67), 
(1011, 11, 'B', 3.00), 
(1012, 12, 'A-', 3.67);

-- 7: The head of a faculty must be a lecturer of that faculty.
ALTER TABLE faculty
ADD CONSTRAINT FK_faculty_head
FOREIGN KEY (Head_id) REFERENCES lecturer(Lecturer_id); 

-- 8. A student's class must be consistent with their enrollment duration.
ALTER TABLE student
ADD CONSTRAINT CK_student_class_duration CHECK (
    (Class = 1 AND DATEDIFF(year, DOB, GETDATE()) >= 17 AND DATEDIFF(year, DOB, GETDATE()) < 18) OR
    (Class = 2 AND DATEDIFF(year, DOB, GETDATE()) >= 18 AND DATEDIFF(year, DOB, GETDATE()) < 19) OR
    (Class = 3 AND DATEDIFF(year, DOB, GETDATE()) >= 19 AND DATEDIFF(year, DOB, GETDATE()) < 20) OR
    (Class = 4 AND DATEDIFF(year, DOB, GETDATE()) >= 20)
);
-- 9. The number of enrolled students of a section must not exceed the capacity of that section.
GO
CREATE TRIGGER trg_check_section_capacity
ON enrollment
AFTER INSERT, DELETE
AS
BEGIN
    DECLARE @SectionID INT;
    DECLARE @EnrolledCount INT;
    DECLARE @Capacity INT;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SELECT @SectionID = Section_identifier FROM inserted;
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        SELECT @SectionID = Section_identifier FROM deleted;
    END

    SELECT @EnrolledCount = COUNT(*) 
    FROM enrollment 
    WHERE Section_identifier = @SectionID;

    SELECT @Capacity = Capacity 
    FROM section 
    WHERE Section_identifier = @SectionID;

    IF @EnrolledCount > @Capacity
    BEGIN
        RAISERROR ('Enrollment exceeds section capacity', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- 10. A student must complete all prerequisites for a course before enrolling in its section.
GO
CREATE TRIGGER trg_check_prerequisites
ON enrollment
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN prerequisite p ON i.Section_identifier IN (
            SELECT Section_identifier 
            FROM section 
            WHERE Course_number = p.Course_number
        )
        LEFT JOIN grade_report gr ON i.Student_number = gr.Student_number 
            AND gr.Section_identifier IN (
                SELECT Section_identifier 
                FROM section 
                WHERE Course_number = p.Prerequisite_course_number
            )
        WHERE gr.Grade IS NULL
    )
    BEGIN
        RAISERROR ('Student has not completed all prerequisites for the course', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
