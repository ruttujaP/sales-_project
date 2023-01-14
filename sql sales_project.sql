use sales;

select count(*) from transactions ;
select count(*) from customers ;

select * from customers;
select * from date;
select * from markets;
select * from products;
select * from transactions;

select sales_amount from transactions 
where sales_amount<1;

select count(sales_amount) from transactions;
select count(sales_amount) from transactions
where sales_amount<1;


SET sql_safe_updates=0;

delete from transactions
where sales_amount<1;

#-------joining the tables --------
select d.* ,c.*,m.*,p.*, t.* from date d
inner join transactions t
on d.date=t.order_date
inner join customers c
on  c.customer_code=t.customer_code
inner join markets m
on m.markets_code=t.market_code
inner join products p
on p.product_code=t.product_code;

#---------------------------------------


#---------------

select d.* , t.* from date d
inner join transactions t
on d.date=t.order_date;


select c.* , t.* from customers c
inner join transactions t
on  c.customer_code=t.customer_code;

#----------top 5 customers with sales amount, quantity and their name--------------------------

select custmer_name,sales_amount,sales_qty,  dense_rank() over (order by sales_amount desc) as ranking from customers c
inner join transactions t
on  c.customer_code=t.customer_code
limit 5;

#-------------customer name  brand wise sales amount-------------------
select custmer_name,sales_amount,customer_type, sum(sales_amount) over(partition by customer_type) as A from 
transactions t inner join customers c
on  c.customer_code=t.customer_code;

#---count of own brand products 
select count(product_code) from products
where product_type="Own Brand";

#----------------------------------------------------------------
select m.* , t.* from markets m
inner join transactions t
on m.markets_code=t.market_code;

select sum(sales_amount) from markets m
inner join transactions t
on m.markets_code=t.market_code
where zone="central";

select sum(sales_amount) from markets m
inner join transactions t
on m.markets_code=t.market_code
where zone="north";

select sum(sales_amount) from markets m
inner join transactions t
on m.markets_code=t.market_code
where zone="south";




#------------------------------------------------
select count(sales_qty) from markets m
inner join transactions t
on m.markets_code=t.market_code
where zone="south";

select count(sales_qty) from markets m
inner join transactions t
on m.markets_code=t.market_code
where zone="north";

select count(sales_qty) from markets m
inner join transactions t
on m.markets_code=t.market_code
where zone="central";



#-----------------------------------------




#---------------------------------
select p.* , t.* from products p
inner join transactions t
on p.product_code=t.product_code;


#----------------------

alter table transactions
add column total_salesamount int;
alter table transactions
drop  column total_salesamount ;

update  transactions
set sales_amount=74*(sales_amount)
where currency='USD';

select sum(sales_amount) from transactions;
select count(sales_qty) from transactions;

#----------------------------------
select d.* ,c.*,m.*,p.*, t.* from date d
inner join transactions t
on d.date=t.order_date
inner join customers c
on  c.customer_code=t.customer_code
inner join markets m
on m.markets_code=t.market_code
inner join products p
on p.product_code=t.product_code;

select custmer_name,markets_name,zone,year,month_name,sales_qty,sales_amount from date d
inner join transactions t
on d.date=t.order_date
inner join customers c
on  c.customer_code=t.customer_code
inner join markets m
on m.markets_code=t.market_code
inner join products p
on p.product_code=t.product_code
order by sales_amount desc
limit 5;
