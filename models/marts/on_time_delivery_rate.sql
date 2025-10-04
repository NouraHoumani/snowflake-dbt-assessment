{{ config(materialized='table') }}

with base as (
  select
    d.nation_name,
    year(f.order_date) as order_year,
    case when f.l_receiptdate <= f.l_commitdate then 1 else 0 end as on_time
  from {{ ref('fact_order_line') }} f
  join {{ ref('dim_customer') }} d using (customer_key)
)
select
  nation_name,
  order_year,
  avg(on_time)::float as on_time_rate
from base
group by 1,2
