-- ============================================================
-- PROJECT: Data Analytics with SQL, MongoDB & BigQuery
-- FILE: bigquery/analysis_queries.sql
-- DESCRIPTION: BigQuery SQL statements to answer the 3 main
--              analysis tasks.
-- ============================================================

-- NOTE: Replace 'your_project.your_dataset' before running

-- ----------------------------------------------------------
-- TASK 1: Membership Engagement
-- Question: Do older accounts (from SQL) contribute more 
--           reviews (from MongoDB) than newer ones?
-- ----------------------------------------------------------
WITH user_cohorts AS (
  SELECT
    id AS user_id,
    CASE 
      WHEN DATE_DIFF(CURRENT_DATE(), registration_date, YEAR) >= 5 THEN 'Veteran (5+ years)'
      WHEN DATE_DIFF(CURRENT_DATE(), registration_date, YEAR) >= 3 THEN 'Senior (3-4 years)'
      WHEN DATE_DIFF(CURRENT_DATE(), registration_date, YEAR) >= 1 THEN 'Mid (1-2 years)'
      ELSE 'New (< 1 year)'
    END AS cohort
  FROM `your_project.your_dataset.users`
),
review_counts AS (
  SELECT user_id, COUNT(*) as review_count
  FROM `your_project.your_dataset.reviews`
  GROUP BY user_id
)
SELECT 
  u.cohort,
  COUNT(u.user_id) AS total_users,
  COALESCE(SUM(r.review_count), 0) AS total_reviews,
  ROUND(COALESCE(SUM(r.review_count), 0) / COUNT(u.user_id), 2) AS avg_reviews_per_user
FROM user_cohorts u
LEFT JOIN review_counts r ON u.user_id = r.user_id
GROUP BY u.cohort
ORDER BY 
  CASE u.cohort 
    WHEN 'Veteran (5+ years)' THEN 1 
    WHEN 'Senior (3-4 years)' THEN 2 
    WHEN 'Mid (1-2 years)' THEN 3 
    ELSE 4 
  END;

-- ----------------------------------------------------------
-- TASK 2: Product Feedback
-- Question: Which categories of products receive the most 
--           descriptive reviews in the log files?
-- ----------------------------------------------------------
SELECT 
  p.category,
  COUNT(r.user_id) AS total_reviews,
  ROUND(AVG(r.word_count), 1) AS avg_word_count,
  ROUND(AVG(r.rating), 2) AS avg_rating,
  COUNTIF(r.word_count > 70) AS highly_descriptive_reviews,
  ROUND((COUNTIF(r.word_count > 70) / COUNT(r.user_id)) * 100, 1) AS highly_descriptive_pct
FROM `your_project.your_dataset.reviews` r
JOIN `your_project.your_dataset.products` p ON r.product_id = p.id
GROUP BY p.category
ORDER BY avg_word_count DESC;

-- ----------------------------------------------------------
-- TASK 3: Price vs. Sentiment
-- Question: Is there a statistical link between the cost of 
--           a product and the rating given in the unstructured documents?
-- ----------------------------------------------------------
-- 1. Overall Pearson Correlation across all products
SELECT 
  'Overall' AS analysis_level,
  ROUND(CORR(p.price, r.rating), 4) AS pearson_correlation,
  COUNT(r.user_id) AS total_reviews,
  ROUND(AVG(p.price), 2) AS avg_price,
  ROUND(AVG(r.rating), 2) AS avg_rating
FROM `your_project.your_dataset.reviews` r
JOIN `your_project.your_dataset.products` p ON r.product_id = p.id;

-- 2. Pearson Correlation segmented by category
SELECT 
  p.category AS analysis_level,
  ROUND(CORR(p.price, r.rating), 4) AS pearson_correlation,
  COUNT(r.user_id) AS total_reviews,
  ROUND(AVG(p.price), 2) AS avg_price,
  ROUND(AVG(r.rating), 2) AS avg_rating
FROM `your_project.your_dataset.reviews` r
JOIN `your_project.your_dataset.products` p ON r.product_id = p.id
GROUP BY p.category
ORDER BY pearson_correlation DESC;
