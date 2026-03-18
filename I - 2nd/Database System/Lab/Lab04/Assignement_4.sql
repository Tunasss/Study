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


--1. Which student has enrolled in the most courses? Show the name and student number.
SELECT TOP 1 s.Student_number, s.Name, COUNT(e.Section_identifier) AS Course_Count
FROM student s
JOIN enrollment e ON s.Student_number = e.Student_number
GROUP BY s.Student_number, s.Name
ORDER BY Course_Count DESC;

--2. Which student has enrolled in both "MATH101" and "CS1310" courses?
SELECT DISTINCT s.Student_number, s.Name
FROM student s
JOIN enrollment e1 ON s.Student_number = e1.Student_number
JOIN section sec1 ON e1.Section_identifier = sec1.Section_identifier
JOIN course c1 ON sec1.Course_number = c1.Course_number
JOIN enrollment e2 ON s.Student_number = e2.Student_number
JOIN section sec2 ON e2.Section_identifier = sec2.Section_identifier
JOIN course c2 ON sec2.Course_number = c2.Course_number
WHERE c1.Course_number = 'MATH101' AND c2.Course_number = 'CS1310';

--3. Find all course numbers offered in either Spring 2025 or Fall 2025.
SELECT DISTINCT c.Course_number
FROM course c
JOIN section s ON c.Course_number = s.Course_number
WHERE (s.Semester = 'Spring' AND s.Year = 2025)
   OR (s.Semester = 'Fall'   AND s.Year = 2025);

--4. Identify lecturers who are both teaching a section and heading a faculty.
SELECT DISTINCT l.Lecturer_id, l.Name
FROM lecturer l
JOIN section s ON l.Lecturer_id = s.Lecturer_id
JOIN faculty f ON f.Head_id = l.Lecturer_id;

--5. List lecturers who are not heading any faculty.
SELECT l.Lecturer_id, l.Name
FROM lecturer l
LEFT JOIN faculty f ON f.Head_id = l.Lecturer_id
WHERE f.Head_id IS NULL;

--6. List all buildings that either host a section taught by a faculty head or are the office locations for a faculty, without duplicates.
SELECT DISTINCT b.Building_id, b.Name
FROM building b
JOIN section s ON b.Building_id = s.Building_id
JOIN faculty f ON s.Faculty_id = f.Faculty_id
WHERE f.Head_id = s.Lecturer_id
UNION
SELECT DISTINCT b.Building_id, b.Name
FROM building b
JOIN faculty f ON f.Office_location LIKE '%' + b.Name + '%';

--7. Find all course numbers that are either prerequisites for courses taught in Fall 2025 or taught by lecturers from the Computer Science faculty.
SELECT DISTINCT p.Prerequisite_course_number AS Course_number
FROM prerequisite p
JOIN course c ON p.Course_number = c.Course_number
JOIN section s ON c.Course_number = s.Course_number
WHERE s.Semester = 'Fall' AND s.Year = 2025
UNION
SELECT DISTINCT c2.Course_number
FROM course c2
JOIN section s2 ON c2.Course_number = s2.Course_number
JOIN lecturer l2 ON s2.Lecturer_id = l2.Lecturer_id
JOIN faculty f2 ON l2.Faculty_id = f2.Faculty_id
WHERE f2.Name = 'Computer Science';

--8. Identify students who are enrolled in sections taught by their faculty's head and have a grade of A (4.00).
SELECT DISTINCT s.Student_number, s.Name
FROM student s
JOIN enrollment e ON s.Student_number = e.Student_number
JOIN grade_report gr ON e.Student_number = gr.Student_number AND e.Section_identifier = gr.Section_identifier
JOIN section sec ON e.Section_identifier = sec.Section_identifier
JOIN faculty f ON sec.Faculty_id = f.Faculty_id
WHERE f.Head_id = sec.Lecturer_id AND gr.Grade = 'A';

--9. Find courses taught in both Spring 2025 and Fall 2025 by lecturers from different faculties.
SELECT DISTINCT c.Course_number
FROM course c
JOIN section s1 ON c.Course_number = s1.Course_number
JOIN lecturer l1 ON s1.Lecturer_id = l1.Lecturer_id
JOIN faculty f1 ON l1.Faculty_id = f1.Faculty_id
JOIN section s2 ON c.Course_number = s2.Course_number
JOIN lecturer l2 ON s2.Lecturer_id = l2.Lecturer_id
JOIN faculty f2 ON l2.Faculty_id = f2.Faculty_id
WHERE s1.Semester = 'Spring' AND s1.Year = 2025
  AND s2.Semester = 'Fall' AND s2.Year = 2025
  AND f1.Faculty_id <> f2.Faculty_id;

