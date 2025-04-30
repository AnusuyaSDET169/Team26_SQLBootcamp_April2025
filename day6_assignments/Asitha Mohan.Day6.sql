
1.      Categorize products by stock status
(Display product_name, a new column stock_status whose values are based on below condition
 units_in_stock = 0  is 'Out of Stock'
       units_in_stock < 20  is 'Low Stock')
SELECT * FROM products
SELECT product_name,
CASE
WHEN units_in_stock=0 THEN 'Out of stock'
     WHEN units_in_stock < 20  THEN 'Low Stock'
 ELSE 'High stock'	
END AS stock_status
FROM products

2.      Find All Products in Beverages Category
(Subquery, Display product_name,unitprice)
SELECT * FROM categories
SELECT product_name,unit_price
FROM products
WHERE 
category_id=(
SELECT category_id
FROM categories
WHERE category_name = 'Beverages'
)

3.      Find Orders by Employee with Most Sales
(Display order_id,   order_date,  freight, employee_id.
Employee with Most Sales=Get the total no.of of orders for each employee then order by DESC and limit 1. Use Subquery)
SELECT * FROM orders
SELECT * FROM employees
SELECT order_id,order_date,freight,employee_id
FROM orders
WHERE employee_id=(
SELECT employee_id 
FROM employees
ORDER BY COUNT(order_id) DESC
limit 1)

select o.order_id,   o.order_date,  o.freight, e.employee_id 
from employees e, 
orders o
where e.employee_id = o.employee_id
and e.employee_id 
in (
select employee_id from orders group by 1 order by count(order_id) desc
limit 1)

4.      Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA. (Subquery, Try with ANY, ALL operators)

SELECT order_id,ship_country
FROM orders
WHERE ship_country != 'USA' AND freight > ANY( SELECT freight FROM orders WHERE ship_country='USA' )
