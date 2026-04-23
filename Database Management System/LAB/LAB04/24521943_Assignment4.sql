--1. Write a procedure find_sname with one input parameter (i_student_id) and two output parameters (o_first_name, o_last_name), which are the first and last names corresponding to the provided student ID.
PROMPT Creating Procedure 'FIND_SNAME'...
CREATE OR REPLACE PROCEDURE find_sname (
	i_student_id IN STUDENT.StudentID%TYPE,
	o_first_name OUT STUDENT.FirstName%TYPE,
	o_last_name  OUT STUDENT.LastName%TYPE
)
IS
BEGIN
	SELECT FirstName, LastName
	INTO o_first_name, o_last_name
	FROM STUDENT
	WHERE StudentID = i_student_id;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		o_first_name := NULL;
		o_last_name := NULL;
END find_sname;
/
--2. Write a procedure print_student_name that prints the name of the student whose ID is passed as an argument to the procedure.
PROMPT Creating Procedure 'PRINT_STUDENT_NAME'...
CREATE OR REPLACE PROCEDURE print_student_name (
	i_student_id IN STUDENT.StudentID%TYPE
)
IS
	v_first_name STUDENT.FirstName%TYPE;
	v_last_name  STUDENT.LastName%TYPE;
BEGIN
	find_sname(i_student_id, v_first_name, v_last_name);

	IF v_first_name IS NOT NULL AND v_last_name IS NOT NULL THEN
		DBMS_OUTPUT.PUT_LINE('Student ' || i_student_id || ': ' || v_first_name || ' ' || v_last_name);
	ELSE
		DBMS_OUTPUT.PUT_LINE('Student ' || i_student_id || ' was not found.');
	END IF;
END print_student_name;
/
--3. Write a procedure Discount that reduces the cost by 5% for all courses that have more than 15 students enrolled. For each discounted course, print its name.
PROMPT Creating Procedure 'DISCOUNT'...
CREATE OR REPLACE PROCEDURE discount
IS
BEGIN
	FOR r IN (
		SELECT c.CourseNo, c.Description
		FROM COURSE c
		JOIN CLASS cl ON cl.CourseNo = c.CourseNo
		JOIN ENROLLMENT e ON e.ClassID = cl.ClassID
		GROUP BY c.CourseNo, c.Description
		HAVING COUNT(e.StudentID) > 15
	)
	LOOP
		UPDATE COURSE
		SET Cost = Cost * 0.95
		WHERE CourseNo = r.CourseNo;

		DBMS_OUTPUT.PUT_LINE('Discounted course: ' || r.Description);
	END LOOP;
END discount;
/

--4. Write a function Total_cost_for_student that takes a student ID as input and returns the total cost that the student has to pay. Return NULL if the corresponding student does not exist.PROMPT Creating Function 'TOTAL_COST_FOR_STUDENT'...
CREATE OR REPLACE FUNCTION Total_cost_for_student (
	i_student_id IN STUDENT.StudentID%TYPE
)
RETURN NUMBER
IS
	v_exists NUMBER;
	v_total  NUMBER;
BEGIN
	SELECT COUNT(*)
	INTO v_exists
	FROM STUDENT
	WHERE StudentID = i_student_id;

	IF v_exists = 0 THEN
		RETURN NULL;
	END IF;

	SELECT NVL(SUM(c.Cost), 0)
	INTO v_total
	FROM ENROLLMENT e
	JOIN CLASS cl ON cl.ClassID = e.ClassID
	JOIN COURSE c ON c.CourseNo = cl.CourseNo
	WHERE e.StudentID = i_student_id;

	RETURN v_total;
END Total_cost_for_student;
/


