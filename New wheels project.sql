/*

-----------------------------------------------------------------------------------------------------------------------------------
             	
-----------------------------------------------------------------------------------------------------------------------------------

											Database Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------
*/

-- [1] To begin with the project,I created the database first
-- Write the Query below to create a Database

drop database if exists vehdb;
Create database vehdb;

-- [2] Now, after creating the database, I have to tell MYSQL which database is to be used.
-- Write the Query below to call the Database

use vehdb;
/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Tables Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [3] Creating the tables:

/*Note:
---> To create the table, refer to the ER diagram. 


-- Syntax to create table-

-- To drop the table if already exists                            

-- To create a table- 
/*CREATE TABLE table_name (
	column_name1 datatype, 
    column_name2 datatype,
    ..
    ..
    ..
	PRIMARY KEY (column_name as primary key)                    
); */                                                            

/* List of tables to be created.

 Create a table temp_t, vehicles_t, order_t, customer_t, product_t, shipper_t */
 
 DROP TABLE IF EXISTS temp_t;

CREATE TABLE temp_t (
 shipper_id INTEGER,
 shipper_name VARCHAR(50),
 shipper_contact_details VARCHAR(30),
 product_id INTEGER,
 vehicle_maker VARCHAR(25),
 vehicle_model VARCHAR(25),
 vehicle_color VARCHAR(20),
 vehicle_model_year INTEGER, 
 vehicle_price DECIMAL(14,8),
 quantity INTEGER,
 discount DECIMAL(4,2),
 customer_id VARCHAR(25),
 customer_name VARCHAR(25),
 gender VARCHAR(15),
 job_title VARCHAR(50),
 phone_number VARCHAR(20),
 email_address VARCHAR(50),
 city VARCHAR(25),
 country VARCHAR(40),
 state VARCHAR(40),
 customer_address VARCHAR(50),
 order_date DATE,
 order_id VARCHAR(25),
 ship_date DATE,
 ship_mode VARCHAR(25),
 shipping VARCHAR(20),
 postal_code INTEGER,
 credit_card_Type VARCHAR(40),
 credit_card_Number BIGINT,
 customer_feedback VARCHAR(15),
 quarter_number INTEGER,
 PRIMARY KEY (order_id, shipper_id, product_id, customer_id)
);


DROP TABLE IF EXISTS vehicles_t;
CREATE TABLE vehicles_t (
 shipper_id INTEGER,
 shipper_name VARCHAR(50),
 shipper_contact_details VARCHAR(30),
 product_id INTEGER,
 vehicle_maker VARCHAR(25),
 vehicle_model VARCHAR(25),
 vehicle_color VARCHAR(20),
 vehicle_model_year INTEGER, 
 vehicle_price DECIMAL(14,8),
 quantity INTEGER,
 discount DECIMAL(4,2),
 customer_id VARCHAR(25),
 customer_name VARCHAR(25),
 gender VARCHAR(15),
 job_title VARCHAR(50),
 phone_number VARCHAR(20),
 email_address VARCHAR(50),
 city VARCHAR(25),
 country VARCHAR(40),
 state VARCHAR(40),
 customer_address VARCHAR(50),
 order_date DATE,
 order_id VARCHAR(25),
 ship_date DATE,
 ship_mode VARCHAR(25),
 shipping VARCHAR(20),
 postal_code INTEGER,
 credit_card_Type VARCHAR(40),
 credit_card_Number BIGINT,
 customer_feedback VARCHAR(15),
 quarter_number INTEGER,
 PRIMARY KEY (order_id, shipper_id, product_id, customer_id)
);

DROP TABLE IF EXISTS customer_t;

CREATE TABLE customer_t (
 customer_id VARCHAR(25), 
 customer_name VARCHAR(25), 
 gender VARCHAR(15), 
 job_title VARCHAR(50), 
 phone_number VARCHAR(20) ,
 email_address VARCHAR(50) ,
 city VARCHAR(25) ,
 country VARCHAR(40) ,
 state VARCHAR(40) ,
 customer_address VARCHAR(50),
    postal_code INTEGER, 
 credit_card_type VARCHAR(40) ,
 credit_card_number BIGINT,
    PRIMARY KEY(customer_id)
);

