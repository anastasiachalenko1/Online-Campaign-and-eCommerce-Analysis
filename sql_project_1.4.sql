with facebook_google_data as
(select date_trunc('month', fabd.ad_date) as month,
        fc.campaign_name,
        sum(fabd.reach) as total_reach
from public.facebook_ads_basic_daily fabd
left join public.facebook_campaign fc
on fabd.campaign_id=fc.campaign_id 
where fabd.ad_date is not null
group by date_trunc('month', fabd.ad_date), fc.campaign_name
union all
select date_trunc('month', gabd.ad_date) as month,
       gabd.campaign_name,
       sum(gabd.reach) as total_reach
from public.google_ads_basic_daily gabd
where gabd.ad_date is not null
group by date_trunc('month', gabd.ad_date), gabd.campaign_name
),
previous_reach as 
( select fgd.month,
         fgd.campaign_name,
         fgd.total_reach as total_reach,
         pfgd.total_reach as previous_reach,
         fgd.total_reach- coalesce(pfgd.total_reach,0) as reach_diff
   from facebook_google_data fgd
   left join facebook_google_data pfgd
   on pfgd.month=(fgd.month- interval '1 month')::date
   order by fgd.month, fgd.campaign_name 
 )
select month,
       reach_diff
from previous_reach
order by 2 desc
limit 1;
       