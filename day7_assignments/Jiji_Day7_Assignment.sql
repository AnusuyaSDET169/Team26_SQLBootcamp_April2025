--1.Rank employees by their total sales
--(Total sales = Total no of orders handled, JOIN employees and orders table)

SELECT E.EMPLOYEE_ID,
	E.FIRST_NAME || ' ' || E.LAST_NAME AS EMPLOYEE_NAME,
	COUNT (O.ORDER_ID) AS NUMBER_OF_ORDERS,
	RANK() OVER (ORDER BY COUNT (O.ORDER_ID) DESC) 
	AS EMPLOYEE_RANK
FROM ORDERS O
JOIN EMPLOYEES E ON O.EMPLOYEE_ID = E.EMPLOYEE_ID
GROUP BY E.EMPLOYEE_ID
ORDER BY EMPLOYEE_RANK;

--2.Compare current order's freight with previous and next order for each customer.
--(Display order_id,  customer_id,  order_date,  freight, Use lead(freight) and lag(freight).

--Lag()
SELECT ORDER_ID,
	CUSTOMER_ID,
	ORDER_DATE,
	FREIGHT,
	LAG (FREIGHT, 1, FREIGHT) 
	OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE) AS PREVIOUS_FREIGHT,
	FREIGHT - LAG (FREIGHT, 1, FREIGHT) 
	OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE) AS FREIGHT_DIFF
FROM ORDERS

--Lead()
SELECT ORDER_ID,
	CUSTOMER_ID,
	ORDER_DATE,
	FREIGHT,
	LEAD (FREIGHT, 1, FREIGHT) 
	OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE) AS NEXT_FREIGHT,
	FREIGHT - LEAD (FREIGHT, 1, FREIGHT) 
	OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE) AS FREIGHT_DIFF
FROM ORDERS

--3.Show products and their price categories, product count in each category, avg price:
--	(HINT: Create a CTE which should have price_category definition:
        	--WHEN unit_price < 20 THEN 'Low Price'
            --WHEN unit_price < 50 THEN 'Medium Price'
            --ELSE 'High Price'
--In the main query display: price_category,  product_count in each price_category,  
--ROUND(AVG(unit_price)::numeric, 2) as avg_price)

WITH price_category_cte AS (
	SELECT product_id, unit_price,
	CASE 
	WHEN unit_price < 20 THEN 'Low Price'
	WHEN unit_price <50 THEN 'Medium Price'
	ELSE
	'High Price'
	END AS price_category
	FROM products
)
SELECT price_category, COUNT (product_id) AS product_count, 
ROUND (AVG (unit_price) :: numeric, 2) AS avg_price
FROM price_category_cte
GROUP BY price_category

			