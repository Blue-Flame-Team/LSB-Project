# Comprehensive Report for LSB-Project: Cloud Data Analytics Platform

## 1. Project Introduction

The LSB-Project aims to build an integrated hybrid data analytics platform that combines different types of data and utilizes various analytical tools to provide comprehensive insights. The project focuses on integrating **structured data** stored in relational databases (using MySQL), **unstructured data** stored in NoSQL databases (using MongoDB), and **powerful cloud analytics** (using Google BigQuery) to process complex analytical queries. The project is characterized by its **Pure Data Architecture**, which does not rely on intermediate code like Python for data processing, but rather directly on database tools.

## 2. Project Structure and Components

The project consists of three main layers, each dealing with a specific type of data and offering distinct analytical capabilities:

### 2.1. MySQL Layer (Structured Data)

This layer uses MySQL (via WAMP server) to store structured data such as user information, products, and financial transactions. Tables are set up and initial data (seeding) is inserted in this layer.

### 2.2. MongoDB Layer (Unstructured Data)

MongoDB is used to store unstructured data, such as customer reviews containing long texts and ratings. This data is imported and analyzed using MongoDB Shell queries.

### 2.3. Google BigQuery Layer (Powerful Cloud Analytics)

This layer is the core of deep analysis, where data from MySQL and MongoDB are uploaded and integrated into a cloud data warehouse on Google BigQuery. This allows for complex, multi-source analyses to answer challenging business questions.

## 3. Operation and Setup Guide

To run the project and extract results, the following steps must be followed for each layer:

### 3.1. Setting up the MySQL Layer (using WAMP Server)

1.  **Start WAMP Server:** Open the WampServer program and ensure its icon turns green, indicating that Apache and MySQL servers are running.
2.  **Access phpMyAdmin:** Open your browser and navigate to `http://localhost/phpmyadmin`. Use `root` as the username and leave the password blank (by default).
3.  **Create Database and Tables:**
    *   From phpMyAdmin, go to the **SQL** tab.
    *   Open the `sql/schema.sql` file from the project folder, copy the code, paste it into the SQL box, and click **Go**.
    *   This will create a database named `analytics_db` and three basic tables (Users, Products, Transactions).
4.  **Insert Default Data (Seeding):**
    *   Select the `analytics_db` database from the left-hand menu in phpMyAdmin.
    *   Go to the **SQL** tab again.
    *   Open the `sql/insert_data.sql` file, copy the code, paste it, and click **Go**.
    *   This will insert default data for 30 users, 20 products, and 60 financial transactions.

### 3.2. Setting up the MongoDB Layer (Unstructured Data)

1.  **Import Data:** Ensure the MongoDB server is running. Open the command line (CMD/Terminal), navigate to the project folder, and execute the following command to import the reviews file:
    ```bash
    mongoimport --db analytics_db --collection reviews --file mongodb/sample_reviews.json --jsonArray
    ```
    This will add 30 documents to the database.
2.  **Examine Data (Optional):** You can use MongoDB Compass to connect to `mongodb://localhost:27017` and inspect the `analytics_db` database and the `reviews` collection.

### 3.3. Setting up the Google BigQuery Layer

