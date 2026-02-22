-- Create Database 

Create database customer_churn_db;

-- Create Table 

CREATE TABLE telco_customer_churn (
    customerID VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges NUMERIC(10,2),
    TotalCharges NUMERIC(10,2),
    Churn VARCHAR(5)
);

--  Explore Dataset

select*from telco_staging

-- Total customers

SELECT COUNT(*) AS total_customers
FROM telco_staging

-- Check for nulls 

select count(*) from telco_staging 
where customerid is null and 
gender is null and partner is null ;

-- Check for duplicates

- select count(*) from telco_staging
- select distinct count(*) from telco_staging
-- Both has equal value no duplicate found

-- Customer churn rate

Select count(*) as total_customers,
sum(case when churn = 'Yes' then 1 else 0 end ) as churned_customers,
sum(case when churn = 'Yes' then 1 else 0 end )*100.0/ count(*) 
as churn_rate_percent from telco_staging;

-- Churn by gender wise

select gender, sum(case when churn = 'Yes' THEN 1 else 0 end) as gender_churn
from telco_staging
group by gender;

-- churn by contract type

select contract,
COUNT(*) AS total,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned
FROM telco_staging
GROUP BY Contract;

-- Monthly charges vs churn

select Churn,
AVG(monthlycharges) as avg_month_charges
FROM telco_staging
GROUP BY Churn;

-- Churn by tenure

select Churn,
AVG(tenure) as avg_tenure
FROM telco_staging
GROUP BY churn;

-- Churn rate by Tech Support

SELECT 
TechSupport,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 
/ COUNT(*) AS churn_rate_percent
FROM telco_staging
GROUP BY TechSupport
ORDER BY churn_rate_percent DESC;

-- churn by phone service

select phoneservice, count(churn) as churn 
from telco_staging 
group by phoneservice;