DROP TABLE IF EXISTS order_t;

CREATE TABLE order_t (
 order_id VARCHAR(25),
 customer_id VARCHAR(25),
    shipper_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    vehicle_price DECIMAL(10,2),
    order_date DATE,
    ship_date DATE,
    discount DECIMAL(4,2),
 ship_mode VARCHAR(25),
 shipping VARCHAR(30),
    customer_feedback VARCHAR(20),
    quarter_number INTEGER,
 PRIMARY KEY (order_id)
);

DROP TABLE if exists product_t;

CREATE TABLE product_t (
  product_id INTEGER,
  vehicle_maker VARCHAR(60),
  vehicle_model VARCHAR(60),
  vehicle_color VARCHAR(60),
  vehicle_model_year INTEGER,
  vehicle_price DECIMAL(14,8),
  PRIMARY KEY(product_id)
);

DROP TABLE if exists shipper_t;

CREATE TABLE shipper_t (
 shipper_id INTEGER,
 shipper_name VARCHAR(50),
 shipper_contact_details VARCHAR(30),
 PRIMARY KEY (shipper_id)
);


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Stored Procedures Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [4] Creating the Stored Procedures:



-- Syntax to create a stored procedure-
/*DELIMITER $$ 
CREATE PROCEDURE procedure_name()
BEGIN
       INSERT INTO table_name (
	column_name1,
    column_name2,
    ..
    ..
    ..              
) SELECT * FROM table_name;
END;*/

DROP PROCEDURE IF EXISTS vehicles_p;

DELIMITER $$ 
CREATE PROCEDURE vehicles_p()
BEGIN
       INSERT INTO vehicles_t (
              shipper_id,
              shipper_name,
              shipper_contact_details,
              product_id,
              vehicle_maker,
              vehicle_model,
              vehicle_color,
              vehicle_model_year,
              vehicle_price ,
              quantity,
              discount,
              customer_id,
              customer_name,
              gender,
              job_title,
              phone_number,
              email_address,       
              city,
              country,
              state,
              customer_address,
              order_date ,
              order_id ,
              ship_date,
              ship_mode ,      
              shipping ,
              postal_code ,
              credit_card_type,
              credit_card_number,
              customer_feedback ,
              quarter_number
) SELECT * FROM temp_t;
END;

DROP PROCEDURE IF EXISTS order_p;

DELIMITER $$ 
CREATE PROCEDURE order_p (qtr_number INTEGER)
BEGIN
 INSERT INTO order_t
(
        order_id,
  customer_id,
  shipper_id,
  product_id,
  quantity,
  vehicle_price,
        discount,
  order_date,
  ship_date,
  ship_mode,
  shipping,
  customer_feedback,
        quarter_number
) SELECT  
        order_id,
  customer_id,
  shipper_id,
  product_id,
  quantity,
  vehicle_price,
        discount,
  order_date,
  ship_date,
  ship_mode,
  shipping,
  customer_feedback,
        quarter_number
FROM
 vehicles_t
WHERE quarter_number = qtr_number;
END;

-- CALL order_p(1);

DROP PROCEDURE IF EXISTS customer_p;

DELIMITER $$ 
CREATE PROCEDURE customer_p()
BEGIN
 INSERT INTO customer_t(
      customer_id,
      customer_name,
      gender,
      job_title,
      phone_number,
      email_address,       
      city,
      country,
      state,
      customer_address,
      postal_code,
      credit_card_type,
      credit_card_number
) SELECT DISTINCT
      customer_id,
      customer_name,
      gender,
      job_title,
      phone_number,
      email_address,       
      city,
      country,
      state,
      customer_address,
      postal_code,
      credit_card_type,
      credit_card_number
 FROM vehicles_t
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM customer_t);
END;


DROP PROCEDURE IF EXISTS product_p;
DELIMITER $$ 
CREATE PROCEDURE product_p()
BEGIN
 INSERT INTO product_t
