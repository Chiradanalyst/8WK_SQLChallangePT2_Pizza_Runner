/*
How many pizzas were delivered that had both exclusions and extras?
	Step 1
		- Create runner_orders_cte to make my main query simpler and cleaner
			- Removed all Null values with COALESCE
			- Removed cancellations with the WHERE function 
	Step 2
		- Main Query
			- LEFT JOIN runner_orders_cte & customer_orders on order_id
			-WHERE function to only keep only values with no entry
				- Did not count Null Values because I cannot confirm that there was no change
				- COUNT on pizza_id to count remaining orders 
	
*/

WITH runner_orders_cte AS(
SELECT order_id, runner_id,
	COALESCE(cancellation, '') AS cancellation
FROM pizza_runner.runner_orders
WHERE order_id <> 6 AND order_id <> 9
)
SELECT COUNT(customer_orders.pizza_id) as total_pizzza_orders_without_eclusions_extras
FROM pizza_runner.customer_orders
LEFT JOIN runner_orders_cte
ON runner_orders_cte.order_id = customer_orders.order_id
WHERE exclusions = '' AND extras = ''
