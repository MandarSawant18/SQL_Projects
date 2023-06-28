-- 1.	How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

        SELECT date_trunc('week',registration_date):: date + 4 AS week_start_date, 
               count(runner_id)
        FROM runners
        GROUP BY  week_start_date
        ORDER BY  week_start_date;

        --+4 is added because calendar week was starting from 28/12/2020 but we wanted week starting from 01/01/2021. Hence 4 days were added

 
-- 2.	What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

        with table1 AS 
            (SELECT ro.order_id,
                    ro.runner_id,
                    order_time,
                    (pickup_time:: timestamp) AS pick_time
            FROM runner_orders ro
            JOIN customer_orders co
                ON ro.order_id = co.order_id
            WHERE pickup_time <> 'null')

        SELECT runner_id,
               round(avg(extract(epoch FROM pick_time - order_time)/60),2) AS avg_minutes
        FROM table1
        GROUP BY  runner_id;

        --avg_minutes is divided by 60 because from epoch we have extracted seconds and we want time in mins

 


-- 3.	Is there any relationship between the number of pizzas and how long the order takes to prepare?

        with table1 AS 
            (SELECT co.order_id,
                    co.pizza_id,
                    order_time,
                    (pickup_time:: timestamp) AS pick_time
            FROM runner_orders ro
            JOIN customer_orders co
                ON ro.order_id = co.order_id
            WHERE pickup_time <> 'null'), 

        table2 AS 
            (SELECT order_id,
                    count(pizza_id) AS pizza_count,
                    extract(epoch FROM pick_time - order_time)/60 AS prep_time
            FROM table1
            GROUP BY  1,3) 

        SELECT pizza_count,
                avg(prep_time)
        FROM table2
        GROUP BY  pizza_count;


        --prep_time is divided by 60 because from epoch we have extracted seconds and we want time in mins

 


-- 4.	What was the average distance travelled for each customer?

        SELECT co.customer_id,
                round(avg(replace(distance,'km','')::numeric),2) AS avg_duration
        FROM customer_orders co
        JOIN runner_orders ro
            ON co.order_id = ro.order_id
        WHERE pickup_time <> 'null'
        GROUP BY  co.customer_id
        ORDER BY  co.customer_id;

 


-- 5.	What was the difference between the longest and shortest delivery times for all orders?

        with table1 AS 
            (SELECT replace(replace(replace(duration,'minutes',''),'mins',''),'minute','')::integer AS del_time
            FROM runner_orders
            WHERE pickup_time <> 'null')

        SELECT max(del_time) - min(del_time) AS delivery_difference
        FROM table1;

 

-- 6.	What was the average speed for each runner for each delivery and do you notice any trend for these values?

        --speed is multiplied by 60 to convert from kms/mins to kms/hr

        with table1 AS 
            (SELECT runner_id,
                    order_id,
                    replace(replace(replace(duration,'minutes',''),'mins',''),'minute','')::integer AS del_time, 
                    replace(distance,'km','')::numeric AS total_distance, 
                    round(replace(distance,'km','')::numeric/replace(replace(replace(duration,'minutes',''),'mins',''),'minute','')::integer,2)*60 AS speed
            FROM runner_orders
            WHERE pickup_time <> 'null')

        SELECT runner_id,
                order_id,
                round(avg(speed),2) AS avg_speed_KM_per_HR
        FROM table1
        GROUP BY  runner_id,order_id
        ORDER BY  runner_id,order_id;

 
-- 7.	What is the successful delivery percentage for each runner?

        --all_orders and successful_orders are converted to numeric because else success_percent will show as 0

        with table1 AS 
            (SELECT runner_id,
                    Count(order_id)::numeric AS all_orders,
                    Sum(CASE
                            WHEN pickup_time <> 'null' 
                            THEN 1 ELSE 0 
                        END):: numeric AS successful_orders
            FROM runner_orders
            GROUP BY  1)

        SELECT runner_id,
                round((successful_orders/all_orders)*100,0) AS success_percent
        FROM table1;

 
