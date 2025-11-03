CREATE SCHEMA rca;
GO

CREATE TABLE rca.dim_product (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_category VARCHAR(50),
    start_date DATE NOT NULL,
    end_date DATE NULL
);
GO

CREATE TABLE rca.dim_product_price (
    product_price_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    price_month DATE NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES rca.dim_product(product_id)
);
GO

CREATE TABLE rca.dim_date (
    date_key DATE PRIMARY KEY,
    year INT,
    month INT,
    month_name VARCHAR(15)
);
GO

DECLARE @date DATE = '2025-01-01';
WHILE @date <= '2025-12-31'
BEGIN
    INSERT INTO rca.dim_date (date_key, year, month, month_name)
    VALUES (
        @date, YEAR(@date), MONTH(@date), DATENAME(MONTH, @date)
    );
    SET @date = DATEADD(DAY, 1, @date);
END;
GO


INSERT INTO rca.dim_product (product_name, product_category, start_date)
VALUES
('iPhone 15', 'Smartphone', '2025-01-01'),
('Samsung Galaxy S24', 'Smartphone', '2025-01-01'),
('Dell XPS 13', 'Laptop', '2025-01-01'),
('OnePlus 13', 'Smartphone', '2025-05-01'),
('MacBook Air M4', 'Laptop', '2025-05-01');
GO

-- iPhone 15
INSERT INTO rca.dim_product_price (product_id, price_month, price)
VALUES
(1, '2025-01-01', 999.00), (1, '2025-02-01', 979.00), (1, '2025-03-01', 949.00),
(1, '2025-04-01', 929.00), (1, '2025-05-01', 849.00), (1, '2025-06-01', 869.00),
(1, '2025-07-01', 879.00), (1, '2025-08-01', 899.00), (1, '2025-09-01', 919.00),
(1, '2025-10-01', 939.00), (1, '2025-11-01', 949.00), (1, '2025-12-01', 959.00);

-- Samsung Galaxy S24
INSERT INTO rca.dim_product_price (product_id, price_month, price)
VALUES
(2, '2025-01-01', 899.00), (2, '2025-02-01', 889.00), (2, '2025-03-01', 869.00),
(2, '2025-04-01', 859.00), (2, '2025-05-01', 749.00), (2, '2025-06-01', 769.00),
(2, '2025-07-01', 789.00), (2, '2025-08-01', 799.00), (2, '2025-09-01', 819.00),
(2, '2025-10-01', 829.00), (2, '2025-11-01', 839.00), (2, '2025-12-01', 849.00);

-- Dell XPS 13
INSERT INTO rca.dim_product_price (product_id, price_month, price)
VALUES
(3, '2025-01-01', 1199.00), (3, '2025-02-01', 1189.00), (3, '2025-03-01', 1179.00),
(3, '2025-04-01', 1159.00), (3, '2025-05-01', 999.00), (3, '2025-06-01', 1049.00),
(3, '2025-07-01', 1069.00), (3, '2025-08-01', 1089.00), (3, '2025-09-01', 1109.00),
(3, '2025-10-01', 1119.00), (3, '2025-11-01', 1129.00), (3, '2025-12-01', 1139.00);

-- OnePlus 13 (launch in May)
INSERT INTO rca.dim_product_price (product_id, price_month, price)
VALUES
(4, '2025-05-01', 699.00), (4, '2025-06-01', 709.00), (4, '2025-07-01', 719.00),
(4, '2025-08-01', 729.00), (4, '2025-09-01', 739.00), (4, '2025-10-01', 749.00),
(4, '2025-11-01', 759.00), (4, '2025-12-01', 769.00);

-- MacBook Air M4 (launch in May)
INSERT INTO rca.dim_product_price (product_id, price_month, price)
VALUES
(5, '2025-05-01', 1099.00), (5, '2025-06-01', 1119.00), (5, '2025-07-01', 1139.00),
(5, '2025-08-01', 1149.00), (5, '2025-09-01', 1159.00), (5, '2025-10-01', 1169.00),
(5, '2025-11-01', 1179.00), (5, '2025-12-01', 1189.00);
GO

