CREATE SCHEMA ojt_20250211;
USE ojt_20250211;

-- Challenge #1

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

INSERT INTO employees (name, department, salary, hire_date) VALUES
('John Doe', 'Sales', 50000.00, '2024-03-15'),
('Jane Smith', 'Marketing', 60000.00, '2024-07-22'),
('Alice Johnson', 'HR', 55000.00, '2025-01-30'),
('Bob Brown', 'IT', 70000.00, '2024-05-10'),
('Charlie Davis', 'Finance', 65000.00, '2025-02-18'),
('Eve White', 'Sales', 48000.00, '2024-11-05'),
('Frank Wilson', 'IT', 72000.00, '2025-09-12'),
('Grace Lee', 'Marketing', 62000.00, '2024-08-25'),
('Henry Moore', 'HR', 53000.00, '2025-04-20'),
('Ivy Taylor', 'Finance', 68000.00, '2024-06-09');

SELECT * FROM employees;

-- 1.) Creates a temporary table temp_high_salaries to store employees who earn more than 50,000.
CREATE TEMPORARY TABLE temp_high_salaries (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

-- 2.) Inserts employees from the employees table who meet this condition.
INSERT INTO temp_high_salaries
SELECT id, name, department, salary, hire_date
FROM employees
WHERE Salary > 50000;

-- 3.) Retrieves data from the temporary table.
SELECT * FROM temp_high_salaries;

-- 4.) Create a view called recent_hires that displays employees who were hired in the last 6 months.
CREATE VIEW recent_hires AS
SELECT id, name, department, salary, hire_date
FROM employees
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

SELECT * FROM recent_hires;

-- 5.) Create a stored procedure GetEmployeesByDepartment that takes a department name as input and returns all employees in that department. 
DELIMITER //

CREATE PROCEDURE GetEmployeesByDepartment(IN dept_name VARCHAR(50))
BEGIN

	SELECT * FROM employees
    WHERE department = dept_name;

END //

DELIMITER ;

CALL GetEmployeesByDepartment('IT');

-- Challenge #2

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    signup_date DATE
);

INSERT INTO customers (name, email, city, signup_date) VALUES
('Alice Johnson', 'alice.johnson@example.com', 'New York', '2023-05-12'),
('Bob Smith', 'bob.smith@example.com', 'Los Angeles', '2023-07-22'),
('Charlie Brown', 'charlie.brown@example.com', 'Chicago', '2023-09-15'),
('Diana Evans', 'diana.evans@example.com', 'Houston', '2023-11-30'),
('Ethan Harris', 'ethan.harris@example.com', 'Phoenix', '2024-01-10'),
('Fiona Clark', 'fiona.clark@example.com', 'Philadelphia', '2024-03-18'),
('George Lewis', 'george.lewis@example.com', 'San Antonio', '2024-05-25'),
('Hannah Walker', 'hannah.walker@example.com', 'San Diego', '2024-07-05'),
('Ian Hall', 'ian.hall@example.com', 'Dallas', '2024-09-12'),
('Jessica Young', 'jessica.young@example.com', 'San Jose', '2024-11-20');

SELECT * FROM customers;

CREATE INDEX idx_name ON customers(name);
CREATE INDEX idx_city ON customers(city);
CREATE INDEX idx_signup_date ON customers(signup_date);

EXPLAIN SELECT * FROM customers WHERE name = 'Diana Evans';
EXPLAIN SELECT * FROM customers WHERE city = 'Philadelphia';
EXPLAIN SELECT * FROM customers WHERE signup_date <= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);