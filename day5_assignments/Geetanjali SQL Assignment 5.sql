1.GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100

SELECT
    Extract(YEAR from order_date) AS OrderYear,
    Extract(QUARTER from order_date) AS OrderQuarter,
    COUNT(*) AS OrderCount,
    AVG(Freight) AS AvgFreightCost
FROM
    Orders
WHERE
    Freight > 100
GROUP BY
   Extract(YEAR from order_date),Extract(QUARTER from order_date)
ORDER BY
    OrderYear, OrderQuarter;


2.GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
Filter regions where no of orders >= 5

SELECT
    ship_region AS ShipRegion,
    COUNT(*) AS OrderCount,
    MIN(freight) AS MinFreightCost,
    MAX(freight) AS MaxFreightCost
FROM
    Orders
GROUP BY
    ship_region
HAVING
    COUNT(*) >= 5
ORDER BY
    OrderCount DESC;


3.Get all title designations across employees and customers ( Try UNION & UNION ALL)	

SELECT title
FROM Employees
UNION
SELECT contact_title
FROM Customers;


4.Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)

SELECT c.category_id, c.category_name
FROM categories c
WHERE c.category_id IN (
    SELECT category_id
    FROM products
    WHERE discontinued = 1
    INTERSECT
    SELECT category_id
    FROM products
    WHERE units_in_stock > 0
);

5.Find orders that have no discounted items (Display the  order_id, EXCEPT)

SELECT o.order_id, o.order_date
FROM orders o
WHERE o.order_id IN (
    SELECT order_id
    FROM order_details
    EXCEPT
    SELECT order_id
    FROM order_details
    WHERE discount > 0
);
 
	