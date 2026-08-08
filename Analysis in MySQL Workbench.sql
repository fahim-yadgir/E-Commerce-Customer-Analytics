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

select product_name , sum(price)as total_revenue
from flipkart_orders_for_sql
group by product_name;

select customer_name ,product_name, sum(price)as max_price
from flipkart_orders_for_sql
group by customer_name,product_name
limit 1;

select product_name , sum(price) over(partition by product_name order by review_date asc)as runnig_salary
from flipkart_orders_for_sql;

delimiter $$
create procedure Update_rating
(
in o_id text,
in rate int
)
begin 
update flipkart_orders_for_sql
set rating = rate
where order_id = o_id;
select * from flipkart_orders_for_sql;
end $$

call Update_rating('ORD000005',3);

delimiter $$
create procedure Update_customer_name(
in o_id text,
in c_name text
)
begin
update flipkart_orders_for_sql
set customer_name = c_name
where order_id = o_id;
select * from flipkart_orders_for_sql;
end $$
call Update_customer_name('ORD000001','Fahim Yadgir');