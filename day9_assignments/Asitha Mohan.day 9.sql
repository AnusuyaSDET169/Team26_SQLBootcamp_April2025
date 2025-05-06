--create product_price_audit
CREATE TABLE  product_price_audit (
 audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
);
select * from product_price_audit;
select * from products where product_id=3
delete from  product_price_audit
update products 
set unit_price = unit_price*1.1
where product_id =3
--create trigger function
CREATE OR REPLACE FUNCTION trigger_product_function()
RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO product_price_audit (
	product_id,
        product_name,
        old_price,
        new_price)
 VALUES(OLD.product_id,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
);
 RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- create INSERT UPDATE trigger 
CREATE TRIGGER trigger_products
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
WHEN (OLD.unit_price IS DISTINCT FROM NEW.unit_price)
EXECUTE FUNCTION trigger_product_function();
drop trigger trigger_products on products

--2. Create stored procedure  using IN and INOUT parameters to assign tasks to employees
CREATE TABLE IF NOT EXISTS employee_tasks (
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
    );
	select * from  employee_tasks
CREATE PROCEDURE assign_task(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Insert new task
    INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);

 -- Count tasks
    SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;

    -- Show notice
    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
END;
$$;
select * from employee_tasks WHERE employee_id = 1;
CALL assign_task(1, 'Review Reports', 0);

