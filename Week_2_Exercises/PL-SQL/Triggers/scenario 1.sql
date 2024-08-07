CREATE TABLE CUSTOMERS (
    CUSTOMER_ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(50),
    DATE_OF_BIRTH DATE,
    LOAN_INTEREST_RATE NUMBER(5, 2),
    BALANCE NUMBER(15, 2),
    IS_VIP CHAR(1),
    LAST_MODIFIED DATE
);

INSERT INTO CUSTOMERS (CUSTOMER_ID, NAME, DATE_OF_BIRTH, LOAN_INTEREST_RATE, BALANCE, IS_VIP, LAST_MODIFIED)
VALUES (1, 'John Doe', TO_DATE('1958-08-15', 'YYYY-MM-DD'), 5.5, 15000, 'F', SYSDATE);

INSERT INTO CUSTOMERS (CUSTOMER_ID, NAME, DATE_OF_BIRTH, LOAN_INTEREST_RATE, BALANCE, IS_VIP, LAST_MODIFIED)
VALUES (2, 'Jane Smith', TO_DATE('1980-05-20', 'YYYY-MM-DD'), 4.0, 20000, 'T', SYSDATE);

CREATE OR REPLACE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE ON CUSTOMERS
FOR EACH ROW
BEGIN
    :NEW.LAST_MODIFIED := SYSDATE;
END;
/

SET SERVEROUTPUT ON;
BEGIN
    UPDATE CUSTOMERS
    SET BALANCE = BALANCE + 500
    WHERE CUSTOMER_ID = 1;

    FOR rec IN (SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID = 1) LOOP
        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || rec.CUSTOMER_ID || ', Last Modified: ' || rec.LAST_MODIFIED);
    END LOOP;
END;
/
