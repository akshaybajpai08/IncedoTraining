Exercise 1:



Exercias:

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(100)
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);



-- Insert into Customers
INSERT INTO Customers VALUES 
(1, 'Alice', 'New York'),
(2, 'Bob', 'Chicago'),
(3, 'Charlie', 'Los Angeles'),
(4, 'David', 'Miami');

-- Insert into Orders
INSERT INTO Orders VALUES 
(101, 1, '2024-07-01', 250.00),
(102, 2, '2024-07-03', 450.00),
(103, 1, '2024-07-04', 300.00),
(104, 3, '2024-07-05', 150.00);




Task 1: Get all customers who have placed at least one order

mysql> select c.CustomerId, c.Name, o.OrderId, o.Amount from Customers c inner join Orders o ON c.CustomerID = o.CustomerID;
+------------+---------+---------+--------+
| CustomerId | Name    | OrderId | Amount |
+------------+---------+---------+--------+
|          1 | Alice   |     101 | 250.00 |
|          1 | Alice   |     103 | 300.00 |
|          2 | Bob     |     102 | 450.00 |
|          3 | Charlie |     104 | 150.00 |
+------------+---------+---------+--------+
4 rows in set (0.00 sec)  


Task 2: List all orders with customer name and city

mysql> select o.OrderID, c.Name, c.City, o.Amount from orders o inner join Customers c ON o.CustomerId = c.CustomerId;
+---------+---------+-------------+--------+
| OrderID | Name    | City        | Amount |
+---------+---------+-------------+--------+
|     101 | Alice   | New York    | 250.00 |
|     102 | Bob     | Chicago     | 450.00 |
|     103 | Alice   | New York    | 300.00 |
|     104 | Charlie | Los Angeles | 150.00 |
+---------+---------+-------------+--------+



mysql> select c.Name, SUM(o.Amount) AS TotalAmount FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID GROUP BY c.Name;
+---------+-------------+
| Name    | TotalAmount |
+---------+-------------+
| Alice   |      550.00 |
| Bob     |      450.00 |
| Charlie |      150.00 |


# Exercise 2: 

-- Create Departments Table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Create Employees Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT,
    manager_id INT
);

-- Insert Departments
INSERT INTO departments VALUES
(1, 'Engineering'),
(2, 'Marketing'),
(3, 'Sales');

-- Insert Employees
INSERT INTO employees VALUES
(101, 'Alice', 80000, 1, NULL),
(102, 'Bob', 60000, 1, 101),
(103, 'Charlie', 50000, 2, 101),
(104, 'David', 40000, NULL, NULL),
(105, 'Eve', 75000, 3, 103),
(106, 'Frank', 30000, 2, 103);





Task 1: List all employees with their department names. (INNER JOIN)


Task 2: Show all employees and their departments. Also show employees without a department. (LEFT JOIN)


Task 3: Show all departments and employees. Include departments with no employees. (RIGHT JOIN)


Task 4: Show all employees and departments, including unmatched ones from both sides. (FULL JOIN)


Task 5: Display each employee and their manager's name. (SELF JOIN)


Task 6: Highest Paid Employee Per Department

Task 1: List all employees with their department names. (INNER JOIN)

mysql> select E.emp_name,D.dept_name FROM employees E INNER JOIN departments D ON E.dept_id=D.dept_id;
+----------+-------------+
| emp_name | dept_name   |
+----------+-------------+
| Alice    | Engineering |
| Bob      | Engineering |
| Charlie  | Marketing   |
| Eve      | Sales       |
| Frank    | Marketing   |
+----------+-------------+
5 rows in set (0.00 sec)
Task 2: Show all employees and their departments. Also show employees without a department. (LEFT JOIN)

