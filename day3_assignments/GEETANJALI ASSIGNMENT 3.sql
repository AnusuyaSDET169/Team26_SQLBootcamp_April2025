--1.Update the categoryName From “Beverages” to "Drinks" in the categories table.

UPDATE categories
SET categoryName = 'Drinks'
WHERE categoryName = 'Beverages'

SELECT categoryName FROM categories

--2.Insert into shipper new record (give any values) Delete that new record from shippers table.

INSERT INTO shippers(shipperid, companyname)
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


Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.

DELETE FROM categories
WHERE categoryid =3;

SELECT * FROM categories;
WHERE categoryid = 3

SELECT * FROM products;
WHERE categoryid = 3



4)Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null
(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)

select * from customers;
select * from orders;

ALTER TABLE orders
    ADD CONSTRAINT fk_cust FOREIGN KEY (customerid) REFERENCES customers (customerid);
	
ALTER TABLE orders
ALTER COLUMN customerID DROP NOT NULL;	

ALTER TABLE orders
DROP CONSTRAINT IF EXISTS fk_cust;

ALTER TABLE orders
ADD CONSTRAINT fk_cust
FOREIGN KEY (customerid)
REFERENCES customers(customerid)
ON DELETE SET NULL;


DELETE FROM customers
WHERE customerid ='VINET';

select * from orders
WHERE customerid ='VINET';

 
5)Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
(this should update the quantityperunit for product_id = 100)


INSERT INTO products
(productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (100, 'Wheat bread', '1 boxes', 13, 0, 5),
(101, 'Wheat bread', '5 boxes', 13, 0, 5),(100, 'Wheat bread', '10 boxes', 13, 0, 5)
 ON CONFLICT (productid)
 DO UPDATE
 SET productname = Excluded.productname,
     quantityperunit = Excluded.quantityperunit,
     unitprice = Excluded.unitprice,
	 discontinued = Excluded.discontinued,
	 categoryid = Excluded.categoryid;

SELECT * FROM products
      WHERE productid IN (100, 101)

6)Write a MERGE query:
Create temp table with name:  ‘updated_products’ and insert values as below:
 
productID  productName   quantityPerUnit            unitPrice     discontinued   categoryID
  100      Wheat breaD          10                    20             1               5
  101        White bread        5 boxes               19.99          0               5
  102     Midnight Mango Fizz   24-12ozbottles        19             0               1
  103      Savory Fire Sauce    12-550mlbottles       10             0               2
Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 
If there are matching products and updated_products .discontinued =1 then delete 
Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.

CREATE TEMP TABLE updated_products
   (productID INT, productName VARCHAR(25), quantityPerUnit VARCHAR(25), unitprice       NUMERIC,
   discontinued SMALLINT, categoryID INT)

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
VALUES (u.productid, u.productName, u.quantityPerUNIT, u.unitPrice, u.discontinued,   u.categoryID)
WHEN MATCHED AND u.discontinued = 0
THEN UPDATE SET
unitPrice = u.unitPrice,
discontinued = u.discontinued

--Q7...List all orders with employee full names. (Inner join)  USED THE OTHER DATABASE 
SELECT o.order_id, e.first_name ||' '|| e.last_name AS full_name
     FROM orders o 
     INNER JOIN employees e 
      ON o.employee_id = e.employee_id
