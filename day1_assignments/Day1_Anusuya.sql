create Table categories(
categoryID SERIAL Primary KEY,
categoryName varchar(100) NOT NULL,
description varchar(200) NOT NULL
); 

select * from customers;
select* from categories;
Select *  from Orders;
select * from orderDetails;
select * from shippers;
select * from employees;
select * from products;

create Table customers (
customerID Text Primary KEY,
companyName varchar(200) NOT NUll Unique,
contactName varchar(250) NOT NULL Unique,
contactTitle varchar(200) NOT NULL,
city varchar(200) NOT NULL,
country varchar(200) NOT NULL);

CREATE SEQUENCE order_id_seq START 10248;
CREATE TABLE Orders (
    orderID INT PRIMARY KEY DEFAULT nextval('order_id_seq'),
    customerID TEXT REFERENCES customers(customerID),
    employeeID INT REFERENCES employees(employeeID),
    orderDate DATE,
    requiredDate DATE,
    shippedDate DATE,
    shipperID INT REFERENCES shippers(shipperID), 
    freight NUMERIC(10, 2),
    CONSTRAINT chk_dates CHECK (
        orderDate < requiredDate AND
        (shippedDate IS NULL OR shippedDate >= requiredDate))
);

ALTER TABLE orders DROP CONSTRAINT IF EXISTS chk_dates;
Drop table Orders;
Select *  from Orders;
--ALTER TABLE orders ADD CONSTRAINT chk_dates
--CHECK (
--    orderDate < requiredDate AND
 --   (shippedDate IS NULL OR shippedDate >= orderDate)
--);


Create Table orderDetails(
orderID INT references orders(orderID),
productID INT references products(ProductID),
unitPrice DECIMAL(10,2) NOT NULL,
quantity INT NOT NULL check (quantity >=1),
discount DECIMAL(3, 2) DEFAULT 0 CHECK (discount >= 0 AND discount <= 1),
   
   PRIMARY KEY (orderID, productID) -- composite primary key
);

drop table orderDetails;
select * from orderDetails;


CREATE TABLE shippers (
    shipperID SERIAL PRIMARY KEY,
    companyName VARCHAR(250)
    
 --   CONSTRAINT fk_shipper_company FOREIGN KEY (companyName)
  --      REFERENCES customers(companyName)
);
select * from shippers;
drop table shippers;


CREATE TABLE employees (
    employeeID SERIAL PRIMARY KEY,
    employeeName VARCHAR(200) UNIQUE,
    title VARCHAR(200) CHECK (
        title IN ('Vice President Sales', 'Sales Representative', 'Sales Manager')
    ),
    city VARCHAR(200) CHECK (
        city IN ('New York', 'London')
    ),
    country VARCHAR(200) CHECK (
        country IN ('USA', 'UK')
    ),
    reportsTo INT REFERENCES employees(employeeID)
);

select * from employees;


Create table products (
ProductID  SERIAL Primary Key,
ProductName Varchar(250) NOT NULL,
quantityPerUnit varchar(250) NOT NULL,
unitPrice NUMERIC(10, 2),
discontinued INT check (discontinued in (0,1)),
categoryID INT,

CONSTRAINT fk_categoryID FOREIGN KEY (categoryID)
       REFERENCES categories(categoryID)

);

select * from products;