1.  **Set up Workspace:**
    *   Log in to the [Google Cloud Console](https://console.cloud.google.com).
    *   Search for **BigQuery** in the top search bar.
    *   In the Explorer menu on the left, click the three dots next to your project name and select **Create data set**.
    *   Specify the name `analytics_dataset` and click **Create Data set**.
2.  **Upload Data:** You will upload four files (CSV and JSON) to create four tables:
    *   Next to `analytics_dataset`, click the three dots and select **Create table**.
    *   **For MySQL tables (Users, Products, Transactions):** Choose source (Upload), upload `data/users.csv`, `data/products.csv`, `data/transactions.csv` respectively. For each table, specify the appropriate table name (users, products, transactions) and enable **Auto detect** in the Schema section.
    *   **For MongoDB table (Reviews):** Choose source (Upload), upload `mongodb/sample_reviews.json`. Set the file format to `JSONL / JSON (Newline Delimited)`. The table name is `reviews`, and enable **Auto detect**.

## 4. Query Analysis and Results

Key queries from each layer (MySQL, MongoDB, BigQuery) have been executed and their results simulated. Here is a breakdown of the results:

### 4.1. MySQL Queries (Structured Data)

The following queries were executed on the structured data in MySQL (simulated using SQLite):

**Q1. User count per membership tier and average age:**

| membership_tier | total_users | avg_age |
|:----------------|:------------|:--------|
| Bronze          | 16          | 31.0    |
| Gold            | 5           | 34.0    |
| Platinum        | 3           | 36.7    |
| Silver          | 6           | 31.7    |

**Q2. Total revenue and average order value per product category:**

| category       | total_orders | total_revenue | avg_order_value |
|:---------------|:-------------|:--------------|:----------------|
| Electronics    | 16           | 15843.90      | 990.24          |
| Sports         | 4            | 3994.97       | 998.74          |
| Home & Kitchen | 9            | 3779.91       | 419.99          |
| Clothing       | 17           | 1654.83       | 97.34           |
| Books          | 12           | 484.88        | 40.41           |

**Q3. Top 10 customers by total spending:**

| id | name             | membership_tier | purchase_count | total_spent |
|:---|:-----------------|:----------------|:---------------|:------------|
| 1  | Ahmed Hassan     | Platinum        | 4              | 3933.98     |
| 3  | Mohamed Ali      | Platinum        | 4              | 2823.97     |
| 10 | Rania Fawzy      | Silver          | 3              | 1998.98     |
| 17 | Samir Abdallah   | Bronze          | 1              | 1899.00     |
| 7  | Khaled Mansour   | Gold            | 3              | 1788.98     |
| 4  | Fatima Al-Rashid | Gold            | 4              | 1674.96     |
| 9  | Yousef Al-Ahmad  | Gold            | 3              | 1489.97     |
| 15 | Amr Farouk       | Silver          | 1              | 1299.99     |
| 23 | Wael Gaber       | Bronze          | 1              | 1299.99     |
| 20 | Nadia Sami       | Bronze          | 1              | 1199.00     |

### 4.2. MongoDB Queries (Unstructured Data)

MongoDB queries were simulated to analyze product reviews. Below is the result of the average rating per category query:

**Average rating per category:**

| category       | mean     | count |
|:---------------|:---------|:------|
| Sports         | 4.800000 | 5     |
| Books          | 4.666667 | 6     |
| Electronics    | 4.625000 | 8     |
| Home & Kitchen | 4.166667 | 6     |
| Clothing       | 3.600000 | 5     |

### 4.3. Google BigQuery Queries (Final Analytics)

BigQuery queries that integrate data from MySQL and MongoDB were simulated to answer complex analytical questions:

**Task 1: Membership Engagement**

Question: Do older accounts (from SQL) contribute more reviews (from MongoDB) than newer ones?

| cohort             | total_users | total_reviews | avg_reviews_per_user |
|:-------------------|:------------|:--------------|:---------------------|
| Mid (1-2 years)    | 4.0         | 4.0           | 1.0                  |
| Senior (3-4 years) | 9.0         | 9.0           | 1.0                  |
| Veteran (5+ years) | 17.0        | 17.0          | 1.0                  |

*Note: The results show that the average number of reviews per user is consistent across all account age cohorts in this simulated data.*

**Task 2: Product Feedback**

Question: Which product categories receive the most descriptive (long) reviews?

| category       | total_reviews | avg_word_count | avg_rating | highly_descriptive_reviews | highly_descriptive_pct |
|:---------------|:--------------|:---------------|:-----------|:---------------------------|:-----------------------|
| Electronics    | 8.0           | 58.5           | 4.62       | 5                          | 62.5                   |
| Books          | 6.0           | 57.8           | 4.67       | 4                          | 66.67                  |
| Home & Kitchen | 6.0           | 55.3           | 4.17       | 4                          | 66.67                  |
| Clothing       | 5.0           | 38.0           | 3.60       | 0                          | 0.0                    |

**Task 3: Price vs. Sentiment**

Question: Is there a statistical link between the cost of a product and the rating given in the reviews?

*   **Overall Pearson Correlation:** 0.2116 (Indicates a weak positive correlation between price and rating overall).

*   **Pearson Correlation segmented by category:**

| category       | pearson_correlation |
|:---------------|:--------------------|
| Books          | 0.2998              |
| Clothing       | 0.2432              |
| Electronics    | -0.4896             |
| Home & Kitchen | 0.4575              |

*Note: A strong negative correlation between price and rating is observed in the Electronics category, while a moderate positive correlation is seen in Books, Clothing, and Home & Kitchen categories.*

## 5. Conclusion

The LSB-Project provides a robust model for hybrid data analytics, demonstrating how to integrate data from various sources (structured and unstructured) and utilize advanced analytical tools like Google BigQuery to extract valuable insights. Through this project, organizations can understand user behavior, product performance, and complex relationships between different variables, thereby supporting informed business decisions. The project highlights the importance of a data infrastructure that relies directly on database tools for efficiency and accuracy in analysis.
