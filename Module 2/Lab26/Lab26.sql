use employees_mod;

DELIMITER $$
CREATE PROCEDURE emp1()
BEGIN 
SELECT * FROM t_employees
LIMIT 1000;
END $$
DELIMITER ; 

CALL emp1();

DELIMITER $$
CREATE PROCEDURE avg_salary()
BEGIN
SELECT AVG(salary)
FROM t_salaries;
END $$

DELIMITER ;


CALL avg_salary()

-- Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, 
-- and returns their employee number.

DELIMITER $$
CREATE PROCEDURE employee_info(fname VARCHAR(14),lname VARCHAR(16))
BEGIN
SELECT emp_no FROM t_employees
WHERE first_name=fname AND last_name=lname ;
END$$

DELIMITER ;
select * from t_employees;
CALL employee_info('Saniya','Kalloufi');

-- Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee,
-- and returns the salary from the newest contract of that employee. 
-- Hint: In the BEGIN-END block of this program, you need to declare and use two variables 
-- – v_max_from_date that will be of the DATE type, and v_salary, that will be of the DECIMAL (10,2) type.

DELIMITER $$
CREATE FUNCTION emp_info(first_name varchar(100), last_name varchar(100)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE v_max_from_date date;
DECLARE v_salary decimal(10,2);
SELECT max(from_date) into v_max_from_date
from t_employees e
join t_salaries s
on s.emp_no=e.emp_no
where e.first_name=first_name and e.last_name=last_name;
SELECT s.salary into v_salary
from t_employees e
join t_salaries s
on s.emp_no=e.emp_no
where e.first_name=first_name and e.last_name=last_name and s.from_date = v_max_from_date;
RETURN v_salary;
END$$
DELIMITER ;
SELECT EMP_INFO('Saniya', 'Kalloufi');

-- Create a trigger that checks if the hire date of an employee is higher than the current date.
--  If true, set this date to be the current date. Format the output appropriately (YY-MM-DD)
DELIMITER $$

CREATE TRIGGER before_employee_update 
BEFORE INSERT ON t_employees
FOR EACH ROW
BEGIN 
    IF NEW.hire_date > SYSDATE() THEN 
        SET NEW.hire_date = SYSDATE(); 
    END IF; 
END $$


DELIMITER ;

INSERT INTO t_employees VALUES ('999904', '1970-01-01', 'John', 'Johnson', 'M', '2025-01-01');

-- Create ‘i_hire_date’ and Drop the ‘i_hire_date’ index.

CREATE INDEX i_hire_date ON t_employees (hire_date); 

DROP INDEX i_hire_date ON t_employees;

-- Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum

SELECT * FROM t_salaries WHERE salary>89000;
-- Then, create an index on the ‘salary’ column of that table, 
-- and check if it has sped up the search of the same SELECT statement.

CREATE INDEX salary ON t_salaries(salary);
-- it has not sped up significantly

-- Use Case statement and obtain a result set containing the employee number, first name, and last name of all employees 
-- with a number higher than 109990. 
-- Create a fourth column in the query, indicating whether this employee is also a manager,
-- according to the data provided in the dept_manager table, or a regular employee.



SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    d.dept_no,
    CASE
        WHEN dept_no IS NULL THEN 'Regular Employee'
        ELSE 'Manager'
    END AS manager
FROM
    t_employees e
        LEFT JOIN
    t_dept_manager d ON e.emp_no = d.emp_no
WHERE
    e.emp_no > 109990;

SELECT 
    s.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_span,
    IF(MAX(s.salary) - MIN(s.salary) > 30000,
        'HIGH',
        'LOW') AS salary_increase
FROM
    t_dept_manager d
        LEFT JOIN
    t_employees e ON e.emp_no = d.emp_no
        LEFT JOIN
    t_salaries s ON d.emp_no = s.emp_no
GROUP BY s.emp_no;

-- Extract the employee number, first name, and last name of the first 100 employees, 
-- and add a fourth column, called “current_employee” saying “Is still employed” 
-- if the employee is still working in the company, or “Not an employee anymore” if they aren’t. 
-- Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise.

SELECT 
    d.emp_no,
    e.first_name,
    e.last_name,
    IF(d.to_date < sysdate(),
        'Not an employee anymore',
        'Is still working here') AS employment_status
FROM
    t_employees e
        JOIN
    t_dept_emp d ON d.emp_no = e.emp_no;