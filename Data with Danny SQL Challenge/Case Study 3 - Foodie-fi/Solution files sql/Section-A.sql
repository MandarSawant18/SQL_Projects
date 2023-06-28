SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id IN (1, 2, 11, 13, 15, 16, 18, 19)

--Had to join subscriptions and plans to get relevant information


-- Customer#1:
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 1



-- Customer 1 signed up for the initial 7 day free trial on 1st August 2020.The trial plan ended a week later and instead of the automatic subscription to `pro monthly`, Customer 1 downgraded to the `basic monthly` subscription. The company earned $9.90 dollars from Customer 1

 




-- Customer#2:
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 2


-- Customer 2 signed up for the initial 7 day free trial on 20th september,2020. A week later when the free trial ended Customer 2 subscribed to the `pro annual` plan instead of the automatic `pro monthly` subscription. Customer 2 spent a total of $199



 



-- Customer#11:
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 11


-- Customer 11 signed up for the 7 day free trial on 19 November,2022. A week later when the free trial ended, Customer 11 cancelled the plan (`churn`).


 





-- Customer#13:
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 13


-- Customer 13 signed up for the 7 day free trial on 15th December 2020 and a week later when the trial ended, Customer 13 downgraded to a basic monthly subscription. Customer 13 continued this subcription for 3 months and upgraded to the pro montly subscription. They spent a total of $49.60 so far.



 

-- Customer#15:
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 15

-- Customer 15 started the 7 day free trial on 17th March 2020 and after it ended they subcribed to the pro monthly plan. A week after the first pro monthly plan ended, they cancelled it. Since they cancelled a week after the first plan ended, It is likely they subscribed for a second month. Hence even though the plan was cancelled, the second subscription will run till 2020-05-24. They spent a total of $39.80 

 




-- Customer#16:
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 16

-- Customer 16 started the 7 day free trial on 31st May 2020. When the trial ended they subscribed to the basic monthly plan. The basic montly plan continued for 4 months. They then upgraded to the pro monthly plan. However they upgraded after the 4th month's subscription had ended, so it implies that they were on their subcription for basic monthly for the fifth month when they upgraded. Since, the pro annual is a higher plan than basic, it got upgraded straightaway.


 


-- Customer#18:
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 18

-- Customer 18 started the 7 day free trial on 6th July 2020 and subscribed to the pro monthly plan when the free trial ended


 






-- Customer#19:
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 19


-- Customer 19 started the free trial on 22nd June 2020. When it ended they subscribed to the pro monthly plan for 2 months after which they upgraded to the pro annual plan. The company has earned $238.8 from them so far


 
