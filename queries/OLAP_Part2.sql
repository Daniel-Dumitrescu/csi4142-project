-- 2.a) Iceberg: Top five largest Total Value in a month across all recordsr  
select
  F."Total_Value",
  C."Common Name", 
  R."Name_EN", 
  D."Date"
from
  "FactTable" as F,
  "Crop" as C,
  "Region" as R,
  "Date" as D
where
  F."Crop_ID" = C."Crop_ID"
  and F."Region_ID" = R."Region_ID"
  and F."Date_ID" = D."Date_ID"
order by
  F."Total_Value" DESC
limit 5

-- 2.b) Windowing: Filter by province of Ontario, partition by type of grain, compute each grain’s average value (across all datapoints) and create rank for months within a particular grain

SELECT
  C."Common Name",
  D."Date",
  "Total_Value",
  AVG("Total_Value") OVER (PARTITION BY C."Crop_ID") AS "Average_Value",
  RANK() OVER (PARTITION BY C."Crop_ID" ORDER BY "Total_Value" DESC) AS "Rank"
FROM
  "FactTable" as F,
  "Region" as R,
  "Date" as D,
  "Crop" as C
WHERE
 F."Crop_ID" = C."Crop_ID"
  and F."Region_ID" = R."Region_ID"
  and F."Date_ID" = D."Date_ID"
  AND R."Name_EN" = 'Ontario'

-- 2.c) Window: Moving window on Volume in Ontario by crop 
select
   C."Common Name", 
   R."Name_EN",
   D."Date", 
   AVG(F."Total_Value") OVER W AS movavg_value
from
  "FactTable" as F,
  "Crop" as C,
  "Region" as R,
  "Date" as D
where
  F."Crop_ID" = C."Crop_ID"
  and F."Region_ID" = R."Region_ID"
  and F."Date_ID" = D."Date_ID"
  and R."Name_EN" = 'Ontario'
window w as (partition by C."Common Name"
  order by D."Date"
  range between interval '1' month preceding
  and interval '1' month following)