(
  product_id,
        vehicle_maker,
        vehicle_model,
        vehicle_color,
        vehicle_model_year,
  vehicle_price

) SELECT  
 DISTINCT
  product_id,
        vehicle_maker,
        vehicle_model,
        vehicle_color,
        vehicle_model_year,
  vehicle_price
FROM
 vehicles_t
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM product_t);
END;

DROP PROCEDURE IF EXISTS shipper_p;

DELIMITER $$ 
CREATE PROCEDURE shipper_p()
BEGIN
 INSERT INTO shipper_t
(
  shipper_id,
        shipper_name,
        shipper_contact_details
) SELECT  
 DISTINCT
  shipper_id,
        shipper_name,
        shipper_contact_details
FROM
 vehicles_t
WHERE shipper_id NOT IN (SELECT DISTINCT shipper_id FROM shipper_t);
END;
/* List of stored procedures to be created.

   Creating the stored procedure for vehicles_p, order_p, customer_p, product_p, shipper_p*/

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Data Ingestion
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [5] Ingesting the data:


TRUNCATE temp_t;

LOAD DATA LOCAL INFILE "D:/............/new_wheels_proj/Data/new_wheels_sales_qtr_1.csv" -- change this location to load another week
INTO TABLE temp_t
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

call vehicles_p();
call customer_p();
call product_p();
call shipper_p();
call order_p(4);

select count(*)
from vehicles_t

select count(*)
from order_t

select count(*)
from product_t

select count(*)
from customer_t

select count(*)
from shipper_t



/* Note: 

---> With the help of the above code, you can ingest the data into temp_t table by ingesting the quarterly data and by calling the stored 
     procedures you can ingest the data into separate table.
---> You have to run the above ingestion code 4 times as 4 quarters of data are present and you also need to call all the stored procedures 
     4 times. Please change the argument value while calling the stored procedure order_p(n). (n = 1,2,3,4)



/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Views Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [6] Creating the views:


-- Syntax to create view-



-- To drop the views if already exists- 
DROP VIEW IF EXISTS view_name;

-- To create a view-
CREATE VIEW view_name AS
    SELECT
	n1.column_name1,
    n2.column_name2,
    ..
    ..
    ..
FROM table_name1 n1
	INNER JOIN table_name2 n2
	    ON n1.column_name1 = n2.column_name2;

-- List of views to be created are "veh_prod_cust_v" , "veh_ord_cust_v"

DROP VIEW IF EXISTS veh_ord_cust_v;

CREATE VIEW veh_ord_cust_v AS
SELECT 
 cust.customer_id,
 cust.customer_name,
 cust.city,
 cust.state,
 cust.credit_card_type,
 ord.order_id,
 ord.order_date,
 ord.ship_date,
 ord.vehicle_price,
 ord.product_id,
 ord.shipper_id,
 ord.discount,
 ord.customer_feedback,
 ord.quantity,
 ord.quarter_number
FROM order_t ord 
INNER JOIN customer_t cust
 ON ord.customer_id = cust.customer_id;
 
 DROP VIEW IF EXISTS veh_prod_cust_v;

CREATE VIEW veh_prod_cust_v AS
    SELECT
   cust.customer_id,
      ord.order_id,
      cust.customer_name,
      cust.credit_card_type,
      cust.state,
   ord.customer_feedback,
   pro.product_id,
   pro.vehicle_maker,
      pro.vehicle_model,
      pro.vehicle_color,
      pro.vehicle_model_year
FROM product_t pro 
 INNER JOIN order_t ord
     ON pro.product_id = ord.product_id
 INNER JOIN customer_t cust
     ON ord.customer_id = cust.customer_id;
/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Functions Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [7] Creating the functions:




-- Create the function calc_revenue_f

-- Syntax to create function-

DELIMITER $$  
CREATE FUNCTION calc_revenue_f (column_name1 datatype, column_name2 datatype, column_name3 datatype) 
RETURNS DECIMAL
DETERMINISTIC  
BEGIN  

-- statements  

END;

DELIMITER $$  
CREATE FUNCTION calc_revenue_f (vehicle_price DECIMAL(14,8), discount DECIMAL(4,2), quantity INTEGER) 
RETURNS DECIMAL
DETERMINISTIC  
BEGIN  
  DECLARE revenue DECIMAL;
      SET revenue = quantity * (vehicle_price - ((discount/100)*vehicle_Price));  
  RETURN revenue;  
END;

-- Create the function days_to_ship_f-

DELIMITER $$
CREATE FUNCTION days_to_ship_f (column_name1 datatype, column_name2 datatype) 
RETURNS INTEGER
DETERMINISTIC
BEGIN  

-- statements

END;

DELIMITER $$
CREATE FUNCTION days_to_ship_f (ord_date date, ship_date date) 
RETURNS INTEGER
DETERMINISTIC
BEGIN  
    DECLARE ship_days INT;
        SET ship_days = DATEDIFF(ship_date, ord_date);  
    RETURN ship_days;  
END;

/*-----------------------------------------------------------------------------------------------------------------------------------
Note: 
After creating tables, stored procedures, views and functions, I then answered the business below questions below
------------------------------------------------------------------------------------------------------------------------------------ 

  
  
-----------------------------------------------------------------------------------------------------------------------------------

                                                         Queries
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
  
/*-- QUESTIONS RELATED TO CUSTOMERS
     [Q1] What is the distribution of customers across states?
     Hint: For each state, count the number of customers.*/

