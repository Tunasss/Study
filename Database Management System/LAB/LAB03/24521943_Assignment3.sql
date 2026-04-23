--1. Write the commands to perform the following tasks:
--a. Create a table Caul with two columns: ID (number) and NAME (varchar2(20)).

PROMPT Creating table 'CAUL'
CREATE TABLE CAUL
(
 ID NUMBER,
 NAME VARCHAR2(20)
)
/

--b. Create a sequence CaulSeq with an increment step of 5.

PROMPT Creating sequence 'CAULSEQ'
CREATE SEQUENCE CAULSEQ
 INCREMENT BY 5
 START WITH 1
/

--c. Declare two variables v_name and v_id. The v_name and v_id variables will be used to hold the values of the student’s name and ID, which will be added.

PROMPT Declaring variables 'V_NAME' and 'V_ID'
DECLARE
 v_name VARCHAR2(20);
 v_id NUMBER;
BEGIN
 v_name := NULL;
 v_id := NULL;
END;
/

--d. Insert the name of the student who has registered for the most courses (from the enrollment table) into the Caul table. The student ID will be taken from the CaulSeq sequence. After this operation, create a Savepoint A.

PROMPT Inserting the name of the student who has registered for the most courses into 'CAUL' and creating Savepoint A
DECLARE
 v_name VARCHAR2(20);
 v_id NUMBER;
BEGIN
 SELECT s.LastName INTO v_name
 FROM STUDENT s
 JOIN ENROLLMENT e ON s.StudentID = e.StudentID
 GROUP BY s.StudentID, s.LastName
 ORDER BY COUNT(*) DESC
 FETCH FIRST 1 ROWS ONLY;

 v_id := CAULSEQ.NEXTVAL;

 INSERT INTO CAUL (ID, NAME) VALUES (v_id, v_name);

 SAVEPOINT A;
END;
/

--e. Insert the name of the student who has registered for the least number of courses (from the enrollment table) into the Caul table. The student ID will be taken from the CaulSeq sequence. After this operation, create a Savepoint B.

PROMPT Inserting the name of the student who has registered for the least number of courses into 'CAUL' and creating Savepoint B
DECLARE
 v_name VARCHAR2(20);
 v_id NUMBER;
BEGIN
 SELECT s.LastName INTO v_name
 FROM STUDENT s
 JOIN ENROLLMENT e ON s.StudentID = e.StudentID
 GROUP BY s.StudentID, s.LastName
 ORDER BY COUNT(*) ASC
 FETCH FIRST 1 ROWS ONLY;

 v_id := CAULSEQ.NEXTVAL;

 INSERT INTO CAUL (ID, NAME) VALUES (v_id, v_name);

 SAVEPOINT B;
END;
/

--f. Do the same for the teachers who have taught the most courses. After this operation, create a Savepoint C.

PROMPT Inserting the name of the teacher who has taught the most courses into 'CAUL' and creating Savepoint C
DECLARE
 v_name VARCHAR2(20);
 v_id NUMBER;
BEGIN
 SELECT i.LastName INTO v_name
 FROM INSTRUCTOR i
 JOIN CLASS c ON i.InstructorID = c.InstructorID
 GROUP BY i.InstructorID, i.LastName
 ORDER BY COUNT(*) DESC
 FETCH FIRST 1 ROWS ONLY;

 v_id := CAULSEQ.NEXTVAL;

 INSERT INTO CAUL (ID, NAME) VALUES (v_id, v_name);

 SAVEPOINT C;
END;
/

--2.Write a PL/SQL block to perform a task that will accept Student Id by user put in. If the student exists in database then print all the information involved that student, otherwise, ask user to put in the student's other information to insert into Student table.
SET SERVEROUTPUT ON;
SET VERIFY OFF;

PROMPT PL/SQL block to accept Student ID and print information or insert new student
DECLARE
    v_student_id        STUDENT.StudentID%TYPE := &p_student_id;
    v_salutation        STUDENT.Salutation%TYPE;
    v_first_name        STUDENT.FirstName%TYPE;
    v_last_name         STUDENT.LastName%TYPE;
    v_address           STUDENT.Address%TYPE;
    v_phone             STUDENT.Phone%TYPE;
    v_employer          STUDENT.Employer%TYPE;
    v_registration_date STUDENT.RegistrationDate%TYPE;
    v_created_by        STUDENT.CreatedBy%TYPE;
    v_created_date      STUDENT.CreatedDate%TYPE;
    v_modified_by       STUDENT.ModifiedBy%TYPE;
    v_modified_date     STUDENT.ModifiedDate%TYPE;