CREATE TABLE rca.fact_sales (
    sale_id INT IDENTITY(1,1) PRIMARY KEY,
    sale_date DATE NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_amount AS (quantity * unit_price) PERSISTED,
    FOREIGN KEY (product_id) REFERENCES rca.dim_product(product_id),
    FOREIGN KEY (sale_date) REFERENCES rca.dim_date(date_key)
);
GO


--  SALES DATA FOR 2025

-- January
INSERT INTO rca.fact_sales (sale_date, product_id, quantity, unit_price)
VALUES
('2025-01-05', 1, 5, 999.00),
('2025-01-10', 2, 3, 899.00),
('2025-01-12', 3, 2, 1199.00),
('2025-01-18', 1, 4, 999.00),
('2025-01-25', 2, 5, 899.00),
('2025-01-30', 3, 1, 1199.00);

-- February
INSERT INTO rca.fact_sales (sale_date, product_id, quantity, unit_price)
VALUES
('2025-02-03', 1, 6, 979.00),
('2025-02-10', 2, 4, 889.00),
('2025-02-15', 3, 3, 1189.00),
('2025-02-20', 1, 5, 979.00),
('2025-02-25', 2, 2, 889.00);

-- March
INSERT INTO rca.fact_sales (sale_date, product_id, quantity, unit_price)
VALUES
('2025-03-03', 1, 5, 949.00),
('2025-03-09', 2, 3, 869.00),
('2025-03-15', 3, 4, 1179.00),
('2025-03-20', 1, 6, 949.00),
('2025-03-25', 2, 5, 869.00),
('2025-03-30', 3, 2, 1179.00);

-- April
INSERT INTO rca.fact_sales (sale_date, product_id, quantity, unit_price)
VALUES
('2025-04-02', 1, 4, 929.00),
('2025-04-10', 2, 3, 859.00),
('2025-04-14', 3, 3, 1159.00),
('2025-04-20', 1, 5, 929.00),
('2025-04-25', 2, 4, 859.00),
('2025-04-29', 3, 2, 1159.00);

-- MAY SPIKE (New Products + Price Drop)
INSERT INTO rca.fact_sales (sale_date, product_id, quantity, unit_price)
VALUES
('2025-05-01', 1, 12, 849.00),
('2025-05-02', 2, 15, 749.00),
('2025-05-03', 3, 10, 999.00),
('2025-05-05', 4, 18, 699.00),
('2025-05-06', 5, 12, 1099.00),
('2025-05-10', 1, 10, 849.00),
('2025-05-15', 2, 9, 749.00),
('2025-05-20', 3, 7, 999.00),
('2025-05-25', 4, 16, 699.00),
('2025-05-28', 5, 11, 1099.00);

-- June
INSERT INTO rca.fact_sales (sale_date, product_id, quantity, unit_price)
VALUES
('2025-06-03', 1, 4, 869.00),
('2025-06-05', 2, 3, 769.00),
('2025-06-07', 3, 3, 1049.00),
('2025-06-10', 4, 6, 709.00),
('2025-06-12', 5, 5, 1119.00);

-- July
INSERT INTO rca.fact_sales (sale_date, product_id, quantity, unit_price)
VALUES
('2025-07-05', 1, 5, 879.00),
('2025-07-10', 2, 4, 789.00),
('2025-07-15', 3, 3, 1069.00),
('2025-07-20', 4, 6, 719.00),
('2025-07-25', 5, 4, 1139.00);

-- August
INSERT INTO rca.fact_sales (sale_date, product_id, quantity, unit_price)
VALUES
('2025-08-03', 1, 4, 899.00),
('2025-08-08', 2, 3, 799.00),
('2025-08-13', 3, 2, 1089.00),
('2025-08-18', 4, 5, 729.00),
('2025-08-23', 5, 4, 1149.00);

