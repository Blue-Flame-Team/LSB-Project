-- ============================================================
-- PROJECT: Data Analytics with SQL, MongoDB & BigQuery
-- FILE: sql/schema.sql
-- DESCRIPTION: MySQL schema — structured relational data
--              (Users, Products, Transactions)
-- ============================================================

CREATE DATABASE IF NOT EXISTS analytics_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE analytics_db;

-- ----------------------------------------------------------
-- TABLE: users
-- ----------------------------------------------------------
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS products;

CREATE TABLE users (
    id                INT AUTO_INCREMENT PRIMARY KEY,
    name              VARCHAR(100)  NOT NULL,
    email             VARCHAR(150)  NOT NULL UNIQUE,
    registration_date DATE          NOT NULL,
    country           VARCHAR(80)   NOT NULL,
    membership_tier   ENUM('Bronze','Silver','Gold','Platinum') NOT NULL DEFAULT 'Bronze',
    age               INT           NOT NULL,
    INDEX idx_reg_date  (registration_date),
    INDEX idx_tier      (membership_tier)
);

-- ----------------------------------------------------------
-- TABLE: products
-- ----------------------------------------------------------
CREATE TABLE products (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(200)   NOT NULL,
    category    VARCHAR(80)    NOT NULL,
    price       DECIMAL(10,2)  NOT NULL,
    stock_qty   INT            NOT NULL DEFAULT 0,
    brand       VARCHAR(100),
    INDEX idx_category (category),
    INDEX idx_price    (price)
);

-- ----------------------------------------------------------
-- TABLE: transactions
-- ----------------------------------------------------------
CREATE TABLE transactions (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    user_id          INT             NOT NULL,
    product_id       INT             NOT NULL,
    amount           DECIMAL(10,2)   NOT NULL,
    transaction_date DATE            NOT NULL,
    status           ENUM('completed','pending','refunded','failed') NOT NULL DEFAULT 'completed',
    payment_method   VARCHAR(50),
    FOREIGN KEY (user_id)    REFERENCES users(id)    ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    INDEX idx_tx_date (transaction_date),
    INDEX idx_status  (status)
);