SELECT state,COUNT(customer_id) AS Number_of_customers 
FROM customer_t
GROUP BY 1

-- ---------------------------------------------------------------------------------------------------------------------------------

-- [Q2] What is the average rating in each quarter?
-- Very Bad is 1, Bad is 2, Okay is 3, Good is 4, Very Good is 5.


WITH feed_bucket AS 
( 
SELECT 
CASE 
    WHEN customer_feedback = 'Very Good' THEN 5 
    WHEN customer_feedback = 'Okay' THEN 3 
    WHEN customer_feedback = 'Very Bad' THEN 1 END AS feedback_count, quarter_number 
    FROM veh_ord_cust_v 
) 
SELECT 
    quarter_number, 
    avg(feedback_count) avg_feedback 
FROM feed_bucket 
GROUP BY quarter_number 
ORDER BY 1;



-- ---------------------------------------------------------------------------------------------------------------------------------
-- [Q3] Are customers getting more dissatisfied over time?
WITH Feedback AS (
    SELECT
        quarter_number,
        customer_feedback,
        COUNT(customer_feedback) AS feedback_count,
        SUM(COUNT(*)) OVER (PARTITION BY quarter_number) AS total_feedback
    FROM veh_ord_cust_v
    GROUP BY 1,2
)

SELECT
    quarter_number,
    customer_feedback,
    ROUND((feedback_count / total_feedback) * 100, 2) AS feedback_percentage
FROM Feedback
ORDER BY 1,2;

/*Thought process: Need the percentage of different types of customer feedback in each quarter. Use a common table expression and
	  determine the number of customer feedback in each category as well as the total number of customer feedback in each quarter.
	  Now use that common table expression to find out the percentage of different types of customer feedback in each quarter.
      Eg: (total number of very good feedback/total customer feedback)* 100 gives you the percentage of very good feedback.*/
      

  

WITH CUST_FEEDBACK AS (SELECT quarter_number,
    SUM(CASE WHEN customer_feedback = 'Very Good' THEN 1 ELSE 0 END) AS very_good,
    SUM(CASE WHEN customer_feedback = 'Good' THEN 1 ELSE 0 END) AS good,
    SUM(CASE WHEN customer_feedback = 'OKAY' THEN 1 ELSE 0 END) AS OKAY,
    SUM(CASE WHEN customer_feedback = 'Bad' THEN 1 ELSE 0 END) AS bad, SUM(CASE WHEN customer_feedback = 'Very Bad' THEN 1 ELSE 0
END) AS very_bad,
    COUNT(customer_feedback) AS TOTAL FROM veh_ord_cust_v
GROUP BY 1)
SELECT quarter_number,
    very_good/TOTAL AS PERC_VERY_GOOD,
    good/TOTAL AS PERC_GOOD, okay/TOTAL AS PERC_okay, very_bad/TOTAL AS PERC_VERY_bad,
    bad/TOTAL AS PERC_bad 