-- September
INSERT INTO rca.fact_sales (sale_date, product_id, quantity, unit_price)
VALUES
('2025-09-03', 1, 4, 919.00),
('2025-09-08', 2, 3, 819.00),
('2025-09-13', 3, 2, 1109.00),
('2025-09-18', 4, 4, 739.00),
('2025-09-23', 5, 3, 1159.00);

-- October
INSERT INTO rca.fact_sales (sale_date, product_id, quantity, unit_price)
VALUES
('2025-10-05', 1, 3, 939.00),
('2025-10-10', 2, 2, 829.00),
('2025-10-15', 3, 2, 1119.00),
('2025-10-20', 4, 4, 749.00),
('2025-10-25', 5, 3, 1169.00);

-- November
INSERT INTO rca.fact_sales (sale_date, product_id, quantity, unit_price)
VALUES
('2025-11-05', 1, 4, 949.00),
('2025-11-10', 2, 3, 839.00),
('2025-11-15', 3, 2, 1129.00),
('2025-11-20', 4, 4, 759.00),
('2025-11-25', 5, 3, 1179.00);

-- December
INSERT INTO rca.fact_sales (sale_date, product_id, quantity, unit_price)
VALUES
('2025-12-05', 1, 3, 959.00),
('2025-12-10', 2, 2, 849.00),
('2025-12-15', 3, 1, 1139.00),
('2025-12-20', 4, 3, 769.00),
('2025-12-25', 5, 2, 1189.00);
GO



-- Verify data
-- Check total sales trend (shows a clear spike in May)
SELECT 
    DATENAME(MONTH, sale_date) AS MonthName,
    SUM(quantity) AS TotalUnitsSold,
    SUM(total_amount) AS TotalRevenue
FROM rca.fact_sales
GROUP BY DATENAME(MONTH, sale_date), MONTH(sale_date)
ORDER BY MONTH(sale_date);
GO



-- Product contribution in May
SELECT 
    p.product_name,
    SUM(f.quantity) AS UnitsSold,
    SUM(f.total_amount) AS Revenue
FROM rca.fact_sales f
JOIN rca.dim_product p ON f.product_id = p.product_id
WHERE MONTH(f.sale_date) = 5
GROUP BY p.product_name
ORDER BY Revenue DESC;
GO



-- Root Cause Analysis (RCA) -------------------------------

-- 1. Monthly Sales Trend
-- Goal: Identify when the spike occurred.
SELECT 
    YEAR(sale_date) AS SalesYear,
    MONTH(sale_date) AS SalesMonth,
    DATENAME(MONTH, sale_date) AS MonthName,
    SUM(quantity) AS TotalUnitsSold,
    SUM(total_amount) AS TotalRevenue
FROM rca.fact_sales
GROUP BY YEAR(sale_date), MONTH(sale_date), DATENAME(MONTH, sale_date)
ORDER BY SalesMonth;
GO
-- Insight:
-- Clearly see May 2025 has the highest TotalUnitsSold and TotalRevenue.
-- This confirms “something unusual happened in May.”



-- 2. Product Contribution to the Spike
-- Goal: Which products caused the jump?
SELECT 
    p.product_name,
    SUM(f.quantity) AS UnitsSold,
    SUM(f.total_amount) AS Revenue
FROM rca.fact_sales f
JOIN rca.dim_product p 
    ON f.product_id = p.product_id
WHERE MONTH(f.sale_date) = 5
GROUP BY p.product_name
ORDER BY Revenue DESC;
-- Insight:
-- OnePlus 13 and MacBook Air M4 (new launches) plus heavy sales
-- of discounted products like iPhone 15 and Galaxy S24 dominate May.



-- 3. Compare Average Monthly Price by Product
-- Goal: Check if lower prices drove demand.
SELECT 
    p.product_name,
    pr.price_month,
    DATENAME(MONTH, pr.price_month) AS MonthName,
    pr.price,
    LAG(pr.price) OVER (PARTITION BY p.product_name ORDER BY pr.price_month) AS PrevMonthPrice,
    (LAG(pr.price) OVER (PARTITION BY p.product_name ORDER BY pr.price_month) - pr.price) AS PriceDrop
