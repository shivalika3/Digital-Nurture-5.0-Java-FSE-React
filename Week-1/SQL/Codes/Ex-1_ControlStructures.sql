/* EXERCISE 1 : CONTROL STRUCTURES */
   

/*TABLE CREATION*/

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    LastModified DATE
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER,
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
);

/* SAMPLE DATA INSERTION */

INSERT INTO Customers
VALUES (1, 'John Doe',
        TO_DATE('1985-05-15','YYYY-MM-DD'),
        1000, SYSDATE);

INSERT INTO Customers
VALUES (2, 'Jane Smith',
        TO_DATE('1990-07-20','YYYY-MM-DD'),
        1500, SYSDATE);

INSERT INTO Accounts
VALUES (1, 1, 'Savings',
        1000, SYSDATE);

INSERT INTO Accounts
VALUES (2, 2, 'Checking',
        1500, SYSDATE);

INSERT INTO Transactions
VALUES (1, 1, SYSDATE,
        200, 'Deposit');

INSERT INTO Transactions
VALUES (2, 2, SYSDATE,
        300, 'Withdrawal');

INSERT INTO Loans
VALUES (1, 1, 5000, 5,
        SYSDATE,
        ADD_MONTHS(SYSDATE,60));

INSERT INTO Employees
VALUES (1, 'Alice Johnson',
        'Manager',
        70000,
        'HR',
        TO_DATE('2015-06-15','YYYY-MM-DD'));

INSERT INTO Employees
VALUES (2, 'Bob Brown',
        'Developer',
        60000,
        'IT',
        TO_DATE('2017-03-20','YYYY-MM-DD'));

/* EXTRA DATA */

INSERT INTO Customers
VALUES (3, 'Robert Wilson',
        TO_DATE('1955-08-10','YYYY-MM-DD'),
        15000,
        SYSDATE);

INSERT INTO Customers
VALUES (4, 'Mary Johnson',
        TO_DATE('1960-02-15','YYYY-MM-DD'),
        12000,
        SYSDATE);

INSERT INTO Loans
VALUES (2, 3, 10000, 7,
        SYSDATE,
        SYSDATE + 20);

INSERT INTO Loans
VALUES (3, 4, 15000, 8,
        SYSDATE,
        SYSDATE + 25);

COMMIT;

/* SCENARIO 1 - Interest Rate Discount */

DECLARE
    v_age NUMBER;
BEGIN

    FOR cust IN (
        SELECT CustomerID, DOB
        FROM Customers
    )
    LOOP

        v_age := TRUNC(
                  MONTHS_BETWEEN(
                  SYSDATE,
                  cust.DOB) / 12);

        IF v_age > 60 THEN

            UPDATE Loans
            SET InterestRate =
                InterestRate - 1
            WHERE CustomerID =
                  cust.CustomerID;

            DBMS_OUTPUT.PUT_LINE(
                'Discount applied for Customer ID: '
                || cust.CustomerID);

        END IF;

    END LOOP;

    COMMIT;

END;
/

/* SCENARIO 2 - VIP Customers */

ALTER TABLE Customers
ADD IsVIP VARCHAR2(5);

BEGIN

    FOR cust IN (
        SELECT CustomerID,
               Balance
        FROM Customers
    )
    LOOP

        IF cust.Balance > 10000 THEN

            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID =
                  cust.CustomerID;

            DBMS_OUTPUT.PUT_LINE(
                'VIP Status Assigned to Customer ID: '
                || cust.CustomerID);

        END IF;

    END LOOP;

    COMMIT;

END;
/

/* SCENARIO 3 - Loan Reminder */

BEGIN

    FOR loan_rec IN
    (
        SELECT c.Name,
               l.LoanID,
               l.EndDate
        FROM Customers c
        JOIN Loans l
        ON c.CustomerID = l.CustomerID
        WHERE l.EndDate
              BETWEEN SYSDATE
              AND SYSDATE + 30
    )
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Reminder: Dear '
            || loan_rec.Name
            || ', your Loan ID '
            || loan_rec.LoanID
            || ' is due on '
            || TO_CHAR(
                loan_rec.EndDate,
                'DD-MON-YYYY'
            )
        );

    END LOOP;

END;
/