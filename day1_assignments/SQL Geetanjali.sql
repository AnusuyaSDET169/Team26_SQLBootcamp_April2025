CREATE TABLE customers (
  customerID VARCHAR(50) PRIMARY KEY,
  companyName VARCHAR(100),
  contactName TEXT,
  contactTitle VARCHAR(100),
  city VARCHAR(40),
  country VARCHAR(40)
);

Select * from customers;

COPY customers(customerID, companyName, contactName,contactTitle,city,country)
FROM 'C:\SQL\customers.csv'
DELIMITER ','
CSV HEADER encoding 'windows-1251';

CREATE TABLE categories (
  categoryID INT PRIMARY KEY,
  categoryName VARCHAR(50),
  description TEXT
);

Select * from categories;

COPY categories(categoryID, categoryName,description)
FROM 'C:\SQL\categories.csv'
DELIMITER ','
CSV HEADER encoding 'windows-1251';


CREATE TABLE products (
  productID SERIAL PRIMARY KEY,
  productName VARCHAR(50),
  quantityPerUnit VARCHAR(50),
  unitPrice double precision,
  discontinued INT,
  categoryID INT NOT NULL,
  FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);

Select * from products;

COPY products(productID, productName, quantityPerUnit, unitPrice,discontinued,categoryID)
FROM 'C:\SQL\products.csv'
DELIMITER ','
CSV HEADER encoding 'windows-1251';

CREATE TABLE shippers (
  shipperID SERIAL PRIMARY KEY,
  companyName VARCHAR(50)
);

Select * from shippers;

COPY shippers(shipperID, companyName)
FROM 'C:\SQL\shippers.csv'
DELIMITER ','
CSV HEADER encoding 'windows-1251';

CREATE TABLE employees (
  employeeID SERIAL PRIMARY KEY,
  employeeName VARCHAR(100),
  title VARCHAR(50),
  city VARCHAR(50),
  country VARCHAR(50),
  reportsTo INT,
  FOREIGN KEY (reportsTo) REFERENCES employees(employeeID)
);

Select * from employees;

COPY employees(employeeID, employeeName, title, city, country, reportsTo)
FROM 'C:\SQL\employees.csv'
DELIMITER ','
CSV HEADER encoding 'windows-1251';


CREATE TABLE orders (
  orderID INT PRIMARY KEY,
  customerID VARCHAR(50) NOT NULL,
  employeeID INT NOT NULL,
  orderDate DATE,
  requiredDate DATE,
  shippedDate DATE,
  shipperID INT NOT NULL,
  freight double precision,
  FOREIGN KEY (customerID) REFERENCES customers(customerID),
  FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
  FOREIGN KEY (shipperID) REFERENCES shippers(shipperID)
);

Select * from orders;

COPY orders(orderID, customerID, employeeID, orderDate, requiredDate, shippedDate, shipperID, freight)
FROM 'C:\SQL\orders.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE order_details (
  orderID INT NOT NULL,
  productID INT NOT NULL,
  unitPrice double precision,
  quantity INT,
  discount double precision,
  PRIMARY KEY (orderID, productID),
  FOREIGN KEY (orderID) REFERENCES orders(orderID),
  FOREIGN KEY (productID) REFERENCES products(productID)
);

Select * from order_details;

COPY order_details(orderID, productID, unitPrice, quantity, discount)
FROM "C:\SQL\order_details.csv'
DELIMITER ','
CSV HEADER encoding 'windows-1251';





 