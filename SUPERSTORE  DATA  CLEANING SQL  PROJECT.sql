-- DATA CLEANING

-- CREATE TABLE `sample - superstore_2`
-- like `sample - superstore`;

-- SELECT *
 -- FROM `sample - superstore_2`;
 
-- INSERT `sample - superstore_2`
-- SELECT * 
 -- FROM `sample - superstore`;
 
 
 
 
 -- REMOVING DUPLICATES
 -- (1) CONFIRMING THAT THERE ARE DUPLICATES
 SELECT *
 FROM iiooio.`sample - superstore_2`;
 
-- WITH DUPLICATE_CTE AS (
-- SELECT*, row_number() OVER (
-- PARTITION BY `order date`, `ORDER ID`, `PRODUCT ID`, `category`, `sub-category`, `product name`) AS Row_Num FROM  `sample - superstore_2`)
 ;

-- (2) REMOVING THE DUPLICATES
 CREATE TABLE `sample - superstore_5` (
  `Row ID` int DEFAULT NULL,
  `Order ID` text,
  `Order Date` text,
  `Ship Date` text,
  `Ship Mode` text,
  `Customer ID` text,
  `Customer Name` text,
  `Segment` text,
  `Country` text,
  `City` text,
  `State` text,
  `Postal Code` int DEFAULT NULL,
  `Region` text,
  `Product ID` text,
  `Category` text,
  `Sub-Category` text,
  `Product Name` text,
  `Sales` double DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Discount` double DEFAULT NULL,
  `Profit` double DEFAULT NULL,
  `Row_Num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 
SELECT *
 FROM `sample - superstore_5`;
 INSERT INTO `sample - superstore_5`
 SELECT *,
 row_number() OVER (
 PARTITION BY `order date`, `ORDER ID`, `PRODUCT ID`, `category`, `sub-category`, `product name`) AS Row_Num FROM  `sample - superstore_2`;
 

 DELETE 
 FROM `sample - superstore_5`
 WHERE Row_Num > 1
  ORDER BY `Row ID`;



-- (3) CONFIRM THAT DUPLICATES HAVE BEEN DELETED 
 SELECT * 
 FROM `sample - superstore_5`
 WHERE Row_Num > 1;
 
 
 -- DATA STANDARDIZATION
 
 
-- (1)FOR ORDER DATE
SELECT `Order date`,
str_to_date(`Order date`,'%m/%d/%Y')
FROM `sample - superstore_5`;

UPDATE  `sample - superstore_5`
SET `Order date` = str_to_date(`Order date`,'%m/%d/%Y');

ALTER TABLE  `sample - superstore_5`
MODIFY COLUMN  `Order date`DATE;



-- (2) FOR SHIP DATE
SELECT `Ship date`,
str_to_date(`Ship date`,'%m/%d/%Y')
FROM `sample - superstore_5`;

UPDATE  `sample - superstore_5`
SET `Ship date` = str_to_date(`Ship date`,'%m/%d/%Y');

SELECT *
FROM  `sample - superstore_5`;


ALTER TABLE  `sample - superstore_5`
MODIFY COLUMN  `Ship date`DATE;


-- THERE WERE NO NULL OR BLANK VALUES IN OUR TABLE


-- DELETING OUR ROW_NUM COLUMN BECAUSE WE DON'T NEED IT ANY MORE
ALTER TABLE `sample - superstore_5`
DROP COLUMN Row_Num;


COMMIT
