CREATE TABLE departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(50)
);

CREATE TABLE employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary INT,
    HireDate DATE,
	FOREIGN KEY (DepartmentID) REFERENCES departments(DepartmentID)
);

-- Create a database schema with the following structure, and retrieve all required data.

INSERT INTO departments (DepartmentName) VALUES ('IT'), ('HR'), ('Finance');

INSERT INTO employees (FirstName, LastName, DepartmentID, Salary, HireDate)
VALUES ('John', 'Doe', 1, 50000, '2020-03-15'),
('Jane', 'Smith', 2, 60000, '2019-07-01'),
('Alice', 'Brown', 1, 55000, '2021-06-23'),
('Bob', 'Johnson', 3, 62000, '2018-09-12'),
('Charlie', 'Wilson', 2, 58000, '2022-01-08');

SELECT * FROM employees;

SELECT * FROM departments;

-- 1.) Retrieve all employees' first names and last names.
SELECT FirstName, LastName FROM employees;

-- 2.) Retrieve all employees ordered by their salary in descending order.
SELECT * FROM employees ORDER BY Salary DESC;

-- 3.) Count the number of employees in each department.
SELECT DepartmentID, COUNT(*) AS NumberOfEmployees 
FROM employees 
GROUP BY DepartmentID;

-- 4.) Find all employees whose first name starts with 'J'
SELECT * FROM employees WHERE FirstName LIKE 'J%';

-- 5.) Display employees’ first names, last names, and a new column "SalaryCategory" which shows 'High' if the salary is above 55000, otherwise 'Low'.
SELECT FirstName, LastName,
CASE
	WHEN Salary > 55000 THEN 'High'
    ELSE 'Low'
END AS 'SalaryCategory'
FROM employees;

-- 6.) Convert the hire date into a formatted string in the format 'Month Day, Year' (e.g., 'March 15, 2020').
SELECT HireDate, DATE_FORMAT(HireDate, "%M, %d, %Y") AS ConvertedHireDate FROM employees;

-- 7.) Retrieve all employees along with their department names.
SELECT * FROM employees e
JOIN departments d ON e.DepartmentID = d.DepartmentID;
 
-- 8.) Retrieve the employees who earn more than the average salary.
SELECT * FROM employees
WHERE Salary > (SELECT AVG(Salary) FROM employees);

-- 9.) Get all employee names from the Employees table and all department names from the Departments table in a single list.
SELECT CONCAT(FirstName, ' ', LastName) AS Name FROM employees
UNION
SELECT DepartmentName AS Name FROM departments;

-- 10.) Retrieve employees who were hired in the year 2020.
SELECT * FROM employees WHERE HireDate BETWEEN '2019-12-31' AND '2021-01-01';

-- 11.) Display each employee’s full name in uppercase.
SELECT UPPER(CONCAT(FirstName, ' ', LastName)) AS Name FROM employees;

-- 12.) Increase the salary of employees in the IT department by 10%, but ensure that the transaction is rolled back if something goes wrong.
DELIMITER //

CREATE PROCEDURE updateITSalary()
BEGIN
	DECLARE row_count INT DEFAULT 0;

    START TRANSACTION;
    
    UPDATE employees
    SET Salary = Salary * 1.10
    WHERE DepartmentID = (SELECT DepartmentID From departments WHERE DepartmentName = 'IT');
    
    SET row_count = ROW_COUNT();
    
    IF row_count > 0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF;
END //

DELIMITER ;

CALL UpdateITSalary();

select * from employees;

-- Self Exercise

INSERT INTO employees VALUES (11, 'Michael', 'Jordan', 1, 50000, '2025-01-27');

-- Show the full name of IT employees along with their department name.
SELECT CONCAT(FirstName, ' ', LastName) As 'Full Name', d.DepartmentName AS 'Department Name' FROM employees e
JOIN departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'IT';

-- Retrieve all employees' first and last names.
SELECT FirstName AS 'First Name', LastName AS 'Last Name' FROM employees;

-- Find the names of employees who work in the IT department.
SELECT CONCAT(FirstName, ' ', LastName) AS Name, d.DepartmentName FROM employees e
JOIN departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'IT';

-- List all employees hired after January 1, 2020.
SELECT * FROM employees
WHERE HireDate > '2020-01-1';

-- Display the total number of employees in each department.
SELECT DepartmentID, COUNT(*) AS 'No. of Employees in each Department' 
FROM employees
GROUP BY DepartmentID;

-- Calculate the average salary of employees in each department.
SELECT AVG(Salary), DepartmentID
FROM employees
GROUP BY DepartmentID;

-- Find the highest salary in the company.
SELECT MAX(Salary) AS 'Highest Salary' FROM employees;

SELECT d.DepartmentName AS 'Dept. Name', e.Salary
FROM employees e
JOIN departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary = (SELECT MAX(Salary) FROM employees);

-- List the departments along with the number of employees in each, sorted by the number of employees in descending order.
SELECT d.DepartmentName AS 'Dept.Name', COUNT(*) AS 'No. of Employees' FROM departments d
JOIN employees e ON d.DepartmentID = e.DepartmentID
GROUP BY e.DepartmentID
ORDER BY COUNT(*) DESC;

--  Retrieve the full name (first and last name) of employees along with their department names.
SELECT CONCAT(e.FirstName, ' ', LastName) AS 'Full Name', d.DepartmentName
FROM employees e
JOIN departments d ON e.DepartmentID = d.DepartmentID;

-- Find employees who earn more than the average salary in their department.
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS 'Full Name', d.DepartmentName
FROM employees e
JOIN departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > (SELECT AVG(e2.Salary) FROM employees e2 WHERE e2.DepartmentID = e.DepartmentID);

select * from employees;

CREATE TEMPORARY TABLE tbTemp (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT
);

INSERT INTO tbTemp (name, age) VALUES ('John Doe', 25);

SELECT * FROM tbTemp;

DROP TEMPORARY TABLE IF EXISTS tbTemp;

SELECT * FROM tbTemp;