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





