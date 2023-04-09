/*How many unique customer orders were made?

	- Performed a NESTED COUNT/DISTINCT on cutomer_id and labeled it total_orders
*/

SELECT count(distinct(order_id)) AS total_orders
FROM pizza_runner.customer_orders