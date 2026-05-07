-- ============================================================
-- PROJECT: Data Analytics with SQL, MongoDB & BigQuery
-- FILE: bigquery/create_tables.sql
-- DESCRIPTION: DDL statements to create tables in BigQuery.
--              Run these in the BigQuery UI before uploading data.
-- ============================================================

-- Replace 'your_project.your_dataset' with your actual GCP details

-- ----------------------------------------------------------
-- 1. Create Users Table (Data from MySQL)
-- ----------------------------------------------------------
CREATE OR REPLACE TABLE `your_project.your_dataset.users` (
    id INT64 NOT NULL,
    name STRING NOT NULL,
    email STRING NOT NULL,
    registration_date DATE NOT NULL,
    country STRING NOT NULL,
    membership_tier STRING NOT NULL,
    age INT64 NOT NULL
);

-- ----------------------------------------------------------
-- 2. Create Products Table (Data from MySQL)
-- ----------------------------------------------------------
CREATE OR REPLACE TABLE `your_project.your_dataset.products` (
    id INT64 NOT NULL,
    name STRING NOT NULL,
    category STRING NOT NULL,
    price FLOAT64 NOT NULL,
    stock_qty INT64,
    brand STRING
);

-- ----------------------------------------------------------
-- 3. Create Transactions Table (Data from MySQL)
-- ----------------------------------------------------------
CREATE OR REPLACE TABLE `your_project.your_dataset.transactions` (
    id INT64 NOT NULL,
    user_id INT64 NOT NULL,
    product_id INT64 NOT NULL,
    amount FLOAT64 NOT NULL,
    transaction_date DATE NOT NULL,
    status STRING NOT NULL,
    payment_method STRING
);

-- ----------------------------------------------------------
-- 4. Create Reviews Table (Data from MongoDB)
-- ----------------------------------------------------------
CREATE OR REPLACE TABLE `your_project.your_dataset.reviews` (
    user_id INT64 NOT NULL,
    product_id INT64 NOT NULL,
    product_name STRING NOT NULL,
    category STRING NOT NULL,
    product_price FLOAT64 NOT NULL,
    rating INT64 NOT NULL,
    review_text STRING NOT NULL,
    word_count INT64 NOT NULL,
    helpful_votes INT64,
    verified_purchase BOOL,
    created_at TIMESTAMP NOT NULL
);
