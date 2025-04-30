select * from products;


Select product_name, product_id,unit_price,units_in_stock,
case
when units_in_stock =0 then 'outofstock'
when units_in_stock <20 then 'Low stock'
end as stock_status
From products;

select * from categories

Select product_id,product_name,category_id,unit_price 
from products 
where 
category_id=(select category_id from categories where category_name= 'Beverages');

select * from employees;
select * from orders;

select order_id, order_date,freight, employee_id
from orders 
where employee_id=(select employee_id from orders
Group by employee_id
order by count(order_id) desc 
limit 1);

select order_id, order_date,freight,ship_country
from orders 
where ship_country!='USA'
and freight > all(select freight from orders where ship_country='USA' );