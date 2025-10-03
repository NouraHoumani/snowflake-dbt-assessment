{{ config(materialized='view') }}

with orders as (
  select
      o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate,
      o_orderpriority, o_clerk, o_shippriority, o_comment
  from {{ source('tpch','orders') }}
),
customer as (
  select c_custkey, c_name
  from {{ source('tpch','customer') }}
)
select
  o.o_orderkey as order_key,
  o.o_custkey as customer_key,
  c.c_name     as customer_name,
  o.o_orderstatus,
  o.o_totalprice,
  o.o_orderdate,
  DATE_PART('year', o.o_orderdate) AS order_year,
  o.o_orderpriority,
  o.o_clerk,
  o.o_shippriority,
  o.o_comment
from orders o
left join customer c on o.o_custkey = c.c_custkey
