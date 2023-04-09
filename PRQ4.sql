/*

How many of each type of pizza was delivered?
	Step 1
		- I created 2 CTEs to remove all NULL values from my tables
			- Customer_orders_cte
			- runner_orders_cte
	Step 2
		- I used the main QUERY to LEFT join these two tables together using order_id
			- A WHERE function was used on Cancellation to remove 'Restaurant Cancellation'
			and 'Customer Cancellation'
		- Next a COUNT function was used on order_id 
			- GROUPED BY pizza_id
	All of this left us
		- Pizza ID
		- Total_pizzas_ordered 
*/

With customer_orders_cte AS (
SELECT order_id,
	customer_id,
	pizza_id,
	COALESCE(exclusions,'NA') AS exclusions,
	COALESCE(extras,'NA') AS extras,
	order_time
FROM pizza_runner.customer_orders
),
runner_orders_cte AS(
SELECT order_id, runner_id,
	COALESCE(pickup_time, 'NA') AS pickup_time,
	COALESCE(distance, 'NA') AS distance,
	COALESCE(duration,'NA') AS duration,
	COALESCE(cancellation, 'NA') AS cancellation
FROM pizza_runner.runner_orders)

SELECT customer_orders_cte.pizza_id, count(runner_orders_cte.order_id) as total_pizzas_ordered
FROM runner_orders_cte
LEFT JOIN customer_orders_cte
ON runner_orders_cte.order_id = customer_orders_cte.order_id
WHERE cancellation != 'Restaurant Cancellation' AND cancellation != 'Customer Cancellation'
GROUP BY customer_orders_cte.pizza_id
ORDER BY total_pizzas_ordered DESC