--5. Write a trigger for insert and update operations on all tables in the relational schema with the fields created_by, created_date, modified_by, and modified_date, which are automatically set by the trigger based on the current user and system date.
PROMPT Creating Audit Triggers For All Eligible Tables...
BEGIN
	FOR r IN (
		SELECT
			utc.table_name,
			MAX(CASE WHEN utc.column_name IN ('CREATED_BY', 'CREATEDBY') THEN utc.column_name END) AS created_by_col,
			MAX(CASE WHEN utc.column_name IN ('CREATED_DATE', 'CREATEDDATE') THEN utc.column_name END) AS created_date_col,
			MAX(CASE WHEN utc.column_name IN ('MODIFIED_BY', 'MODIFIEDBY') THEN utc.column_name END) AS modified_by_col,
			MAX(CASE WHEN utc.column_name IN ('MODIFIED_DATE', 'MODIFIEDDATE') THEN utc.column_name END) AS modified_date_col
		FROM USER_TAB_COLUMNS utc
		WHERE utc.table_name IN ('INSTRUCTOR', 'GRADE', 'CLASS', 'COURSE', 'ENROLLMENT', 'STUDENT')
		GROUP BY utc.table_name
		HAVING MAX(CASE WHEN utc.column_name IN ('CREATED_BY', 'CREATEDBY') THEN 1 END) = 1
		   AND MAX(CASE WHEN utc.column_name IN ('CREATED_DATE', 'CREATEDDATE') THEN 1 END) = 1
		   AND MAX(CASE WHEN utc.column_name IN ('MODIFIED_BY', 'MODIFIEDBY') THEN 1 END) = 1
		   AND MAX(CASE WHEN utc.column_name IN ('MODIFIED_DATE', 'MODIFIEDDATE') THEN 1 END) = 1
	)
	LOOP
		EXECUTE IMMEDIATE
			'CREATE OR REPLACE TRIGGER TRG_' || r.table_name || '_AUDIT ' ||
			'BEFORE INSERT OR UPDATE ON ' || r.table_name || ' ' ||
			'FOR EACH ROW ' ||
			'BEGIN ' ||
			'  IF INSERTING THEN ' ||
			'    :NEW.' || r.created_by_col || ' := USER; ' ||
			'    :NEW.' || r.created_date_col || ' := SYSDATE; ' ||
			'  END IF; ' ||
			'  :NEW.' || r.modified_by_col || ' := USER; ' ||
			'  :NEW.' || r.modified_date_col || ' := SYSDATE; ' ||
			'END;';
	END LOOP;
END;
/



--6. Write a trigger that enforces the following requirement: each student must not register for more than 4 courses.
PROMPT Creating Trigger 'TRG_ENROLLMENT_MAX_4_COURSES'...
CREATE OR REPLACE TRIGGER TRG_ENROLLMENT_MAX_4_COURSES
FOR INSERT OR UPDATE OF StudentID, ClassID ON ENROLLMENT
COMPOUND TRIGGER
	TYPE t_seen_map IS TABLE OF NUMBER INDEX BY VARCHAR2(30);
	g_seen_students t_seen_map;

	PROCEDURE mark_student(p_student_id IN ENROLLMENT.StudentID%TYPE) IS
		v_key VARCHAR2(30);
	BEGIN
		IF p_student_id IS NOT NULL THEN
			v_key := TO_CHAR(p_student_id);
			g_seen_students(v_key) := 1;
		END IF;
	END;

	AFTER EACH ROW IS
	BEGIN
		mark_student(:NEW.StudentID);
		IF UPDATING THEN
			mark_student(:OLD.StudentID);
		END IF;
	END AFTER EACH ROW;

	AFTER STATEMENT IS
		v_key VARCHAR2(30);
		v_count NUMBER;
	BEGIN
		v_key := g_seen_students.FIRST;
		WHILE v_key IS NOT NULL LOOP
			SELECT COUNT(DISTINCT ClassID)
			INTO v_count
			FROM ENROLLMENT
			WHERE StudentID = TO_NUMBER(v_key);

			IF v_count > 4 THEN
				RAISE_APPLICATION_ERROR(-20001, 'A student cannot register for more than 4 courses. StudentID=' || v_key);
			END IF;

			v_key := g_seen_students.NEXT(v_key);
		END LOOP;
	END AFTER STATEMENT;
END TRG_ENROLLMENT_MAX_4_COURSES;
/