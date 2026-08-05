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