BEGIN
    SELECT Salutation, FirstName, LastName, Address, Phone, Employer, 
           RegistrationDate, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate
    INTO   v_salutation, v_first_name, v_last_name, v_address, v_phone, v_employer, 
           v_registration_date, v_created_by, v_created_date, v_modified_by, v_modified_date
    FROM   STUDENT
    WHERE  StudentID = v_student_id;

 	DBMS_OUTPUT.PUT_LINE('Student Information:');
 	DBMS_OUTPUT.PUT_LINE('Salutation: ' || v_salutation);
 	DBMS_OUTPUT.PUT_LINE('First Name: ' || v_first_name);
 	DBMS_OUTPUT.PUT_LINE('Last Name: ' || v_last_name);
 	DBMS_OUTPUT.PUT_LINE('Address: ' || v_address);
 	DBMS_OUTPUT.PUT_LINE('Phone: ' || v_phone);
 	DBMS_OUTPUT.PUT_LINE('Employer: ' || v_employer);
 	DBMS_OUTPUT.PUT_LINE('Registration Date: ' || TO_CHAR(v_registration_date, 'DD-MON-YYYY'));
 	DBMS_OUTPUT.PUT_LINE('Created By: ' || v_created_by);
 	DBMS_OUTPUT.PUT_LINE('Created Date: ' || TO_CHAR(v_created_date, 'DD-MON-YYYY'));
 	DBMS_OUTPUT.PUT_LINE('Modified By: ' || v_modified_by);
 	DBMS_OUTPUT.PUT_LINE('Modified Date: ' || TO_CHAR(v_modified_date, 'DD-MON-YYYY'));

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Student ID not found. Proceeding to insert new record...');

        v_salutation    := '&p_salutation';
        v_first_name    := '&p_first_name';
        v_last_name     := '&p_last_name';
        v_address       := '&p_address';
        v_phone         := '&p_phone';
        v_employer      := '&p_employer';
        
        v_registration_date := SYSDATE;
        v_created_by        := USER;
        v_created_date      := SYSDATE;
        v_modified_by       := USER;
        v_modified_date     := SYSDATE;

        INSERT INTO STUDENT (StudentID, Salutation, FirstName, LastName, Address, Phone, Employer, 
                            RegistrationDate, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate)
        VALUES (v_student_id, v_salutation, v_first_name, v_last_name, v_address, v_phone, v_employer, 
                v_registration_date, v_created_by, v_created_date, v_modified_by, v_modified_date);
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('New student record inserted successfully.');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/

--3. Write a PL/SQL block that will accept Student Id and display message about student’s enrollment (how many courses).
SET SERVEROUTPUT ON;
SET VERIFY OFF;

PROMPT PL/SQL block to accept Student ID and display enrollment information
DECLARE
	v_student_id STUDENT.StudentID%TYPE := &p_student_id;
	v_course_count NUMBER;
BEGIN
	SELECT COUNT(*) INTO v_course_count
	FROM ENROLLMENT
	WHERE StudentID = v_student_id;

	DBMS_OUTPUT.PUT_LINE('Student ID: ' || v_student_id || ' is enrolled in ' || v_course_count || ' course(s).');
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/

--4.Write a PL/SQL block that  the user inputs the ID of a teacher, and the program determines how many classes the teacher is teaching. If the number of classes is greater than or equal to 10, it will display a message: "This teacher should take a rest!", otherwise, it will print the number of classes the teacher is teaching.
SET SERVEROUTPUT ON;
SET VERIFY OFF;

PROMPT PL/SQL block to accept Teacher ID and display teaching load information
DECLARE
	v_instructor_id INSTRUCTOR.InstructorID%TYPE := &p_instructor_id;
	v_class_count NUMBER;
	v_instructor_lastname INSTRUCTOR.LastName%TYPE;
	v_instructor_firstname INSTRUCTOR.FirstName%TYPE;

	v_instructor_name VARCHAR2(100);

BEGIN
	SELECT COUNT(*) INTO v_class_count
	FROM CLASS
	WHERE InstructorID = v_instructor_id;

	SELECT LastName, FirstName INTO v_instructor_lastname, v_instructor_firstname
	FROM INSTRUCTOR
	WHERE InstructorID = v_instructor_id;

	v_instructor_name := v_instructor_firstname || ' ' || v_instructor_lastname;

	IF v_class_count >= 10 THEN
		DBMS_OUTPUT.PUT_LINE('Instructor ' || v_instructor_name || ' teaches ' || v_class_count || ' sections. This teacher should take a rest!');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Instructor ' || v_instructor_name || ' teaches ' || v_class_count || ' sections.');
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/

