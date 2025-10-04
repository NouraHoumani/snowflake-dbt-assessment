{{ config(materialized='table') }}

select
  f.customer_key,
  d.customer_name,
  year(f.order_date) as order_year,
  sum(f.line_revenue) as total_revenue
from {{ ref('fact_order_line') }} f
join {{ ref('dim_customer') }} d using (customer_key)
group by 1,2,3
