1.      GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100
SELECT * FROM orders
SELECT * FROM shippers
SELECT * FROM order_details
SELECT EXTRACT(year from order_date) AS order_year,EXTRACT(quarter from order_date)AS quarter,
COUNT(order_id)AS order_count,AVG(freight) AS avg_freight_cost
FROM orders
WHERE freight >100
GROUP BY order_year,quarter

2. GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5
 SELECT ship_region,COUNT (order_id) AS no_of_orders,MIN(freight)AS min_freight_cost,
 Max(freight)AS max_freight_cost
 FROM orders 
 GROUP BY 1
 HAVING COUNT (order_id) >=5

3. Get all title designations across employees and customers ( Try UNION & UNION ALL)
SELECT * FROM employees
SELECT * FROM customers
SELECT title 
FROM employees
UNION ALL
SELECT contact_title 
FROM customers

4.      Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)
SELECT * FROM categories 
SELECT * FROM products WHERE (discontinued>0 and units_in_stock >0)
SELECT category_id
FROM categories
INTERSECT 
SELECT category_id
FROM products
WHERE (discontinued!=0 and units_in_stock !=0)

5.Find orders that have no discounted items (Display the  order_id, EXCEPT)
SELECT * FROM order_details
SELECT * FROM orders
SELECT order_id
FROM orders
EXCEPT
SELECT order_id
FROM order_details
WHERE discount>0
 
