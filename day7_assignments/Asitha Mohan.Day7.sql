
--1.     Rank employees by their total sales
--(Total sales = Total no of orders handled, JOIN employees and orders table)
SELECT * FROM employees
SELECT * FROM orders
SELECT e.first_name||' '||e.last_name AS employee_name,COUNT(order_id) AS total_no_of_orders,
RANK()OVER(
order by COUNT(order_id) DESC) AS sales_rank
FROM employees e
JOIN orders o
ON e.employee_id=o.employee_id
GROUP BY  e.first_name||' '||e.last_name
ORDER BY sales_rank;

--2.      Compare current order's freight with previous and next order for each customer.
--(Display order_id,  customer_id,  order_date,  freight,
--Use lead(freight) and lag(freight).
SELECT order_id,customer_id,order_date,freight,
lag(freight)over(partition by customer_id order by order_date)AS previous_day_freight,
lead(freight)over(partition by customer_id order by order_date)AS next_day_freight
FROM orders;

--3.     Show products and their price categories, product count in each category, avg price:
SELECT * FROM products
WITH productprice AS(
SELECT product_id,product_name,category_id,unit_price,
CASE 
WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
END AS price_category
FROM products)
SELECT price_category,
COUNT (*) AS product_count,
round (AVG(unit_price)::numeric, 2) as avg_price
FROM productprice
GROUP BY price_category;




