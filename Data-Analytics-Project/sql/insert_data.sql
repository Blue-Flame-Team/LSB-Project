-- ============================================================
-- PROJECT: Data Analytics with SQL, MongoDB & BigQuery
-- FILE: sql/insert_data.sql
-- DESCRIPTION: Insert realistic data into users, products,
--              and transactions tables
-- ============================================================

USE analytics_db;

-- ----------------------------------------------------------
-- USERS (30 records — spanning 2018–2024 registration dates)
-- Older accounts → higher membership tiers (engagement correlation)
-- ----------------------------------------------------------
INSERT INTO users (name, email, registration_date, country, membership_tier, age) VALUES
-- 2018 — Veteran accounts (Platinum/Gold)
('Ahmed Hassan',      'ahmed.hassan@gmail.com',    '2018-01-15', 'Egypt',        'Platinum', 34),
('Sara Khalid',       'sara.khalid@outlook.com',   '2018-03-20', 'Saudi Arabia', 'Gold',     29),
('Mohamed Ali',       'm.ali1990@gmail.com',        '2018-06-10', 'Egypt',        'Platinum', 36),
('Fatima Al-Rashid',  'fatima.rashid@yahoo.com',   '2018-09-05', 'UAE',          'Gold',     31),
('Omar Nasser',       'omar.nasser@hotmail.com',   '2018-11-18', 'Kuwait',       'Platinum', 40),
-- 2019 — Senior accounts (Gold/Silver)
('Layla Ibrahim',     'layla.ibrahim@gmail.com',   '2019-01-22', 'Jordan',       'Gold',     27),
('Khaled Mansour',    'k.mansour@company.com',     '2019-03-14', 'Egypt',        'Gold',     45),
('Nour Saleh',        'nour.saleh@outlook.com',    '2019-05-30', 'Lebanon',      'Silver',   33),
('Yousef Al-Ahmad',   'y.alahmad@gmail.com',       '2019-08-12', 'Qatar',        'Gold',     38),
('Rania Fawzy',       'rania.fawzy@yahoo.com',     '2019-10-25', 'Egypt',        'Silver',   30),
-- 2020 — Mid-level accounts (Silver/Bronze)
('Hassan Mostafa',    'hassan.mostafa@gmail.com',  '2020-01-08', 'Egypt',        'Silver',   32),
('Dina Youssef',      'dina.youssef@hotmail.com',  '2020-03-14', 'Saudi Arabia', 'Silver',   26),
('Tariq Zahrawi',     'tariq.zahrawi@gmail.com',   '2020-06-20', 'Morocco',      'Silver',   41),
('Mona Abdel-Aziz',   'mona.aziz@outlook.com',     '2020-08-11', 'Egypt',        'Bronze',   35),
('Amr Farouk',        'amr.farouk@company.eg',     '2020-11-25', 'Egypt',        'Silver',   28),
-- 2021 — Junior accounts (Bronze)
('Yasmin Barakat',    'yasmin.barakat@gmail.com',  '2021-01-17', 'UAE',          'Bronze',   24),
('Samir Abdallah',    'samir.abdallah@yahoo.com',  '2021-04-03', 'Jordan',       'Bronze',   43),
('Hana Mahmoud',      'hana.mahmoud@gmail.com',    '2021-06-19', 'Egypt',        'Bronze',   29),
('Bilal Qasim',       'bilal.qasim@outlook.com',   '2021-09-28', 'Pakistan',     'Bronze',   37),
('Nadia Sami',        'nadia.sami@hotmail.com',    '2021-12-15', 'Tunisia',      'Bronze',   31),
-- 2022 — Junior accounts (Bronze)
('Karim Lotfy',       'karim.lotfy@gmail.com',     '2022-02-20', 'Egypt',        'Bronze',   25),
('Eman Tarek',        'eman.tarek@outlook.com',    '2022-04-10', 'Egypt',        'Bronze',   22),
('Wael Gaber',        'wael.gaber@yahoo.com',      '2022-07-15', 'Saudi Arabia', 'Bronze',   39),
('Samira Osman',      'samira.osman@gmail.com',    '2022-09-22', 'Sudan',        'Bronze',   28),
('Mahmoud Shehab',    'mahmoud.shehab@company.com','2022-11-18', 'Egypt',        'Bronze',   44),
-- 2023–2024 — New accounts (Bronze, minimal activity)
('Asmaa Nabil',       'asmaa.nabil@gmail.com',     '2023-01-30', 'Egypt',        'Bronze',   26),
('Ibrahim Al-Sayed',  'ibrahim.sayed@hotmail.com', '2023-05-12', 'Bahrain',      'Bronze',   33),
('Noha Ramadan',      'noha.ramadan@outlook.com',  '2023-08-04', 'Egypt',        'Bronze',   30),
('Fady Saad',         'fady.saad@gmail.com',       '2023-11-21', 'Lebanon',      'Bronze',   27),
('Reem Al-Khaldi',    'reem.khaldi@yahoo.com',     '2024-03-09', 'Kuwait',       'Bronze',   23);

