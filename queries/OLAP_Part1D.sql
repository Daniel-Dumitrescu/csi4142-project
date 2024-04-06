-- 1. Compare total yearly productions of Wheat   
select
  sum(F."Volume") as Total_Volume,
  D."Year"
from
  "FactTable" as F,
  "Crop" as C,
  "Date" as D
where
  F."Crop_ID" = C."Crop_ID"
  and F."Date_ID" = D."Date_ID"
  and C."Common Name" = 'Wheat' -- slice by the Crop 'wheat'
group by
  D."Year"; -- roll-up by year 

  -- 2. Compare total productions in each quarter of Oats across different regions  
select
  sum(F."Volume") as Total_Volume,
  R."GeographicRegion",
  D."Quarter"
from
  "FactTable" as F,
  "Crop" as C,
  "Region" as R,
  "Date" as D
where
  F."Crop_ID" = C."Crop_ID"
  and F."Region_ID" = R."Region_ID"
  and F."Date_ID" = D."Date_ID"
  and C."Common Name" = 'Oats' -- slice by the Crop 'oats'
group by
  R."GeographicRegion", -- roll-up by region
  D."Quarter"; -- roll-up by quarter

 -- 3. find average volume of Barley produced in different Temperature bands 
select
  avg(F."Volume") as Average_Volume,
  Cl."Mean_Temp_Binned",Cl."Mean_Temp_Binned_Encoded"
from
  "FactTable" as F,
  "Crop" as C,
  "Climate" as Cl
where
  F."Crop_ID" = C."Crop_ID"
  and F."Climate_ID" = Cl."Climate_ID"
  and C."Common Name" = 'Barley' -- slice by Barley
group by
  Cl."Mean_Temp_Binned",Cl."Mean_Temp_Binned_Encoded" -- roll-up by mean temperatures 
order by
  Cl."Mean_Temp_Binned_Encoded" DESC

  -- 4. Find total Rye value in Saskatchewan in each band of ‘Total Precip’  
select
  sum(F."Total_Value") as Sum_Total_Values,
  Cl."Total_Precip_Binned",Cl."Total_Precip_Binned_Encoded"
from
  "FactTable" as F,
  "Crop" as C,
  "Region" as R,
  "Date" as D,
  "Climate" as Cl
where
  F."Crop_ID" = C."Crop_ID"
  and F."Region_ID" = R."Region_ID"
  and F."Date_ID" = D."Date_ID"
  and F."Climate_ID" = Cl."Climate_ID"
  and C."Common Name" = 'Rye' -- dice by Crop and Province  
  and R."Name_EN" = 'Saskatchewan'
group by
  Cl."Total_Precip_Binned",Cl."Total_Precip_Binned_Encoded" -- rollup by precipitation bands
order by
  Cl."Total_Precip_Binned_Encoded" DESC