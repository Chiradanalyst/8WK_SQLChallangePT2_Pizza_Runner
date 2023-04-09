/*
What was the average distance travelled for each customer?
	STEP 1 Clean data with distance CTE
		- Removed 'KM' with REPLACE function and CAST into a NUMERIC
		- Removed Null values
	STEP 2
		- LEFT JOINED DISTANCE CTE & customer_orders ON order_id
		- USED AVG to aggregate the distance_travelled 
		- grouped this by customer_id 
		- ordered by distance_travelled 
*/
With distance as(
SELECT order_id,
	CAST(REPLACE(distance, 'km', '') AS NUMERIC) as distance
FROM pizza_runner.runner_orders
WHERE distance <> 'null')

SELECT customer_orders.customer_id,
	ROUND(AVG(distance.distance), 1) as distance_travelled
FROM pizza_runner.customer_orders
LEFT JOIN distance
ON customer_orders.order_id = distance.order_id
GROUP BY customer_id
order by distance_travelled

