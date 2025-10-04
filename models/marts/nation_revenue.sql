{{ config(materialized='table') }}

select
  d.nation_name,
  sum(f.line_revenue) as total_revenue
from {{ ref('fact_order_line') }} f
join {{ ref('dim_customer') }} d using (customer_key)
group by 1
