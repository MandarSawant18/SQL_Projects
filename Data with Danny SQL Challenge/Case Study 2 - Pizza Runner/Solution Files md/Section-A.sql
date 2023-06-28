-- 1.	How many pizzas were ordered?
        SELECT count(pizza_id) AS pizza_count
        FROM customer_orders;

 

-- 2.	How many unique customer orders were made?
        SELECT count(distinct order_id) AS orders
        FROM customer_orders;

--3.	How many successful orders were delivered by each runner?
        SELECT runner_id,
               count(distinct order_id) AS delivered_orders
        FROM runner_orders
        WHERE pickup_time <> 'null'
        GROUP BY  runner_id;

--pickup_time is varchar and hence null should be a string
 
-- 4.	How many of each type of pizza was delivered?
        SELECT pz.pizza_name,
               count (co.pizza_id)
        FROM customer_orders co
        JOIN pizza_names pz
            ON co.pizza_id = pz.pizza_id
        JOIN runner_orders ro
            ON co.order_id = ro.order_id
        WHERE ro.pickup_time <> 'null'
        GROUP BY  pz.pizza_name;	

 


-- 5.	How many Vegetarian and Meatlovers were ordered by each customer?
        SELECT  co.customer_id,
                pz.pizza_name,
                count (co.pizza_id) AS ordered_pizzas
        FROM customer_orders co
        JOIN pizza_names pz
            ON co.pizza_id = pz.pizza_id
        GROUP BY  co.customer_id,pz.pizza_name
        ORDER BY  co.customer_id;

 

-- 6.	What was the maximum number of pizzas delivered in a single order?
        SELECT co.order_id,
               count (co.pizza_id) AS pizza_count
        FROM customer_orders co
        JOIN runner_orders ro
            ON co.order_id = ro.order_id
        WHERE ro.pickup_time <> 'null'
        GROUP BY  co.order_id
        ORDER BY  pizza_count DESC 
        LIMIT 1;

 

-- 7.	For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
        SELECT  customer_id,
                SUM(CASE
                    WHEN ( (exclusions IS NOT NULL AND exclusions<>'null' AND LENGTH(exclusions)>0) AND (extras IS NOT NULL AND extras<>'null' AND LENGTH(extras)>0) )=TRUE 
                    THEN 1 ELSE 0 
                    END) AS changes, 
                SUM(CASE
                    WHEN ( (exclusions IS NOT NULL AND exclusions<>'null'AND LENGTH(exclusions)>0) AND (extras IS NOT NULL AND extras<>'null' AND LENGTH(extras)>0) )=TRUE 
                    THEN 0 ELSE 1 
                    END) AS no_changes
        FROM customer_orders AS co
        INNER JOIN runner_orders AS ro
            ON ro.order_id = co.order_id
        WHERE pickup_time<>'null'
        GROUP BY  customer_id;	

 

-- 8.	How many pizzas were delivered that had both exclusions and extras?
        SELECT COUNT(pizza_id) AS pizzas_delivered_with_exclusions_and_extras
        FROM customer_orders AS co
        INNER JOIN runner_orders AS ro
            ON ro.order_id = co.order_id
        WHERE pickup_time<>'null'
              AND (exclusions IS NOT NULL AND exclusions<>'null'AND LENGTH(exclusions)>0)
              AND (extras IS NOT NULL AND extras<>'null' AND LENGTH(extras)>0);

 

-- 9.	What was the total volume of pizzas ordered for each hour of the day?
        SELECT  extract(hour FROM order_time) AS hour_of_day, 
                count(pizza_id) AS ordered_pizzas
        FROM customer_orders co
        GROUP BY  extract(hour FROM order_time)
        ORDER BY  extract(hour FROM order_time);

 

-- 10.	What was the volume of orders for each day of the week?
        SELECT  to_char(order_time,'Dy') AS day_of_week, 
                count(pizza_id) AS ordered_pizzas
        FROM customer_orders co
        GROUP BY  to_char(order_time, 'Dy');
