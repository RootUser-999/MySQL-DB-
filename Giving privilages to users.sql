-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS EmployeeDatabase_Lab19;
USE EmployeeDatabase_Lab19;

-- Create the departments table
CREATE TABLE IF NOT EXISTS departments (
  department_id INT AUTO_INCREMENT,
  department_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (department_id)
);

-- Create the jobs table
CREATE TABLE IF NOT EXISTS jobs (
  job_id VARCHAR(10) NOT NULL,
  job_title VARCHAR(255) NOT NULL,
  PRIMARY KEY (job_id)
);

-- Create the employees table with foreign keys
CREATE TABLE IF NOT EXISTS employees (
  employee_id INT AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone_number VARCHAR(20),
  hire_date DATE NOT NULL,
  job_id VARCHAR(10) NOT NULL,
  salary DECIMAL(8, 2) NOT NULL CHECK (salary > 0),
  manager_id INT,
  department_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (employee_id),
  FOREIGN KEY (job_id) REFERENCES jobs(job_id),
  FOREIGN KEY (department_id) REFERENCES departments(department_id),
  FOREIGN KEY (manager_id) REFERENCES employees(employee_id) ON DELETE SET NULL
);

-- Create the users table for system users
CREATE TABLE IF NOT EXISTS users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  role VARCHAR(50) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample data into departments
INSERT INTO departments (department_name) VALUES
('Sales'),
('Marketing'),
('IT'),
('HR'),
('Finance');

-- Insert sample data into jobs
INSERT INTO jobs (job_id, job_title) VALUES
('SA_MAN', 'Sales Manager'),
('SA_REP', 'Sales Representative'),
('MK_MAN', 'Marketing Manager'),
('IT_PROG', 'IT Programmer'),
('HR_REP', 'HR Representative'),
('FI_MAN', 'Finance Manager'),
('SH_CLERK', 'Shipping Clerk');

-- Insert sample data into employees
INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890', '2020-01-01', 'SA_MAN', 100000.00, NULL, 1),
('Jane', 'Doe', 'jane.doe@example.com', '987-654-3210', '2020-01-01', 'SA_REP', 50000.00, 1, 1),
('Bob', 'Smith', 'bob.smith@example.com', '555-123-4567', '2020-01-01', 'MK_MAN', 80000.00, NULL, 2),
('Alice', 'Johnson', 'alice.johnson@example.com', '111-222-3333', '2020-01-01', 'IT_PROG', 60000.00, NULL, 3),
('Mike', 'Williams', 'mike.williams@example.com', '444-555-6666', '2020-01-01', 'HR_REP', 70000.00, NULL, 4),
('Emily', 'Davis', 'emily.davis@example.com', '777-888-9999', '2020-01-01', 'FI_MAN', 90000.00, NULL, 5),
('Bull', 'Bull', 'bull.bull@example.com', '333-444-5555', '2020-01-01', 'SH_CLERK', 40000.00, NULL, 5);

-- Create user for database access
CREATE USER 'your_first_name'@'localhost' IDENTIFIED BY 'your_password'; -- Replace 'your_password' with the actual password

-- Grant privileges to the user for the EmployeeDatabase_Lab19 database
GRANT CREATE, SELECT ON EmployeeDatabase_Lab19.* TO 'your_first_name'@'localhost';

-- Create a view
CREATE VIEW my_view AS
SELECT *
FROM employees;  -- Assuming you want a view based on the employees table

-- Grant privileges to the user on the view
GRANT INSERT, DELETE, UPDATE ON my_view TO 'your_first_name'@'localhost';

-- Revoke privileges from the user on the view
REVOKE INSERT, DELETE, UPDATE ON my_view FROM 'your_first_name'@'localhost';
