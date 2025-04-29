select * from orders;

select 
extract (year from order_date) as order_year ,
extract (quarter from order_date) as order_quarter,
count (*) as order_count,
avg(freight) as avg_freight from orders
where freight > 100
group by 
extract (year from order_date), 
extract (quarter from order_date) ;


select 
ship_region, 
count(*) as order_count, 
min(freight) as minfreight,
max(freight) as maxfreight 
from orders
group by ship_region
having count(*)>=5;


----Get all title designations across employees and customers ( Try UNION & UNION ALL)

select * from employees;
select * from customers;


select  contact_title as customer_designation from customers
union 
select  title as employee_designation from employees;

select  contact_title as customer_designation from customers
union all
select  title as employee_designation from employees;

select * from categories;

select * from products;

select category_id from products where discontinued=1
intersect
select category_id from products where units_in_stock >0;

select * from order_details;

select distinct order_id  from order_details 
except 
select distinct order_id from order_details where discount <0;




