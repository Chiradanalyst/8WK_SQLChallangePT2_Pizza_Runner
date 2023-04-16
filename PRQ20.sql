SELECT * from 
pizza_runner.customer_orders

/*
Generate an order item for each record in the customers_orders table in the format of one of the following:
Meat Lovers
Meat Lovers - Exclude Beef
Meat Lovers - Extra Bacon
Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers
*/

INSERT INTO pizza_runner.customer_orders
VALUES
	(11,105,1,3,'', TIMESTAMP '2020-01-01 19:01:01')
	(11,105,1,'',1, TIMESTAMP '2020-01-01 19:01:02')
	(11,105,1,'4,1', '6,9', TIMESTAMP '2020-01-01 19:01:03');

