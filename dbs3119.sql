SET SERVEROUTPUT ON;

-- student TABLE setup --

DROP TABLE student15;

CREATE TABLE student15(
    SID int,
    Marks int,
    Grade varchar(2)
    ); 

insert into student15 ( sid, marks) values (1,80);
insert into student15 ( sid, marks) values (2,90);
insert into student15 ( sid, marks) values (3,70);
insert into student15 ( sid, marks) values (4,67);
insert into student15 ( sid, marks) values (5, 79);
insert into student15 ( sid, marks) values (6,21);
insert into student15 ( sid, marks) values (7, 75);
insert into student15 ( sid, marks) values (8,35);
insert into student15 ( sid, marks) values (9, 59);
insert into student15 ( sid, marks) values (10,71);


-- student TABLE setup END --
            
--Questions 1--
CREATE OR REPLACE PROCEDURE calGrade
AS
BEGIN
    UPDATE student15
    SET grade = 'A'
    WHERE marks >= 80;
    
    UPDATE student15
    SET grade = 'B+'
    WHERE marks BETWEEN 75 AND 79;
    
    UPDATE student15
    SET grade = 'B'
    WHERE marks BETWEEN 70 AND 74;
    
    UPDATE student15
    SET grade = 'C'
    WHERE marks BETWEEN 60 AND 69;
    
    UPDATE student15
    SET grade = 'D'
    WHERE marks BETWEEN 50 AND 59;
    
    UPDATE student15
    SET grade = 'F'
    WHERE marks < 50;
    
    FOR i IN (SELECT * FROM student15)
    LOOP 
        dbms_output.put_line('SID: ' || i.sid || ' Marks: ' || i.marks || ' grade: ' || i.grade);
    END LOOP;
END calGrade;

/
--Questions 2--
CREATE OR REPLACE PROCEDURE upmarks15
AS
BEGIN
    UPDATE student15
    SET marks = ROUND(marks * 1.115);
    
    UPDATE student15
    SET marks = 100
    WHERE marks > 100; -- When marks is over 100, set it back to 100 
    
    calGrade;
    
END upmarks15;

/

--Questions 3--
CREATE OR REPLACE PROCEDURE numSort(small15 IN number, large15 IN number)
AS
small15cpy NUMBER:= small15;
large15cpy NUMBER:= large15;
tempNum NUMBER;
BEGIN
   IF small15cpy > large15cpy THEN
        tempNum := small15cpy;
        small15cpy := large15cpy;
        large15cpy := tempNum; -- swap the value if small num is greater than large num
    END IF;
    
    dbms_output.put_line('small15 = ' || small15cpy);
    dbms_output.put_line('large15 = ' || large15cpy);
    
END;

/

-- EMP Table setUp--

DROP TABLE EMP15;

CREATE TABLE EMP15
AS 
SELECT * FROM employees;

ALTER TABLE EMP15
ADD bonus int;

DESCRIBE EMP15;

-- EMP Table setUp END --


--Questions 4--
CREATE OR REPLACE PROCEDURE calSales
AS
    CURSOR sales_cursor IS
    SELECT c.sales_rep, e.last_name, SUM(ol.price * ol.qty) AS tolSales
    FROM customers c JOIN EMP15 e
    ON c.sales_rep = e.employee_id
    JOIN orders o
    ON e.employee_id = o.rep_no
    JOIN orderlines ol
    ON o.order_no = ol.order_no
    GROUP BY c.sales_rep, e.last_name;
    c_test sys_refcursor;
BEGIN
    FOR i IN sales_cursor
    LOOP
        IF i.tolSales > 150000 THEN 
            UPDATE EMP15
            SET bonus = i.tolSales * 0.04
            WHERE employee_id = i.sales_rep;
        ELSIF i.tolSales >= 50000 and i.tolSales <= 150000 THEN
            UPDATE EMP15
            SET bonus = ROUND(i.tolSales * 0.025)
            WHERE employee_id = i.sales_rep;
        ELSE 
            UPDATE EMP15
            SET bonus = ROUND(i.tolSales * 0.01)
            WHERE employee_id = i.sales_rep;
        END IF;
        
    END LOOP;
    
    dbms_output.put_line('ID   LAST_NAME   SALARY     BONUS');
    FOR i IN (SELECT DISTINCT c.sales_rep, e.last_name, e.salary, e.bonus 
                FROM customers c JOIN EMP15 e
                ON c.sales_rep = e.employee_id
                ORDER BY 1)
    LOOP 
        dbms_output.put_line( i.sales_rep || '|   ' || i.last_name || '|     ' || i.salary || '  |   ' || i.bonus);
    END LOOP;
END;

/
 
-- TESTING START --

BEGIN
    dbms_output.put_line('-----Questions1-----');
    calGrade;
END;

/

BEGIN
    dbms_output.put_line('-----Questions2-----');
    upmarks15;
END;
/

PAUSE "Question 1 is shown above ... Press enter each time "
BEGIN
    dbms_output.put_line('-----Questions3-----');
    numSort(9,7);
END;
/

PAUSE "Question 2 is shown above ... Press enter each time "
BEGIN
    dbms_output.put_line('-----Questions4-----');
    calSales;
END;
/
PAUSE "Question 3 is shown above ... Press enter each time"

PAUSE "Question 4 is shown above ... Press enter each time"

 
-- TESTING END --
    
    
