-- SQL RETAIL SALES ANALYSIS  - P1
Create Database Sql_project_p2

-- Create Table 
DROP TABLE IF EXISTS Retail_sales;
Create Table retail_sales 
	( 
transactions_id	INT PRIMARY KEY, 
sale_date	    DATE,
sale_time	    TIME,
customer_id		INT, 
gender	    	VARCHAR(15),
age				INT,	
category		VARCHAR (25), 
quantiy			INT,
price_per_unit	FLOAT, 
cogs			FLOAT,
total_sale		FLOAT

)

Select Count(*) From retail_sales;

-- Data Cleaning
Select * From retail_sales 
Where Transactions_id IS NULL; 

Select * From retail_sales 
Where Sale_date IS NULL 
	OR 
	Transactions_id IS NULL
	OR
	Sale_time  IS NULL
	OR 
	Gender IS NULL  
	OR 
	Category IS NULL 
	OR 
	Quantity IS NULL
	OR
	COGS IS NULL
	OR
	Total_sale IS NULL

	--
	Delete From retail_sales 
Where Sale_date IS NULL 
	OR 
	Transactions_id IS NULL
	OR
	Sale_time  IS NULL
	OR 
	Gender IS NULL  
	OR 
	Category IS NULL 
	OR 
	Quantity IS NULL
	OR
	COGS IS NULL
	OR
	Total_sale IS NULL

	-- Data Exploration	

-- How many sales do we have 
Select Count(*) as Total_sales From retail_sales

--How many unique Customer do we have

Select Count(Distinct Customer_id) as number_of_customer From retail_sales

Select Distinct Category From retail_sales


-- Data Analysis & Business Key Problem


-- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:

Select * from retail_sales where to_char(sale_date,'yyyy-mm')='2022-11' 

-- Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
Select * from retail_sales 
where category = 'Clothing'
and to_char(sale_date,'yyyy-mm')='2022-11' 
and quantity >= 4;

-- Q3. Write a SQL query to calculate the total sales (total_sale) for each category.:


Select Category , Sum( Quantity) From retail_sales Group By category;

-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category. 

Select Round((Avg(age), 2)  From retail_sales Where category = 'Beauty';

-- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:

Select * From retail_sales where total_sale > 1000

-- Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:


Select count( *),  Gender, Category From retail_sales Group By Gender, Category

-- Q7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:


Select Avg(total_sale) as AVG_sale , extract(month From sale_date) AS order_month, Extract(Year FROM Sale_date) AS order_year
From retail_sales 
group By order_month , order_year
ORDER BY order_year , AVG_sale DESC

-- Q8. Write a SQL query to find the top 5 customers based on the highest total sales 
 select * from retail_sales
Select Customer_id, Sum(Total_sale) as Cus_total_sales  From retail_sales
Group By Customer_id ORDER BY Cus_total_sales DESC  Limit 5 

-- Q9. Write a SQL query to find the number of unique customers who purchased items from each category.:

Select Count(Distinct(customer_id)) , category from retail_sales Group By Category

-- Q10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
With Hourly_shift as
(Select *, 
	case  
			when Extract(Hour From Sale_time) < 12 then 'Morning'
			when Extract(Hour From Sale_time) Between 12 and 17 then 'Afternoon'
			Else 'Evening'
End as Shift
From retail_sales)

Select Shift , Count(*) total_orders From Hourly_shift Group By Shift