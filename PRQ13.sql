/*

Is there any relationship between the number of pizzas and how long the order takes to prepare?
	STEP 1 CREATE pizzas_ordered CTE
		- The main reason for this is to COUNT how many pizzas are ordered for each ORDER_ID
	STEP 2 Create pickup_time CTE to clean data
		- Remove 'Null' values from pickup_time
		- Convert pickup_time into a TIMESTAMP
	STEP 3 
		- LEFT JOIN both CTEs on order_id
		- Get the AVERAGE AGE of each order
			- GROUP this by pizzas_ordered in STEP 1
	Final Answer 
		- Yes, order size dramatically impacts the time from order to delivery 
*/

WITH pizza_orders AS (
SELECT order_id, COUNT(customer_id) AS pizzas_ordered, order_time
FROM pizza_runner.customer_orders
GROUP BY order_id, order_time
ORDER BY pizzas_ordered DESC),

pickup_time AS (
SELECT DISTINCT(order_id), 
TO_TIMESTAMP(runner_orders.pickup_time, 'YYYY/MM/DD/HH24:MI:ss') AS pickup_time
FROM pizza_runner.runner_orders
WHERE pickup_time <> 'null')

SELECT pizzas_ordered,
	AVG(AGE(pickup_time, order_time))
FROM pizza_orders
LEFT JOIN pickup_time
ON pizza_orders.order_id = pickup_time.order_id
GROUP BY (pizzas_ordered)
