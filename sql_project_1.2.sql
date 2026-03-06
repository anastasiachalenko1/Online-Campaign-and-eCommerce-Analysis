with fc_gl_dataset as
(select ad_date,
        sum(spend) as total_spend,
        sum(value) as total_value,
        case 
        	when sum(spend)=0 then 0
        	else round((sum(value)-sum(spend))::numeric/sum(spend)*100,2)
        end as "ROMI"
  from public.facebook_ads_basic_daily
  group by 1
  union all 
  select ad_date,
         sum(spend) as total_spend,
         sum(value) as total_value,
         case 
        	when sum(spend)=0 then 0
        	else round((sum(value)-sum(spend))::numeric/sum(spend)*100,2)
        end as "ROMI"
  from public.google_ads_basic_daily
  group by 1
  )
  select ad_date,
         "ROMI"
  from fc_gl_dataset
  where "ROMI" is not null
  group by 1, 2
  order by 2 desc
  limit 5;
  
  
  
  
  
        
case 
        	when sum(spend)=0 then 0
        	else round((sum(value)-sum(spend))::numeric/sum(spend)*100,2)
        end as "ROMI"
