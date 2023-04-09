/*
How many successful orders were delivered by each runner?
	Step 1:
		- Create runner_orders_cte to remove all NULL values
			- COALESCE is used to replace NULL values with NA
	STEP 2 
		- COUNT order_id
			- GROUP BY runner_id
		- WHERE function to remove all cancellations
			- Then ORDER BY DESC to get the largest to smallest values using count_of_orders
*/
WITH runner_orders_cte AS(
SELECT order_id, runner_id,
	COALESCE(pickup_time, 'NA') AS pickup_time,
	COALESCE(distance, 'NA') AS distance,
	COALESCE(duration,'NA') AS duration,
	COALESCE(cancellation, 'NA') AS cancellation
FROM pizza_runner.runner_orders)

Select runner_id,
	count(order_id) as count_of_orders
FROM runner_orders_cte
WHERE cancellation != 'Restaurant Cancellation' AND cancellation != 'Customer Cancellation'
GROUP BY runner_id
ORDER BY count_of_orders DESC
