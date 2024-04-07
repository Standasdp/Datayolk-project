-- Dataset

-- Vehicle Table
CREATE TABLE Vehicle (
    VehicleID INTEGER PRIMARY KEY,
    ModelName TEXT,
    VehicleType TEXT,
    Price REAL,
    FuelType TEXT
);

-- Salesperson Table
CREATE TABLE Salesperson (
    SalespersonID INTEGER PRIMARY KEY,
    FirstName TEXT,
    LastName TEXT
);

-- Sales Transaction Table
CREATE TABLE SalesTransaction (
    TransactionID INTEGER PRIMARY KEY,
    VehicleID INTEGER,
    SalespersonID INTEGER,
    SaleDate DATE,
    FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID),
    FOREIGN KEY (SalespersonID) REFERENCES Salesperson(SalespersonID)
);

-- Data for Vehicle Table
INSERT INTO Vehicle (ModelName, VehicleType, Price, FuelType) VALUES
('Sedan A', 'Sedan', 1200000, 'Petrol'),
('SUV X', 'SUV', 1500000, 'Electric'),
('Hatchback B', 'Hatchback', 800000, 'Petrol'),
('Sedan C', 'Sedan', 900000, 'Electric'),
('Truck Y', 'Truck', 2000000, 'Diesel'),
('SUV A', 'SUV', 1700000, 'Electric'),
('SUV Y', 'SUV', 1800000, 'Electric'),
('SUV Z', 'SUV', 1700000, 'Electric'),
('Hatchback C', 'Hatchback', 2100000, 'Petrol'),
('Sedan X', 'Sedan', 1500000, 'Petrol'),
('SUV B', 'SUV', 1300000, 'Electric');

-- Data for Salesperson Table
INSERT INTO Salesperson (FirstName, LastName) VALUES
('John', 'Doe'),
('Jane', 'Smith'),
('Bob', 'Johnson');

-- Data for Sales Transaction Table
INSERT INTO SalesTransaction (VehicleID, SalespersonID, SaleDate) VALUES
(1, 1, '2023-03-01'),
(2, 2, '2023-03-02'),
(3, 1, '2023-03-03'),
(4, 3, '2023-03-03'),
(5, 2, '2023-03-04'),
(6, 2, '2023-03-04'),
(7, 2, '2024-03-04'),
(8, 3, '2024-03-04'),
(9, 3, '2024-03-04'),
(10, 2, '2024-03-04'),
(11, 1, '2024-03-04'),
(12, 2, '2024-03-04');


____________________________________________________________________________________

-- Check Dataset
SELECT * From Vehicle;
SELECT * FROM Salesperson;
SELECT * From SalesTransaction;


-- Started Challenge !!!

-- Q1: Shows the types of cars that can be sold. From the most sold to the least.
SELECT VehicleType, count(TransactionID) As TotalSales
FROM Vehicle v
JOIN SalesTransaction st ON v.VehicleID = st.VehicleID
GROUP BY VehicleType
ORDER BY TotalSales DESC;


-- Q2: Show the salesperson (First and last name) who sold the most cars and how many cars they sold
SELECT s.FirstName, s.LastName, count(st.TransactionID) AS TotalTransactions
FROM Salesperson s
JOIN SalesTransaction st ON s.SalespersonID = st.SalespersonID
GROUP BY s.SalespersonID
ORDER BY TotalTransactions DESC;


-- Q3: Calculate the total sales of each salesperson.
SELECT s.FirstName, s.LastName, SUM(v.Price) AS TotalRevenue
FROM SalesTransaction st
JOIN Vehicle v ON st.VehicleID = v.VehicleID
JOIN Salesperson s ON st.SalespersonID = s.SalespersonID
GROUP BY s.SalespersonID
ORDER BY TotalRevenue DESC;


-- Q4: In 2023, between electric cars (Electric) or fuel-powered cars (Petrol), which is more popular?
SELECT v.FuelType , COUNT(st.TransactionID) AS TotalSales
FROM SalesTransaction st
JOIN Vehicle v ON st.VehicleID = v.VehicleID
WHERE strftime('%Y', st.SaleDate) = '2023' AND v.FuelType IN ('Electric', 'Petrol')
GROUP BY v.FuelType;


-- Q5: The team leader wants to categorize each car model. With the condition that If the price is equal to or more than 1 million, 
-- it is classified as a Flagship Model. But if the price is lower than that, it is classified as a Normal Model.
SELECT ModelName,
  CASE
    WHEN Price >= 1000000 THEN 'Flagship Model'
    ELSE 'Normal Model'
  END AS ModelLabel
FROM Vehicle
GROUP BY ModelName
ORDER BY ModelName ASC;



-- Thank you Datayolk Facebook page🙏
-- Run on DB Browser for SQLite

















