select * from employees;

select * from orders;

select e.employee_id, e.first_name || '' || e.last_name as employeename,
count (o.order_id) as ordersplaced,
rank() over(order by count(o.order_id)desc) as TotalSales
from employees e
inner join orders o	
on e.employee_id=o.employee_id
group by e.employee_id, e.first_name,e.last_name
order by TotalSales desc;



Select order_id,customer_id,order_date,freight,
lag(freight) over (partition by customer_id order by order_date) as previous_freight , 
lead(freight) over (partition by customer_id order by order_date) as next_freight
from orders;



select * from products;
select * from categories;

With productprice as (select product_id,
product_name,
category_id,unit_price, 
case
when unit_price < 20 then 'Low Price'
when unit_price < 50 then 'Medium Price'
else 'HighPrice'
end as product_category
from products )
select product_category,
count (*) as product_count,
round (AVG(unit_price)::numeric, 2) as avg_price
from productprice
group by product_category;
