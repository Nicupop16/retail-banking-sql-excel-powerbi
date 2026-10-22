SELECT name
FROM sqlite_master
WHERE type = 'table'
ORDER BY name;

PRAGMA table_info (customer);
PRAGMA table_info (transactions);

SELECT * FROM customer
LIMIT 10;

SELECT
       transaction_type,
       COUNT(*) AS transactions_count,
	   ROUND(SUM(CAST(AMOUNT AS REAL)), 2) AS net_amount,
	   ROUND(AVG(CAST(AMOUNT AS REAL)),2) AS average_amount
FROM transactions
GROUP BY transaction_type
ORDER BY net_amount DESC;

SELECT 
      customer_id,
	  branch_id,
	  account_type,
	  income_bracket,
	  current_balance
FROM customer
ORDER BY CAST(current_balance AS REAL) DESC
LIMIT 10;

SELECT
       c.account_type,
	   t.transaction_type,
	   COUNT(*) AS transaction_count,
	   ROUND(SUM(CAST(t.amount AS REAL)), 2) AS net_amount
FROM customer AS c
JOIN transactions AS t  
       ON c.customer_id = t.customer_id
GROUP BY 
       c.account_type,
	   t.transaction_type
ORDER BY 
       c.account_type,
	   net_amount DESC;
	   
SELECT 
      customer_id,
	  account_type,
	  last_txn_date,
	  current_balance
FROM customer
LIMIT 10;

SELECT  
      account_type,
	  COUNT(*) AS customer_count
FROM customer
GROUP BY account_type
ORDER BY customer_count DESC;

SELECT 
      transaction_type,
	  COUNT(*) AS  transaction_count,
	  ROUND(AVG(CAST(amount AS REAL)), 2) AS average_amount
FROM transactions
GROUP BY transaction_type
ORDER BY average_amount DESC;

SELECT 
       income_bracket,
	   COUNT(*) AS customer_count,
	   ROUND(AVG(CAST(current_balance AS REAL)), 2) AS average_balance
FROM customer
GROUP BY  income_bracket
ORDER BY average_balance DESC; 

SELECT 
      kyc_status,
	  COUNT(*) AS customer_count
FROM customer
GROUP BY kyc_status
ORDER BY customer_count DESC;

SELECT 
      kyc_status,
	  account_type,
	  COUNT(*) AS customer_count
FROM customer
GROUP BY 
        account_type,
		kyc_status
ORDER BY customer_count DESC;

SELECT 
      c.branch_id,
	  COUNT(*) AS transaction_count
FROM customer AS c
JOIN transactions AS t
     ON c.customer_id = t.customer_id
GROUP BY c.branch_id
ORDER BY transaction_count DESC
LIMIT 10;

SELECT  
       account_type,
	   COUNT(*) AS customer_account,
	   ROUND(SUM(CAST(current_balance AS REAL)), 2) AS total_balance,
	   ROUND(AVG(CAST(current_balance AS REAL)), 2) AS average_balance
FROM customer
GROUP BY account_type
ORDER BY total_balance DESC;

SELECT 
      COUNT(*) AS total_customers,
	  COUNT(customer_id) AS customer_with_id,
	  COUNT(DISTINCT customer_id) AS unique_customers
FROM customer;

SELECT 
       COUNT(*) AS unmatched_transactions
FROM transactions AS t
LEFT JOIN customer AS c
       ON t.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT 
      COUNT(*) AS total_transactions,
	  COUNT(transaction_id) AS transaction_with_id,
	  COUNT(DISTINCT transaction_id) AS unique_transaction
FROM transactions;

SELECT 
      COUNT(*) AS total_customers,
	  COUNT(customer_id) AS customers_with_id,
	  COUNT(*) - COUNT(customer_id) AS missing_customer_ids,
	  COUNT(customer_id) - COUNT(DISTINCT customer_id) AS duplicate_customer_ids 
FROM customer;

SELECT 
      COUNT(*) AS total_transactions,
	  COUNT(transaction_id) AS transactions_with_id,
	  COUNT(*) - COUNT(transaction_id) AS missing_transaction_ids,
	  COUNT(transaction_id) - COUNT(DISTINCT transaction_id) AS duplicate_transaction_ids
FROM transactions;
	  
	  
