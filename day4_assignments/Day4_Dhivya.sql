--------------         1            ------------------
SELECT 
c.company_name AS customer,
o.order_id,
p.product_name,
od.quantity,
o.order_date
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id;
--------------         2            ------------------
SELECT 
o.order_id,
c.company_name AS customer,
CONCAT(e.first_name, ' ', e.last_name) AS employee,
s.company_name AS shipper,
p.product_name,
od.quantity,
o.order_date
FROM orders o 
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN employees e ON o.employee_id = e.employee_id
LEFT JOIN shippers s ON o.ship_via = s.shipper_id
LEFT JOIN order_details od ON o.order_id = od.order_id
LEFT JOIN products p ON od.product_id = p.product_id;
--------------         3            ------------------
SELECT 
od.order_id,
p.product_id,
od.quantity,
p.product_name
FROM order_details od 
RIGHT JOIN products p ON od.product_id = p.product_id;
--------------         4            ------------------
SELECT
c.category_id,
c.category_name,
p.product_id
FROM categories c
FULL OUTER JOIN products p ON p.category_id = c.category_id;
--------------         5            ------------------
SELECT
p.product_id,
c.category_id,
c.category_name
FROM products p
CROSS JOIN categories c;
--------------         6            ------------------
SELECT 
e1.first_name || ' ' || e1.last_name AS employee_name,
e2.first_name || ' ' || e2.last_name AS manager_name
FROM employees e1
LEFT JOIN employees e2 ON e1.reports_to = e2.employee_id;
--------------         7            ------------------
SELECT 
c.customer_id,
c.company_name,
o.ship_via
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.ship_via IS NULL;