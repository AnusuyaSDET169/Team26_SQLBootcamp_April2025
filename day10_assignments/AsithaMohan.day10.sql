1.	Write  a function to Calculate the total stock value for a given category:
(Stock value=ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
Return data type is DECIMAL(10,2)

create or replace function stock_value(p_category_id INT)
returns decimal(10,2)
language plpgsql
as $$
declare
  v_stock decimal(10,2);
Begin
if not exists(select 1 from products p where p.category_id=p_category_id)then
raise exception 'category_id % doesnot exist',p_category_id;
return 0;
end if;
select round(SUM(p.unit_price * p.units_in_stock)::decimal, 2)
into v_stock
from products p
where category_id = p_category_id;
return v_stock;
end;
$$;
select * from products
SELECT stock_value(1);

2.Try writing a   cursor query which I executed in the training.
create or replace procedure update_low_stock_product_prices()
language plpgsql
as $$
declare
product_record RECORD;
product_cursor cursor for
select product_id, product_name, unit_price, units_in_stock
from products;
begin
open product_cursor;
loop
fetch product_cursor into product_record;
exit when not found;
-- Check condition
if product_record.units_in_stock < 10 then
update products
set unit_price = unit_price * 1.10
where product_id = product_record.product_id;
raise notice 'Updated product % - new price: %',
product_record.product_name,
(product_record.unit_price * 1.10);
end if;
end loop;
close product_cursor;
end;
$$;

call update_low_stock_product_prices()