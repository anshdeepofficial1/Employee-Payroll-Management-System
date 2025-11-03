-- Create database (optional)
CREATE DATABASE payrolldb;
USE payrolldb;

-- Employee Table
CREATE TABLE Employee (
  empid INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  designation VARCHAR(30),
  basicsalary DECIMAL(10,2)
);

-- Attendance Table
CREATE TABLE Attendance (
  attendanceid INT PRIMARY KEY AUTO_INCREMENT,
  empid INT,
  day DATE,
  status VARCHAR(10), -- Present, Absent, Leave
  FOREIGN KEY (empid) REFERENCES Employee(empid)
);

-- Salary Structure Table
CREATE TABLE SalaryStructure (
  structureid INT PRIMARY KEY AUTO_INCREMENT,
  empid INT,
  allowances DECIMAL(10,2),
  deductions DECIMAL(10,2),
  FOREIGN KEY (empid) REFERENCES Employee(empid)
);

-- Payslip Table
CREATE TABLE Payslip (
  payslipid INT PRIMARY KEY AUTO_INCREMENT,
  empid INT,
  month INT,
  year INT,
  grosssalary DECIMAL(10,2),
  netsalary DECIMAL(10,2),
  FOREIGN KEY (empid) REFERENCES Employee(empid)
);

-- Sample Insert Statements

-- Employees
INSERT INTO Employee (name, designation, basicsalary) VALUES
  ('Amit Kumar', 'Manager', 50000),
  ('Seema Rana', 'Developer', 40000),
  ('Rohit Sharma', 'Accountant', 35000);

-- Salary Structure
INSERT INTO SalaryStructure (empid, allowances, deductions) VALUES
  (1, 8000, 1500),
  (2, 6000, 1200),
  (3, 5000, 1000);

-- Attendance for October 2025
INSERT INTO Attendance (empid, day, status) VALUES
  (1, '2025-10-01', 'Present'),
  (1, '2025-10-02', 'Present'),
  (2, '2025-10-01', 'Leave'),
  (3, '2025-10-01', 'Absent');

-- Calculate Gross and Net Salary for October 2025 (sample select)
SELECT
  e.empid, e.name, e.basicsalary,
  ss.allowances, ss.deductions,
  e.basicsalary + ss.allowances AS grosssalary,
  e.basicsalary + ss.allowances - ss.deductions AS netsalary
FROM Employee e
JOIN SalaryStructure ss ON e.empid = ss.empid;

-- Generate payslip sample for October 2025
INSERT INTO Payslip (empid, month, year, grosssalary, netsalary)
SELECT
  e.empid, 10, 2025,
  e.basicsalary + ss.allowances,
  e.basicsalary + ss.allowances - ss.deductions
FROM Employee e
JOIN SalaryStructure ss ON e.empid = ss.empid;

-- View Payslips
SELECT
  p.payslipid, e.name, p.month, p.year, p.grosssalary, p.netsalary
FROM Payslip p
JOIN Employee e ON p.empid = e.empid;
