USE corona_project;

SELECT *
FROM corona_data;

-- Standardize the Data.

SELECT 
STR_TO_DATE(`Date`, '%Y-%m-%d') AS Cleaned_Date
FROM corona_data;

UPDATE corona_data
SET `Date` = STR_TO_DATE(`Date`, '%Y-%m-%d');

ALTER TABLE corona_data
MODIFY COLUMN `Date` DATE;

-- Check if NULL values exists, Replace them with a suitable values.

SELECT *
FROM corona_data
WHERE 
	Province IS NULL OR
	`Country/Region` IS NULL OR
	Latitude IS NULL OR
	Longitude IS NULL OR
	`Date` IS NULL OR
	Confirmed IS NULL OR
	Deaths IS NULL OR
	Recovered IS NULL;

-- Check total number of rows.

SELECT COUNT(*) 
FROM corona_data; 

SELECT COUNT(Province) 
FROM corona_data; 

SELECT COUNT(DISTINCT Province) 
FROM corona_data; 

-- Check the start and the end date

SELECT 
	MIN(`Date`) AS Start_Date, 
	MAX(`Date`) AS End_Date
FROM corona_data;

-- Check number of months in dataset.

SELECT SUBSTR(`Date`,1,7)
FROM corona_data;

SELECT COUNT(DISTINCT SUBSTR(`Date`,1,7)) AS Corona_Months
FROM corona_data;

-- Find monthly average for confirmed, deaths and recovered cases.

SELECT 
  SUBSTR(`Date`, 1, 7) AS `Month`,
  AVG(Confirmed) AS Avg_Confirmed,
  AVG(Deaths) AS Avg_Deaths,
  AVG(Recovered) AS Avg_Recovered
FROM corona_data
GROUP BY `Month`;

SELECT 
  SUBSTR(`Date`, 1, 7) AS `Month`,
  ROUND(AVG(Confirmed),2) AS Avg_Confirmed,
  ROUND(AVG(Deaths),2) AS Avg_Deaths,
  ROUND(AVG(Recovered),2) AS Avg_Recovered
FROM corona_data
GROUP BY `Month`
ORDER BY `Month` DESC;

-- Find minimum values for confirmed, deaths and recovered cases per year.

SELECT 
  YEAR(`Date`) AS `Year`,
  MIN(Confirmed) AS Min_Confirmed,
  MIN(Deaths) AS Min_Deaths,
  MIN(Recovered) AS Min_Recovered
FROM corona_data
WHERE
	Confirmed != 0 AND
	Deaths != 0 AND
	Recovered != 0
GROUP BY `Year`;

-- Find maximum values for confirmed, deaths and recovered cases per year.

SELECT 
  YEAR(`Date`) AS `Year`,
  MAX(Confirmed) AS Max_Confirmed,
  MAX(Deaths) AS Max_Deaths,
  MAX(Recovered) AS Max_Recovered
FROM corona_data
GROUP BY `Year`;

-- Find total number for confirmed, deaths and recovered cases each month.

SELECT 
  SUBSTR(`Date`, 1, 7) AS `Month`,
  SUM(Confirmed) AS Total_Confirmed,
  SUM(Deaths) AS Total_Deaths,
  SUM(Recovered) AS Total_Recovered
FROM corona_data
GROUP BY `Month`
ORDER BY `Month` DESC;

-- Find the ncountry with the highest number of confirmed cases.

SELECT 
	`Country/Region` AS Country,
    SUM(Confirmed) AS Total_Confirmed
FROM corona_data
GROUP BY `Country`
ORDER BY Total_Confirmed DESC;

SELECT 
	`Country/Region` AS Country,
    SUM(Confirmed) AS Total_Confirmed
FROM corona_data
GROUP BY `Country`
ORDER BY Total_Confirmed DESC
LIMIT 1;

WITH Country_Confirmed AS (
    SELECT 
    `Country/Region` AS Country, 
	SUM(Confirmed) AS Total_Confirmed
    FROM corona_data
    GROUP BY Country
)
SELECT Country
FROM Country_Confirmed
WHERE Total_Confirmed = (
	SELECT MAX(Total_Confirmed) 
	FROM Country_Confirmed
);

WITH Country_Totals AS (
    SELECT 
		`Country/Region` AS Country,
        SUM(Confirmed) AS Total_Confirmed
    FROM corona_data
    GROUP BY Country
)
SELECT 
    Country,
    Total_Confirmed,
    RANK() OVER (ORDER BY Total_Confirmed DESC) AS Country_Rank
FROM Country_Totals
ORDER BY Country_Rank;


