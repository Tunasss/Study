-- Assignment 5: Part B, C, D - Procedures, Functions, Triggers, and Exception Handling
-- Database Management System LAB05

SET PAGESIZE 100
SET LINESIZE 120
SET ECHO ON
SET FEEDBACK ON

-- ============================================================================
-- PART B: PROCEDURES AND FUNCTIONS
-- ============================================================================

-- ============================================================================
-- TASK B1: Procedure to Print Employees by Title (IN Parameter Only)
-- ============================================================================

CREATE OR REPLACE PROCEDURE print_employees_by_title(p_title IN VARCHAR2)
IS
    v_emp_count    NUMBER := 0;
    v_emp_id       s_emp.id%TYPE;
    v_emp_name     s_emp.name%TYPE;
    v_emp_salary   s_emp.salary%TYPE;
    v_dept_id      s_emp.dept_id%TYPE;
    
    CURSOR emp_cur IS
        SELECT id, name, salary, dept_id
        FROM s_emp
        WHERE title = p_title
        ORDER BY id;
BEGIN
    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('Employees with Title: ' || p_title);
    DBMS_OUTPUT.PUT_LINE('==============================================');
    
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO v_emp_id, v_emp_name, v_emp_salary, v_dept_id;
        EXIT WHEN emp_cur%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_emp_id || 
                           ', Name: ' || v_emp_name || 
                           ', Salary: ' || TO_CHAR(v_emp_salary, '99,999.99') ||
                           ', Dept: ' || v_dept_id);
        v_emp_count := v_emp_count + 1;
    END LOOP;
    CLOSE emp_cur;
    
    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('Total Employees Printed: ' || v_emp_count);
    DBMS_OUTPUT.PUT_LINE('==============================================');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END print_employees_by_title;
/

-- PL/SQL Block to invoke Procedure B1
DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- TASK B1: Invoking Procedure to Print Employees ---');
    DBMS_OUTPUT.PUT_LINE('');
    
    print_employees_by_title('Sales Representative');
    
    DBMS_OUTPUT.PUT_LINE('');
END;
/

-- ============================================================================
-- TASK B2: Modified Procedure with OUT Parameter for Employee Count
-- ============================================================================

CREATE OR REPLACE PROCEDURE print_employees_by_title_v2(
    p_title IN VARCHAR2,
    p_emp_count OUT NUMBER
)
IS
    v_emp_id       s_emp.id%TYPE;
    v_emp_name     s_emp.name%TYPE;
    v_emp_salary   s_emp.salary%TYPE;
    v_dept_id      s_emp.dept_id%TYPE;
    
    CURSOR emp_cur IS
        SELECT id, name, salary, dept_id
        FROM s_emp
        WHERE title = p_title
        ORDER BY id;
BEGIN
    p_emp_count := 0;
    
    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('Employees with Title: ' || p_title);
    DBMS_OUTPUT.PUT_LINE('==============================================');
    
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO v_emp_id, v_emp_name, v_emp_salary, v_dept_id;
        EXIT WHEN emp_cur%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_emp_id || 
                           ', Name: ' || v_emp_name || 
                           ', Salary: ' || TO_CHAR(v_emp_salary, '99,999.99') ||
                           ', Dept: ' || v_dept_id);
        p_emp_count := p_emp_count + 1;
    END LOOP;
    CLOSE emp_cur;
    
    DBMS_OUTPUT.PUT_LINE('==============================================');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        p_emp_count := -1;
END print_employees_by_title_v2;
/

-- PL/SQL Block to invoke Procedure B2
DECLARE
    v_emp_count    NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- TASK B2: Procedure with OUT Parameter ---');
    DBMS_OUTPUT.PUT_LINE('');
    
    print_employees_by_title_v2('Vice President', v_emp_count);
    DBMS_OUTPUT.PUT_LINE('OUT Parameter - Total Employees Printed: ' || v_emp_count);
    
    DBMS_OUTPUT.PUT_LINE('');
END;
/

-- ============================================================================
-- TASK B3: Function to Return Number of Employees with Given Title
-- ============================================================================

