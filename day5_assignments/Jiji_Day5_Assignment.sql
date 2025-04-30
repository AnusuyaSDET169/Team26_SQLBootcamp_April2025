--1.GROUP BY with WHERE - Orders by Year and Quarter
--Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100

SELECT EXTRACT (YEAR FROM ORDER_DATE) AS ORDER_YEAR,
	EXTRACT (QUARTER FROM ORDER_DATE) AS QUARTER,
	COUNT (*) AS ORDER_COUNT,
	AVG (FREIGHT) AS AVG_FREIGHT_COST
FROM ORDERS
WHERE FREIGHT > 100
GROUP BY ORDER_YEAR,
	QUARTER
ORDER BY ORDER_YEAR,
	QUARTER
	
--2.GROUP BY with HAVING - High Volume Ship Regions
--Display, ship region, no of orders in each region, min and max freight cost Filter regions where no of orders >= 5

SELECT SHIP_REGION,
	COUNT(*) AS NO_OF_ORDERS,
	MIN (FREIGHT) AS MIN_FREIGHT_COST,
	MAX (FREIGHT) AS MAX_FREIGHT_COST
FROM ORDERS
GROUP BY SHIP_REGION
HAVING COUNT(*) >= 5

--3.Get all title designations across employees and customers ( Try UNION & UNION ALL)

--UNION
SELECT TITLE
FROM EMPLOYEES
UNION
SELECT CONTACT_TITLE
FROM CUSTOMERS

--UNION ALL
SELECT TITLE
FROM EMPLOYEES
UNION ALL
SELECT CONTACT_TITLE
FROM CUSTOMERS

--4.Find categories that have both discontinued and in-stock products
--(Display category_id, instock means units_in_stock > 0, Intersect)

SELECT CATEGORY_ID,
	UNITS_IN_STOCK AS IN_STOCK,
	DISCONTINUED
FROM PRODUCTS
WHERE UNITS_IN_STOCK > 0 INTERSECT
	SELECT CATEGORY_ID,
		UNITS_IN_STOCK AS IN_STOCK,
		DISCONTINUED
	FROM PRODUCTS WHERE DISCONTINUED = 1

--5.Find orders that have no discounted items (Display the  order_id, EXCEPT)

SELECT DISTINCT ORDER_ID
FROM ORDER_DETAILS
EXCEPT
SELECT DISTINCT ORDER_ID
FROM ORDER_DETAILS
WHERE DISCOUNT > 0
