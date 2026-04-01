SELECT * FROM `data-analytics-491111.amazon_sales_dataset.amazon_sales` LIMIT 1000;

--Total revenue category
Select
Concat('$',ROUND(SUM(CASE WHEN product_category = 'Electronics' THEN total_revenue END),2)) AS total_Electronics_revenue,
Concat ('$', ROUND(SUM(CASE WHEN product_category = 'Home & Kitchen' THEN total_revenue END),2))AS total_Home_and_Kitchen_revenue,
Concat('$',ROUND(SUM(CASE WHEN product_category = 'Beauty' THEN total_revenue  END),2)) AS total_beauty_revenue,
Concat('$',ROUND(SUM(CASE WHEN product_category = 'Books' THEN total_revenue END),2)) AS total_Books_revenue,
Concat('$',ROUND(SUM(CASE WHEN product_category = 'Fashion' THEN total_revenue END),2)) AS total_Fashion_revenue,
Concat('$',ROUND(SUM(CASE WHEN product_category = 'Sports' THEN total_revenue END),2)) AS total_Sports_revenue

from `amazon_sales_dataset.amazon_sales`;
--Average Discount Category
Select     
Round(AVG(DISTINCT CASE WHEN product_category = 'Electronics' THEN discount_percent END)) AS AVG_Electronics_discount,
Round(AVG(DISTINCT CASE WHEN product_category = 'Home & Kitchen' THEN discount_percent END)) AS AVG_Home_Kitchen_discount,
Round(AVG(DISTINCT CASE WHEN product_category = 'Beauty' THEN discount_percent END)) AS AVG_beauty_discount,
ROUND(AVG(DISTINCT CASE WHEN product_category = 'Books' THEN discount_percent END)) AS AVG_Books_discount,
ROUND(AVG(DISTINCT CASE WHEN product_category = 'Fashion' THEN discount_percent END)) AS AVG_Fashion_discount,
ROUND(AVG(DISTINCT CASE WHEN product_category = 'Sports' THEN discount_percent END)) AS AVG_Sports_discount

from `amazon_sales_dataset.amazon_sales`;
Select distinct avg(discount_percent) ,product_category from `amazon_sales_dataset.amazon_sales`
group by product_category;
--Highest quantity sold category
select
Count(case when product_category ='Electronics' then quantity_sold end) AS Electronics_quantity_sold,
Count(case when product_category ='Home & Kitchen' then quantity_sold end) AS Home_and_Kitchen_quantity_sold,
Count(case when product_category ='Beauty' then quantity_sold end) AS beauty_quantity_sold,
Count(case when product_category ='Books' then quantity_sold end) AS Books_quantity_sold,
Count(case when product_category ='Fashion' then quantity_sold end) AS Fashion_quantity_sold,
Count(case when product_category ='Sports' then quantity_sold end) AS Sports_quantity_sold
from `amazon_sales_dataset.amazon_sales`;

--Discount vs Revenue
SELECT
product_category,
ROUND(avg(discount_percent),3) as avg_discount,
sum( total_revenue) as revenue
from `amazon_sales_dataset.amazon_sales`
GROUP BY product_category
order by revenue desc;

--Revenue by region 
select customer_region,
round(sum(total_revenue)) as revenue
from `amazon_sales_dataset.amazon_sales`
group by customer_region;

--Quantity sold by region and catergory
select customer_region,product_category,
sum(quantity_sold) as quantity_sold
from `amazon_sales_dataset.amazon_sales`
group by product_category,customer_region
order by quantity_sold desc;
select 
customer_region,discount_percent,
count(case when product_category ='Electronics' then customer_region end ) as electronics_region_performance ,
count(case when product_category ='Home & Kitchen' then customer_region end ) as home_and_kitchen_region_performance ,
count(case when product_category ='Beauty' then customer_region end) as beauty_region_performance,
count(case when product_category ='Books' then customer_region end) as Books_region_performance,
count(case when product_category ='Fashion' then customer_region end) as Fashion_region_performance,
count(case when product_category ='Sports' then customer_region end) as Sports_region_performance
from `amazon_sales_dataset.amazon_sales` 
group by customer_region, discount_percent
having sum(quantity_sold)>=1 and(sum(discount_percent)>=1 )
order by customer_region,electronics_region_performance, beauty_region_performance ,Books_region_performance ,Fashion_region_performance ,Sports_region_performance desc; 


--Quantity sold and revenue earned by region and category
select customer_region,product_category,
sum (quantity_sold) as quantity_sold,CONCAT('$', ROUND(SUM(total_revenue),2)) AS total_revenue
 from `amazon_sales_dataset.amazon_sales` 
group by customer_region,product_category;

--Payment method
select customer_region,
count(case when payment_method ='UPI' then customer_region end)as UPI,
count(case when payment_method ='Credit card' then customer_region end)as Credit_card,
count(case when payment_method ='Debit Card' then customer_region end)as Debit_cars,
count(case when payment_method ='Wallet' then customer_region end)as Wallet,
count(case when payment_method ='Cash on Delivery' then customer_region end)as Cash_on_Delivery,
from `amazon_sales_dataset.amazon_sales`
group by customer_region;
