/*
What was the maximum number of pizzas delivered in a single order?
	STEP 1
		- Create runner_orders_cte
			- This is to remove all cancellations from the data set made by both customers and the restaurant
	STEP 2 
		- join the tables and clean the data
		- LEFT JOIN runner_orders_cte & customer_orders on customer_id
		- Use the COUNT Function on customer_orders.order_id
			- GROUP BY runner_orders_cte.order_id
		- ORDER BY count_pizzas_ordered DESC to show the largest order at the top
		- Limit to 1, to only keep the largest order	
	
*/

With runner_orders_cte AS(
SELECT order_id,
	COALESCE(cancellation, '') AS cancellation
FROM pizza_runner.runner_orders
WHERE order_id !=6 and order_id !=9
)

SELECT runner_orders_cte.order_id, COUNT(customer_orders.order_id) AS count_pizzas_ordered
FROM runner_orders_cte
LEFT JOIN pizza_runner.customer_orders
ON runner_orders_cte.order_id = pizza_runner.customer_orders.order_id
GROUP BY runner_orders_cte.order_id
ORDER BY count_pizzas_ordered DESC
LIMIT 1