--5. Write a PL/SQL block that will display list of classes (ClassID, ClassNo, StartDateTime, Location, InstructorID, Capacity) and the number of students who were enrolled.
SET SERVEROUTPUT ON;
SET VERIFY OFF;

PROMPT PL/SQL block to display list of classes and enrollment counts
DECLARE
	CURSOR class_cursor IS
		SELECT ClassID, ClassNo, StartDateTime, Location, InstructorID, Capacity
		FROM CLASS;

	v_class_id CLASS.ClassID%TYPE;
	v_class_no CLASS.ClassNo%TYPE;
	v_start_datetime CLASS.StartDateTime%TYPE;
	v_location CLASS.Location%TYPE;
	v_instructor_id CLASS.InstructorID%TYPE;
	v_capacity CLASS.Capacity%TYPE;
	v_enrollment_count NUMBER;
BEGIN
	FOR class_record IN class_cursor LOOP
		v_class_id := class_record.ClassID;
		v_class_no := class_record.ClassNo;
		v_start_datetime := class_record.StartDateTime;
		v_location := class_record.Location;
		v_instructor_id := class_record.InstructorID;
		v_capacity := class_record.Capacity;

		SELECT COUNT(*) INTO v_enrollment_count
		FROM ENROLLMENT
		WHERE ClassID = v_class_id;

		DBMS_OUTPUT.PUT_LINE('ClassID: ' || v_class_id || ', ClassNo: ' || v_class_no || 
		                     ', StartDateTime: ' || TO_CHAR(v_start_datetime, 'DD-MON-YYYY HH24:MI') || 
		                     ', Location: ' || v_location || 
		                     ', InstructorID: ' || v_instructor_id || 
		                     ', Capacity: ' || v_capacity || 
		                     ', Enrolled Students: ' || v_enrollment_count);
	END LOOP;
END;
/

--6. Write a PL/SQL block that will accept Student Id and ClassID. Print the character grade of student in this class as the following: A(90-100), B(80-90), C(70-80), D(50-70) F(0-50). Message errors when the user put in studentID or classID which are not avalaible.
SET SERVEROUTPUT ON;
SET VERIFY OFF;

PROMPT PL/SQL block to accept Student ID and ClassID and display grade
DECLARE
	v_student_id STUDENT.StudentID%TYPE := &p_student_id;
	v_class_id CLASS.ClassID%TYPE := &p_class_id;
	v_grade NUMBER;
	v_letter_grade VARCHAR2(2);
BEGIN
	SELECT Grade INTO v_grade
	FROM GRADE
	WHERE StudentID = v_student_id AND ClassID = v_class_id;

	IF v_grade >= 90 THEN
		v_letter_grade := 'A';
	ELSIF v_grade >= 80 THEN
		v_letter_grade := 'B';
	ELSIF v_grade >= 70 THEN
		v_letter_grade := 'C';
	ELSIF v_grade >= 50 THEN
		v_letter_grade := 'D';
	ELSE
		v_letter_grade := 'F';
	END IF;

	DBMS_OUTPUT.PUT_LINE('Student ID: ' || v_student_id || ', Class ID: ' || v_class_id || ', Grade: ' || v_letter_grade);
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('No grade found for Student ID: ' || v_student_id || ' in Class ID: ' || v_class_id || '. Please check the inputs.');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/

--7.Write a PL/SQL block that will display courses (CourseNo, Desciption) and classes involved these courses as following format: 

SET SERVEROUTPUT ON;
SET VERIFY OFF;

PROMPT PL/SQL block to display courses and classes with enrollment counts
DECLARE
	CURSOR course_cursor IS
		SELECT CourseNo, Description
		FROM COURSE;

	v_course_no COURSE.CourseNo%TYPE;
	v_description COURSE.Description%TYPE;
	v_class_count NUMBER;
	v_class_no CLASS.ClassNo%TYPE;
BEGIN
	FOR course_record IN course_cursor LOOP
		v_course_no := course_record.CourseNo;
		v_description := course_record.Description;

		DBMS_OUTPUT.PUT_LINE('CourseNo: ' || v_course_no || ' (Description: ' || v_description || ')');

		FOR class_record IN (SELECT ClassNo, ClassID FROM CLASS WHERE CourseNo = v_course_no) LOOP
			v_class_no := class_record.ClassNo;

			SELECT COUNT(*) INTO v_class_count
			FROM ENROLLMENT
			WHERE ClassID = class_record.ClassID;

			DBMS_OUTPUT.PUT_LINE('    Class''s number ' || v_class_no || ' has the number of students enrolled is: ' || v_class_count);
		END LOOP;
	END LOOP;
END;
/