--10. Find students who have taken a course with a prerequisite but have not taken the prerequisite course.
SELECT DISTINCT st.Student_number, st.Name
FROM student st
JOIN enrollment e ON st.Student_number = e.Student_number
JOIN section sec ON e.Section_identifier = sec.Section_identifier
JOIN course c ON sec.Course_number = c.Course_number
JOIN prerequisite p ON c.Course_number = p.Course_number
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollment e2
    JOIN section sec2 ON e2.Section_identifier = sec2.Section_identifier
    JOIN course c2 ON sec2.Course_number = c2.Course_number
    WHERE e2.Student_number = st.Student_number
      AND c2.Course_number = p.Prerequisite_course_number
);

--11. Show details for students who used to enroll in all courses taught by Dr Irene Wong.
SELECT s.Student_number, s.Name
FROM student s
JOIN enrollment e ON s.Student_number = e.Student_number
JOIN section sec ON e.Section_identifier = sec.Section_identifier
JOIN lecturer l ON sec.Lecturer_id = l.Lecturer_id
WHERE l.Name = 'Dr. Irene Wong'
GROUP BY s.Student_number, s.Name, l.Lecturer_id
HAVING COUNT(DISTINCT sec.Section_identifier) = (
    SELECT COUNT(*)
    FROM section s2
    WHERE s2.Lecturer_id = l.Lecturer_id
);

--12. Find students who have enrolled in all Computer Science courses.
SELECT s.Student_number, s.Name
FROM student s
JOIN enrollment e ON s.Student_number = e.Student_number
JOIN section sec ON e.Section_identifier = sec.Section_identifier
join course c ON sec.Course_number = c.Course_number
JOIN faculty f ON s.Faculty_id = f.Faculty_id
WHERE f.Name = 'Computer Science'

--13. Find lecturers who have taught sections in all buildings used by the Science faculties.
SELECT l.Lecturer_id, l.Name
FROM lecturer l
JOIN section s ON l.Lecturer_id = s.Lecturer_id
JOIN faculty f ON s.Faculty_id = f.Faculty_id
JOIN building b ON s.Building_id = b.Building_id
WHERE f.Name LIKE '%Science%'
GROUP BY l.Lecturer_id, l.Name
HAVING COUNT(DISTINCT b.Building_id) = (
    SELECT COUNT(DISTINCT b2.Building_id)
    FROM building b2
    JOIN section s2 ON b2.Building_id = s2.Building_id
    JOIN faculty f2 ON s2.Faculty_id = f2.Faculty_id
    WHERE f2.Name LIKE '%Science%'
);

--14. Find students who have earned an A (Grade_point 4.00) in all courses taught by lecturers from the Mathematics faculty.
SELECT s.Student_number, s.Name
FROM student s
JOIN enrollment e ON s.Student_number = e.Student_number
JOIN grade_report gr ON e.Student_number = gr.Student_number AND e.Section_identifier = gr.Section_identifier
JOIN section sec ON e.Section_identifier = sec.Section_identifier
JOIN faculty f ON sec.Faculty_id = f.Faculty_id
WHERE f.Name = 'Mathematics' AND gr.Grade = 'A'
GROUP BY s.Student_number, s.Name
HAVING COUNT(DISTINCT sec.Section_identifier) = (
    SELECT COUNT(DISTINCT s2.Section_identifier)
    FROM section s2
    JOIN faculty f2 ON s2.Faculty_id = f2.Faculty_id
    WHERE f2.Name = 'Mathematics'
);

-- 15. Find courses that have been taken by all students in the Computer Science faculty.
SELECT c.Course_number, c.Name
FROM course c
JOIN section s ON c.Course_number = s.Course_number
JOIN enrollment e ON s.Section_identifier = e.Section_identifier
JOIN student st ON e.Student_number = st.Student_number
JOIN faculty f ON st.Faculty_id = f.Faculty_id
WHERE f.Name = 'Computer Science'
GROUP BY c.Course_number, c.Name
HAVING COUNT(DISTINCT st.Student_number) = (
    SELECT COUNT(*)
    FROM student st2
    JOIN faculty f2 ON st2.Faculty_id = f2.Faculty_id
    WHERE f2.Name = 'Computer Science'
);

