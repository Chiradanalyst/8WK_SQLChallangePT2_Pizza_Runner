/*
What was the total volume of pizzas ordered for each hour of the day?
	STEP 1
		- Count on order_id to count Pizzas ordered as Count_of_pizzas_ordered
		- Performed EXTRACT on order_time to GROUP my Count_of_pizzas_ordered
*/

SELECT EXTRACT('hour' FROM order_time) AS HOUR_OF_DAY, COUNT(order_id) AS Count_of_pizzas_ordered
FROM pizza_runner.customer_orders
GROUP BY EXTRACT('hour' FROM order_time)
ORDER BY hour_of_day;