mysql> select E.emp_name,D.dept_name FROM employees E LEFT JOIN departments D ON E.dept_id=D.dept_id;
+----------+-------------+
| emp_name | dept_name   |
+----------+-------------+
| Alice    | Engineering |
| Bob      | Engineering |
| Charlie  | Marketing   |
| David    | NULL        |
| Eve      | Sales       |
| Frank    | Marketing   |
+----------+-------------+
6 rows in set (0.00 sec)
Task 3: Show all departments and employees. Include departments with no employees. (RIGHT JOIN)
SELECT D.dept_name,E.emp_name FROM departments D LEFT JOIN employees E ON D.dept_id=E.dept_id;
+-------------+----------+
| dept_name   | emp_name |
+-------------+----------+
| Engineering | Bob      |
| Engineering | Alice    |
| Marketing   | Frank    |
| Marketing   | Charlie  |
| Sales       | Eve      |
+-------------+----------+
5 rows in set (0.00 sec)

Task 4: Show all employees and departments, including unmatched ones from both sides. (FULL JOIN)
+---------+-------------+----------+----------+----------+---------+-------------+
| dept_id | dept_name   | emp_id   | emp_name | salary   | dept_id | manager_id  |
+---------+-------------+----------+----------+----------+---------+-------------+
|       1 | Engineering |   102.00 | Bob      | 60000.00 |       1 | 101         |
|       1 | Engineering |   101.00 | Alice    | 80000.00 |       1 | NULL        |
|       2 | Marketing   |   106.00 | Frank    | 30000.00 |       2 | 103         |
|       2 | Marketing   |   103.00 | Charlie  | 50000.00 |       2 | 101         |
|       3 | Sales       |   105.00 | Eve      | 75000.00 |       3 | 103         |
|     102 | Bob         | 60000.00 | 1        |   101.00 |       1 | Engineering |
|     101 | Alice       | 80000.00 | 1        |     NULL |       1 | Engineering |
|     106 | Frank       | 30000.00 | 2        |   103.00 |       2 | Marketing   |
|     103 | Charlie     | 50000.00 | 2        |   101.00 |       2 | Marketing   |
|     105 | Eve         | 75000.00 | 3        |   103.00 |       3 | Sales       |
+---------+-------------+----------+----------+----------+---------+-------------+
10 rows in set (0.00 sec)

Task 5: Display each employee and their manager's name. (SELF JOIN)

mysql> SELECT e1.emp_name,e2.emp_name AS manager_name
    -> FROM employees e1 JOIN employees e2 ON
    -> e2.emp_id=e1.manager_id;
+----------+--------------+
| emp_name | manager_name |
+----------+--------------+
| Bob      | Alice        |
| Charlie  | Alice        |
| Eve      | Charlie      |
| Frank    | Charlie      |
+----------+--------------+
4 rows in set (0.00 sec)

Task 6: Highest Paid Employee Per Department
 with dept_salaries AS(
    SELECT d.dept_name,e.emp_name,e.salary FROM departments d JOIN employees e ON d.dept_id=E.dept_id) SELECT dept_name,emp_name,max(salary) 
    FROM dept_salaries;

 +-------------+-------------+
| dept_name   | MAX(salary) |
+-------------+-------------+
| Engineering |    80000.00 |
| Marketing   |    50000.00 |
| Sales       |    75000.00 |
+-------------+-------------+


3 rows in set (0.00 sec)

mysql> select d.dept_name,e.emp_name,e.salary from employees e inner join departments d on e.dept_id=d.dept_id where e.salary=(select MAX(salary) from employees where dept_id=e.dept_id);
+-------------+----------+----------+
| dept_name   | emp_name | salary   |
+-------------+----------+----------+
| Engineering | Alice    | 80000.00 |
| Marketing   | Charlie  | 50000.00 |
| Sales       | Eve      | 75000.00 |
+-------------+----------+----------+
3 rows in set (0.00 sec)


Exercise 3: 

-- Create Departments Table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Create Employees Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT,
    manager_id INT
);

-- Create Projects Table
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    dept_id INT
);




-- Departments
INSERT INTO departments VALUES
(1, 'Engineering'),
(2, 'Marketing'),
(3, 'Sales'),
(4, 'HR');