-- 16. Calculate the average grade point for each course section.
SELECT s.Section_identifier, c.Course_number, AVG(gr.Grade_point) AS Average_Grade_Point
FROM section s
JOIN course c ON s.Course_number = c.Course_number
JOIN grade_report gr ON s.Section_identifier = gr.Section_identifier
GROUP BY s.Section_identifier, c.Course_number;

-- 17. Determine the maximum capacity of sections in each building.
SELECT b.Building_id, b.Name, MAX(s.Capacity) AS Max_Capacity
FROM building b
JOIN section s ON b.Building_id = s.Building_id
GROUP BY b.Building_id, b.Name;

-- 18. Count the number of sections taught by each lecturer in 2024.
SELECT l.Lecturer_id, l.Name, COUNT(*) AS Sections_2024
FROM lecturer l
JOIN section s ON l.Lecturer_id = s.Lecturer_id
WHERE s.Year = 2024
GROUP BY l.Lecturer_id, l.Name;

-- 19. Determine the sections with the maximum capacity of each building.
SELECT b.Building_id, b.Name AS Building_Name, s.Section_identifier, s.Capacity
FROM section s
JOIN building b ON s.Building_id = b.Building_id
WHERE s.Capacity = (
    SELECT MAX(s2.Capacity) FROM section s2 WHERE s2.Building_id = s.Building_id
)
ORDER BY b.Building_id;

-- 20. Find the minimum and maximum grade points for each course.
SELECT c.Course_number,
       MIN(gr.Grade_point) AS Min_Grade_Point,
       MAX(gr.Grade_point) AS Max_Grade_Point
FROM course c
JOIN section s ON c.Course_number = s.Course_number
JOIN grade_report gr ON s.Section_identifier = gr.Section_identifier
GROUP BY c.Course_number;

-- 21. Find the number of sections offered per course in each semester and year.
SELECT c.Course_number, s.Semester, s.Year, COUNT(*) AS Sections_Count
FROM course c
JOIN section s ON c.Course_number = s.Course_number
GROUP BY c.Course_number, s.Semester, s.Year
ORDER BY c.Course_number, s.Year, s.Semester;

-- 22. Calculate the average grade point for each lecturer, excluding sections with fewer than 5 graded students.
WITH section_stats AS (
    SELECT Section_identifier,
           COUNT(*) AS graded_count,
           AVG(Grade_point) AS avg_grade_point
    FROM grade_report
    GROUP BY Section_identifier
)
SELECT l.Lecturer_id, l.Name, AVG(ss.avg_grade_point) AS Lecturer_Avg_Grade_Point
FROM section_stats ss
JOIN section s ON ss.Section_identifier = s.Section_identifier
JOIN lecturer l ON s.Lecturer_id = l.Lecturer_id
WHERE ss.graded_count >= 5
GROUP BY l.Lecturer_id, l.Name;

-- 23. Identify lecturers who teach more than one section in the same semester and year, and count their sections.
SELECT l.Lecturer_id, l.Name, s.Semester, s.Year, COUNT(*) AS Sections_Count
FROM section s
JOIN lecturer l ON s.Lecturer_id = l.Lecturer_id
GROUP BY l.Lecturer_id, l.Name, s.Semester, s.Year
HAVING COUNT(*) > 1
ORDER BY l.Lecturer_id, s.Year, s.Semester;

-- 24. Find courses with the highest average grade point in each faculty.
SELECT Faculty_id, Course_number, Avg_Grade
FROM (
    SELECT f.Faculty_id, c.Course_number, AVG(gr.Grade_point) AS Avg_Grade,
           RANK() OVER (PARTITION BY f.Faculty_id ORDER BY AVG(gr.Grade_point) DESC) AS rnk
    FROM course c
    JOIN section s ON c.Course_number = s.Course_number
    JOIN grade_report gr ON s.Section_identifier = gr.Section_identifier
    JOIN faculty f ON s.Faculty_id = f.Faculty_id
    GROUP BY f.Faculty_id, c.Course_number
) t
WHERE rnk = 1
ORDER BY Faculty_id;

