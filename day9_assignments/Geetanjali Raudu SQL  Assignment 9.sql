Create AFTER UPDATE trigger to track product price changes
·       Create product_price_audit table with below columns:
CREATE TABLE product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
);
·       Create a trigger function with the below logic:
  INSERT INTO product_price_audit (
        product_id,
        product_name,
        old_price,
        new_price
    )
    VALUES (
        OLD.product_id,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
    );
CREATE OR REPLACE FUNCTION log_product_price_change()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO product_price_audit (
        product_id,
        product_name,
        old_price,
        new_price
    )
    VALUES (
        OLD.product_id,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
    );
	
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
	
·       Create a row level trigger for below event:
          	AFTER UPDATE OF unit_price ON products
			  CREATE TRIGGER trg_log_price_update
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
EXECUTE FUNCTION log_product_price_change();
·        Test the trigger by updating the product price by 10% to any one product_id.
UPDATE products
SET unit_price = unit_price * 1.10
WHERE product_id = 1;
2.     2.      Create stored procedure  using IN and INOUT parameters to assign tasks to employees
·       Parameters:
IN p_employee_id INT,
IN p_task_name VARCHAR(50),
 INOUT p_task_count INT DEFAULT 0
CREATE TABLE tasks (
    task_id SERIAL PRIMARY KEY,
    employee_id INT,
    task_name VARCHAR(50),
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE OR REPLACE PROCEDURE assign_task_to_employee(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Insert the new task
    INSERT INTO tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);
    -- Update the task count
    SELECT COUNT(*) INTO p_task_count
    FROM tasks
    WHERE employee_id = p_employee_id;
END;
$$;
-- Call in an anonymous block (e.g., in pgAdmin or psql)
DO $$
DECLARE
    v_task_count INT := 0;
BEGIN
    CALL assign_task_to_employee(1, 'Prepare Monthly Report', v_task_count);
    RAISE NOTICE 'Updated Task Count: %', v_task_count;
END;
$$;
·       Inside Logic: Create table employee_tasks:
 CREATE TABLE IF NOT EXISTS employee_tasks (
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
    );
CREATE OR REPLACE PROCEDURE assign_task_to_employee(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Create the table if it does not exist
    PERFORM 1 FROM information_schema.tables
    WHERE table_name = 'employee_tasks';
    IF NOT FOUND THEN
        EXECUTE '
            CREATE TABLE employee_tasks (
                task_id SERIAL PRIMARY KEY,
                employee_id INT,
                task_name VARCHAR(50),
                assigned_date DATE DEFAULT CURRENT_DATE
            )
        ';
    END IF;
    -- Insert the new task
    INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);
    -- Return updated task count
    SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;
END;
$$;
CREATE TABLE IF NOT EXISTS employee_tasks (
    task_id SERIAL PRIMARY KEY,
    employee_id INT,
    task_name VARCHAR(50),
    assigned_date DATE DEFAULT CURRENT_DATE
);
INSERT INTO employee_tasks (employee_id, task_name)
VALUES (101, 'Prepare budget report');
DO $$
DECLARE
    v_task_count INT := 0;
BEGIN
    -- Calling the procedure with employee_id = 101 and task_name = 'Prepare budget report'
    CALL assign_task_to_employee(101, 'Prepare budget report', v_task_count);
    -- Output the result
    RAISE NOTICE 'Total tasks for employee 101: %', v_task_count;
END;
$$;
CREATE OR REPLACE PROCEDURE assign_task_to_employee(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Create the employee_tasks table if it doesn't exist
    PERFORM 1 FROM information_schema.tables
    WHERE table_name = 'employee_tasks';
    IF NOT FOUND THEN
        EXECUTE '
            CREATE TABLE employee_tasks (
                task_id SERIAL PRIMARY KEY,
                employee_id INT,
                task_name VARCHAR(50),
                assigned_date DATE DEFAULT CURRENT_DATE
            )
        ';
    END IF;
    -- Insert the task into employee_tasks table
    INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);
    -- Count the total tasks assigned to the employee and put the count into p_task_count
    SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;
    -- Raise a notice with the task details and total task count
    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %', p_task_name, p_employee_id, p_task_count;
END;
$$;
DO $$
DECLARE
    v_task_count INT := 0;
BEGIN
    -- Calling the procedure to assign a task
    CALL assign_task_to_employee(101, 'Prepare budget report', v_task_count);
    -- The RAISE NOTICE will display the output message
END;
$$;
-- Call the stored procedure with employee_id = 1 and task_name = 'Review Reports'
CALL assign_task_to_employee(1, 'Review Reports', p_task_count);
CREATE OR REPLACE PROCEDURE assign_task_to_employee(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Create the employee_tasks table if it doesn't exist
    PERFORM 1 FROM information_schema.tables
    WHERE table_name = 'employee_tasks';
    IF NOT FOUND THEN
        EXECUTE '
            CREATE TABLE employee_tasks (
                task_id SERIAL PRIMARY KEY,
                employee_id INT,
                task_name VARCHAR(50),
                assigned_date DATE DEFAULT CURRENT_DATE
            )
        ';
    END IF;
    -- Insert the task into employee_tasks table
    INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);
    -- Count the total tasks assigned to the employee and put the count into p_task_count
    SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;
    -- Raise a notice with the task details and total task count
    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %', p_task_name, p_employee_id, p_task_count;
END;
$$;
DO $$
DECLARE
    v_task_count INT := 0;  -- Declare and initialize the task count variable
BEGIN
    -- Call the procedure with employee_id = 1 and task_name = 'Review Reports'
    CALL assign_task_to_employee(1, 'Review Reports', v_task_count);
    -- Output the updated task count (optional, just for confirmation)
    RAISE NOTICE 'Updated task count for employee 1: %', v_task_count;
END;
$$;
SELECT * FROM employee_tasks WHERE employee_id = 1;
