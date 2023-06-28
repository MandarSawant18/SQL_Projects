## Section A - Customer Journey

1. Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each customer’s onboarding journey. 
####

```bash
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id IN (1, 2, 11, 13, 15, 16, 18, 19)

--Had to join subscriptions and plans to get relevant information
```
##


**Customer 1**
```bash
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 1
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%203%20-%20Foodie-fi/Screenshots/A1.png?raw=true)

Customer 1 signed up for the initial 7 day "free trial" on 1st August 2020.The trial plan ended a week later and instead of the automatic subscription to "pro monthly", Customer 1 downgraded to the "basic monthly" subscription. The company earned $9.90 dollars from Customer 1
##
**Customer 2**
```bash
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 2
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%203%20-%20Foodie-fi/Screenshots/A2.png?raw=true)

On September 20th, 2020, Customer 2 enrolled in the initial 7-day "free trial." After the trial period ended a week later, Customer 2 opted for the "pro annual" plan instead of the automatic "pro monthly" subscription. Customer 2 paid a total of $199.
##
**Customer 11**
```bash
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 11
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%203%20-%20Foodie-fi/Screenshots/A11.png?raw=true)

On November 19, 2022, Customer 11 registered for the 7-day "free trial." After a week, when the trial period expired, Customer 11 terminated the plan (churned).
##
**Customer 13**
```bash
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 13
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%203%20-%20Foodie-fi/Screenshots/A13.png?raw=true)

Customer 13 enrolled in the 7-day "free trial" on December 15, 2020. After the trial concluded one week later, Customer 13 switched to a "basic monthly" subscription. They maintained this subscription for three months before upgrading to the "pro monthly" subscription. In total, they have spent $49.60 thus far.
##
**Customer 15**
```bash
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 15
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%203%20-%20Foodie-fi/Screenshots/A15.png?raw=true)

Customer 15 initiated a 7-day "free trial" on March 17th, 2020. After the trial concluded, they opted for the "pro monthly" plan. However, they cancelled this plan a week after its initial term ended. Considering the cancellation occurred a week after the first plan ended, it is probable that they subscribed for a second month. Consequently, despite the plan being cancelled, the second subscription will remain active until May 24th, 2020. In total, they spent $39.80.
##
**Customer 16**
```bash
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 16
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%203%20-%20Foodie-fi/Screenshots/A16.png?raw=true)

Customer 16 initiated the 7-day "free trial" on May 31, 2020. Upon the expiration of the trial, they opted for the "basic monthly" plan. They remained on this plan for 4 months before switching to the "pro annual plan". Notably, the upgrade occurred after the completion of the fourth month's subscription, indicating that they remained on the basic monthly plan during the fifth month when the upgrade took place. As the pro annual plan is superior to the basic plan, it was immediately upgraded.
##
**Customer 18**
```bash
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 18
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%203%20-%20Foodie-fi/Screenshots/A18.png?raw=true)

Customer 18 initiated the 7-day "free trial" on July 6, 2020, and upgraded to the "pro monthly" plan once the free trial period concluded.
##
**Customer 19**
```bash
SELECT  customer_id,
        plan_name,
        price,
        start_date
FROM subscriptions sub
JOIN plans pl
  ON sub.plan_id = pl.plan_id
WHERE customer_id = 19
```
![](https://github.com/MandarSawant18/SQL_Projects/blob/main/Data%20with%20Danny%20SQL%20Challenge/Case%20Study%203%20-%20Foodie-fi/Screenshots/A19.png?raw=true)

Customer 19 initiated the "free trial" on June 22nd, 2020. Upon its conclusion, they proceeded to subscribe to the "pro monthly" plan for a duration of 2 months, following which they upgraded to the "pro annual" plan. To date, the company has generated a total revenue of $238.8 from this customer.
