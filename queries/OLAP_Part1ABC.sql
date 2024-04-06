/*Roll up from month to quarter*/
SELECT D."Year",D."Quarter", SUM("Price") as Quarterly_Price , SUM("Volume") as Quarterly_Volume
FROM public."FactTable" F, public."Date" D
WHERE F."Date_ID" = D."Date_ID"
GROUP BY D."Year", D."Quarter"
ORDER BY D."Year", D."Quarter" asc

/*Roll up provinces to Canada Total price and volume every month*/
SELECT F."Date_ID", SUM("Price") as Total_Price , SUM("Volume") as Total_Volume
FROM public."FactTable" F
GROUP BY F."Date_ID"
ORDER BY F."Date_ID" asc



/*Slice by Ontario*/
WITH region_id AS (
    SELECT * FROM public."Region" WHERE "Name_EN" = 'Ontario'
)
SELECT F.*
FROM public."FactTable" F, region_id
WHERE F."Region_ID" = region_id."Region_ID";

/*Dice by Alberta and 2019*/
WITH region_id AS (
    SELECT * FROM public."Region" WHERE "Name_EN" = 'Alberta'
), date_id AS (
    SELECT * FROM public."Date" WHERE "Year" = 2019
)
SELECT F.*
FROM public."FactTable" F, region_id, date_id
WHERE F."Region_ID" = region_id."Region_ID" AND F."Date_ID" = date_id."Date_ID";

/*Dice by Oats and Manitoba*/
WITH crop_id AS (
    SELECT * FROM public."Crop" WHERE "Common Name" = 'Oats'
), region_id AS (
    SELECT * FROM public."Region" WHERE "Name_EN" = 'Manitoba'
)
SELECT F.*
FROM public."FactTable" F, crop_id, region_id
WHERE F."Crop_ID" = crop_id."Crop_ID" AND F."Region_ID" = region_id."Region_ID";


