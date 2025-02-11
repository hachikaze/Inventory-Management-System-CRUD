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