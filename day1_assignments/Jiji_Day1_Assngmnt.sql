CREATE TABLE IF NOT EXISTS categories (
	categoryID INT PRIMARY KEY, 
	categoryName VARCHAR(100) NOTNULL,
	description TEXT
)

SELECT * FROM categories

CREATE TABLE IF NOT EXISTS customers (
	customerID VARCHAR(5) PRIMARY KEY, 
	companyName VARCHAR(50) NOT NULL,
	contactName VARCHAR(50) NOT NULL, 
	contactTitle VARCHAR(50), 
	city VARCHAR(20), 
	country VARCHAR(20)
)

SELECT * FROM customers

CREATE TABLE IF NOT EXISTS employees (
	employeeID INT PRIMARY KEY,
	employeeName VARCHAR(20) NOT NULL,
	title VARCHAR(30),
	city VARCHAR(20),
	country VARCHAR(20),
	reportsTo SMALLINT,
	FOREIGN KEY (reportsTo) REFERENCES employees (employeeID)
)

SELECT * FROM employees

CREATE TABLE IF NOT EXISTS products (
	productID INT PRIMARY KEY,
	productName VARCHAR(50) NOT NULL,
	quantityPerUnit VARCHAR(30),
	unitPrice NUMERIC,
	discontinued INT NOT NULL,
	categoryID INT,
	FOREIGN KEY (categoryID) REFERENCES categories (categoryID)
)

SELECT * FROM products 

CREATE TABLE IF NOT EXISTS shippers (
	shipperID SMALLINT PRIMARY KEY,
	companyName VARCHAR(50)
)

SELECT * FROM shippers 

CREATE TABLE IF NOT EXISTS orders (
	orderID INT PRIMARY KEY,
	customerID VARCHAR(5) NOT NULL,
	employeeID INT,
	orderDate DATE,
	requiredDate DATE,
	shippedDate DATE,
	shipperID SMALLINT,
	freight NUMERIC,
	FOREIGN KEY (customerID) REFERENCES customers (customerID),
	FOREIGN KEY (employeeID) REFERENCES employees (employeeID),
	FOREIGN KEY (shipperID) REFERENCES shippers (shipperID)
)

SELECT * FROM orders

CREATE TABLE IF NOT EXISTS order_details (
	orderID INT,
	productID INT,
	unitPrice NUMERIC,
	quantity INT,
	discount NUMERIC,
	PRIMARY KEY (orderID, productID),
	FOREIGN KEY (orderID) REFERENCES orders (orderID),
	FOREIGN KEY (productID) REFERENCES products (productID)
)

SELECT * FROM order_details