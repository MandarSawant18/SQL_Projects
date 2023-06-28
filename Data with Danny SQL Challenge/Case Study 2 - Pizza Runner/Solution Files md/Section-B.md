## Section B - Runner and Customer Experience

1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
```bash
SELECT  date_trunc('week',registration_date):: date + 4 AS week_start_date, 
        count(runner_id)
FROM runners
GROUP BY  week_start_date
ORDER BY  week_start_date;

-- +4 is done because calendar week was starting from 28/12/2020 but we wanted week starting from 01/01/2021. Hence 4 days were added

```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/B1.png?raw=true)
Maximum signups occurred in Week 1.

##
2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
```bash
with table1 AS 
    (SELECT ro.order_id,
            ro.runner_id,
            order_time,
            (pickup_time:: timestamp) AS pick_time
    FROM runner_orders ro
    JOIN customer_orders co
        ON ro.order_id = co.order_id
    WHERE pickup_time <> 'null')

SELECT  runner_id,
        round(avg(extract(epoch FROM pick_time - order_time)/60),2) AS avg_minutes
FROM table1
GROUP BY  runner_id;

-- avg_minutes is divided by 60 because from epoch we have extracted seconds and we want time in mins
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/B2.png?raw=true)

Runner 2 is the slowest at delivering.
##
3. Is there any relationship between the number of pizzas and how long the order takes to prepare?
```bash
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

SELECT  pizza_count,
        avg(prep_time)
FROM table2
GROUP BY  pizza_count;


-- prep_time is divided by 60 because from epoch we have extracted seconds and we want time in mins
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/B3.png?raw=true)

We can say that it takes approximately around 10 minutes to prepare a pizza. Consequently, the more pizzas there are, the longer it will take to prepare them.
##
4. What was the average distance travelled for each customer?
```bash
SELECT  co.customer_id,
        round(avg(replace(distance,'km','')::numeric),2) AS avg_duration
FROM customer_orders co
JOIN runner_orders ro
    ON co.order_id = ro.order_id
WHERE pickup_time <> 'null'
GROUP BY  co.customer_id
ORDER BY  co.customer_id;
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/B4.png?raw=true)

Customer 105 resides at the farthest distance, which is 25km, whereas Customer 104 resides at the closest distance, which is 10km.
##
5. What was the difference between the longest and shortest delivery times for all orders?
```bash
with table1 AS 
    (SELECT replace(replace(replace(duration,'minutes',''),'mins',''),'minute','')::integer AS del_time
    FROM runner_orders
    WHERE pickup_time <> 'null')

SELECT max(del_time) - min(del_time) AS delivery_difference
FROM table1;
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/B5.png?raw=true)

There is a 30-minute difference between the longest and shortest delivery times.
##
6. What was the average speed for each runner for each delivery and do you notice any trend for these values?
```bash
with table1 AS 
    (SELECT runner_id,
            order_id,
            replace(replace(replace(duration,'minutes',''),'mins',''),'minute','')::integer AS del_time, 
            replace(distance,'km','')::numeric AS total_distance, 
            round(replace(distance,'km','')::numeric/replace(replace(replace(duration,'minutes',''),'mins',''),'minute','')::integer,2)*60 AS speed
    FROM runner_orders
    WHERE pickup_time <> 'null')

SELECT  runner_id,
        order_id,
        round(avg(speed),2) AS avg_speed_KM_per_HR
FROM table1
GROUP BY  runner_id,order_id
ORDER BY  runner_id,order_id;

-- speed is multiplied by 60 to convert from kms/mins to kms/hr
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/B6.png?raw=true)

The speed of Runner 2 is a matter of concern due to the significant difference between the lowest (35.4 km/hr) and highest (93.6 km/hr) speeds. This discrepancy should be examined.
##
7. What is the successful delivery percentage for each runner?
```bash
with table1 AS 
    (SELECT runner_id,
            count(order_id)::numeric AS all_orders,
            Sum(CASE
                    WHEN pickup_time <> 'null' 
                    THEN 1 
                    ELSE 0 
                END):: numeric AS successful_orders
    FROM runner_orders
    GROUP BY  1)

SELECT  runner_id,
        round((successful_orders/all_orders)*100,0) AS success_percent
FROM table1;

 -- all_orders and successful_orders are converted to numeric else success_percent will be shown as 0

```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Screenshots/B7.png?raw=true)

Runner 1 has the best delivery success rate of 100%, while Runner 3 has the lowest at 50%. However, it is worth mentioning that the runners have no control over order cancellations, which can be initiated by either the customer or the restaurant.
##
Other section [solutions](https://github.com/MandarSawant18/SQL_Projects/tree/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%202%20-%20Pizza%20Runner/Solution%20Files%20md)

##
View other case studies [here](https://github.com/MandarSawant18/SQL_Projects/tree/main/Data%20with%20Danny%20SQL%20Challenge)