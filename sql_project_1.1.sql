with fc_gl_dataset as 
(select ad_date,
        'Facebook' as media_source,
         coalesce(spend,0) as spend
 from public.facebook_ads_basic_daily 
 union all 
 select ad_date,
        'Google' as media_source,
        coalesce(spend,0) as spend
from  public.google_ads_basic_daily
)
select ad_date,
       media_source,
       max(spend),
       avg(spend),
       min(spend)
from fc_gl_dataset
group by ad_date, media_source