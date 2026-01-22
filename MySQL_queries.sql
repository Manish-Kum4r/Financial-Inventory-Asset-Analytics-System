create database inventory ;
use inventory ;
CREATE TABLE Inventory_mgt (
    Product_ID INT,
    Category VARCHAR(100),
    Current_Stock INT,
    Reorder_Level INT,
    Supplier VARCHAR(100),
    Sales_Last_30_Days INT
);

SET foreign_key_checks = 0;

SET unique_checks = 0;

LOAD DATA INFILE
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\inventory_stock.csv'
INTO TABLE inventory_mgt
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET foreign_key_checks = 1;

SET unique_checks = 1;

SELECT Product_ID, Category, Current_Stock, Reorder_Level
FROM Inventory_mgt
WHERE Current_Stock < Reorder_Level;

select * from inventory_mgt
order by current_stock 
desc limit 10 ;

SELECT *
FROM inventory_mgt
WHERE current_stock < 10
ORDER BY current_stock ASC;

SELECT category, SUM(current_stock) AS total_stock
FROM inventory_mgt
GROUP BY category
ORDER BY total_stock DESC;

SELECT product_id,
       SUM(sales_last_30_days) AS total_revenue
FROM inventory_mgt
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 10;

SELECT product_id,current_stock,SUM(Sales_Last_30_Days) AS total_sales
FROM inventory_mgt
GROUP BY product_id, current_stock
ORDER BY total_sales DESC;

CREATE VIEW low_stock_items AS
SELECT product_id, current_stock
FROM inventory_mgt
WHERE current_stock < 10;

SELECT Product_ID, Category, Current_Stock, Reorder_Level
FROM inventory_mgt
WHERE Current_Stock < Reorder_Level
ORDER BY Current_Stock ASC;

SELECT Product_ID, Category, Sales_Last_30_Days
FROM inventory_mgt
ORDER BY Sales_Last_30_Days DESC
LIMIT 10;

SELECT Supplier, SUM(Sales_Last_30_Days) AS total_sales
FROM inventory_mgt
GROUP BY Supplier
ORDER BY total_sales DESC;

SELECT Product_ID, Category, Current_Stock, Sales_Last_30_Days,
       CASE 
         WHEN Sales_Last_30_Days > Current_Stock THEN 'Fast-Moving'
         ELSE 'Slow-Moving'
       END AS product_type
FROM inventory_mgt;

SELECT Category, AVG(Reorder_Level) AS avg_reorder_level
FROM inventory_mgt
GROUP BY Category
ORDER BY avg_reorder_level DESC;

SELECT Product_ID, Category, Current_Stock, Reorder_Level, Sales_Last_30_Days
FROM inventory_mgt
WHERE Current_Stock < Reorder_Level
AND Sales_Last_30_Days > (Reorder_Level * 2);

