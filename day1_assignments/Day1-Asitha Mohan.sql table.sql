-----CATEGORIES
create table categories(
category_id serial PRIMARY KEY,
category_name varchar(255) unique not null,
description varchar(255) unique not null
);

-----CUSTOMERS
create table customers(
customer_id varchar(25) PRIMARY KEY,
company_name varchar(255),
contact_name varchar(255),
contact_title varchar(255),
city varchar(255),
country varchar(255)
);

-----EMPLOYEES
create table employees(
employee_id serial primary key,
employee_name varchar(255),
title varchar(255),
city varchar(255),
country varchar(255),
reports_to int
);

-----ORDER_DETAILS
create table order_details(
order_id int,
product_id int,
unit_price decimal(6,2),
quatity int,
discount decimal(6,2),
primary key (order_id,product_id)
);


-----ORDERS
create table orders(
order_id int primary key,
customer_id varchar(25),
employee_id int,
order_date date,
required_date date,
shipped_date date,
shipper_id int,
freight decimal(6,2),
);

--- ADD FOREIGN KEYS
ALTER TABLE ORDERS
ADD CONSTRAINT FK_CUSTOMER
foreign key(customer_id)references customers (customer_id),
ADD CONSTRAINT FK_EMPLOYEE
foreign key(employee_id) references employees (employee_id),
ADD CONSTRAINT FK_SHIPPER
foreign key(shipper_ID) references Shippers (shipper_ID) ;

-----PRODUCTS
create table products(
product_ID serial primary key,
product_Name varchar(255),
quantity_PerUnit varchar(255),
unitPrice decimal(6,3),
discontinued int,
category_id int
);

ALTER TABLE PRODUCTS
ADD CONSTRAINT FK_CATEGORY
foreign key(category_id)references categories (category_id);

-----SHIPPERS
create table Shippers
(shipper_ID serial primary key,
company_Name varchar(25)
);