CREATE OR REPLACE FUNCTION count_employees_by_title(p_title IN VARCHAR2) 
RETURN NUMBER
IS
    v_emp_count    NUMBER := 0;
    v_emp_id       s_emp.id%TYPE;
    v_emp_name     s_emp.name%TYPE;
    v_emp_salary   s_emp.salary%TYPE;
    v_dept_id      s_emp.dept_id%TYPE;
    
    CURSOR emp_cur IS
        SELECT id, name, salary, dept_id
        FROM s_emp
        WHERE title = p_title
        ORDER BY id;
BEGIN
    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('Employees with Title: ' || p_title);
    DBMS_OUTPUT.PUT_LINE('==============================================');
    
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO v_emp_id, v_emp_name, v_emp_salary, v_dept_id;
        EXIT WHEN emp_cur%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_emp_id || 
                           ', Name: ' || v_emp_name || 
                           ', Salary: ' || TO_CHAR(v_emp_salary, '99,999.99') ||
                           ', Dept: ' || v_dept_id);
        v_emp_count := v_emp_count + 1;
    END LOOP;
    CLOSE emp_cur;
    
    DBMS_OUTPUT.PUT_LINE('==============================================');
    
    RETURN v_emp_count;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RETURN -1;
END count_employees_by_title;
/

-- PL/SQL Block to invoke Function B3
DECLARE
    v_emp_count    NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- TASK B3: Function to Count Employees by Title ---');
    DBMS_OUTPUT.PUT_LINE('');
    
    v_emp_count := count_employees_by_title('Manager');
    DBMS_OUTPUT.PUT_LINE('Function Return - Total Employees with Title: ' || v_emp_count);
    
    DBMS_OUTPUT.PUT_LINE('');
END;
/

-- ============================================================================
-- TASK B4: Accounts Table and Banking Procedures
-- ============================================================================

-- Drop table if exists
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Accounts';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

-- Create Accounts table
CREATE TABLE Accounts (
    Account_id      NUMBER(8) PRIMARY KEY,
    Account_name    VARCHAR2(50) NOT NULL,
    Amount_balance  NUMBER(12, 2) NOT NULL CHECK (Amount_balance >= 0)
);

-- Insert sample data
INSERT INTO Accounts VALUES (1001, 'John Doe', 5000.00);
INSERT INTO Accounts VALUES (1002, 'Jane Smith', 3500.00);
INSERT INTO Accounts VALUES (1003, 'Bob Wilson', 7200.00);
COMMIT;

-- ============================================================================
-- B4a: Withdrawal Procedure
-- ============================================================================

CREATE OR REPLACE PROCEDURE withdraw_money(
    p_account_id IN NUMBER,
    p_amount IN NUMBER
)
IS
    v_current_balance    NUMBER;
BEGIN
    -- Get current balance
    SELECT Amount_balance INTO v_current_balance
    FROM Accounts
    WHERE Account_id = p_account_id;
    
    -- Check if sufficient funds
    IF v_current_balance < p_amount THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Insufficient funds!');
        DBMS_OUTPUT.PUT_LINE('Available Balance: ' || TO_CHAR(v_current_balance, '99,999.99'));
        DBMS_OUTPUT.PUT_LINE('Withdrawal Amount: ' || TO_CHAR(p_amount, '99,999.99'));
    ELSE
        -- Update balance
        UPDATE Accounts
        SET Amount_balance = Amount_balance - p_amount
        WHERE Account_id = p_account_id;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Withdrawal Successful!');
        DBMS_OUTPUT.PUT_LINE('Account ID: ' || p_account_id);
        DBMS_OUTPUT.PUT_LINE('Amount Withdrawn: ' || TO_CHAR(p_amount, '99,999.99'));
        DBMS_OUTPUT.PUT_LINE('New Balance: ' || TO_CHAR(v_current_balance - p_amount, '99,999.99'));
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Account not found!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END withdraw_money;
/

-- ============================================================================
-- B4b: Deposit Procedure
-- ============================================================================

