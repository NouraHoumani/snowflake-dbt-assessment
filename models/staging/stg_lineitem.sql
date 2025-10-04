{{ config(materialized='view') }}

select
  l_orderkey    as order_key,
  l_linenumber  as line_number,
  l_quantity,
  l_extendedprice,
  l_discount,
  l_tax,
  l_shipdate,
  l_commitdate,
  l_receiptdate,
  l_returnflag,
  l_linestatus
from {{ source('tpch','lineitem') }}
