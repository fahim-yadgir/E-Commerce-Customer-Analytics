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

select product_name , sum(price) over(partition by product_name order by review_date asc)as runnig_price
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

select customer_name , count(*)as customer_count
from flipkart_orders_for_sql
group by customer_name;

select count(distinct(customer_name))
from flipkart_orders_for_sql;

select count(customer_name)
from flipkart_orders_for_sql;

select month(review_date)as Month_review , sum(price)as total_price
from flipkart_orders_for_sql
group by Month_review
order by Month_review asc;

create view Kitchenware_product as(
select * from flipkart_orders_for_sql
where product_name = 'Kitchenware')

select * from 
Kitchenware_product;

drop view `2024_January_data`;

create view `2024_data` as 
(
select year(review_date)as years ,order_id , customer_name, product_name, review_date , rating , price , sum(price) over(order by order_id)
from flipkart_orders_for_sql
where year(review_date) = '2024'
)

select * from `2024_data`;


create view `2025_years_data` as
(
select year(review_date)as years , customer_name,product_name,review_date,rating,price,sum(price) over(order by order_id)as runnig_price
from flipkart_orders_for_sql
where year(review_date) = '2025'
)

select * from `2025_years_data`;

create view `2026_years_data` as
(
select year(review_date)as years , customer_name,product_name,review_date,rating,price,sum(price) over(order by order_id)as runnig_price
from flipkart_orders_for_sql
where year(review_date) = '2026'
)

select * from `2026_years_data`;

create view `2024_years_data` as
(
select year(review_date)as years , customer_name,product_name,review_date,rating,price,sum(price) over(order by order_id)as runnig_price
from flipkart_orders_for_sql
where year(review_date) = '2026'
)

select * from `2026_years_data`;

select year(review_date) as years,sum(price)as total_price
from flipkart_orders_for_sql
group by years;

create view `2023_years_data` as
(
select year(review_date)as years , customer_name,product_name,review_date,rating,price,sum(price) over(order by order_id)as runnig_price
from flipkart_orders_for_sql
where year(review_date) = '2023'
)

select * from `2023_years_data`;

select product_name , sum(price)as total_revenue
from flipkart_orders_for_sql
group by product_name
order by total_revenue desc;

create view Electronics_products as
(
select product_name , customer_name , review_date , rating , price,sum(price) over(order by review_date)as runnig_price
from flipkart_orders_for_sql
where product_name = 'Electronics'
order by review_date asc
)

select * from Electronics_products;

create view Groceries_Data as
(
select * from flipkart_orders_for_sql
where product_name = "Groceries"
)

select * from Groceries_Data;

select product_name , count(*)as total_count
from flipkart_orders_for_sql
group by product_name
order by total_count desc;

select rating , sum(price)as total_sell
from flipkart_orders_for_sql
group by rating
order by total_sell desc;

select product_name,price,sum(price)over(order by review_date)as dates
from flipkart_orders_for_sql
where price > 7000 and product_name = "Electronics"


drop procedure Update_product_name;

delimiter $$

create procedure Update_product_name
(
in o_id text,
in p_name text,
in price bigint
)
begin 
update flipkart_orders_for_sql
set product_name = p_name , price = price
where order_id = o_id;
select * from flipkart_orders_for_sql;
end $$

call Update_product_name("ORD000001","Groceries",200);

select customer_name , product_name , `returns` , review_date , rating , price
from flipkart_orders_for_sql
where review_date between '2026-01-01' and '2026-12-31' and rating = 5 and price > 4000 and `returns` = 'Yes';

select customer_name , product_name,sum(price)as total_purchasing ,count(*)as total_count
from flipkart_orders_for_sql
group by customer_name , product_name
having sum(price) > 50000
order by product_name;

select customer_name , product_name 
from flipkart_orders_for_sql
where customer_name = 'Inaya Taneja'

select * from flipkart_orders_for_sql;

select *,sum(price) over(order by review_date)
from flipkart_orders_for_sql
where `returns` = 'Yes' and price > 5000;

create view Sports_Equipment as
(
select * ,sum(price) over(order by review_date) from flipkart_orders_for_sql
where product_name = 'Sports Equipment'
)

select * from Sports_Equipment;

select customer_name , product_name , `returns` , price
from flipkart_orders_for_sql
where customer_name = 'Tara Varughese';

select customer_name , product_name , `returns` , price
from flipkart_orders_for_sql
where rating >= 4 and price > 4500 ;

delimiter $$
create procedure Update_returns
(
in order_id text,
in `returns`text
)
begin 
update flipkart_orders_for_sql
set `returns` = `returns`
where order_id = order_id;
select * from flipkart_orders_for_sql;
end $$
delimiter $$

start transaction;
call Update_returns("ORD000001","No");

rollback;

select order_id , customer_name , product_name , `returns` , price
from flipkart_orders_for_sql
where `returns` = 'Yes' and price < 100;