-- 25. Find the average number of students enrolled per section for each course.
SELECT c.Course_number,
       AVG(ISNULL(sec_enroll.count_students,0)*1.0) AS Avg_Students_Per_Section
FROM course c
JOIN (
    SELECT s.Section_identifier, s.Course_number, COUNT(e.Student_number) AS count_students
    FROM section s
    LEFT JOIN enrollment e ON s.Section_identifier = e.Section_identifier
    GROUP BY s.Section_identifier, s.Course_number
) sec_enroll ON c.Course_number = sec_enroll.Course_number
GROUP BY c.Course_number
ORDER BY c.Course_number;

-- 26. Find lecturers who have taught in multiple buildings and have the highest total student enrollment across all their sections.
WITH lect_stats AS (
    SELECT l.Lecturer_id, l.Name,
           COUNT(DISTINCT s.Building_id) AS buildings_taught,
           SUM(ISNULL(sec_enroll.count_students,0)) AS total_enrollment
    FROM lecturer l
    JOIN section s ON l.Lecturer_id = s.Lecturer_id
    LEFT JOIN (
        SELECT Section_identifier, COUNT(*) AS count_students FROM enrollment GROUP BY Section_identifier
    ) sec_enroll ON s.Section_identifier = sec_enroll.Section_identifier
    GROUP BY l.Lecturer_id, l.Name
)
SELECT ls.Lecturer_id, ls.Name, ls.buildings_taught, ls.total_enrollment
FROM lect_stats ls
WHERE ls.buildings_taught > 1
  AND ls.total_enrollment = (
      SELECT MAX(total_enrollment) FROM lect_stats WHERE buildings_taught > 1
  );

-- 27. Find lecturers whose sections have consistently high enrollment (all sections above the average enrollment for their faculty).
WITH faculty_avg AS (
    SELECT s.Faculty_id, AVG(ISNULL(sec_enroll.count_students,0)*1.0) AS faculty_avg_enrollment
    FROM section s
    LEFT JOIN (
        SELECT Section_identifier, COUNT(*) AS count_students FROM enrollment GROUP BY Section_identifier
    ) sec_enroll ON s.Section_identifier = sec_enroll.Section_identifier
    GROUP BY s.Faculty_id
), lect_sections AS (
    SELECT s.Section_identifier, s.Faculty_id, s.Lecturer_id, ISNULL(sec_enroll.count_students,0) AS count_students
    FROM section s
    LEFT JOIN (
        SELECT Section_identifier, COUNT(*) AS count_students FROM enrollment GROUP BY Section_identifier
    ) sec_enroll ON s.Section_identifier = sec_enroll.Section_identifier
)
SELECT l.Lecturer_id, l.Name
FROM lecturer l
WHERE EXISTS (SELECT 1 FROM lect_sections ls WHERE ls.Lecturer_id = l.Lecturer_id)
  AND NOT EXISTS (
      SELECT 1
      FROM lect_sections ls
      JOIN faculty_avg fa ON ls.Faculty_id = fa.Faculty_id
      WHERE ls.Lecturer_id = l.Lecturer_id
        AND ls.count_students <= fa.faculty_avg_enrollment
  );

-- 28. Find faculties with the largest number of students enrolled in the Spring sections of 2025 but have the smallest number of students who earned an A grade.
WITH stats AS (
    SELECT f.Faculty_id, f.Name,
           SUM(ISNULL(sec_enroll.count_students,0)) AS total_enrollment,
           SUM(CASE WHEN gr.Grade = 'A' THEN 1 ELSE 0 END) AS a_count
    FROM faculty f
    JOIN section s ON s.Faculty_id = f.Faculty_id
    LEFT JOIN (
       SELECT Section_identifier, COUNT(*) AS count_students FROM enrollment GROUP BY Section_identifier
    ) sec_enroll ON s.Section_identifier = sec_enroll.Section_identifier
    LEFT JOIN grade_report gr ON s.Section_identifier = gr.Section_identifier
    WHERE s.Semester = 'Spring' AND s.Year = 2025
    GROUP BY f.Faculty_id, f.Name
)
SELECT *
FROM stats
WHERE total_enrollment = (SELECT MAX(total_enrollment) FROM stats)
ORDER BY a_count ASC;
