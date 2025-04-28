--1)Alter Table:
-- Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.
--Change the linkedin_profile column data type from VARCHAR to TEXT.
 --Add unique, not null constraint to linkedin_profile
--Drop column linkedin_profile

CREATE TABLE Employees1 (
    Employee_id INT PRIMARY KEY,
    Employee_Name VARCHAR(50) NOT NULL,
    Email_id VARCHAR(100)
);

ALTER TABLE Employees1
ADD COLUMN Linked_in_Profile VARCHAR(300),
ADD COLUMN Linked_in_URLs VARCHAR(300);

ALTER TABLE Employees1
ALTER COLUMN Linked_in_Profile TYPE TEXT;

ALTER TABLE Employees1
ADD UNIQUE (Linked_in_Profile);

ALTER TABLE Employees1
ADD COLUMN Title VARCHAR(300);

ALTER TABLE Employees1
DROP COLUMN Linked_in_Profile;

--2)      Querying (Select)
-- Retrieve the employee name and title of all employees
 --Find all unique unit prices of products
 --List all customers sorted by company name in ascending order
 --Display product name and unit price, but rename the unit_price column as price_in_usd


SELECT split_part(Employee_Name,' ',1)AS first_name,
   split_part(Employee_Name,' ',2)AS last_name,
   title
   FROM employees1

SELECT distinct unitprice FROM products

 SELECT contact_name,company_name
   FROM customers
   ORDER BY company_name

    SELECT product_name,unitprice AS price_in_usd
   FROM products

   
--3)      Filtering
--Get all customers from Germany.
--Find all customers from France or Spain
--Retrieve all orders placed in 1997 (based on order_date), and either have freight greater than 50 or the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))
--select * from orders

 SELECT contact_name,country
   FROM customers
   WHERE country = 'Germany'

   
 SELECT contact_name,country
   FROM customers
   WHERE country IN ('France', 'Spain')

    SELECT * FROM orders
   WHERE EXTRACT(YEAR FROM order_date)=1997 AND freight >50;

--4)      Filtering
 --Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
--List all employees who are located in the USA and have the title "Sales Representative".
--Retrieve all products that are not discontinued and priced greater than 30.


SELECT * FROM products
 SELECT  product_id, product_name,unitprice
   FROM products
   WHERE unitprice >15;

   
 SELECT employee_name,title,country
   FROM employees
   WHERE title = 'Sales Representative' AND country='USA'
 SELECT  product_id,product_name,discontinued,unitprice

 
   FROM products
   WHERE discontinued=0 AND unitprice > 30

--5)      LIMIT/FETCH
-- Retrieve the first 10 orders from the orders table.
-- Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).


SELECT * FROM orders
 SELECT order_id,customer_id
   FROM orders
   limit 10
 SELECT order_id,customer_id
   FROM orders
   limit 10
   OFFSET 10

--6)      Filtering (IN, BETWEEN)
--List all customers who are either Sales Representative, Owner
--Retrieve orders placed between January 1, 2013, and December 31, 2013.


select * from orders
 SELECT contact_name,contact_title
   FROM customers
   WHERE contact_title IN ('Sales Representative', 'Owner')


SELECT * FROM orders
   WHERE order_date BETWEEN '2013-01-01' AND '2013-12-31';
   
--7)      Filtering
--List all products whose category_id is not 1, 2, or 3.
--Find customers whose company name starts with "A".


select * from customers
 SELECT * FROM products
   WHERE category_id NOT IN (1,2,3);


SELECT customer_id,contact_name,company_name
   FROM customers
   WHERE company_name LIKE 'A%';

--8)       INSERT into orders table:
-- Task: Add a new order to the orders table with the following details:

Order ID: 11078
Customer ID: ALFKI
Employee ID: 5
Order Date: 2025-04-23
Required Date: 2025-04-30
Shipped Date: 2025-04-25
shipperID:2
Freight: 45.50


select * from products  order by product_id

INSERT INTO orders(order_id,customer_id,employee_id,order_date,required_date,shipped_date,shipper_id,freight)
   VALUES(11078,'ALFKI',5,'2025-04-23','2025-04-30','2025-04-25',2,45.50);

--9)      Increase(Update)  the unit price of all products in category_id =2 by 10%.
--(HINT: unit_price =unit_price * 1.10)


UPDATE products
   SET unitprice =unitprice * 1.10
   WHERE category_id=2;

   
