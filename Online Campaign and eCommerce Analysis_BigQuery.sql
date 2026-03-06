SELECT 
 timestamp_micros(event_timestamp) as event_timestamp,
 user_pseudo_id,
 (select value.int_value from unnest(event_params) ep where ep.key= 'ga_session_id') as session_id,
 event_name,
 geo.country as country,
 device.category,
 traffic_source.source as source,
 traffic_source.medium as medium,
 traffic_source.name as campaign
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` 
where _TABLE_SUFFIX between '20210101' and '20210131'
and event_name in (
  'session_start',
  'view_item',
  'add_to_cart',
  'begin_checkout',
  'add_delivery_info',
  'add_payment_info',
  'purchase' )