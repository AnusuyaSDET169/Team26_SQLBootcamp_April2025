select * from products;

create view update_products_view as
select product_id,product_name,unit_price,units_in_stock
--count(*) as product_count
from products where discontinued =0;


UPDATE update_products_view SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;

select * from update_products_view where units_in_stock < 10;


Begin;

update products 
set unit_price=unit_price*1.1 where category_id=1;

select product_id,product_name,unit_price,
units_in_stock from products where category_id=1;

Commit;
select * from products where category_id=1;
Rollback;

select * from employees;
select * from employee_territories;
select * from territories;
select * from region;

create view employee_terrritory_region as
select e.employee_id,
e.last_name || '' || e.first_name as employee_fullname,
e.title,
et.territory_id,t.territory_description,r.region_id,r.region_description
from employees e
inner join employee_territories et on e.employee_id=et.employee_id
inner join territories t on et.territory_id=t.territory_id
inner join region r on r.region_id=t.region_id;

select * from employee_terrritory_region;


select * from employees;

with recursive cte_employees_hierarchy as
( select employee_id,
first_name || '' || last_name as employee_name,
reports_to,
1 as level
from employees 
where reports_to is NULL
 
 UNION ALL
 
select e.employee_id,
e.first_name || '' || e.last_name as employee_name,
e.reports_to,eh.level +1 
from employees e
INNER JOIN cte_employees_hierarchy eh ON e.reports_to = eh.employee_id
)

SELECT * FROM cte_employees_hierarchy
ORDER BY level, reports_to, employee_id;






