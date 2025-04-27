

select * from customers;
select * from products;
select * from order_details;
select * from orders;
select * from shippers;
select * from employees;

select c.customer_id,c.company_name as customer,
p.product_name,od.quantity,o.order_id,o.order_date
from customers c
inner join 
orders o on c.customer_id=o.customer_id
inner join 
order_details od on o.order_id=od.order_id
inner join 
products p on p.product_id=od.product_id;


select o.order_id as ordersplaced,
o.order_date,o.customer_id as customer,
c.company_name,e.employee_id,e.first_name || '' || e.last_name as employeename,
s.shipper_id,s.company_name as shipperscompanyname,
p.product_id,p.product_name,od.quantity
from orders o
left join order_details od on od.order_id=o.order_id
left join customers c on c.customer_id=o.customer_id
left join employees e on o.employee_id = e.employee_id
left join shippers s on s.shipper_id=o.ship_via
left join products p on p.product_id=od.product_id;


select od.order_id,od.quantity,od.product_id,
p.product_name,p.product_id
from order_details od
right join products p on od.product_id=p.product_id;


select * from categories
select * from products;

select c.category_id,c.category_name,p.product_id,p.product_name
from categories c
full outer join products p on  c.category_id=p.category_id;

select p.product_id,p.product_name,c.category_id,c.category_name
from products p
cross join categories c ;

select * from customers;
select * from orders;
 select e.employee_id , e.first_name || '' || e.last_name as employeename,e.reports_to as manager
from employees e
 join employees e1 on e.employee_id=e1.reports_to;

 select c.customer_id,c.company_name as customer,
 o.order_id,o.customer_id,o.order_date
 from customers c
 left join orders o on c.customer_id=o.customer_id
 where o.ship_via is null;


