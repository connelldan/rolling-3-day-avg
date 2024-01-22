/* Using this dataset, show the SQL query to find the rolling 3 day average transaction amount for each day in January 2021. */

with tbd as(
  select 
    cast(transaction_time as date) as trans_date, 
    sum(transaction_amount) as total_transaction_amount 
  from 
    transactions 
  group by 
    cast(transaction_time as date) 
  order by 
    cast(transaction_time as date)
) 
select 
  *, 
  avg(total_transaction_amount) over(
    order by 
      trans_date rows between 2 preceding 
      and current row
  ) as moving_average 
from 
  tbd