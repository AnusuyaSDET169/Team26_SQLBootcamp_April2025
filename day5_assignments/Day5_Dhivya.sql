---------------           1           -----------------
select extract(year from order_date) as year,
    extract(quarter from order_date) as quarter,
    count(*) as orders,
    avg(freight) as avg_freight
from orders
where freight > 100
group by year, quarter
order by year, quarter;
---------------           2           -----------------
select ship_region,
    count(*) as order_count,
    min(freight) as min_freight,
    max(freight) as max_freight
from orders
group by ship_region
having count(*) >= 5;
---------------           3           -----------------
select title from employees
union
select contact_title from customers;

select title from employees
union all
select contact_title from customers;
---------------           4           -----------------
select category_id from products
where discontinued = 0
intersect
select category_id from products
where units_in_stock > 0;
---------------           5           -----------------
select order_id from order_details
except
select order_id from order_details
where discount > 0;
