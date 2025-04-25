--1.Update the categoryName From “Beverages” to "Drinks" in the categories table.

UPDATE categories
SET categoryName = 'Drinks'
WHERE categoryName = 'Beverages'

SELECT categoryName FROM categories

--2.Insert into shipper new record (give any values) Delete that new record from shippers table.
INSERT INTO shippers
(shipperid, companyname)
VALUES (4, 'International Shipping')

SELECT * FROM shippers

DELETE FROM shippers
WHERE shipperid = 4

--3.Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
ALTER TABLE products
DROP CONSTRAINT IF EXISTS products_categoryid_fkey

ALTER TABLE products
ADD CONSTRAINT products_categoryid_fkey
FOREIGN KEY (categoryid)
REFERENCES categories (categoryid)
ON UPDATE CASCADE
ON DELETE CASCADE

UPDATE categories
SET categoryid = 1001
WHERE categoryid = 1

SELECT * FROM products
WHERE categoryid = 1001

SELECT * FROM categories
WHERE categoryid = 1001

--Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
ALTER TABLE order_details
DROP CONSTRAINT IF EXISTS order_details_productid_fkey

ALTER TABLE order_details
ADD CONSTRAINT order_details_productid_fkey
FOREIGN KEY (productid)
REFERENCES products (productid)
ON UPDATE CASCADE
ON DELETE CASCADE

DELETE FROM categories
WHERE categoryID = 3

SELECT * FROM categories
WHERE categoryid = 3

SELECT * FROM products
WHERE categoryid = 3
 
--4. Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null
ALTER TABLE orders
DROP CONSTRAINT IF EXISTS orders_customerid_fkey

ALTER TABLE orders
ADD CONSTRAINT orders_customerid_fkey
FOREIGN KEY (customerid)
REFERENCES customers (customerid)
ON DELETE SET NULL
--Remove NOT NULL constraint from the customerid column in the orders table
ALTER TABLE orders 
ALTER COLUMN customerid DROP NOT NULL

DELETE FROM customers
WHERE customerid = 'VINET'

SELECT * FROM customers
WHERE customerid = 'VINET'

SELECT * FROM orders
WHERE customerid = 'VINET'

--5.Insert the following data to Products using UPSERT:

INSERT INTO products
(productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (100, 'Wheat bread', '1 boxes', 13, 0, 5),
       (101, 'Wheat bread', '5 boxes', 13, 0, 5),
	   (100, 'Wheat bread', '10 boxes', 13, 0, 5)
ON CONFLICT (productid)
DO UPDATE
SET productname = Excluded.productname,
    quantityperunit = Excluded.quantityperunit,
	unitprice = Excluded.unitprice,
	discontinued = Excluded.discontinued,
	categoryid = Excluded.categoryid
	
--Write a MERGE query:
--Create temp table
CREATE TEMP TABLE updated_products
(productID INT, productName VARCHAR(25), quantityPerUnit VARCHAR(25), unitprice NUMERIC,
discontinued SMALLINT, categoryID INT)
Drop table updated_products
INSERT INTO updated_products
VALUES 
	(100, 'Wheat bread', '10', 20, 1, 5),
	(101, 'Wheat bread', '5 boxes', 19.99, 0, 5),
	(102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1),
	(103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2)

SELECT * FROM updated_products

MERGE INTO products p 
USING updated_products AS u
ON p.productid = u.productid
WHEN MATCHED AND u.discontinued = 1
THEN DELETE
WHEN NOT MATCHED AND u.discontinued = 0
THEN INSERT (productid, productName, quantityPerUNIT, unitPrice, discontinued, categoryID)
VALUES (u.productid, u.productName, u.quantityPerUNIT, u.unitPrice, u.discontinued, u.categoryID)
WHEN MATCHED AND u.discontinued = 0
THEN UPDATE SET
unitPrice = u.unitPrice,
discontinued = u.discontinued

SELECT * FROM products
WHERE productid IN (100, 101, 102, 103)

--7.List all orders with employee full names. (Inner join)

SELECT o.order_id, e.first_name ||' '|| e.last_name AS full_name
FROM orders o 
INNER JOIN employees e 
ON o.employee_id = e.employee_id


