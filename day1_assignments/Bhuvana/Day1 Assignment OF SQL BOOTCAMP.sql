CREATE TABLE "mytable" (
  "Day1 Assignment OF SQLBOOTCAMP:" text
);

INSERT INTO "mytable" ("Day1 Assignment OF SQLBOOTCAMP:")
VALUES
('--DAY 1 ASSIGNMENT OF SQLBOOTCAMP'),
('--To create employees table'),
('CREATE table employees('),
('employeeID INT PRIMARY KEY'),
('employeeName VARCHAR(255)NOT NULL'),
('title VARCHAR(255)'),
('city VARCHAR(255)'),
('country VARCHAR(255)'),
('reportsTo int'),
(')'),
('--To create data_dictionary table'),
('CREATE table data_dictionary('),
('table_name VARCHAR(255)'),
('Field VARCHAR(255)'),
('Description TEXT'),
(')'),
('--To create customers table'),
('CREATE table customers('),
('customerID VARCHAR(5) NOT NULL PRIMARY KEY'),
('CompanyName VARCHAR(255)'),
('contactName VARCHAR(255)'),
('contactTitle VARCHAR(255)'),
('city VARCHAR(255)'),
('country VARCHAR(255)'),
(')'),
('--To create shippers table'),
('CREATE table shippers('),
('shipperID INT NOT NULL PRIMARY KEY'),
('companyName VARCHAR(40) NOT NULL'),
(')'),
('--To create categories table'),
('CREATE table categories('),
('categoryID SERIAL PRIMARY KEY'),
('categoryName VARCHAR(40)NOT NULL'),
('description TEXT'),
(')'),
('--To create products table'),
('CREATE table products('),
('productID serial PRIMARY KEY'),
('productName	VARCHAR(40) NOT NULL'),
('quantityPerUnit VARCHAR(40)'),
('unitPrice NUMERIC(10'),
('discontinued BOOLEAN NOT NULL'),
('categoryID INT'),
('/*categoryID is primary key in categories table'),
('and we are referring categoryID in product table as FORIEGN KEY for referrence*/'),
('FOREIGN KEY (categoryID) REFERENCES categories(categoryID)'),
(')'),
('--To create orders table'),
('CREATE table orders('),
('orderID	SERIAL PRIMARY KEY'),
('customerID VARCHAR(40)'),
('employeeID INT'),
('orderDate DATE'),
('requiredDate DATE'),
('shippedDate	DATE'),
('shipperID INT'),
('freight NUMERIC(10'),
('/*Below used customerID'),
('from customer'),
('to creating connection bettween the tables*/'),
('FOREIGN KEY (customerID) REFERENCES customers(customerID)'),
('FOREIGN KEY (employeeID) REFERENCES employees(employeeID)'),
('FOREIGN KEY (shipperID)  REFERENCES shippers(shipperID)'),
(')'),
('--To create order_details table'),
('CREATE table order_details('),
('orderID	INT NOT NULL'),
('productID INT NOT NULL'),
('unitPrice NUMERIC(10'),
('quantity SMALLINT NOT NULL'),
('discount REAL NOT NULL'),
('PRIMARY KEY (orderID'),
('FOREIGN KEY (orderID) REFERENCES orders(orderID)'),
('FOREIGN KEY (productID) REFERENCES products(productID)'),
(')');
