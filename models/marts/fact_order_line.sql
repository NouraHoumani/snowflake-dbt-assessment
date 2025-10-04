{{ config(materialized='table') }}

with li as (select * from {{ ref('stg_lineitem') }}),
o  as (
  select o_orderkey as order_key, o_custkey as customer_key, o_orderdate
  from {{ source('tpch','orders') }}
)
select
  li.order_key,
  li.line_number,
  o.customer_key,
  o.o_orderdate        as order_date,
  (li.l_extendedprice * (1 - li.l_discount)) as line_revenue,
  li.l_quantity,
  li.l_tax,
  li.l_returnflag,
  li.l_linestatus,
  li.l_shipdate,
  li.l_commitdate,
  li.l_receiptdate
from li
join o using (order_key)
