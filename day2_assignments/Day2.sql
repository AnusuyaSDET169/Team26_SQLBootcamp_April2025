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


select* from customers;
select * from customers where companyname like 'A%';
select * from customers where country='Germany';

select * from customers where country IN ('France' , 'Spain');
select * from customers order by companyName asc;

select * from customers where contacttitle in ('Sales Representative','Owner');


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

insert into orders (orderid,customerid,employeeid,orderdate,requireddate,shippeddate,shipperid,freight)
values (11078,'ALFKI',5,'2025-04-23','2025-04-30','2025-04-25',2,45.50);

Select *  from Orders where orderid='11078';

ALTER TABLE orders DROP CONSTRAINT IF EXISTS chk_dates;
Drop table Orders;
select * from orders  order by orderid limit 10;
select * from orders order by orderid offset 10 fetch next 10 rows only;
select * from orders where EXTRACT(YEAR FROM orderdate) ='2014' and 
(freight>50 or shippeddate is NOT NULL );

select * from orders where orderdate between '2013-01-1' and '2013-12-31';

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

select * from employees where country ='USA' and title='Sales Representative';

Alter table employees
add column linkedinprofile varchar;

Alter table employees
alter column linkedinprofile type TEXT;

UPDATE employees SET linkedinprofile = 'personalCareers' WHERE linkedinprofile is NULL;
select * from employees;

Alter Table employees 
alter column linkedinprofile SET NOT NULL;

ALTER TABLE employees
ADD CONSTRAINT unique_linkedinprofile UNIQUE (linkedinprofile); 

Alter table employees
drop column linkedinprofile  ;
select * from employees;


select
  split_part(employeename, ' ', 1) AS first_name,
  split_part(employeename, ' ', 2) AS last_name,
  title
from employees;


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

select * from products where categoryid NOT in ('1','2','3');
select * from products where discontinued=0 and unitprice> 30;
select productname,unitprice AS price_in_usd from products;

select distinct unitprice from products;

select productid,productname,unitprice from products where unitprice > 15;

update products set unitprice =unitprice * 1.10 where categoryid= 2;
select * from products where categoryid=2;







