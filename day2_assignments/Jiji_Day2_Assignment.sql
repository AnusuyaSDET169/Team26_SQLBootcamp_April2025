--1.Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.
ALTER TABLE employees 
ADD linkedin_profile VARCHAR

--2.Change the linkedin_profile column data type from VARCHAR to TEXT.
ALTER TABLE employees
ALTER COLUMN linkedin_profile
SET DATA TYPE TEXT

--3. Add unique, not null constraint to linkedin_profile
ALTER TABLE employees
ADD CONSTRAINT linkedin_profile_uni_name UNIQUE (linkedin_profile)

UPDATE employees
SET linkedin_profile = 'https://www.linkedin.com/in/'|| employeename 
WHERE linkedin_profile IS NULL

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL

--4.Drop column linkedin_profile
ALTER TABLE employees
DROP COLUMN linkedin_profile

--5. Retrieve the employee name and title of all employees
SELECT employeename, title 
FROM employees

--6.Find all unique unit prices of products
SELECT DISTINCT unitprice
FROM products

--7. List all customers sorted by company name in ascending order
SELECT customerid, companyname
FROM customers
ORDER BY companyname 

--8.Display product name and unit price, but rename the unit_price column as price_in_usd
SELECT productname, unitprice AS price_in_usd
FROM products

--9.Get all customers from Germany.
SELECT customerid, country
FROM customers
WHERE country = 'Germany'

--10.Find all customers from France or Spain
SELECT customerid, country
FROM customers
WHERE country = 'France' OR
country = 'Spain'

--11.Retrieve all orders placed in 2014(based on order_date), and either have freight greater than 50 or the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))
SELECT orderid, orderdate, freight, shippeddate
FROM orders
WHERE EXTRACT (YEAR FROM orderdate) = 2014 AND
(freight > 50 OR shippeddate IS NOT NULL)

--12.Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
SELECT productid, productname, unitprice
FROM products
WHERE unitprice > 15

--13.List all employees who are located in the USA and have the title "Sales Representative".
SELECT employeename, title, country
FROM employees
WHERE country = 'USA' AND
title = 'Sales Representative'

--14.Retrieve all products that are not discontinued and priced greater than 30.
SELECT productname, unitprice, discontinued
FROM products
WHERE discontinued = 0 AND
unitprice > 30

--15. Retrieve the first 10 orders from the orders table.
SELECT * FROM orders
LIMIT 10

--16.Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).
SELECT * FROM orders
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY

--17.List all customers who are either Sales Representative, Owner
SELECT customerid, contacttitle
FROM customers
WHERE contacttitle IN ('Sales Representative', 'Owner')

--18.Retrieve orders placed between January 1, 2013, and December 31, 2013.
SELECT orderid, orderdate
FROM orders
WHERE orderdate BETWEEN '2013-01-01' AND '2013-12-31'

--19.List all products whose category_id is not 1, 2, or 3.
SELECT productname, categoryid
FROM products
WHERE categoryid NOT IN (1, 2, 3)

--20.Find customers whose company name starts with "A".
SELECT customerid, companyname
FROM customers
WHERE companyname LIKE 'A%'