-- Employees
INSERT INTO employees VALUES
(101, 'Alice', 80000, 1, NULL),
(102, 'Bob', 60000, 1, 101),
(103, 'Charlie', 50000, 2, 101),
(104, 'David', 40000, NULL, NULL),
(105, 'Eve', 75000, 3, 103),
(106, 'Frank', 30000, 2, 103);

-- Projects
INSERT INTO projects VALUES
(201, 'Website Revamp', 1),
(202, 'Ad Campaign', 2),
(203, 'Client Outreach', 3),
(204, 'Hiring Drive', 4),
(205, 'Data Migration', 1);




Task 5: Display each employee along with their manager’s name.

Task 6: List all projects with their department name and employees working in that department.

Task 7: List employees who do not belong to a department that has a project.

Task 8: Find all departments that are handling more than one project and display the department name with the number of projec

Task 9: Show the highest paid employee in each department along with the department’s project(s).

Task 10: List each employee, their manager, and the department both belong to.

Task 11: Create all possible combinations of employees and projects (even if unrelated).

Task 12: Department Summary Report

For each department, show:
- Department name
- Number of employees
- Number of projects
- Average salary
Task 5: Display each employee along with their manager’s name.

mysql> SELECT e1.emp_name,e2.emp_name AS manager_name FROM employees e1 JOIN employees e2 ON e2.emp_id=e1.manager_id;
+----------+--------------+
| emp_name | manager_name |
+----------+--------------+
| Bob      | Alice        |
| Charlie  | Alice        |
| Eve      | Charlie      |
| Frank    | Charlie      |
+----------+--------------+
4 rows in set (0.00 sec)

Task 6: List all projects with their department name and employees working in that department.
mysql> select p.project_name,d.dept_name,e.emp_name FROM projects p JOIN departments d ON p.dept_id=d.dept_id JOIN employees e ON d.dept_id=e.dept_id;
+-----------------+-------------+----------+
| project_name    | dept_name   | emp_name |
+-----------------+-------------+----------+
| Data Migration  | Engineering | Alice    |
| Website Revamp  | Engineering | Alice    |
| Data Migration  | Engineering | Bob      |
| Website Revamp  | Engineering | Bob      |
| Ad Campaign     | Marketing   | Charlie  |
| Client Outreach | Sales       | Eve      |
| Ad Campaign     | Marketing   | Frank    |
+-----------------+-------------+----------+
7 rows in set (0.00 sec)

Task 7: List employees who do not belong to a department that has a project.
??
mysql> select e.emp_name,d.dept_id,d.dept_name FROM employees e LEFT JOIN departments d on e.dept_id=d.dept_id where d.dept_id IS NULL;
+----------+---------+-----------+
| emp_name | dept_id | dept_name |
+----------+---------+-----------+
| David    |    NULL | NULL      |
+----------+---------+-----------+
1 row in set (0.00 sec)

Task 8: Find all departments that are handling more than one project and display the department name with the number of projec
mysql> SELECT d.dept_name, COUNT(p.project_id) AS num_projects FROM departments d JOIN projects p ON d.dept_id=p.dept_id GROUP BY d.dept_name;
+-------------+-----------------+
| dept_name   | num_projects |
+-------------+-----------------+
| Engineering |               2 |
| Marketing   |               1 |
| Sales       |               1 |
| HR          |               1 |
+-------------+-----------------+
4 rows in set (0.00 sec)
Task 9: Show the highest paid employee in each department along with the department’s project(s).
mysql> select d.dept_name,e.emp_name,e.salary,p.project_name from employees e inner join departments d on e.dept_id=d.dept_id JOIN projects p ON p.dept_id=d.dept_id where e.salary=(select MAX(salary) from employees where dept_id=e.dept_id);
+-------------+----------+----------+-----------------+
| dept_name   | emp_name | salary   | project_name    |
+-------------+----------+----------+-----------------+
| Engineering | Alice    | 80000.00 | Data Migration  |
| Engineering | Alice    | 80000.00 | Website Revamp  |
| Marketing   | Charlie  | 50000.00 | Ad Campaign     |
| Sales       | Eve      | 75000.00 | Client Outreach |
+-------------+----------+----------+-----------------+
4 rows in set (0.00 sec)

