--A) PL/SQL Block
--1. Write a PL/SQL block which accepts employee id and should display Employee name, PF and net salary.

DECLARE
    v_emp_id NUMBER(7);
    v_first_name VARCHAR2(25);
    v_last_name VARCHAR2(25);
    v_basic_salary NUMBER(11, 2);
    v_hra NUMBER(11, 2);
    v_da NUMBER(11, 2);
    v_pf NUMBER(11, 2);
    v_net_salary NUMBER(11, 2);
BEGIN
    v_emp_id := &employee_id; -- Accept employee id as input
    -- Fetch employee details
    SELECT first_name, last_name, salary INTO v_first_name, v_last_name, v_basic_salary
    FROM s_emp
    WHERE id = v_emp_id;
    -- Calculate HRA and DA
    v_hra := 0.31 * v_basic_salary;
    v_da := 0.15 * v_basic_salary;
    -- Calculate PF based on basic salary
    IF v_basic_salary < 1000 THEN
        v_pf := 0.05 * v_basic_salary;
    ELSIF v_basic_salary BETWEEN 1000 AND 1500 THEN
        v_pf := 0.07 * v_basic_salary;
    ELSE
        v_pf := 0.08 * v_basic_salary;
    END IF;
    -- Calculate net salary
    v_net_salary := v_basic_salary + v_hra + v_da - v_pf;
    -- Display results
    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || v_first_name || ' ' || v_last_name);
    DBMS_OUTPUT.PUT_LINE('PF: ' || v_pf);
    DBMS_OUTPUT.PUT_LINE('Net Salary: ' || v_net_salary);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee found with ID: ' || v_emp_id);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;

--2. Write a PL/SQL block to award an employee with the bonus.
--Bonus is 15% of commission drawn by the employee. If the employee does not earn any commission, then display a message that ‘employee does not earn any commission’. Otherwise, print bonus of the employee. The block should accept an input for the employee id.

DECLARE
    v_emp_id s_emp.id%TYPE := &emp_id;
    v_commission s_emp.commission_pct%TYPE;
    v_bonus NUMBER(10, 2);
    v_emp_name s_emp.name%TYPE;
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


--3. Write a PL/SQL block which displays the department name, total no of employees in the department, avg salary of the employees in the department for all the departments from department 10 to department 40 in the Dept table. If no employees are working in the department, then display a message that no employees are working in that department.

DECLARE
    v_dept_id s_dept.id%TYPE;
    v_dept_name s_dept.name%TYPE;
    v_emp_count NUMBER := 0;
    v_avg_salary NUMBER(10, 2) := 0;
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


--4. Write a PL/SQL block which accepts employee id and finds the average salary of the employees working in the department where that employee works. If his salary is more than the average salary of his department, then display message that ‘employee’s salary is more than average salary’ else display ‘employee’s salary is less than average salary’

DECLARE
    v_emp_id s_emp.id%TYPE := &emp_id;
    v_emp_name s_emp.name%TYPE;
    v_emp_salary s_emp.salary%TYPE;
    v_dept_id s_emp.dept_id%TYPE;
    v_dept_name s_dept.name%TYPE;
    v_avg_salary NUMBER(10, 2);
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


--5. Write a program that gives all employees in department 10 a 15% pay increase. Display a message displaying how many Employees were awarded the increase.
DECLARE
    v_emp_count NUMBER := 0;
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

--6. Write a PL/SQL block that copies all departments to a table called old_dept. Display how many rows were copied.

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

--B) Procedures and functions
--1. Create a procedure that prints rows from the s_emp table. It should accept 1 parameter (title), print the employee’s information with that title. Display how many employees were printed. Write a PL/SQL block to invoke the procedure.
CREATE OR REPLACE PROCEDURE print_employees_by_title(p_title IN VARCHAR2) IS
    v_emp_count NUMBER := 0;
BEGIN
    -- Print employee information for the given title
    FOR rec IN (SELECT id, name, salary FROM s_emp WHERE title = p_title
                ORDER BY id) LOOP
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || rec.id || 
                           ', Name: ' || rec.name || 
                           ', Salary: ' || TO_CHAR(rec.salary, '99,999.99'));
        v_emp_count := v_emp_count + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Total employees with title "' || p_title || '": ' || v_emp_count);
END;
/

--2. Change the above procedure so that it returns the number of employees printed via an OUT parameter. Write a PL/SQL block to invoke the procedure and display how many employees were printed.
CREATE OR REPLACE PROCEDURE print_employees_by_title(p_title IN VARCHAR2, p_emp_count OUT NUMBER) IS
BEGIN
    p_emp_count := 0; -- Initialize employee count
    -- Print employee information for the given title
    FOR rec IN (SELECT id, name, salary FROM s_emp WHERE title = p_title
                ORDER BY id) LOOP
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || rec.id ||
                            ', Name: ' || rec.name || 
                            ', Salary: ' || TO_CHAR(rec.salary, '99,999.99'));
        p_emp_count := p_emp_count + 1;
    END LOOP;
END;
/

--3. Instead of using an OUT parameter for the number of employees printed, use the function to return the number of employees with that title. Write a PL/SQL block to invoke the function and display how many employees with that title.
CREATE OR REPLACE FUNCTION get_employee_count_by_title(p_title IN VARCHAR2) RETURN NUMBER IS
    v_emp_count NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO v_emp_count
    FROM s_emp
    WHERE title = p_title;

    RETURN v_emp_count;