-- ----------------------------------------------------------
-- PRODUCTS (20 records across 5 categories)
-- ----------------------------------------------------------
INSERT INTO products (name, category, price, stock_qty, brand) VALUES
-- Electronics (high price)
('Samsung Galaxy S24 Ultra',       'Electronics',   1299.99, 50,  'Samsung'),
('Apple iPhone 15 Pro',            'Electronics',   1199.00, 40,  'Apple'),
('Sony WH-1000XM5 Headphones',     'Electronics',    349.99, 120, 'Sony'),
('Logitech MX Master 3 Mouse',     'Electronics',     99.99, 200, 'Logitech'),
('Dell XPS 15 Laptop',             'Electronics',   1899.00, 25,  'Dell'),
-- Books (low price)
('Clean Code by Robert Martin',    'Books',           39.99, 500, 'Prentice Hall'),
('The Pragmatic Programmer',       'Books',           44.99, 400, 'Addison-Wesley'),
('Designing Data-Intensive Apps',  'Books',           54.99, 350, 'O''Reilly'),
('Python Crash Course',            'Books',           29.99, 600, 'No Starch Press'),
('Database Design for Mere Mortals','Books',          34.99, 450, 'Addison-Wesley'),
-- Clothing (medium price)
('Nike Air Max 270',               'Clothing',       119.99, 300, 'Nike'),
('Adidas Ultraboost 23',           'Clothing',       139.99, 250, 'Adidas'),
('Levi''s 511 Slim Jeans',         'Clothing',        69.99, 400, 'Levi''s'),
('Under Armour Training T-Shirt',  'Clothing',        34.99, 500, 'Under Armour'),
('Polo Ralph Lauren Hoodie',       'Clothing',        89.99, 200, 'Ralph Lauren'),
-- Home & Kitchen (medium–high price)
('Nespresso Vertuo Machine',       'Home & Kitchen', 199.99, 150, 'Nespresso'),
('Dyson V15 Detect Vacuum',        'Home & Kitchen', 749.99,  60, 'Dyson'),
('Instant Pot Duo 7-in-1',         'Home & Kitchen',  89.99, 180, 'Instant Pot'),
-- Sports (varied price)
('Peloton Bike+',                  'Sports',        2495.00,  15, 'Peloton'),
('Garmin Forerunner 955',          'Sports',         499.99,  55, 'Garmin');

