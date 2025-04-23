CREATE TABLE categories (
	categoryID SERIAL PRIMARY KEY,
	categoryName VARCHAR(50) NOT NULL,
	description TEXT
);

CREATE TABLE customers (
	customerID VARCHAR(5) PRIMARY KEY,
	companyName VARCHAR(100) NOT NULL,
	contactName VARCHAR(50),
	contactTitle VARCHAR(50),
	city VARCHAR(50),
	country VARCHAR(50)
);

CREATE TABLE employees (
	employeeID SERIAL PRIMARY KEY,
	employeeName VARCHAR(50) NOT NULL,
	title VARCHAR(50) NOT NULL,
	city VARCHAR(25) NOT NULL,
	country VARCHAR(25) NOT NULL,
	reportsTo INT
);

CREATE TABLE shippers (
	shipperID SERIAL PRIMARY KEY,
	companyName VARCHAR(50) NOT NULL
);

CREATE TABLE orders ( 
	orderID INT PRIMARY KEY,
	customerID VARCHAR(5) NOT NULL,
	employeeID INT NOT NULL,
	orderDate DATE,
	requiredDate DATE,
	shippedDate DATE,
	shipperID INT,
	freight FLOAT,
	FOREIGN KEY (customerID) REFERENCES customers (customerID),
	FOREIGN KEY (employeeID) REFERENCES employees (employeeID),
	FOREIGN KEY (shipperID) REFERENCES shippers (shipperID)
);

CREATE TABLE order_details (
	orderID INT NOT NULL,
	productID INT NOT NULL,
	unitPrice FLOAT NOT NULL,
	quantity INT NOT NULL,
	discount FLOAT NOT NULL,
	PRIMARY KEY (orderID, productID),
	FOREIGN KEY (orderID) REFERENCES orders(orderID),
	FOREIGN KEY (productID) REFERENCES products(productID)
);

CREATE TABLE products (
	productID SERIAL PRIMARY KEY,
	productName VARCHAR(100) NOT NULL,
	quantityPerUnit VARCHAR(50) NOT NULL,
	unitPrice FLOAT NOT NULL,
	discontinued INT NOT NULL,
	categoryID INT NOT NULL,
	FOREIGN KEY (categoryID) REFERENCES categories (categoryID)
);
