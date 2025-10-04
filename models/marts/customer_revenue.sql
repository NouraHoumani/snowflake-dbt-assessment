{{ config(materialized='table') }}

with orders as (
  select o_orderkey, o_custkey
  from {{ source('tpch','orders') }}
),
customer as (
  select c_custkey, c_name
  from {{ source('tpch','customer') }}
),
lineitem as (
  select l_orderkey, l_extendedprice, l_discount
  from {{ source('tpch','lineitem') }}
),
revenue as (
  select
    o.o_custkey as customer_key,
    sum(l.l_extendedprice * (1 - l.l_discount)) as total_revenue
  from orders o
  join lineitem l on l.l_orderkey = o.o_orderkey
  group by 1
)
select
  c.c_custkey as customer_key,
  c.c_name    as customer_name,
  r.total_revenue
from revenue r
join customer c on c.c_custkey = r.customer_key
