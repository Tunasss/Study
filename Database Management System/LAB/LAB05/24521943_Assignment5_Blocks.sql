-- Assignment 5: PL/SQL Blocks
-- Database Management System LAB05

-- ============================================================================
-- TASK 2: Award Employee with Bonus (15% of commission)
-- ============================================================================
-- Accept employee ID as input
-- If employee has commission, award 15% bonus and display it
-- Otherwise display message that employee does not earn any commission

DECLARE
    v_emp_id         s_emp.id%TYPE := &emp_id;
    v_commission     s_emp.commission_pct%TYPE;
    v_bonus          NUMBER(10, 2);
    v_emp_name       s_emp.name%TYPE;
BEGIN
    -- Fetch employee commission
    SELECT commission_pct, name 
    INTO v_commission, v_emp_name
    FROM s_emp
    WHERE id = v_emp_id;
    
    -- Check if commission exists and is not null
    IF v_commission IS NULL OR v_commission = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_emp_name || ' does not earn any commission');
    ELSE
        v_bonus := v_commission * 0.15;
        DBMS_OUTPUT.PUT_LINE('Employee: ' || v_emp_name);
        DBMS_OUTPUT.PUT_LINE('Commission: ' || v_commission || '%');
        DBMS_OUTPUT.PUT_LINE('Bonus (15% of commission): ' || v_bonus);
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee ID ' || v_emp_id || ' not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- ============================================================================
-- TASK 3: Display Department Details for Departments 10 to 40
-- ============================================================================
-- For each department (10 to 40):
-- Display: Department name, total no of employees, avg salary
-- If no employees in department, display appropriate message

DECLARE
    v_dept_id        s_dept.id%TYPE;
    v_dept_name      s_dept.name%TYPE;
    v_emp_count      NUMBER := 0;
    v_avg_salary     NUMBER(10, 2) := 0;
BEGIN
    -- Process departments from 10 to 40
    FOR v_dept_id IN 10..40 LOOP
        BEGIN
            -- Get department name and employee count
            SELECT name INTO v_dept_name
            FROM s_dept
            WHERE id = v_dept_id;
            
            -- Count employees in department
            SELECT COUNT(*), NVL(AVG(salary), 0)
            INTO v_emp_count, v_avg_salary
            FROM s_emp
            WHERE dept_id = v_dept_id;
            
            -- Display results
            IF v_emp_count = 0 THEN
                DBMS_OUTPUT.PUT_LINE('Department ' || v_dept_id || ' (' || v_dept_name || '): No employees are working in that department');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Department ' || v_dept_id || ' (' || v_dept_name || ')');
                DBMS_OUTPUT.PUT_LINE('  Total Employees: ' || v_emp_count);
                DBMS_OUTPUT.PUT_LINE('  Average Salary: ' || TO_CHAR(v_avg_salary, '99,999.99'));
                DBMS_OUTPUT.PUT_LINE('');
            END IF;
            
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                NULL;  -- Department doesn't exist, skip
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error processing department ' || v_dept_id || ': ' || SQLERRM);
        END;
    END LOOP;
    
END;
/

-- ============================================================================
-- TASK 4: Compare Employee Salary with Department Average
-- ============================================================================
-- Accept employee ID
-- Find average salary of department where employee works
-- Compare employee's salary with department average

DECLARE
    v_emp_id         s_emp.id%TYPE := &emp_id;
    v_emp_name       s_emp.name%TYPE;
    v_emp_salary     s_emp.salary%TYPE;
    v_dept_id        s_emp.dept_id%TYPE;
    v_dept_name      s_dept.name%TYPE;
    v_avg_salary     NUMBER(10, 2);
BEGIN
    -- Get employee details
    SELECT e.id, e.name, e.salary, e.dept_id
    INTO v_emp_id, v_emp_name, v_emp_salary, v_dept_id
    FROM s_emp e
    WHERE e.id = v_emp_id;
    
    -- Get department name
    SELECT name INTO v_dept_name
    FROM s_dept
    WHERE id = v_dept_id;
    
    -- Calculate average salary of the department
    SELECT AVG(salary) INTO v_avg_salary
    FROM s_emp
    WHERE dept_id = v_dept_id;
    
    -- Display results
    DBMS_OUTPUT.PUT_LINE('Employee: ' || v_emp_name);
    DBMS_OUTPUT.PUT_LINE('Department: ' || v_dept_name);
    DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || TO_CHAR(v_emp_salary, '99,999.99'));
    DBMS_OUTPUT.PUT_LINE('Department Average Salary: ' || TO_CHAR(v_avg_salary, '99,999.99'));
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Compare and display message
    IF v_emp_salary > v_avg_salary THEN
        DBMS_OUTPUT.PUT_LINE('Result: Employee''s salary is more than average salary');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Result: Employee''s salary is less than average salary');
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee ID ' || v_emp_id || ' not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- ============================================================================
-- TASK 5: Give 15% Pay Increase to All Employees in Department 10
-- ============================================================================
-- Update all employees in department 10 with 15% raise
-- Display count of employees updated

DECLARE
    v_emp_count      NUMBER := 0;
BEGIN
    -- Update salaries for all employees in department 10
    UPDATE s_emp
    SET salary = salary * 1.15
    WHERE dept_id = 10;
    
    -- Get number of rows affected
    v_emp_count := SQL%ROWCOUNT;
    
    -- Display result
    IF v_emp_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE(v_emp_count || ' Employee(s) in Department 10 were awarded a 15% pay increase');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No employees found in Department 10');
    END IF;
    
    -- Commit the changes
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

-- ============================================================================
-- TASK 6: Copy All Departments to old_dept Table
-- ============================================================================
-- Create old_dept table if it doesn't exist
-- Copy all departments from s_dept to old_dept
-- Display number of rows copied

-- First, create the old_dept table structure
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE old_dept';
EXCEPTION
    WHEN OTHERS THEN
        NULL;  -- Table might not exist
END;
/

CREATE TABLE old_dept AS
SELECT * FROM s_dept WHERE 1=0;

DECLARE
    v_rows_copied    NUMBER := 0;
BEGIN
    -- Insert all departments into old_dept
    INSERT INTO old_dept
    SELECT * FROM s_dept;
    
    -- Get number of rows inserted
    v_rows_copied := SQL%ROWCOUNT;
    
    -- Commit the changes
    COMMIT;
    
    -- Display result
    DBMS_OUTPUT.PUT_LINE(v_rows_copied || ' row(s) were copied to old_dept table');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Old_dept table contents:');
    
    -- Display the copied data
    FOR rec IN (SELECT id, name, region_id FROM old_dept ORDER BY id) LOOP
        DBMS_OUTPUT.PUT_LINE('  Department ID: ' || rec.id || 
                           ', Name: ' || rec.name || 
                           ', Region ID: ' || rec.region_id);
    END LOOP;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

-- ============================================================================
-- Enable output display
-- ============================================================================
SET PAGESIZE 100
SET LINESIZE 120
SET ECHO ON
SET FEEDBACK ON
