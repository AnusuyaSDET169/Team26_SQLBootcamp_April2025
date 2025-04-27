1. Add a new column linkedin_profile to employees table as VARCHAR
ALTER TABLE employees
ADD COLUMN linkedin_profile VARCHAR(255);

-- 2. Change the data type from VARCHAR to TEXT
ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE TEXT;

select *from employees

-- 3. Add UNIQUE and NOT NULL constraints
UPDATE employees
SET linkedin_profile = ' '
WHERE linkedin_profile IS NULL;

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL;


-- 4. Drop the linkedin_profile column
ALTER TABLE employees
DROP COLUMN linkedin_profile;

 Q2: Querying (Select) */
---1.  Retrieve the employee name and title of all employees
SELECT employeeID, employeeName, title FROM employees;

---2. Find all unique unit prices of products
SELECT DISTINCT unitprice
FROM products;

--3. List all customers sorted by company name in ascending order
SELECT contactName FROM customers 
ORDER BY companyName ASC;


--4. Display product name and unit price, but rename the unit_price column as price_in_usd
SELECT productname, unitprice AS price_in_usd
FROM products;

 Q3: Filtering */
--1. Get all customers from Germany
SELECT *
FROM customers
WHERE country = 'Germany';

--2. Find all customers from France or Spain
SELECT *
FROM customers
WHERE country IN ('France', 'Spain');

--3.Retrieve all orders placed in 2014(based on order_date), and either have freight greater than 50 or 
the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))
SELECT *
FROM orders
WHERE EXTRACT(YEAR FROM orderDate) = 2014
AND (freight > 50 OR shippedDate IS NOT NULL);

  
 Q4: Filtering */
  --1. Retrieve product_id, product_name, and unit_price of products where unit_price > 15
SELECT productid, productname, unitprice
FROM products
WHERE unitprice > 15;

--2.List all employees located in the USA with the title "Sales Representative"
SELECT *
FROM employees
WHERE country = 'USA'
  AND title = 'Sales Representative';
  
-- 3.Retrieve all products that are NOT discontinued AND priced greater than 30
 SELECT *
FROM products
WHERE discontinued = 0
  AND unitprice > 30;
  
 Q5: LIMIT/FETCH */
---1. Retrieve the first 10 orders
  SELECT *
FROM orders
LIMIT 10;

-- 2. Retrieve orders 11 to 20 (i.e., skip the first 10, then fetch 10)
--OFFSET 10 skips the first 10 rows, and LIMIT 10 fetches the next 10 → gives you rows 11 to 20.
SELECT *
FROM orders
OFFSET 10
LIMIT 10;


 Q6:  Filtering (IN, BETWEEN) */
--1. List all customers who are either Sales Representative or Owner
SELECT *
FROM customers
WHERE contacttitle IN ('Sales Representative', 'Owner');

-- 2. Retrieve orders placed between January 1, 2013 and December 31, 2013
SELECT *
FROM orders
WHERE orderdate BETWEEN '2013-01-01' AND '2013-12-31';

 Q7:  Filtering */
---1. List all products whose category_id is NOT 1, 2, or 3
SELECT *
FROM products
WHERE categoryid NOT IN (1, 2, 3);

--- 2. Find customers whose company name starts with "A"
---% is a wildcard — so 'A%' matches anything starting with A
SELECT *
FROM customers
WHERE companyname LIKE 'A%';

 Q8:  INSERT into orders table: */
---1. INSERT New Order into orders Table
INSERT INTO orders (
  orderid,
  customerid,
  employeeid,
  orderdate,
  requireddate,
  shippeddate,
  shipperid,
  freight
)
VALUES (
  11078,
  'ALFKI',
  5,
  '2025-04-23',
  '2025-04-30',
  '2025-04-25',
  2,
  45.50
);

 Q9:Increase(Update)  the unit price of all products in category_id =2 by 10%.
 (HINT: unit_price =unit_price * 1.10)
UPDATE products
SET unitPrice = unitPrice * 1.10
WHERE categoryID = 2;

10) Sample Northwind database:
Download
 Download northwind.sql from below link into your local. Sign in to Git first https://github.com/pthom/northwind_psql
 Manually Create the database using pgAdmin:
 Right-click on "Databases" → Create → Database
Give name as ‘northwind’ (all small letters)
Click ‘Save’

Import database:
 Open pgAdmin and connect to your server          	
  Select the database  ‘northwind’
  Right Click-> Query tool.
  Click the folder icon to open your northwind.sql file
 Press F5 or click the Execute button.
  You will see total 14 tables loaded
  Databases → your database → Schemas → public → Tables