mysql>
Task 10: List each employee, their manager, and the department both belong to.
mysql>  SELECT e1.emp_name,e2.emp_name AS manager_name,d.dept_name FROM employees e1 JOIN employees e2 ON e2.emp_id=e1.manager_id JOIN departments D ON E2.dept_id=D.dept_id;
+----------+--------------+-------------+
| emp_name | manager_name | dept_name   |
+----------+--------------+-------------+
| Bob      | Alice        | Engineering |
| Charlie  | Alice        | Engineering |
| Eve      | Charlie      | Marketing   |
| Frank    | Charlie      | Marketing   |
+----------+--------------+-------------+
4 rows in set (0.00 sec)

mysql>  SELECT e1.emp_name,e2.emp_name AS manager_name,e1.dept_id,e2.dept_id,d.Dept_id,d.dept_name FROM employees e1 JOIN employees e2 ON e2.emp_id=e1.manager_id JOIN departments d ON e2.dept_id=d.dept_id;
+----------+--------------+---------+---------+---------+-------------+
| emp_name | manager_name | dept_id | dept_id | Dept_id | dept_name   |
+----------+--------------+---------+---------+---------+-------------+
| Bob      | Alice        |       1 |       1 |       1 | Engineering |
| Charlie  | Alice        |       2 |       1 |       1 | Engineering |
| Eve      | Charlie      |       3 |       2 |       2 | Marketing   |
| Frank    | Charlie      |       2 |       2 |       2 | Marketing   |
+----------+--------------+---------+---------+---------+-------------+

Task 11: Create all possible combinations of employees and projects (even if unrelated).
mysql> select * from employees E CROSS JOIN projects P ON E.dept_id=P.dept_id;
+--------+----------+----------+---------+------------+------------+-----------------+---------+
| emp_id | emp_name | salary   | dept_id | manager_id | project_id | project_name    | dept_id |
+--------+----------+----------+---------+------------+------------+-----------------+---------+
|    101 | Alice    | 80000.00 |       1 |       NULL |        205 | Data Migration  |       1 |
|    101 | Alice    | 80000.00 |       1 |       NULL |        201 | Website Revamp  |       1 |
|    102 | Bob      | 60000.00 |       1 |        101 |        205 | Data Migration  |       1 |
|    102 | Bob      | 60000.00 |       1 |        101 |        201 | Website Revamp  |       1 |
|    103 | Charlie  | 50000.00 |       2 |        101 |        202 | Ad Campaign     |       2 |
|    105 | Eve      | 75000.00 |       3 |        103 |        203 | Client Outreach |       3 |
|    106 | Frank    | 30000.00 |       2 |        103 |        202 | Ad Campaign     |       2 |
+--------+----------+----------+---------+------------+------------+-----------------+---------+
Task 12: Department Summary Report

For each department, show:
- Department name
- Number of employees
- Number of projects
- Average salary

mysql> SELECT D.dept_name,COUNT(E.emp_id) as Number_of_employees,COUNT(P.project_id) AS Number_of_projects,AVG(salary) as Avg_salary
    -> FROM departments D JOIN employees E ON D.dept_id=E.dept_id JOIN projects P ON D.dept_id=P.dept_id
    -> GROUP BY D.dept_name;
+-------------+---------------------+--------------------+--------------+
| dept_name   | Number_of_employees | Number_of_projects | Avg_salary   |
+-------------+---------------------+--------------------+--------------+
| Engineering |                   4 |                  4 | 70000.000000 |
| Marketing   |                   2 |                  2 | 40000.000000 |
| Sales       |                   1 |                  1 | 75000.000000 |
+-------------+---------------------+--------------------+--------------+
