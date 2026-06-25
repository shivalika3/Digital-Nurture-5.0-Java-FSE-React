/* EXERCISE 2 : ERROR HANDLING */

/* SCENARIO 1 - SafeTransferFunds Procedure */

CREATE OR REPLACE PROCEDURE SafeTransferFunds(
    p_fromAccount IN NUMBER,
    p_toAccount   IN NUMBER,
    p_amount      IN NUMBER
)
IS
    v_balance NUMBER;
BEGIN

    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE AccountID = p_fromAccount;

    IF v_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Insufficient Funds'
        );
    END IF;

    UPDATE Accounts
    SET Balance = Balance - p_amount
    WHERE AccountID = p_fromAccount;

    UPDATE Accounts
    SET Balance = Balance + p_amount
    WHERE AccountID = p_toAccount;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'Funds transferred successfully.'
    );

EXCEPTION

    WHEN OTHERS THEN

        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE(
            'Transfer Failed: ' || SQLERRM
        );

END;
/

/* Test Case */

BEGIN
    SafeTransferFunds(1, 2, 500);
END;
/

/* SCENARIO 2 - UpdateSalary Procedure */

CREATE OR REPLACE PROCEDURE UpdateSalary(
    p_employeeID IN NUMBER,
    p_percentage IN NUMBER
)
IS
    v_count NUMBER;
BEGIN

    SELECT COUNT(*)
    INTO v_count
    FROM Employees
    WHERE EmployeeID = p_employeeID;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Employee ID Not Found'
        );
    END IF;

    UPDATE Employees
    SET Salary = Salary +
                 (Salary * p_percentage / 100)
    WHERE EmployeeID = p_employeeID;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'Salary Updated Successfully.'
    );

EXCEPTION

    WHEN OTHERS THEN

        DBMS_OUTPUT.PUT_LINE(
            'Error: ' || SQLERRM
        );

END;
/

/* Test Case */

BEGIN
    UpdateSalary(1, 10);
END;
/

/* SCENARIO 3 - AddNewCustomer Procedure */

CREATE OR REPLACE PROCEDURE AddNewCustomer(
    p_customerID IN NUMBER,
    p_name       IN VARCHAR2,
    p_dob        IN DATE,
    p_balance    IN NUMBER
)
IS
BEGIN

    INSERT INTO Customers(
        CustomerID,
        Name,
        DOB,
        Balance,
        LastModified
    )
    VALUES(
        p_customerID,
        p_name,
        p_dob,
        p_balance,
        SYSDATE
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'Customer Added Successfully.'
    );

EXCEPTION

    WHEN DUP_VAL_ON_INDEX THEN

        DBMS_OUTPUT.PUT_LINE(
            'Error: Customer ID Already Exists.'
        );

    WHEN OTHERS THEN

        DBMS_OUTPUT.PUT_LINE(
            'Error: ' || SQLERRM
        );

END;
/

/* Test Case */

BEGIN
    AddNewCustomer(
        5,
        'David Miller',
        TO_DATE(
            '1995-06-10',
            'YYYY-MM-DD'
        ),
        8000
    );
END;
/