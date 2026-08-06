create database E_commerce;
use E_commerce;

select * from flipkart_orders_for_sql;

SET SQL_SAFE_UPDATES = 0;

SET SQL_SAFE_UPDATES = 1;

alter table flipkart_orders_for_sql
rename column `ï»¿order_id_pk`  to order_id;

update flipkart_orders_for_sql
set review_date = str_to_date(review_date,'%d-%m-%Y');

alter table flipkart_orders_for_sql
modify column rating int;

alter table flipkart_orders_for_sql
modify column price bigint;

select `returns`,rating , sum(price) 
from flipkart_orders_for_sql
where rating = 5 and `returns` = 'Yes'
group by `returns`,rating;

select rating , max(price)as total_price
from flipkart_orders_for_sql
group by rating 
order by total_price desc
limit 1;

select customer_name , sum(price)as total_price,count(customer_name)as total_count
from flipkart_orders_for_sql
group by customer_name;