-- ----------------------------------------------------------
-- TRANSACTIONS (60 records)
-- ----------------------------------------------------------
INSERT INTO transactions (user_id, product_id, amount, transaction_date, status, payment_method) VALUES
-- Veteran users (2018) — many purchases
(1, 2,  1199.00, '2019-03-12', 'completed', 'Credit Card'),
(1, 6,    39.99, '2019-07-22', 'completed', 'PayPal'),
(1, 16,  199.99, '2020-01-05', 'completed', 'Credit Card'),
(1, 19, 2495.00, '2021-04-18', 'completed', 'Bank Transfer'),
(2, 3,   349.99, '2018-11-20', 'completed', 'Credit Card'),
(2, 11,  119.99, '2019-06-14', 'completed', 'PayPal'),
(2,  8,   54.99, '2021-01-15', 'completed', 'PayPal'),
(3, 5,  1899.00, '2019-02-28', 'completed', 'Credit Card'),
(3, 8,    54.99, '2019-09-15', 'completed', 'PayPal'),
(3, 17,  749.99, '2020-05-20', 'completed', 'Credit Card'),
(4, 1,  1299.99, '2019-01-10', 'completed', 'Credit Card'),
(4, 14,   34.99, '2020-03-08', 'completed', 'Cash on Delivery'),
(4, 12,  139.99, '2021-05-30', 'completed', 'Credit Card'),
(5, 20,  499.99, '2019-04-25', 'completed', 'Credit Card'),
(5, 6,    39.99, '2021-01-30', 'completed', 'PayPal'),
-- Senior users (2019) — moderate purchases
(6, 12,  139.99, '2019-05-17', 'completed', 'Credit Card'),
(6, 16,  199.99, '2020-11-09', 'completed', 'PayPal'),
(7, 2,  1199.00, '2019-03-22', 'completed', 'Bank Transfer'),
(7, 15,   89.99, '2021-08-04', 'completed', 'PayPal'),
(8, 4,    99.99, '2019-02-08', 'completed', 'Credit Card'),
(8, 18,   89.99, '2020-04-14', 'completed', 'Cash on Delivery'),
(9, 1,  1299.99, '2019-07-30', 'completed', 'Credit Card'),
(9, 13,   69.99, '2022-11-21', 'completed', 'Cash on Delivery'),
(10, 5, 1899.00, '2019-08-15', 'completed', 'Credit Card'),
(10, 9,   29.99, '2020-02-27', 'completed', 'PayPal'),
-- Mid-level users (2020) — reasonable activity
(11, 3,  349.99, '2020-04-05', 'completed', 'Credit Card'),
(11, 6,   39.99, '2020-09-17', 'completed', 'PayPal'),
(12, 4,   99.99, '2020-01-28', 'completed', 'Credit Card'),
(12, 10,  34.99, '2021-06-14', 'completed', 'PayPal'),
(13, 20, 499.99, '2020-05-12', 'completed', 'Bank Transfer'),
(14, 11, 119.99, '2020-07-03', 'completed', 'PayPal'),
(15, 1, 1299.99, '2020-08-30', 'completed', 'Credit Card'),
-- Junior users (2021–2022) — limited purchases
(16, 14,  34.99, '2021-03-19', 'completed', 'Cash on Delivery'),
(17, 5, 1899.00, '2021-06-25', 'completed', 'Bank Transfer'),
(18, 12, 139.99, '2021-10-07', 'completed', 'Credit Card'),
(19, 17, 749.99, '2022-03-14', 'completed', 'Bank Transfer'),
(20, 2, 1199.00, '2022-11-18', 'completed', 'Credit Card'),
(21, 3,  349.99, '2022-02-20', 'completed', 'Credit Card'),
(22, 4,   99.99, '2022-04-09', 'completed', 'Credit Card'),
(23, 1, 1299.99, '2022-07-30', 'completed', 'Credit Card'),
(24, 10,  34.99, '2022-05-15', 'completed', 'Cash on Delivery'),
(25, 17, 749.99, '2022-09-08', 'completed', 'Bank Transfer'),
-- New users (2023–2024) — minimal purchases
(26, 9,   29.99, '2023-03-05', 'completed', 'PayPal'),
(27, 14,  34.99, '2023-06-21', 'completed', 'Cash on Delivery'),
(28, 7,   44.99, '2023-08-14', 'completed', 'PayPal'),
(29, 10,  34.99, '2023-12-03', 'completed', 'PayPal'),
(30, 13,  69.99, '2024-01-20', 'completed', 'Credit Card'),
-- Some refunded/failed for realism
(1, 19, 2495.00, '2022-05-10', 'refunded',  'Credit Card'),
(10, 17, 749.99, '2022-10-15', 'refunded',  'Bank Transfer'),
(25, 5, 1899.00, '2023-02-20', 'failed',    'Credit Card'),
-- Additional completions
(3, 11,  119.99, '2021-03-22', 'completed', 'Credit Card'),
(4, 16,  199.99, '2022-02-14', 'completed', 'Credit Card'),
(5, 7,    44.99, '2022-04-09', 'completed', 'PayPal'),
(6, 18,   89.99, '2022-07-17', 'completed', 'Cash on Delivery'),
(7, 20,  499.99, '2022-09-04', 'completed', 'Credit Card'),
(8, 15,   89.99, '2023-01-08', 'completed', 'PayPal'),
(9, 11,  119.99, '2023-03-16', 'completed', 'Credit Card'),
(10, 13,  69.99, '2023-05-29', 'completed', 'Cash on Delivery'),
(11, 17, 749.99, '2024-01-13', 'completed', 'Bank Transfer'),
(12, 12, 139.99, '2024-02-28', 'completed', 'Credit Card'),
(13, 11, 119.99, '2024-04-10', 'completed', 'Credit Card');
