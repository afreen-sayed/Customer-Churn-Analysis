CREATE DATABASE customer_behavior;
USE customer_behavior;

# Question 1: What percentage of customers have churned?

select 
round((sum(case when churn = 1 then 1 else 0 end) * 100.00/ count(*)),2) as percentage
from customer;

# Question 2: Do male or female customers churn more?

select Gender,
round((sum(case when churn = 1 then 1 else 0 end) * 100.00/ count(*)),2) as percentage
from customer
group by Gender;

# Question 3: Churn rate by age group

SELECT 
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 45 THEN '30–45'
        WHEN Age BETWEEN 46 AND 60 THEN '46–60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS churned_customers
FROM customer
WHERE Churn = 1
GROUP BY age_group
ORDER BY churned_customers DESC;

#Question 4:Which income group is most likely to churn?

SELECT 
    Income_Category,
    COUNT(*) AS churned_customers
FROM customer
WHERE Churn = 1
GROUP BY Income_Category
ORDER BY churned_customers DESC;

# Question 5: Which credit card category has the highest churn?

SELECT 
    	Card_Category,
    COUNT(*) AS churned_customers
FROM customer
WHERE Churn = 1
GROUP BY Card_Category
ORDER BY churned_customers DESC;

# Question 6: Do churned customers have lower credit limits?

SELECT 
    Churn,
    ROUND(AVG(Credit_Limit), 2) AS avg_credit_limit
FROM customer
GROUP BY Churn;

# Question 7: Do churned customers perform fewer transactions?

SELECT 
    Churn,
    ROUND(AVG(Total_Transaction_Count), 2) AS Total_Transaction_Count
FROM customer
GROUP BY Churn;

# Question 8: Does inactivity lead to churn?

SELECT 
    Inactive_Months,
    COUNT(*) AS churned_customers
FROM customer
WHERE Churn = 1
GROUP BY Inactive_Months
ORDER BY churned_customers DESC;

# Question 9: What does a high-risk churn customer look like?

SELECT 
    Income_Category,
    Card_Category,
    ROUND(AVG(Credit_Limit), 2) AS avg_credit_limit,
    ROUND(AVG(Total_Transaction_Count), 2) AS avg_transactions
FROM customer
WHERE Churn = 1
GROUP BY Income_Category, Card_Category
ORDER BY avg_transactions ASC;

# Question 10: Compare key metrics between churned and retained customers.

SELECT 
    Churn,
    COUNT(*) AS total_customers,
    ROUND(AVG(Credit_Limit), 2) AS avg_credit_limit,
    ROUND(AVG(Total_Transaction_Count), 2) AS avg_transactions,
    ROUND(AVG(Inactive_Months), 2) AS avg_inactive_months
FROM customer
GROUP BY Churn;