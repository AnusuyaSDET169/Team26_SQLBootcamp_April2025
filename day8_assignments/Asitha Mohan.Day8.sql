
1.     Create view vw_updatable_products (use same query whatever I used in the training)
select * from products where product_name= 'Chai';
select * from update_products_view

create view update_products_view as
select product_id,product_name,unit_price,units_in_stock
from products where discontinued =0;

UPDATE update_products_view SET unit_price = unit_price * 1.1 
where units_in_stock < 10;
select * from update_products_view where units_in_stock < 10;
Begin;
update products 
set unit_price=unit_price*1.1 where category_id=1;

select product_id,product_name,unit_price,
units_in_stock from products where category_id=1;
Commit;
select * from products where category_id=1;
end;
Rollback;

--2.     Transaction:
--Update the product price for products by 10% in category id=1
--Try COMMIT and ROLLBACK and observe what happens.
Begin;
update products 
set unit_price=unit_price*1.1
where category_id=1;

select product_id,product_name,unit_price,
units_in_stock from products where category_id=1;
Commit;
select * from products where category_id=1;
Rollback;
--3.     Create a regular view which will have below details (Need to do joins):
Employee_id,
Employee_full_name,
Title,
Territory_id,
territory_description,
region_description
select * from employees;
select * from employee_territories;
select * from territories;
select * from region;

create view employee_territory_region as
select e.employee_id,
e.last_name || ' ' || e.first_name as employee_fullname,e.title,
et.territory_id,t.territory_description,r.region_id,r.region_description
from employees e
inner join employee_territories et on e.employee_id=et.employee_id
inner join territories t on et.territory_id=t.territory_id
inner join region r on r.region_id=t.region_id;
select * from employee_territory_region

--4.     Create a recursive CTE based on Employee Hierarchy
with recursive cte_employeehierarchy AS(
select employee_id,first_name,last_name,reports_to,
0 as level
From employees e
where reports_to is null
union all
select e.employee_id,e.first_name,e.last_name,e.reports_to,
eh.level+1
from employees e
join cte_employeehierarchy eh
on eh.employee_id=e.reports_to
)
SELECT * FROM cte_employeehierarchy
ORDER BY level, reports_to, employee_id;


