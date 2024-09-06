-- INSIGHTS FROM POSEY DATABASE

-- Analysing each tables and checking for null values on the accounts table

SELECT id, COUNT(*)
FROM accounts
GROUP BY id
HAVING COUNT(*) > 1;

-- 1. The sales rep with the highest account?

SELECT sales_rep_id, COUNT(*) AS Number_of_Accounts
 FROM accounts
 GROUP BY sales_rep_id
 ORDER BY Number_of_Accounts DESC limit 5;

-- 2. The number of accounts, sales representatives, and unique points of contact
 SELECT
   COUNT(*) AS Total_Accounts,
   COUNT(DISTINCT sales_rep_id) AS Number_of_Sales_Reps,
   COUNT(DISTINCT primary_poc) AS Unique_Contacts
 FROM accounts;


-- 3. What is the total revenue from standard, gloss, and poster products?

SELECT SUM(standard_amt_usd) total_standard_amt, SUM(gloss_amt_usd) gloss_standard_amt, 
SUM(poster_amt_usd) poster_standard_amt
FROM orders;

-- 4. Which accounts have purchased the most standard products? 

SELECT o.account_id, TRIM(a.name) company_name, SUM(o.standard_amt_usd) total_standard_amt 
FROM orders o
LEFT JOIN accounts a ON a.id = o.account_id
GROUP BY 1,2
ORDER BY 3 DESC;

-- 5. Which accounts have purchased the most gloss products?

SELECT o.account_id, TRIM(a.name) company_name, SUM(o.gloss_amt_usd) gloss_standard_amt
FROM orders o
LEFT JOIN accounts a ON a.id = o.account_id
GROUP BY 1,2
ORDER BY 3 DESC;

-- 6. Which accounts have purchased the most poster products?

SELECT o.account_id, TRIM(a.name) company_name, SUM(o.poster_amt_usd) poster_standard_amt
FROM orders o
LEFT JOIN accounts a ON a.id = o.account_id
GROUP BY 1,2
ORDER BY 3 DESC;

-- 7. Which months have the highest total sales revenue?

SELECT TO_CHAR(occurred_at, 'YYYY-MM') month_year, SUM(total_amt_usd) total_sales
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

-- 8. What is the average revenue per order?

SELECT o.account_id, TRIM(a.name) company_name, AVG(o.total_amt_usd) avg_revenue
FROM orders o
LEFT JOIN accounts a ON a.id = o.account_id
GROUP BY 1,2
ORDER BY 3 DESC;

-- 9. Which regions generate the most revenue?

SELECT TRIM(r.name) region_name, SUM(o.total_amt_usd) total_revenue
FROM orders o
LEFT JOIN accounts a ON a.id = o.account_id
LEFT JOIN sales_reps s ON a.sales_rep_id = s.id
LEFT JOIN region r ON s.region_id = r.id
GROUP BY 1
ORDER BY 2 DESC;

-- 10. How does the total number of orders vary across regions?

SELECT TRIM(r.name) region_name, SUM(o.standard_qty) standard_qty, SUM(o.gloss_qty) gloss_qty, 
	SUM(o.poster_qty) poster_qty, SUM(o.total) total
FROM orders o
LEFT JOIN accounts a ON a.id = o.account_id
LEFT JOIN sales_reps s ON a.sales_rep_id = s.id
LEFT JOIN region r ON s.region_id = r.id
GROUP BY 1
ORDER BY 5 DESC;

-- 11. Who are the top 3 sales reps by total revenue and number of orders?

SELECT TRIM(s.name) sales_rep_name, SUM(o.total_amt_usd) total_amount, SUM(o.total) total_order
FROM orders o
LEFT JOIN accounts a ON a.id = o.account_id
LEFT JOIN sales_reps s ON a.sales_rep_id = s.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;

-- 12. Which sales rep from what region, handles the most accounts?

SELECT TRIM(s.name) sales_rep_name, TRIM(r.name) region_name, count(*) no_of_accounts
FROM accounts a
LEFT JOIN sales_reps s ON a.sales_rep_id = s.id
LEFT JOIN region r ON s.region_id = r.id
GROUP BY 1,2
ORDER BY 3 DESC;

