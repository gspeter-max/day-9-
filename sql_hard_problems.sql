'''
Problem Statement
You are given a Transactions table that logs all money transfers between users in a bank. 
Some users are flagged as fraudulent,
and fraudsters tend to transfer money to each other. 
Your goal is to find all users who have indirectly received money from a fraudster (any number of transactions down the chain).
'''


with recursive temp_temp as (
	select t.receiver_id
	from fraudulent_users f 
	join  transactions  t on t.sender_id = f.user_id 

	union all 

	select t2.receiver_id
	from transactions t2 
	join temp_temp t3 on t2.sender_id = t3.receiver_id 
) 
select distinct receiver_id 
from temp_temp 
order by receiver_id ;


''' 
Problem Statement
You are given a table of daily stock prices. The data has missing dates, so you cannot assume consecutive rows represent consecutive days. Your task is to:

Find the longest increasing streak of stock prices (ignoring missing dates).
Rank stocks by their best price streaks.
''' 

with temp_temp as (
	select stock_id , 
		date,
		price, 
		lag(price) over(partition by stock_id order by date ), 
		sum(
			case when price > leg(price) over(
				partition by stock_id order by date ) then 1 else 0 end )
				over(partition by stock_id order by date ) as stick_count, 
		from stock_prices 
	) 

select stock_id , max(count(*) over(partition by stock_id , stick_count)) as longest_increasing_steak
from temp_temp 
group by stock_id , stick_count;



'''
Problem Statement

Retention for 3 months: Similar, but checking for cancellations within 3 months.
A company tracks user subscription start and cancellation dates. 
You need to predict the percentage of users still active per cohort (monthly joiners) at 1 month, 
3 months, and 6 months.
'''
with temp_temp as (
	select date_format(singup_date, '%Y-%m-01') as cohort_month, 
		count(user_id) as total_users,
		
		count(case when cancel_date is null or cancel_date >= signup_date + interval 1 month then 1 
		 end ) * 100 / count(*) as retention_1m , 

		count(case when cancel_date is null or cancel_date >= signup_date + interval 3 month then 1 
		 end ) * 100 / count(*) as retention_3m , 

		count(case when cancel_date is null or cancel_date >= signup_date + interval 6 month then 1 
		 end ) * 100 / count(*) as retention_6m 

	from subscription
	group by cohort_month
	order by cohort_month
) 
select cohort_month , 
	retention_1m, 
	retention_3m, 
	retention_6m
from temp_temp; 