CREATE OR REPLACE PROCEDURE deposit_money(
    p_account_id IN NUMBER,
    p_amount IN NUMBER
)
IS
    v_current_balance    NUMBER;
BEGIN
    -- Check if amount is valid
    IF p_amount <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Deposit amount must be positive!');
        RETURN;
    END IF;
    
    -- Get current balance
    SELECT Amount_balance INTO v_current_balance
    FROM Accounts
    WHERE Account_id = p_account_id;
    
    -- Update balance
    UPDATE Accounts
    SET Amount_balance = Amount_balance + p_amount
    WHERE Account_id = p_account_id;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Deposit Successful!');
    DBMS_OUTPUT.PUT_LINE('Account ID: ' || p_account_id);
    DBMS_OUTPUT.PUT_LINE('Amount Deposited: ' || TO_CHAR(p_amount, '99,999.99'));
    DBMS_OUTPUT.PUT_LINE('New Balance: ' || TO_CHAR(v_current_balance + p_amount, '99,999.99'));
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Account not found!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END deposit_money;
/

-- ============================================================================
-- B4c: Transfer Procedure
-- ============================================================================

CREATE OR REPLACE PROCEDURE transfer_money(
    p_from_account_id IN NUMBER,
    p_to_account_id IN NUMBER,
    p_amount IN NUMBER
)
IS
    v_from_balance    NUMBER;
    v_to_balance      NUMBER;
    v_from_name       VARCHAR2(50);
    v_to_name         VARCHAR2(50);
BEGIN
    -- Validate amount
    IF p_amount <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Transfer amount must be positive!');
        RETURN;
    END IF;
    
    -- Get source account details
    SELECT Amount_balance, Account_name INTO v_from_balance, v_from_name
    FROM Accounts
    WHERE Account_id = p_from_account_id;
    
    -- Get destination account details
    SELECT Amount_balance, Account_name INTO v_to_balance, v_to_name
    FROM Accounts
    WHERE Account_id = p_to_account_id;
    
    -- Check if sufficient funds in source account
    IF v_from_balance < p_amount THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Insufficient funds in source account!');
        DBMS_OUTPUT.PUT_LINE('Available Balance: ' || TO_CHAR(v_from_balance, '99,999.99'));
        DBMS_OUTPUT.PUT_LINE('Transfer Amount: ' || TO_CHAR(p_amount, '99,999.99'));
        RETURN;
    END IF;
    
    -- Perform transfer
    UPDATE Accounts
    SET Amount_balance = Amount_balance - p_amount
    WHERE Account_id = p_from_account_id;
    
    UPDATE Accounts
    SET Amount_balance = Amount_balance + p_amount
    WHERE Account_id = p_to_account_id;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Transfer Successful!');
    DBMS_OUTPUT.PUT_LINE('From Account: ' || p_from_account_id || ' (' || v_from_name || ')');
    DBMS_OUTPUT.PUT_LINE('To Account: ' || p_to_account_id || ' (' || v_to_name || ')');
    DBMS_OUTPUT.PUT_LINE('Amount Transferred: ' || TO_CHAR(p_amount, '99,999.99'));
    DBMS_OUTPUT.PUT_LINE('From New Balance: ' || TO_CHAR(v_from_balance - p_amount, '99,999.99'));
    DBMS_OUTPUT.PUT_LINE('To New Balance: ' || TO_CHAR(v_to_balance + p_amount, '99,999.99'));
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: One or both accounts not found!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END transfer_money;
/

-- PL/SQL Block to test B4 Banking Procedures
DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- TASK B4: Banking Procedures ---');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Test Withdrawal
    DBMS_OUTPUT.PUT_LINE('Test 1: Valid Withdrawal');
    withdraw_money(1001, 500.00);
    DBMS_OUTPUT.PUT_LINE('');
    
    DBMS_OUTPUT.PUT_LINE('Test 2: Insufficient Funds Withdrawal');
    withdraw_money(1002, 5000.00);
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Test Deposit
    DBMS_OUTPUT.PUT_LINE('Test 3: Valid Deposit');
    deposit_money(1002, 2000.00);
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Test Transfer
    DBMS_OUTPUT.PUT_LINE('Test 4: Valid Transfer');
    transfer_money(1001, 1003, 1000.00);
    DBMS_OUTPUT.PUT_LINE('');
    
    DBMS_OUTPUT.PUT_LINE('Test 5: Transfer with Insufficient Funds');
    transfer_money(1002, 1001, 10000.00);
    DBMS_OUTPUT.PUT_LINE('');
    
