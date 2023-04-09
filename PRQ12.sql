/* 

What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ
to pickup the order?
	
	Step 1
		- Create times CTE to clean data 
			- I do this to join my two tables, customer_orders and runner_orders, on order_id
			- I remove duplicate rows with the DISTINCT used on order_id
			- I remove all 'null' values in my where statement 
			- Finally, I convert pickup_time to a TIMESTAMP for step 2
	STEP 2
		- AGE function is used to show the difference between pickup_time & order_time
	
*/ 

WITH times AS (
SELECT DISTINCT(customer_orders.order_id),
	customer_orders.order_time,
	TO_TIMESTAMP(runner_orders.pickup_time, 'YYYY/MM/DD/HH24:MI:ss') AS pickup_time
FROM pizza_runner.customer_orders
LEFT JOIN pizza_runner.runner_orders
ON customer_orders.order_id = runner_orders.order_id
WHERE pickup_time <> 'null')

SELECT order_id,
	AGE(pickup_time, order_time)
FROM times