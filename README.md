# 📚 Online Bookstore Database (MySQL)

A complete **MySQL-based database project** for an **Online Bookstore**, covering database design, CSV data import, and beginner-to-advanced SQL queries for analysis and reporting.

---

## 📌 Project Overview

This project demonstrates how to:
- Design a relational database in **MySQL**
- Import CSV data into tables
- Apply **constraints & relationships**
- Write **basic and advanced SQL queries**
- Perform **sales, customer, and inventory analysis**

---

## 🛠️ Tech Stack

- **Database:** MySQL 8+
- **Query Language:** SQL
- **Data Source:** CSV files
- **Tool:** MySQL Workbench / MySQL CLI

---

## 📂 Project Structure


OnlineBookstore/
│

├── Books.csv
├── Customers.csv
── Orders.csv
│
├── OnlineBookstore.sql # Complete MySQL script
└── README.md


---

## 🗄️ Database Schema

### 1️⃣ Books
| Column | Type |
|------|-----|
| Book_ID | INT (PK, AUTO_INCREMENT) |
| Title | VARCHAR |
| Author | VARCHAR |
| Genre | VARCHAR |
| Published_Year | INT |
| Price | DECIMAL |
| Stock | INT |

---

### 2️⃣ Customers
| Column | Type |
|------|-----|
| Customer_ID | INT (PK, AUTO_INCREMENT) |
| Name | VARCHAR |
| Email | VARCHAR |
| Phone | VARCHAR |
| City | VARCHAR |
| Country | VARCHAR |

---

### 3️⃣ Orders
| Column | Type |
|------|-----|
| Order_ID | INT (PK, AUTO_INCREMENT) |
| Customer_ID | INT (FK) |
| Book_ID | INT (FK) |
| Order_Date | DATE |
| Quantity | INT |
| Total_Amount | DECIMAL |

---

## 🔗 Relationships

- **Customers → Orders** (One-to-Many)
- **Books → Orders** (One-to-Many)

---

## 📥 Data Import (CSV)

All CSV files are placed inside:

Data is imported using:
```sql
LOAD DATA LOCAL INFILE

📊 SQL Queries Included
✅ Basic Queries

Fiction books

Books published after 1950

Customers from Canada

Orders in November 2023

Total stock

Most expensive book

Total revenue

🚀 Advanced Queries

Total books sold per genre

Average price by genre

Customers with multiple orders

Most frequently ordered book

Top 3 expensive Fantasy books

Books sold per author

Cities with high-spending customers

Customer with highest spending

Remaining stock after orders

▶️ How to Run

Open MySQL Workbench

Run the full SQL file:

OnlineBookstore.sql


Ensure CSV files are in:

Desktop/sql/


▶️ Verify imported data:

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