END;
/

-- ============================================================================
-- PART C: TRIGGERS
-- ============================================================================

-- ============================================================================
-- TASK C1: Trigger to Prevent Salary Decrease
-- ============================================================================

CREATE OR REPLACE TRIGGER prevent_salary_decrease
BEFORE UPDATE OF salary ON s_emp
FOR EACH ROW
BEGIN
    IF :NEW.salary < :OLD.salary THEN
        RAISE_APPLICATION_ERROR(-20001, 
            'Error: Cannot decrease employee salary. Old: ' || :OLD.salary || 
            ', New: ' || :NEW.salary);
    END IF;
END prevent_salary_decrease;
/

-- ============================================================================
-- TASK C2: Trigger to Limit Maximum 20 Employees per Department
-- ============================================================================

CREATE OR REPLACE TRIGGER max_employees_per_dept
BEFORE INSERT ON s_emp
FOR EACH ROW
DECLARE
    v_emp_count    NUMBER;
BEGIN
    -- Count current employees in the department
    SELECT COUNT(*) INTO v_emp_count
    FROM s_emp
    WHERE dept_id = :NEW.dept_id;
    
    -- Check if department would exceed 20 employees
    IF v_emp_count >= 20 THEN
        RAISE_APPLICATION_ERROR(-20002, 
            'Error: Department ' || :NEW.dept_id || 
            ' already has 20 employees. Cannot add more employees.');
    END IF;
END max_employees_per_dept;
/

-- ============================================================================
-- Test Triggers
-- ============================================================================

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- TESTING TRIGGERS ---');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Test Trigger C1 - Try to decrease salary (will fail)
    DBMS_OUTPUT.PUT_LINE('Test C1: Attempting to decrease employee salary');
    BEGIN
        UPDATE s_emp SET salary = salary - 100 WHERE id = 100;
        DBMS_OUTPUT.PUT_LINE('ERROR: Should have been prevented!');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Trigger Working - ' || SQLERRM);
    END;
    
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Test Trigger C2 - Try to insert many employees in one department (will fail if over 20)
    DBMS_OUTPUT.PUT_LINE('Test C2: Checking department employee limit');
    BEGIN
        SELECT COUNT(*) INTO v_emp_count FROM s_emp WHERE dept_id = 10;
        DBMS_OUTPUT.PUT_LINE('Department 10 currently has ' || v_emp_count || ' employees');
        IF v_emp_count < 20 THEN
            DBMS_OUTPUT.PUT_LINE('Can still add employees to this department');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
    
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Test salary increase (should succeed)
    DBMS_OUTPUT.PUT_LINE('Test: Attempting to increase employee salary (should succeed)');
    BEGIN
        UPDATE s_emp SET salary = salary + 100 WHERE id = 100;
        IF SQL%ROWCOUNT > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Success: Salary increased for 1 employee');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
    
END;
/

-- ============================================================================
-- PART D: EXCEPTION HANDLING
-- ============================================================================

-- ============================================================================
-- TASK D1: Exception Handling for Salary Selection
-- ============================================================================

