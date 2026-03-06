with facebook_google_dataset as
  (select fabd.ad_date,
          fc.campaign_name,
          fabd.value
 from public.facebook_ads_basic_daily fabd
 left join public.facebook_campaign fc 
 on fabd.campaign_id=fc.campaign_id
 where fabd.ad_date is not null
 union all 
 select gabd.ad_date,
          gabd.campaign_name,
          gabd.value
 from public.google_ads_basic_daily gabd)
 select campaign_name,
        date_trunc ('week', ad_date) as week_start,
        sum(value) as total_value
from facebook_google_dataset
group by 2, 1
order by 3 desc
limit 1;