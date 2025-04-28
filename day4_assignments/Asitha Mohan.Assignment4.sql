                             Day4-Asitha Mohan Paladan Chirakkal DA165

1.     List all customers and the products they ordered with the order date. (Inner join)
SELECT * FROM customers
SELECT * FROM products
SELECT * FROM orders
SELECT * FROM employees
SELECT * FROM order_details
SELECT * FROM shippers
SELECT * FROM categories
SELECT company_name AS customer,o.order_id,p.product_name,quantity_per_unit AS quantity,order_date
FROM customers c
INNER JOIN orders o
ON c.customer_id=o.customer_id
INNER JOIN order_details od
ON o.order_id=od.order_id
INNER JOIN products p
ON od.product_id=p.product_id

2.     Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
SELECT o.order_id AS orders,c.customer_id AS customer,e.first_name ||' '||e.last_name AS employee,s.shipper_id,s.company_name,p.product_id,p.product_name
FROM orders o
LEFT JOIN customers c
ON o.customer_id=c.customer_id
LEFT JOIN employees e
ON o.employee_id=e.employee_id
LEFT JOIN shippers s
ON s.shipper_id=s.shipper_id
LEFT JOIN order_details od
ON o.order_id=od.order_id
LEFT JOIN products p
ON od.product_id=p.product_id

3.     Show all order details and products (include all products even if they were never ordered). (Right Join)
SELECT od.order_id,p.product_id,p.product_name,p.quantity_per_unit AS quantity,p.product_name
FROM order_details od
RIGHT JOIN products p
ON od.product_id=p.product_id

4. 	List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)
SELECT c.category_id,c.category_name,p.product_name AS products
FROM categories c
FULL OUTER JOIN products p
ON c.category_id=p.product_id

5. 	Show all possible product and category combinations (Cross join).
SELECT  p.product_id,p.product_name,c.category_id,c.category_name
FROM products p
CROSS JOIN categories c

6. 	Show all employees and their manager(Self join(left join))
SELECT e1.first_name||' '||e1.last_name AS employees,e2.first_name||' '||e2.last_name AS managers
FROM employees e1
JOIN employees e2
ON e1.reports_to=e2.employee_id

7. 	List all customers who have not selected a shipping method.
(Left Join, WHERE o.shipvia IS NULL)
SELECT c.contact_name AS customer, o.ship_via AS shipping
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id
WHERE o.ship_via is null