DECLARE
    v_salary    NUMBER := &salary_input;
    v_emp_name  s_emp.name%TYPE;
    
    -- Custom exception for multiple rows
    e_multiple_rows    EXCEPTION;
    
    -- Pragma to associate exception with Oracle error code
    PRAGMA EXCEPTION_INIT(e_multiple_rows, -1422);
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- TASK D1: Exception Handling for Salary Selection ---');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Searching for employee with salary: ' || v_salary);
    DBMS_OUTPUT.PUT_LINE('');
    
    BEGIN
        -- This will raise TOO_MANY_ROWS if more than one employee has this salary
        SELECT name INTO v_emp_name
        FROM s_emp
        WHERE salary = v_salary;
        
        -- If we reach here, exactly one row was found
        DBMS_OUTPUT.PUT_LINE('SUCCESS: Found employee');
        DBMS_OUTPUT.PUT_LINE('Employee Name: ' || v_emp_name);
        DBMS_OUTPUT.PUT_LINE('Salary: ' || TO_CHAR(v_salary, '99,999.99'));
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: No employee with salary of ' || 
                               TO_CHAR(v_salary, '99,999.99'));
        
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: More than one employee with salary of ' || 
                               TO_CHAR(v_salary, '99,999.99'));
        
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Some other error occurred - ' || SQLERRM);
    END;
    
    DBMS_OUTPUT.PUT_LINE('');
    
END;
/

-- ============================================================================
-- TASK D2: Remove Department with Pragma Exception_Init
-- ============================================================================

DECLARE
    v_dept_id                NUMBER := &dept_id_to_remove;
    
    -- Define custom exception for foreign key constraint
    e_foreign_key_violation  EXCEPTION;
    
    -- Pragma to map error code for employees in department
    PRAGMA EXCEPTION_INIT(e_foreign_key_violation, -2292);
    
    v_emp_count              NUMBER;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- TASK D2: Remove Department with Exception Handling ---');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Attempting to remove Department: ' || v_dept_id);
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Check if employees exist in the department
    SELECT COUNT(*) INTO v_emp_count
    FROM s_emp
    WHERE dept_id = v_dept_id;
    
    IF v_emp_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Cannot remove department!');
        DBMS_OUTPUT.PUT_LINE('Reason: Department ' || v_dept_id || 
                           ' has ' || v_emp_count || ' employee(s)');
        DBMS_OUTPUT.PUT_LINE('Please reassign or delete employees first.');
    ELSE
        -- Try to delete the department
        BEGIN
            DELETE FROM s_dept
            WHERE id = v_dept_id;
            
            DBMS_OUTPUT.PUT_LINE('SUCCESS: Department ' || v_dept_id || ' has been removed');
            DBMS_OUTPUT.PUT_LINE('Rows affected: ' || SQL%ROWCOUNT);
            
            COMMIT;
            
        EXCEPTION
            WHEN e_foreign_key_violation THEN
                DBMS_OUTPUT.PUT_LINE('ERROR: Cannot remove department!');
                DBMS_OUTPUT.PUT_LINE('Reason: Foreign key constraint - employees exist in this department');
                ROLLBACK;
            
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
                ROLLBACK;
        END;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('');
    
END;
/

-- ============================================================================
-- Additional Test Cases for D1
-- ============================================================================

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- TEST CASES FOR D1: Exception Handling ---');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Test Case 1: Unique salary (should succeed)
    DBMS_OUTPUT.PUT_LINE('Test Case 1: Searching for unique salary');
    DECLARE
        v_name    s_emp.name%TYPE;
    BEGIN
        SELECT name INTO v_name FROM s_emp WHERE salary = 26000;
        DBMS_OUTPUT.PUT_LINE('Found: ' || v_name || ' with salary 26000');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No employee found with this salary');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Multiple employees with this salary');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Other error: ' || SQLERRM);
    END;
    
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Test Case 2: Non-existent salary (should trigger NO_DATA_FOUND)
    DBMS_OUTPUT.PUT_LINE('Test Case 2: Searching for non-existent salary');
    DECLARE
        v_name    s_emp.name%TYPE;
    BEGIN
        SELECT name INTO v_name FROM s_emp WHERE salary = 99999;
        DBMS_OUTPUT.PUT_LINE('Found: ' || v_name);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: No employee with salary of 99999');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Multiple employees with this salary');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Other error: ' || SQLERRM);
    END;
    
    DBMS_OUTPUT.PUT_LINE('');
    
END;
/

COMMIT;
