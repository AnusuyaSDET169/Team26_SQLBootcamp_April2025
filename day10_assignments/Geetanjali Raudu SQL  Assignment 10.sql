
1.	Write  a function to Calculate the total stock value for a given category:
(Stock value=ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
Return data type is DECIMAL(10,2)

CREATE OR REPLACE FUNCTION get_total_stock_value(category_id_input INTEGER)
RETURNS DECIMAL(10,2) AS $$
DECLARE
    total_value DECIMAL(10,2);
BEGIN
    SELECT ROUND(SUM(unit_price * units_in_stock)::NUMERIC, 2)
    INTO total_value
    FROM products
    WHERE category_id = category_id_input;
    RETURN total_value;
END;
$$ LANGUAGE plpgsql;



2.	Try writing a   cursor query which I executed in the training.
CREATE OR REPLACE FUNCTION get_total_stock_value_cursor(category_id_input INTEGER)
RETURNS DECIMAL(10,2) AS $$

DECLARE
    product_cursor CURSOR FOR
        SELECT unit_price, units_in_stock
        FROM products
        WHERE category_id = category_id_input;
    product_record RECORD;
    total_value DECIMAL(10,2) := 0.00;
BEGIN
    OPEN product_cursor;
    LOOP
        FETCH product_cursor INTO product_record;
        EXIT WHEN NOT FOUND;
        total_value := total_value + (product_record.unit_price * product_record.units_in_stock);
    END LOOP;
    CLOSE product_cursor;
    RETURN ROUND(total_value, 2);
END;
$$ LANGUAGE plpgsql;