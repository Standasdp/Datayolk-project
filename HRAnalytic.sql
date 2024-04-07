-- Dataset

-- Team Table
CREATE TABLE Team (
  team_id INT PRIMARY KEY,
  team_name VARCHAR(50)
);

-- Employee Table
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(255) UNIQUE,
    hire_date DATE,
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES team(team_id)
);

-- Salary Table
CREATE TABLE Salary (
  employee_id INT PRIMARY KEY,
  role VARCHAR(50),
  salary INTEGER
);


-- INSERT INTO Table
INSERT INTO employee (employee_id, first_name, last_name, email, hire_date, team_id)
VALUES (1, 'Warde', 'Remon', 'wremon0@zimbio.com','1-Jun-23', 1),
(2, 'Orlando', 'Groneway', 'ogroneway1@wikipedia.org', '22-Jun-23', 1),
(3, 'Amalita', 'Shorland', 'ashorland2@npr.org', '25-Mar-23', 1),
(4, 'Reinwald', 'Pickersail', 'rpickersail3@skyrock.com', '24-Jun-23', 1),
(5, 'Ilario', 'Anfrey', 'ianfrey4@google.com','2-Jan-23',1),
(6,'Davey', 'Frowen', 'dfrowen5@nsw.gov.au', '3-Mar-23', 6),
(7, 'Leigha', 'Randlesome', 'lrandlesome6@alibaba.com', '15-Oct-22', 6),
(8,'Junia', 'Yakovliv', 'jyakovliv7@artisteer.com', '31-Jul-23', 6),
(9, 'Rochell', 'Waggatt', 'rwaggatt8@opera.com', '15-Apr-23', 6),
(10, 'Moises', 'Ardley', 'mardley9@webnode.com', '21-Jun-23', 6);

INSERT INTO Team (team_id, team_name)
VALUES (1, 'plan_A'),
(6, 'plan_B');

INSERT INTO Salary (employee_id, role, salary)
VALUES (1, 'Sales', 40153),
(2, 'Marketing', 46670),
(3, 'Legal', 71983),
(4, 'Sales', 15857),
(5, 'Software Engineer', 95174),
(6, 'Sales', 27819),
(7, 'Legal', 75323),
(8, 'Software Engineer', 90525),
(9, 'Tax Accountant', 85946),
(10, 'Marketing', 56575);


.mode box
.header on
SELECT * FROM Team;
SELECT * FROM Employee;
SELECT * FROM Salary;



-- Challenge start !!

-- Q1: Query each employee's first, last name, email address, date of employment, title, and salary.

SELECT E.first_name, E.last_name, E.email, E.hire_date, S.role, S.salary
FROM Employee E
LEFT JOIN Salary S 
ON E.employee_id = S.employee_id;


-- Q2: Who are the three most recently hired employees? What team are they on? and What day do they come to work?
-- Show Team ID
SELECT team_id, first_name, last_name, email, hire_date, 
RANK() OVER (ORDER BY hire_date) AS hire_date_rank
FROM employee
LIMIT 3;

-- OR (Show Team Name)

SELECT t.team_name, e.first_name, e.last_name, e.email, e.hire_date,
RANK() OVER (ORDER BY e.hire_date ASC) AS hire_date_rank
FROM 
    employee e
JOIN 
    team t 
ON 
    e.team_id = t.team_id
LIMIT 3;


-- Q3
-- Q3.1: find the average salary of employees in each position.
SELECT role, AVG(salary) AS average_salary
FROM Salary
GROUP BY role;

-- Q3.2 Find the salary of each position as a proportion of the total employee salary.
SELECT 
  role, 
  SUM(salary) * 1.0 / (SELECT SUM(salary) FROM Salary) AS proportion
FROM Salary
GROUP BY role;

-- OR

SELECT 
    S.role,
    SUM(S.salary) * 1.0 / (SELECT SUM(salary) FROM Salary) AS proportion
FROM 
    Team T
JOIN 
    Employee E ON T.team_id = E.team_id
JOIN 
    Salary S ON E.employee_id = S.employee_id
GROUP BY 
  S.role;


-- Q4: Employees with a salary higher than 75,000 are called Managers, salaries from 45,000 to 75,000 are called Seniors, and those with salaries less than that are called Staff.

SELECT
  e.employee_id,
  e.first_name,
  e.last_name,
  s.salary,
  CASE
    WHEN s.salary > 75000 THEN 'Manager'
    WHEN s.salary > 45000 AND s.salary <= 75000 THEN 'Senior'
    ELSE 'Staff'
  END AS employee_category
FROM Employee e
JOIN Salary s ON e.employee_id = s.employee_id;


-- Q5: If an employee comes on 14-Oct-23 for the Marketing position with a salary of 45,000 baht, what will the latest average salary for the Marketing position?

-- Insert the 11th new employee in the employee and salary tables.

INSERT INTO employee (employee_id, first_name, last_name, email, hire_date, team_id)
VALUES (1, 'Warde', 'Remon', 'wremon0@zimbio.com','1-Jun-23', 1),
(2, 'Orlando', 'Groneway', 'ogroneway1@wikipedia.org', '22-Jun-23', 1),
(3, 'Amalita', 'Shorland', 'ashorland2@npr.org', '25-Mar-23', 1),
(4, 'Reinwald', 'Pickersail', 'rpickersail3@skyrock.com', '24-Jun-23', 1),
(5, 'Ilario', 'Anfrey', 'ianfrey4@google.com','2-Jan-23',1),
(6,'Davey', 'Frowen', 'dfrowen5@nsw.gov.au', '3-Mar-23', 6),
(7, 'Leigha', 'Randlesome', 'lrandlesome6@alibaba.com', '15-Oct-22', 6),
(8,'Junia', 'Yakovliv', 'jyakovliv7@artisteer.com', '31-Jul-23', 6),
(9, 'Rochell', 'Waggatt', 'rwaggatt8@opera.com', '15-Apr-23', 6),
(10, 'Moises', 'Ardley', 'mardley9@webnode.com', '21-Jun-23', 6),
(11, , , , '11-Oct-23', );

INSERT INTO Salary (employee_id, role, salary)
VALUES (1, 'Sales', 40153),
(2, 'Marketing', 46670),
(3, 'Legal', 71983),
(4, 'Sales', 15857),
(5, 'Software Engineer', 95174),
(6, 'Sales', 27819),
(7, 'Legal', 75323),
(8, 'Software Engineer', 90525),
(9, 'Tax Accountant', 85946),
(10, 'Marketing', 56575),
(11, 'Marketing', 45000);

-- Find the latest average salary for Marketing.
SELECT 
    role,
    AVG(salary) AS average_salary
FROM 
    salary
GROUP BY role
HAVING role = 'Marketing';


-- 
