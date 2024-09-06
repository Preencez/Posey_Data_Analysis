# Analysing each tables 
# checking for null values on the acounts table 

SELECT id, COUNT(*)
FROM accounts
GROUP BY id
HAVING COUNT(*) > 1;

# sales rep with the highest account
SELECT sales_rep_id, COUNT(*) AS Number_of_Accounts
 FROM accounts
 GROUP BY sales_rep_id
 ORDER BY Number_of_Accounts DESC limit 5;

#the number of accounts, sales representatives, and unique points of contact
 SELECT
   COUNT(*) AS Total_Accounts,
   COUNT(DISTINCT sales_rep_id) AS Number_of_Sales_Reps,
   COUNT(DISTINCT primary_poc) AS Unique_Contacts
 FROM accounts;
 
 