FROM CUST_FEEDBACK




-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q4] Which are the top 5 vehicle makers preferred by the customer.

Thought process: For each vehicle make what is the count of the customers.*/

SELECT COUNT(customer_id) AS Number_of_customers,vehicle_maker
FROM vehicles_t
GROUP BY 2 
ORDER BY 1  DESC 
limit 5



-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q5] What is the most preferred vehicle make in each state?

Thought process: Use the window function RANK() to rank based on the count of customers for each state and vehicle maker. 
After ranking, take the vehicle maker whose rank is 1.*/

SELECT
    State,
    vehicle_maker as Top_vehicle_maker,customer_count
FROM (
    SELECT
        COUNT(customer_id) as customer_count,state,
        vehicle_maker,
        RANK() OVER (PARTITION BY state ORDER BY COUNT(customer_id) DESC) AS State_rank
    FROM
        vehicles_t
    GROUP BY
        state,
        vehicle_maker
	ORDER BY COUNT(customer_id) Desc
) ranked_data
WHERE
    State_rank = 1
    
select count(*) from vehicles_t
-- ---------------------------------------------------------------------------------------------------------------------------------

/*QUESTIONS RELATED TO REVENUE and ORDERS 

-- [Q6] What is the trend of number of orders by quarters?*/
Select *
from 
(Select *,
    rank() over( partition by time_of_day order by total desc) as rnk
from
(Select crime_type
   , time_f(incident_time) as time_of_day
      , count(report_no) as total
From rep_loc_off_v
group by 1,2)a) b
where rnk = 1
Hint: Count the number of orders for each quarter.*/

SELECT quarter_number,
COUNT( order_id) AS TOTAL_ORDERS
FROM veh_ord_cust_v
GROUP BY 1


-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q7] What is the quarter over quarter % change in revenue? 

Thought process: Quarter over Quarter percentage change in revenue means what is the change in revenue from the subsequent quarter to the previous quarter in percentage.
      To calculate you need to use the common table expression to find out the sum of revenue for each quarter.
      Then use that CTE along with the LAG function to calculate the QoQ percentage change in revenue.
*/
      
WITH QOQ AS
(SELECT quarter_number,
SUM(calc_revenue_f( vehicle_price,discount ,quantity )) AS
QUARTER_REV
FROM veh_ord_cust_v GROUP BY 1)
SELECT *,100*(QUARTER_REV -LAG(QUARTER_REV,1) OVER(ORDER BY quarter_number) / LAG(QUARTER_REV,1) OVER(ORDER BY quarter_number)) AS PERC_QOQ
FROM QOQ

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q8] What is the trend of revenue and orders by quarters?

Thought process: Find out the sum of revenue and count the number of orders for each quarter.*/

SELECT
    quarter_number,
    SUM(calc_revenue_f(vehicle_price, discount, quantity)) AS total_revenue,
    COUNT(order_id) AS total_orders
FROM
    order_t
GROUP BY
    quarter_number







-- ---------------------------------------------------------------------------------------------------------------------------------

/* QUESTIONS RELATED TO SHIPPING 
    [Q9] What is the average discount offered for different types of credit cards?

Thought process: Find out the average of discount for each credit card type.*/

SELECT credit_card_Type,AVG(discount) AS Average_discount
FROM vehicles_t
GROUP BY 1

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q10] What is the average time taken to ship the placed orders for each quarters?
   Use days_to_ship_f function to compute the time taken to ship the orders.

Thought process: For each quarter, find out the average of the function that you created to calculate the difference between the ship date and the order date.*/


SELECT
    quarter_number,
    AVG(days_to_ship_f(order_date, ship_date)) AS avg_days_to_ship
FROM
    order_t
GROUP BY
    quarter_number;


-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------



