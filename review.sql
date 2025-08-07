-- Question1 
select *
from Customer;

-- Question2 
select *
from Orders
where customer_id = 22;

-- Question3
select *
from LineItem
where order_id = 22;

-- Question4

DELIMITER //
CREATE FUNCTION compute_order_total(given_order_id INT)
RETURNS DECIMAL(10, 2)
READ SQL DATA
BEGIN
	DECLARE sum_order DECIMAL(10, 2);
    
    SELECT SUM(quantity * price) INTO sum_order
    FROM LineItem
    GROUP BY order_id
    WHERE order_id = given_order_id;
    
    RETURN sum_order
END //
DELIMITER ;
SELECT compute_order_total(22);

-- Question5
DELIMITER //
CREATE PROCEDURE add_customer(IN add_customer_name VARCHAR(255))
BEGIN	
	INSERT INTO Customer(customer_name)
    values(add_customer_name);
END //
DELIMITER ;
CALL add_customer("Nguyen Phu Trong");

-- Question6
DELIMITER //
CREATE PROCEDURE delete_customer(IN delete_customer_id INT)
BEGIN
	DELETE FROM LineItem WHERE order_id IN (
		SELECT order_id
        FROM Orders
        WHERE customer_id = delete_customer_id
    );
    DELETE FROM Orders WHERE customer_id = delete_customer_id;
    DELETE FROM Customer WHERE customer_id = delete_customer_id;
END //
DELIMITER ;
CALL delete_customer(22);

-- Question7
DELIMITER //
CREATE PROCEDURE update_customer(IN update_customer_id INT, update_customer_name VARCHAR(255))
BEGIN
	UPDATE Customer
    SET customer_name = update_customer_name
    WHERE customer_id = update_customer_id;
END //
DELIMITER ;
CALL update_customer(22, "Trong Nguyen Phu");

-- Question8
INSERT INTO Orders(order_date, customer_id, employee_id, total)
VALUES("08-07-2025", 22, 22, 500.000);

-- Question9
INSERT INTO LineItem
VALUES(22, 22, 2, 100.000);

-- Question10
UPDATE Orders
SET total = (
	SELECT SUM(quantity * price)
	FROM LineItem
    GROUP BY order_id
    WHERE order_id = 22
)
WHERE order_id = 22;