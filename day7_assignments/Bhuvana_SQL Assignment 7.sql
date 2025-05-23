CREATE TABLE IF NOT EXISTS "Bhuvana_SQLBootcamp_Assignment_7" (
    "SQLBootcamp_Assignment_7" TEXT,
    "Column_2" TEXT,
    "Column_3" TEXT,
    "Column_4" TEXT,
    "Column_5" INT
);
INSERT INTO "Bhuvana_SQLBootcamp_Assignment_7" VALUES (NULL,NULL,NULL,NULL,NULL),
	('1.Rank employees by their total sales',NULL,NULL,NULL,NULL),
	('(Total sales = Total no of orders handled',' JOIN employees and orders table)',NULL,NULL,NULL),
	(NULL,NULL,NULL,NULL,NULL),
	('SELECT e.employee_id',' e.employee_name',' COUNT(o.order_id) AS total_sales',NULL,NULL),
	('       RANK() OVER (ORDER BY COUNT(o.order_id) DESC) AS sales_rank',NULL,NULL,NULL,NULL),
	('FROM employees e',NULL,NULL,NULL,NULL),
	('JOIN orders o ON e.employee_id = o.employee_id',NULL,NULL,NULL,NULL),
	('GROUP BY e.employee_id',' e.employee_name',NULL,NULL,NULL),
	('ORDER BY total_sales DESC;',NULL,NULL,NULL,NULL),
	(NULL,NULL,NULL,NULL,NULL),
	(' ',NULL,NULL,NULL,NULL),
	('2.Compare current order''s freight with previous and next order for each customer.',NULL,NULL,NULL,NULL),
	('(Display order_id','  customer_id','  order_date','  freight',NULL),
	('Use lead(freight) and lag(freight).',NULL,NULL,NULL,NULL),
	(NULL,NULL,NULL,NULL,NULL),
	('SELECT order_id',' customer_id',' order_date',' freight',NULL),
	('       LAG(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_freight',NULL,NULL,NULL,NULL),
	('       LEAD(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_freight',NULL,NULL,NULL,NULL),
	('FROM orders',NULL,NULL,NULL,NULL),
	('ORDER BY customer_id',' order_date;',NULL,NULL,NULL),
	(' ',NULL,NULL,NULL,NULL),
	('3.Show products and their price categories',' product count in each category',' avg price:',NULL,NULL),
	('        	(HINT:',NULL,NULL,NULL,NULL),
	('·  	Create a CTE which should have price_category definition:',NULL,NULL,NULL,NULL),
	('        	WHEN unit_price < 20 THEN ''Low Price''',NULL,NULL,NULL,NULL),
	('            WHEN unit_price < 50 THEN ''Medium Price''',NULL,NULL,NULL,NULL),
	('            ELSE ''High Price''',NULL,NULL,NULL,NULL),
	('·  	In the main query display: price_category','  product_count in each price_category','  ROUND(AVG(unit_price)::numeric',' 2) as avg_price)',NULL),
	(NULL,NULL,NULL,NULL,NULL),
	('WITH price_cte AS (',NULL,NULL,NULL,NULL),
	('    SELECT product_id',' product_name',' unit_price',NULL,NULL),
	('           CASE ',NULL,NULL,NULL,NULL),
	('               WHEN unit_price < 20 THEN ''Low Price''',NULL,NULL,NULL,NULL),
	('               WHEN unit_price < 50 THEN ''Medium Price''',NULL,NULL,NULL,NULL),
	('               ELSE ''High Price''',NULL,NULL,NULL,NULL),
	('           END AS price_category',NULL,NULL,NULL,NULL),
	('    FROM products',NULL,NULL,NULL,NULL),
	(')',NULL,NULL,NULL,NULL),
	('SELECT price_category',' ',NULL,NULL,NULL),
	('       COUNT(*) AS product_count',NULL,NULL,NULL,NULL),
	('       ROUND(AVG(unit_price)::numeric',' 2) AS avg_price',NULL,NULL,NULL),
	('FROM price_cte',NULL,NULL,NULL,NULL),
	('GROUP BY price_category',NULL,NULL,NULL,NULL),
	('ORDER BY avg_price;',NULL,NULL,NULL,NULL);