END;
/

--4. Create a table having the following structure
--Accounts (Account_id, Account_name, amount_balance)  
--Write a PL/SQL procedure to perform a withdrawal operation that only permits a withdrawal if there are sufficient funds in the account. The procedure should take Account_id and withdrawal amount as input.
--Write a procedure to deposit money into someone's account. The procedure should accept the account_id and the deposit amount.
--Write a procedure to transfer money from one person's account to another. The procedure should table two account_id’s one for the giver and one for the receiver and the amount to be transferred. 

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Accounts';
EXCEPTION
    WHEN OTHERS THEN
        NULL;  -- Table might not exist
END;
/
CREATE TABLE Accounts (
    Account_id NUMBER(7) PRIMARY KEY,
    Account_name VARCHAR2(50) NOT NULL,
    amount_balance NUMBER(11, 2) NOT NULL
);

CREATE OR REPLACE PROCEDURE withdraw(p_account_id IN NUMBER, p_withdrawal_amount IN NUMBER) IS
    v_balance NUMBER(11, 2);
BEGIN
    -- Check current balance
    SELECT amount_balance INTO v_balance
    FROM Accounts
    WHERE Account_id = p_account_id;
    -- Check if sufficient funds are available
    IF v_balance >= p_withdrawal_amount THEN
        UPDATE Accounts
        SET amount_balance = amount_balance - p_withdrawal_amount
        WHERE Account_id = p_account_id;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Withdrawal of ' || TO_CHAR(p_withdrawal_amount, '99,999.99') || ' successful. New balance: ' || TO_CHAR(v_balance - p_withdrawal_amount, '99,999.99'));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient funds for withdrawal. Current balance: ' || TO_CHAR(v_balance, '99,999.99'));
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Account ID ' || p_account_id || ' not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE deposit(p_account_id IN NUMBER, p_deposit_amount IN NUMBER) IS
BEGIN
    UPDATE Accounts
    SET amount_balance = amount_balance + p_deposit_amount
    WHERE Account_id = p_account_id;
    IF SQL%ROWCOUNT > 0 THEN
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Deposit of ' || TO_CHAR(p_deposit_amount, '99,999.99') || ' successful. New balance updated.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account ID ' || p_account_id || ' not found');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE transfer(p_from_account_id IN NUMBER, p_to_account_id IN NUMBER, p_transfer_amount IN NUMBER) IS
BEGIN
    -- Withdraw from the giver's account
    withdraw(p_from_account_id, p_transfer_amount);
    -- Deposit into the receiver's account
    deposit(p_to_account_id, p_transfer_amount);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error during transfer: ' || SQLERRM);
END;
/

--C) Trigger
--1. Updating an employee's salary to a lower amount is not allowed.
CREATE OR REPLACE TRIGGER trg_salary_check
BEFORE UPDATE OF salary ON s_emp
FOR EACH ROW
BEGIN
    IF :NEW.salary < :OLD.salary THEN
        RAISE_APPLICATION_ERROR(-20001, 'Updating salary to a lower amount is not allowed.');
    END IF;
END;
/

--2. Each department cannot have more than 20 employees.
CREATE OR REPLACE TRIGGER trg_dept_employee_limit
BEFORE INSERT OR UPDATE OF department_id ON s_emp
FOR EACH ROW
DECLARE
    v_emp_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_emp_count
    FROM s_emp
    WHERE department_id = :NEW.department_id;

    IF v_emp_count >= 20 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Department cannot have more than 20 employees.');
    END IF;
END;
/

--D) Exception Handling
--1. Write a PL/SQL block to select the name of the employee with a given salary value. 
--If the salary entered returns more than one row, handle the exception with an appropriate message: “more than one employee with a salary of <salary>”
--If the salary entered does not return any rows, handle the exception with an appropriate message: “no employee with a salary of <salary>”
--If the salary entered returns only one row, display the employee’s name and the salary amount.
--Handle any other exception with a message “some other error occurred”. 
--Test the block for a variety of test cases.

DECLARE
    v_salary s_emp.salary%TYPE := &salary;
    v_emp_name s_emp.name%TYPE;
BEGIN
    SELECT name INTO v_emp_name
    FROM s_emp
    WHERE salary = v_salary;
    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || v_emp_name || ', Salary: ' || TO_CHAR(v_salary, '99,999.99'));
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More than one employee with a salary of ' || TO_CHAR(v_salary, '99,999.99'));
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee with a salary of ' || TO_CHAR(v_salary, '99,999.99'));
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Some other error occurred: ' || SQLERRM);
END;


--2. Write a PL/SQL block to remove a specified department from the department table. If there are employees in that department, print a message to the user that the department cannot be removed. (Use pragma Exception_init)

DECLARE
    v_dept_id s_dept.id%TYPE := &dept_id;
    v_emp_count NUMBER;
BEGIN
    -- Check if there are employees in the department
    SELECT COUNT(*) INTO v_emp_count
    FROM s_emp
    WHERE dept_id = v_dept_id;
    IF v_emp_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Department ID ' || v_dept_id || ' cannot be removed because there are employees in that department.');
    ELSE
        DELETE FROM s_dept
        WHERE id = v_dept_id;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Department ID ' || v_dept_id || ' has been removed successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;