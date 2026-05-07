-- ============================================================
-- PROJECT: Data Analytics with SQL, MongoDB & BigQuery
-- FILE: sql/queries.sql
-- DESCRIPTION: Analytical SQL queries run on MySQL to explore
--              the structured data before loading to BigQuery
-- ============================================================

USE analytics_db;

-- ──────────────────────────────────────────────────────────
-- Q1. User count per membership tier
-- ──────────────────────────────────────────────────────────
SELECT
    membership_tier,
    COUNT(*)          AS total_users,
    ROUND(AVG(age),1) AS avg_age
FROM users
GROUP BY membership_tier
ORDER BY FIELD(membership_tier, 'Platinum','Gold','Silver','Bronze');

-- ──────────────────────────────────────────────────────────
-- Q2. Total revenue and avg order value per product category
-- ──────────────────────────────────────────────────────────
SELECT
    p.category,
    COUNT(t.id)              AS total_orders,
    ROUND(SUM(t.amount), 2)  AS total_revenue,
    ROUND(AVG(t.amount), 2)  AS avg_order_value
FROM transactions t
JOIN products p ON t.product_id = p.id
WHERE t.status = 'completed'
GROUP BY p.category
ORDER BY total_revenue DESC;

-- ──────────────────────────────────────────────────────────
-- Q3. Top 10 customers by total spending
-- ──────────────────────────────────────────────────────────
SELECT
    u.id,
    u.name,
    u.membership_tier,
    u.registration_date,
    COUNT(t.id)             AS purchase_count,
    ROUND(SUM(t.amount), 2) AS total_spent
FROM users u
JOIN transactions t ON u.id = t.user_id
WHERE t.status = 'completed'
GROUP BY u.id, u.name, u.membership_tier, u.registration_date
ORDER BY total_spent DESC
LIMIT 10;

-- ──────────────────────────────────────────────────────────
-- Q4. Monthly revenue trend
-- ──────────────────────────────────────────────────────────
SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    COUNT(id)                              AS total_orders,
    ROUND(SUM(amount), 2)                  AS monthly_revenue
FROM transactions
WHERE status = 'completed'
GROUP BY month
ORDER BY month;

-- ──────────────────────────────────────────────────────────
-- Q5. Products with no transactions (dead stock)
-- ──────────────────────────────────────────────────────────
SELECT
    p.id,
    p.name,
    p.category,
    p.price,
    p.stock_qty
FROM products p
LEFT JOIN transactions t ON p.id = t.product_id AND t.status = 'completed'
WHERE t.id IS NULL;

-- ──────────────────────────────────────────────────────────
-- Q6. Users who registered in 2018 (veteran cohort) vs
--     their total transaction count
-- ──────────────────────────────────────────────────────────
SELECT
    u.id,
    u.name,
    u.registration_date,
    u.membership_tier,
    COUNT(t.id)             AS tx_count,
    ROUND(SUM(t.amount),2)  AS total_spent
FROM users u
LEFT JOIN transactions t ON u.id = t.user_id AND t.status = 'completed'
WHERE YEAR(u.registration_date) = 2018
GROUP BY u.id, u.name, u.registration_date, u.membership_tier
ORDER BY tx_count DESC;
