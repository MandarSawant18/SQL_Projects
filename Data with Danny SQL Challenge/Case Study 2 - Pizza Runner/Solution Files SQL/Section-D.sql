--1.	If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?

        SELECT
            SUM(
                CASE
                    WHEN pizza_id = 1 THEN 12
                    ELSE 10
                END
            ) AS total_revenue
        FROM customer_orders co
        JOIN runner_orders ro 
            ON co.order_id = ro.order_id
        WHERE pickup_time <> 'null'

 

-- 2.	What if there was an additional $1 charge for any pizza extras? Add cheese is $1 extra

        WITH table1 AS (
            SELECT
                *,
                CASE
                    WHEN(((length(extras) = 0) OR (extras IS NULL) OR (extras = 'null'))) = TRUE 
                    THEN 0
                    WHEN length(extras) = 1 
                    THEN 1
                    ELSE length(extras) - length(replace(replace (extras, ',', ''), ' ', ''))
                END AS extra_count
            FROM
                customer_orders co
            JOIN runner_orders ro 
                ON co.order_id = ro.order_id
            WHERE ro.pickup_time <> 'null')

        SELECT
            SUM(
                CASE
                    WHEN(pizza_id = 1 AND extra_count = 0) = TRUE 
                    THEN 12
                    WHEN(pizza_id = 1 AND extra_count <> 0) = TRUE 
                    THEN (12 + extra_count)
                    WHEN(pizza_id = 2 AND extra_count = 0) = TRUE 
                    THEN 10
                    WHEN(pizza_id = 2 AND extra_count <> 0) = TRUE 
                    THEN (10 + extra_count)
                END
                ) AS total_revenue
        FROM table1

 


-- 3.	The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.

        DROP TABLE if EXISTS ratings;
        CREATE TABLE ratings (order_id INTEGER, rating INTEGER);
        INSERT INTO
            ratings (order_id, rating)
        VALUES
            (1, 4),
            (2, 3),
            (3, 5),
            (4, 1),
            (5, 4),
            (7, 2),
            (8, 2),
            (10, 5);


        --order_id 6 & 9 were cancelled, hence their ratings are not inserted
		   
		   
	 

-- 4.	Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries? 
        -- (customer_id, order_id, runner_id, rating, order_time, pickup_time, Time between order and pickup, Delivery duration, Average speed, Total number of pizzas

        SELECT
            co.customer_id,
            co.order_id,
            ro.runner_id,
            rating,
            order_time,
            pickup_time:: TIMESTAMP,
            FLOOR(EXTRACT(epoch FROM (pickup_time:: TIMESTAMP - order_time)) / 60) AS time_bw_order_and_pickup,
            replace(replace(replace(duration, 'minutes', ''), 'mins', ''),'minute',''):: INTEGER AS duration_in_mins,
            ROUND(replace(distance, 'km', ''):: NUMERIC / (replace(replace(replace(duration, 'minutes', ''), 'mins', ''),'minute',''):: INTEGER) * 60,2) AS avg_speed_km_per_hr,
            COUNT(pizza_id) AS pizza_count
        FROM customer_orders co
        JOIN runner_orders ro 
            ON co.order_id = ro.order_id
        JOIN ratings rt 
            ON co.order_id = rt.order_id
        WHERE pickup_time <> 'null'
        GROUP BY
            co.customer_id,
            co.order_id,
            ro.runner_id,
            rating,
            order_time,
            pickup_time:: TIMESTAMP,
            FLOOR(EXTRACT(epoch FROM (pickup_time:: TIMESTAMP - order_time)) / 60),
            replace(replace(replace(duration, 'minutes', ''), 'mins', ''),'minute',''):: INTEGER,
            ROUND(replace(distance, 'km', ''):: NUMERIC / (replace(replace(replace(duration, 'minutes', ''), 'mins', ''),'minute',''):: INTEGER) * 60,2)
        ORDER BY co.customer_id

 



-- 5.	If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?

        -- In Q.1, we already know the revenue earned on orders is 138
 
        SELECT round(138 - (sum(round(replace(distance, 'km', '')::numeric, 2))*0.30), 2) AS final_amount_left
        FROM runner_orders
        WHERE pickup_time <> 'null'
