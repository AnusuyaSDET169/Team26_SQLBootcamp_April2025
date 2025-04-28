Select c.company_name as customer,o.order_id,p.product_name,od.quantity,o.order_date
From customers c
inner join orders o on c.customer_id=o.customer_id
inner join order_details od on o.order_id=od.order_id
inner join products p on od.product_id=p.product_id;




SELECT o.order_id,o.order_date,c.customer_id,c.company_name AS customer_name,e.employee_id,
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,s.shipper_id,s.company_name AS shipper_name,
p.product_id,p.product_name,od.quantity,od.unit_price
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN employees e ON o.employee_id = e.employee_id
LEFT JOIN shippers s ON o.ship_via = s.shipper_id
LEFT JOIN order_details od ON o.order_id = od.order_id
LEFT JOIN products p ON od.product_id = p.product_id
ORDER BY o.order_id;



SELECT od.order_id,p.product_id,od.quantity,p.product_name
FROM order_details od
RIGHT JOIN products p
ON od.product_id = p.product_id
ORDER BY p.product_id;



SELECT
  c.category_id,
  c.category_name,
  p.product_id,
  p.product_name
FROM categories c
FULL OUTER JOIN products p ON c.category_id = p.category_id
ORDER BY c.category_name, p.product_name;


SELECT p.Product_name, c.Category_name
FROM Products p
CROSS JOIN Categories c;



SELECT
    e.employee_id AS employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    e.title AS employee_title,
    m.employee_id AS manager_id,
    m.first_name || ' ' || m.last_name AS manager_name,
    m.title AS manager_title
FROM
    employees e
LEFT JOIN
    employees m ON e.reports_to = m.employee_id;



SELECT
    c.customer_id,
    c.company_name,
    c.contact_name,
    c.phone
FROM
    customers c
LEFT JOIN
    orders o ON c.customer_id = o.customer_id
WHERE
    o.ship_via IS NULL;

