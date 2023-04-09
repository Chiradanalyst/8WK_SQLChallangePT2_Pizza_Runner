/*
How many pizzas were ordered?
	- To solve this I used a COUNT FUNCTION on pizza_id
*/

With customer_orders_cte AS (
SELECT order_id,
	customer_id,
	pizza_id,
	COALESCE(exclusions,'-') AS exclusions,
	COALESCE(extras,'-') AS extras,
	order_time
FROM pizza_runner.customer_orders
)
SELECT COUNT(pizza_id) AS total_pizza_orders
FROM customer_orders_cte
