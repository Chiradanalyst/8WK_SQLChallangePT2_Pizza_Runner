/*
What was the volume of orders for each day of the week?
*/

select
	count(customer_orders) filter (where extract(dow from order_time) = 1) as monday,
	count(customer_orders) filter (where extract(dow from order_time) = 2) as tuesday,
	count(customer_orders) filter (where extract(dow from order_time) = 3) as wednesday,
	count(customer_orders) filter (where extract(dow from order_time) = 4) as thursday,
	count(customer_orders) filter (where extract(dow from order_time) = 5) as friday,
	count(customer_orders) filter (where extract(dow from order_time) = 6) as saturday,
	count(customer_orders) filter (where extract(dow from order_time) = 7) as sunday
FROM pizza_runner.customer_orders


