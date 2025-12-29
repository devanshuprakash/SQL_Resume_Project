/* ===============================
   DATABASE
================================ */
CREATE DATABASE IF NOT EXISTS OnlineBookstore;
USE OnlineBookstore;


/* ===============================
   DROP TABLES (FK SAFE ORDER)
================================ */
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Books;


/* ===============================
   CREATE TABLES
================================ */

CREATE TABLE Books (
    Book_ID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price DECIMAL(10,2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT,
    Book_ID INT,
    Order_Date DATE,
    Quantity INT,
    Total_Amount DECIMAL(10,2),
    CONSTRAINT fk_customer
        FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    CONSTRAINT fk_book
        FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);


/* ===============================
   VIEW EMPTY TABLES
================================ */
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


/* ===============================
   ENABLE CSV IMPORT
================================ */
SET GLOBAL local_infile = 1;


/* ===============================
   IMPORT CSV DATA
================================ */

LOAD DATA LOCAL INFILE 'D:/Desktop/sql/Books.csv'
INTO TABLE Books
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Book_ID, Title, Author, Genre, Published_Year, Price, Stock);

LOAD DATA LOCAL INFILE 'D:/Desktop/sql/Customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Customer_ID, Name, Email, Phone, City, Country);

LOAD DATA LOCAL INFILE 'D:/Desktop/sql/Orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount);


/* ===============================
   BASIC QUERIES
================================ */

-- 1) Fiction books
SELECT * FROM Books WHERE Genre = 'Fiction';

-- 2) Books published after 1950
SELECT * FROM Books WHERE Published_Year > 1950;

-- 3) Customers from Canada
SELECT * FROM Customers WHERE Country = 'Canada';

-- 4) Orders in Nov 2023
SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Total stock
SELECT SUM(Stock) AS Total_Stock FROM Books;

-- 6) Most expensive book
SELECT * FROM Books ORDER BY Price DESC LIMIT 1;

-- 7) Orders with quantity > 1
SELECT * FROM Orders WHERE Quantity > 1;

-- 8) Orders where total amount > 20
SELECT * FROM Orders WHERE Total_Amount > 20;

-- 9) All genres
SELECT DISTINCT Genre FROM Books;

-- 10) Lowest stock book
SELECT * FROM Books ORDER BY Stock ASC LIMIT 1;

-- 11) Total revenue
SELECT SUM(Total_Amount) AS Revenue FROM Orders;


/* ===============================
   ADVANCED QUERIES
================================ */

-- 1) Total books sold per genre
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Genre;

-- 2) Average price of Fantasy books
SELECT AVG(Price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

-- 3) Customers with at least 2 orders
SELECT c.Customer_ID, c.Name, COUNT(o.Order_ID) AS Order_Count
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2;

-- 4) Most frequently ordered book
SELECT b.Book_ID, b.Title, COUNT(o.Order_ID) AS Order_Count
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY Order_Count DESC
LIMIT 1;

-- 5) Top 3 expensive Fantasy books
SELECT * FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

-- 6) Total books sold by each author
SELECT b.Author, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Author;

-- 7) Cities where customers spent over $30
SELECT DISTINCT c.City
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
WHERE o.Total_Amount > 30;

-- 8) Customer who spent the most
SELECT c.Customer_ID, c.Name, SUM(o.Total_Amount) AS Total_Spent
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Spent DESC
LIMIT 1;

-- 9) Stock remaining after orders
SELECT 
    b.Book_ID,
    b.Title,
    b.Stock,
    COALESCE(SUM(o.Quantity), 0) AS Order_Quantity,
    b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining_Quantity
FROM Books b
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock
ORDER BY b.Book_ID;
