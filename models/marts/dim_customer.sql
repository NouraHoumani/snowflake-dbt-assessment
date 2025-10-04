{{ config(materialized='table') }}

with c as (
  select * from {{ ref('stg_customer') }}
),
n as (
  select n_nationkey as nation_key, n_name as nation_name
  from {{ source('tpch','nation') }}
)
select
  c.customer_key,
  c.customer_name,
  n.nation_name,
  c.market_segment,
  c.account_balance
from c
left join n using (nation_key)