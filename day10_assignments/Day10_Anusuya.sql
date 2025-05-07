select * from products;
create function calculate_stockvalue(p_category_id INT)
returns decimal (10,2)as $$
declare 
stock_value decimal(10,2);
begin
select round(SUM(unit_price * units_in_stock)::decimal, 2)
into stock_value
from products
where category_id = p_category_id;

return stock_value;
end;
$$ language plpgsql;


SELECT calculate_stockvalue(1);



create procedure product_price_updated_cursor()
language plpgsql
as $$
declare
product_cursor cursor for 
select product_id,product_name,unit_price,units_in_stock from products;

product_record record;
v_newprice decimal(10,2);
Begin
open product_cursor;
loop
fetch product_cursor into product_record;
exit when not found;


---new price calculation
if products_record.units_in_stock < 10 THEN
            UPDATE products
            SET v_newprice = unit_price * 1.1
            WHERE product_id = products_record.product_id;
end if;

raise notice 'Updated price % from % to %',
products_record.product_name,
products_record.unit_price,
v_new_price;
end loop;

close product_cursor;
end ;
$$;
call product_price_updated_cursor();


CREATE OR REPLACE PROCEDURE update_low_stock_product_prices()
LANGUAGE plpgsql
AS $$
DECLARE
    product_record RECORD;
    product_cursor CURSOR FOR
        SELECT product_id, product_name, unit_price, units_in_stock
        FROM products;
BEGIN
    OPEN product_cursor;

    LOOP
        FETCH product_cursor INTO product_record;
        EXIT WHEN NOT FOUND;

        -- Check condition
        IF product_record.units_in_stock < 10 THEN
            UPDATE products
            SET unit_price = unit_price * 1.10
            WHERE product_id = product_record.product_id;

            RAISE NOTICE 'Updated product % - new price: %',
                product_record.product_name,
                (product_record.unit_price * 1.10);
        END IF;
    END LOOP;

    CLOSE product_cursor;
END;
$$;

CALL update_low_stock_product_prices();
