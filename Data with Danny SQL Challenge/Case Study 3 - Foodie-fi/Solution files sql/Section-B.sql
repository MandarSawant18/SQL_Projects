-- 1.	How many customers has Foodie-Fi ever had?

        SELECT Count(distinct customer_id) AS customer_count
        FROM subscriptions

-- Foodie-Fi has 1,000 unique customers




-- 2.	What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value

        SELECT extract(month FROM start_date) AS month_num,
            to_char(start_date,'Month') AS month_name, 
            count(plan_id)::integer AS user_count
        FROM subscriptions
        WHERE plan_id = 0
        GROUP BY  extract(month
        FROM start_date),to_char(start_date, 'Month')
        ORDER BY  extract(month FROM start_date)

 
-- March had the highest number of people signing up for the trial plan, February recorded the lowest




-- 3.	What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name

        SELECT pl.plan_id,
            initcap(pl.plan_name) AS plan,
            count(pl.plan_id) AS no_of_events
        FROM plans pl
        LEFT JOIN subscriptions sub
        ON pl.plan_id = sub.plan_id
        WHERE sub.start_date >= '2021-01-01'
        GROUP BY  pl.plan_id,pl.plan_name
        ORDER BY  pl.plan_id

        --initcap has capitalized the month names

--There were no customers who signed up for the trial plan in 2021, which means maybe Foodie-fi doesn’t have any new customers in 2021




-- 4.	What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

        SELECT  count(distinct customer_id) AS churn_count,
                round(count(distinct customer_id)::numeric *100 /(SELECT count(distinct customer_id) FROM  subscriptions),1) AS churn_percentage
        FROM subscriptions
        WHERE plan_id = 4

--There are 307 customers who churned, which is 30.7% of Foodie-Fi customer base.



-- 5.	How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

        with table1 AS 
            (SELECT *,
                    row_number()over(partition by customer_id ORDER BY  plan_id) AS ranking
            FROM subscriptions)
            
            
        SELECT  count(distinct customer_id) AS churn_count,
                round(count(distinct customer_id)::numeric *100 /(SELECT count(distinct customer_id)FROM subscriptions),0) AS churn_percentage
        FROM table1
        WHERE ranking = 2 AND plan_id = 4

--92 customers churned straight after the initial free trial which is 9% of entire customer base



-- 6.	What is the number and percentage of customer plans after their initial free trial?

    --Steps: Rank by start_date, this way rank 2 will be the plan customers go to after the end of their trial plan. Count this rank and group by plan

        with plans_table AS 
            (SELECT *,
                    rank()over(partition by customer_id ORDER BY  start_date ) AS ranking
            FROM subscriptions)
            
        SELECT  pt.plan_id,
                initcap(pl.plan_name) AS plan_name,
                count(pt.plan_id) AS plan_count,
                round(count(pt.plan_id)::numeric *100 /(SELECT count(distinct customer_id) FROM subscriptions),2) AS plan_percentage
        FROM plans_table pt
        JOIN plans pl
            ON pt.plan_id = pl.plan_id
        WHERE ranking =2
        GROUP BY  pt.plan_id, initcap(pl.plan_name)

-- Foodie enjoys an over 90% conversion rate with basic monthly plan the most likely plan a user migrates to after the trial period elapses.
--Why more than half (54.6%) the customers prefer to downgrade instead of automatically continue with the pro monthly subscription should be investigated



-- 7.	What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?

    --Steps - Rank by start_date desc so that we can get the latest plan the customer is on. Hence we use rank =1 . Start date is filtered for year 2020.

        with plans_table AS 
            (SELECT *,
                    rank()over(partition by customer_id ORDER BY  start_date desc) AS ranking
            FROM subscriptions
            WHERE start_date <= '2020-12-31')
            
        SELECT  pt.plan_id,
                initcap(pl.plan_name) AS plan_name,
                count(pt.plan_id) AS customer_count,
                round(count(pt.plan_id)::numeric *100 /(SELECT count(distinct customer_id) FROM plans_table           WHERE ranking=1),2) AS customer_percentage
        FROM plans_table pt
        JOIN plans pl
            ON pt.plan_id = pl.plan_id
        WHERE ranking = 1
        GROUP BY  pt.plan_id, initcap(pl.plan_name)
        ORDER BY  pt.plan_id

 
--By December 31, 2020, the pro monthly plan was the most subscribed to. Churn rate is higher here



--8.	How many customers have upgraded to an annual plan in 2020?

        SELECT count(customer_id)::integer AS annual_plan_count
        FROM subscriptions
        WHERE extract(year FROM start_date) = '2020' AND plan_id = 3

--195 customers upgraded to an annual plan in 2020



-- 9.	How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?

    -- Steps-  Find start_date of customers with trial plan
            -- Find date of customers when they start annual plan
            -- Subtract both the dates and take avg

        with table1 AS 
            (SELECT customer_id,
                    start_date AS trial_date
            FROM subscriptions
            WHERE plan_id = 0), 

        table2 AS 
            (SELECT customer_id,
                    start_date AS annual_plan_date
            FROM subscriptions
            WHERE plan_id = 3)

        SELECT round(avg(t2.annual_plan_date - t1.trial_date)) AS avg_no_of_days
        FROM table1 t1
        JOIN table2 t2
            ON t1.customer_id = t2.customer_id

 
-- It takes an average 105 days for customers to upgrade to an annual plan after they join Foodie-Fi.



-- 10.	Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)

    -- Steps-  Find start_date of customers with trial plan
            -- Find date of customers when they start annual plan
            -- width_bucket(operand, min, max, num_of_buckets)
            -- width_bucket(diff in dates, 0, 360,12)
            -- Then count these bucket numbers to get the customer count in that bracket

        with table1 AS 
            (SELECT customer_id,
                    start_date AS trial_date
            FROM subscriptions
            WHERE plan_id = 0),

        table2 AS 
            (SELECT customer_id,
                    start_date AS annual_plan_date
            FROM subscriptions
            WHERE plan_id = 3),

        day_bins AS 
            (SELECT width_bucket(t2.annual_plan_date - t1.trial_date,0,360,12) AS bracket_no,
                    round((annual_plan_date - trial_date)) AS no_of_days
            FROM table1 t1
            JOIN table2 t2
                ON t1.customer_id = t2.customer_id)

        SELECT  concat(((bracket_no-1)*30 +1),'-',bracket_no*30,' days') AS day_bracket, 
                count(bracket_no)::integer AS customer_count
        FROM day_bins
        GROUP BY  bracket_no
        ORDER BY  bracket_no

 


-- 11.	How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

        WITH table1 AS 
            (SELECT *,
                    Lead(plan_id) over( PARTITION BY customer_id ORDER BY  start_date) AS next_plan
            FROM subscriptions
            WHERE Extract(year FROM start_date) = '2020')

        SELECT Count(*) AS downgraded_customers
        FROM table1
        WHERE plan_id = 2 AND next_plan = 1

-- In the year 2020, no customer downgraded from pro monthly to basic monthly. Pro monthly plan must have been good value for money.
