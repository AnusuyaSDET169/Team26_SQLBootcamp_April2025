----------------------          1         -----------------------
SELECT product_name,
CASE 
WHEN units_in_stock = 0 THEN 'Out of Stock'
WHEN units_in_stock < 20 THEN 'Low Stock'
END AS stock_status
FROM products;
----------------------          2         -----------------------
SELECT product_name, unit_price
FROM products
WHERE category_id = (
SELECT category_id
FROM categories
WHERE category_name = 'Beverages'
);
----------------------          3         -----------------------
SELECT order_id, order_date, freight, employee_id
FROM orders
WHERE employee_id = (
SELECT employee_id
FROM orders
GROUP BY employee_id
ORDER BY COUNT(order_id) DESC
LIMIT 1
);
----------------------          4         -----------------------
SELECT order_id, order_date, freight, ship_country
FROM orders
WHERE ship_country != 'USA'
AND freight > ANY (
SELECT freight
FROM orders
WHERE ship_country = 'USA'
);