FROM rca.dim_product_price pr
JOIN rca.dim_product p 
    ON p.product_id = pr.product_id
WHERE YEAR(pr.price_month) = 2025
ORDER BY p.product_name, pr.price_month;
GO
-- Insight:
-- All three existing products show a major price drop in May 2025, aligning with the sales spike.



-- 4. Correlate Price Change vs Sales Change
-- Goal: Quantify how price reduction affected units sold.
WITH MonthlySales AS (
    SELECT 
        p.product_id,
        p.product_name,
        YEAR(f.sale_date) AS SalesYear,
        MONTH(f.sale_date) AS SalesMonth,
        SUM(f.quantity) AS UnitsSold
    FROM rca.fact_sales f
    JOIN rca.dim_product p ON f.product_id = p.product_id
    GROUP BY p.product_id, p.product_name, YEAR(f.sale_date), MONTH(f.sale_date)
),
MonthlyPrice AS (
    SELECT 
        pr.product_id,
        MONTH(pr.price_month) AS PriceMonth,
        pr.price
    FROM rca.dim_product_price pr
    WHERE YEAR(pr.price_month) = 2025
)
SELECT 
    s.product_name,
    s.SalesMonth,
    DATENAME(MONTH, DATEFROMPARTS(2025, s.SalesMonth, 1)) AS MonthName,
    s.UnitsSold,
    p.price,
    LAG(s.UnitsSold) OVER (PARTITION BY s.product_name ORDER BY s.SalesMonth) AS PrevMonthUnits,
    LAG(p.price) OVER (PARTITION BY s.product_name ORDER BY s.SalesMonth) AS PrevMonthPrice,
    (LAG(p.price) OVER (PARTITION BY s.product_name ORDER BY s.SalesMonth) - p.price) AS PriceChange,
    (s.UnitsSold - LAG(s.UnitsSold) OVER (PARTITION BY s.product_name ORDER BY s.SalesMonth)) AS SalesChange
FROM MonthlySales s
JOIN MonthlyPrice p 
    ON s.product_id = p.product_id AND s.SalesMonth = p.PriceMonth
ORDER BY s.product_name, s.SalesMonth;
GO
-- Insight:
-- In May, large negative PriceChange values (price drops) and
-- large positive SalesChange values — a clear inverse correlation.
-- That’s quantitative root cause.



-- 5. Summary RCA — Why May Spiked
-- Combine all evidence in one summary view.
SELECT 
    DATENAME(MONTH, f.sale_date) AS MonthName,
    COUNT(DISTINCT f.product_id) AS ActiveProducts,
    SUM(f.quantity) AS TotalUnitsSold,
    SUM(f.total_amount) AS TotalRevenue,
    AVG(f.unit_price) AS AvgSellingPrice
FROM rca.fact_sales f
GROUP BY DATENAME(MONTH, f.sale_date), MONTH(f.sale_date)
ORDER BY MONTH(f.sale_date);

-- Interpreting the pattern:
-- Number of active products rises in May (two new launches).
-- Average selling price dips.
-- Units sold and revenue spike sharply.
-- This is the classical RCA chain:
-- Product count (^) + Price (v) → Demand (^) → Sales (^)



-- 6. Create a Reusable View
--  the RCA results for Power BI or future queries:
CREATE VIEW rca.vw_root_cause_analysis AS
SELECT 
    DATENAME(MONTH, f.sale_date) AS MonthName,
    COUNT(DISTINCT f.product_id) AS ActiveProducts,
    SUM(f.quantity) AS TotalUnitsSold,
    SUM(f.total_amount) AS TotalRevenue,
    AVG(f.unit_price) AS AvgSellingPrice
FROM rca.fact_sales f
GROUP BY DATENAME(MONTH, f.sale_date), MONTH(f.sale_date);
GO

SELECT * FROM rca.vw_root_cause_analysis ORDER BY MonthName;
