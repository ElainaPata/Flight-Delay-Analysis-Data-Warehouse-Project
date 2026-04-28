/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

===============================================================================
*/

-- ====================================================================
-- Checking 'dim_airline.csv'
-- ====================================================================
-- Check for NULL values
-- Expectation: No results
Select *
From bronze.dim_airline
Where Reporting_airline IS NULL or Airline_name IS NULL

--Checking for Primary Key Uniquness
-- Expectation: All pk's unique
Select Reporting_airline, COUNT(*) as Dupe_count
From bronze.dim_airline
GROUP BY Reporting_airline
Having COUNT(*) > 1

--Checking for whitespaces 
--Expectation: No results
Select *
From bronze.dim_airline
Where Reporting_airline != TRIM(Reporting_airline) OR 
Airline_name != TRIM(Airline_name)



-- ====================================================================
-- Checking 'dim_airport.csv'
-- ====================================================================
-- Check for NULL values
-- Expectation: No results
SELECT *
FROM bronze.dim_airport
WHERE Airport_code IS NULL
   OR Airport_name IS NULL
   OR City IS NULL
   OR State IS NULL
   OR Latitude IS NULL
   OR Longitude IS NULL

--Checking for Primary Key Uniquness
-- Expectation: All pk's unique
SELECT Airport_code, COUNT(*) as dupes
From bronze.dim_airport
GROUP By Airport_code
HAVING COUNT(*) > 1

--Checking for whitespaces
-- Expectation: No results
Select * 
From bronze.dim_airport
Where Airport_code != TRIM(Airport_code) 
OR Airport_name != TRIM(Airport_name)
OR City != TRIM(City)
OR State != TRIM(State)
OR Latitude != TRIM(Latitude)
OR Longitude != TRIM(Longitude)

-- ====================================================================
-- Checking 'dim_date.csv'
-- ====================================================================
--Checking Primary Key uniqueness and counting total rows
--Expectation: total rows = 31 and unique dates = 31
Select COUNT(*) as total_rows,
    Count(distinct Flight_date) As unique_dates
From bronze.dim_date

--Check date range and validate date conversion
--Expectation: 2019-01-01 and 2019-01-31
SELECT 
    MIN(TRY_CONVERT(DATE, Flight_date, 1)) AS Min_flight_date,
    MAX(TRY_CONVERT(DATE, Flight_date, 1)) AS Max_flight_date
FROM bronze.dim_date

--Checking for duplicates
--Expectation: No results
Select Flight_date, COUNT(*) as dupe_values
From bronze.dim_date
Group By Flight_date
Having count(*) > 1

--Checking for any whitespaces
--Expectation: No results
Select * 
From bronze.dim_date
Where Flight_date != TRIM(Flight_date) 
OR Calendar_year != TRIM(Calendar_year)
OR Month_number != TRIM(Month_number)
OR Date_number != TRIM(Date_number)
OR Day_of_week != TRIM(Day_of_week)
OR Day_name != TRIM(Day_name)
OR Is_weekend != TRIM(Is_weekend)
OR Quarter_name != TRIM(Quarter_name)

-- ====================================================================
-- Checking 'dim_route.csv'
-- ====================================================================
--Checking for null values
--Expectation: No results
Select * 
From bronze.dim_route
WHERE Route_id IS NULL
OR Origin IS NULL
OR Destination IS NULL

--Checking duplicates by route
--Expectation: No results
Select Route_id, COUNT(*) as total_records 
From bronze.dim_route
GROUP By Route_id
HAVING COUNT(*) > 1

--Checking for any whitespaces
--Expectation: No results
Select * 
From bronze.dim_route
Where Route_id != TRIM(Route_id)
OR Origin != TRIM(Origin)
OR Destination != TRIM(Destination)

-- ====================================================================
-- Checking 'dim_weather.csv'
-- ====================================================================
--Checking for null values
--Expectation: No results
SELECT *
FROM bronze.dim_weather
WHERE Airport_code IS NULL
   OR Airport_name IS NULL
   OR Flight_date IS NULL
   OR Wind IS NULL
   OR Precipitation IS NULL
   OR Snow IS NULL
   OR Avg_temp IS NULL

--Checking for uniqueness of the two columns that join to the fact table 
--Expectation: No dupes 
SELECT Airport_code, Flight_date, COUNT(*) AS record_count
FROM bronze.dim_weather
GROUP BY Airport_code, Flight_date
HAVING COUNT(*) > 1

--Counting to see how many missing values appear in each column with nulls 
SELECT COUNT(*) AS Wind_missing
FROM bronze.dim_weather
WHERE Wind IS NULL OR TRIM(Wind) = ''

SELECT COUNT(*) AS Precipitation_missing
FROM bronze.dim_weather
WHERE Precipitation IS NULL OR TRIM(Precipitation) = ''

SELECT COUNT(*) AS Snow_missing
FROM bronze.dim_weather
WHERE Snow IS NULL OR TRIM(Snow) = ''

--Check date range and validate date conversion
--Expectation: 2019-01-01 through 2019-01-31
SELECT MIN(TRY_CONVERT(DATE, Flight_date)) AS Min_flight_date,
 MAX(TRY_CONVERT(DATE, Flight_date)) AS Max_flight_date
FROM bronze.dim_weather

--Checking for whitespace issues
--Expectation: No results
SELECT *
FROM bronze.dim_weather
WHERE Airport_code != TRIM(Airport_code)
OR Airport_name != TRIM(Airport_name)
OR Flight_date != TRIM(Flight_date)

-- ====================================================================
-- Checking 'fact_flights.csv'
-- ====================================================================
--Checking key columns for nulls 
--Expectation: No results 
SELECT *
FROM bronze.fact_flights
WHERE Flight_date IS NULL
OR Reporting_airline IS NULL
OR Origin IS NULL
OR Destination IS NULL
OR Route_id IS NULL

--Checking for dupes 
--Expectation: No results
SELECT 
Flight_date,
Reporting_airline,
Origin,
Destination,
Route_id,
Dep_delay,
Taxi_out,
Taxi_in,
Arr_delay,
Cancelled,
Diverted,
Distance,
COUNT(*) AS record_count
FROM bronze.fact_flights
GROUP BY 
Flight_date,
Reporting_airline,
Origin,
Destination,
Route_id,
Dep_delay,
Taxi_out,
Taxi_in,
Arr_delay,
Cancelled,
Diverted,
Distance
HAVING COUNT(*) > 1

--Counting to see how many dupe rows actually exist
SELECT COUNT(*) AS duplicate_groups
FROM (
    SELECT 
        Flight_date,
        Reporting_airline,
        Origin,
        Destination,
        Route_id,
        Dep_delay,
        Taxi_out,
        Taxi_in,
        Arr_delay,
        Cancelled,
        Diverted,
        Distance
    FROM bronze.fact_flights
    GROUP BY 
        Flight_date,
        Reporting_airline,
        Origin,
        Destination,
        Route_id,
        Dep_delay,
        Taxi_out,
        Taxi_in,
        Arr_delay,
        Cancelled,
        Diverted,
        Distance
    HAVING COUNT(*) > 1
) d

--Checking to see if the date ranges for all of January appear 
--Expectation: Jan 1 - 31
SELECT 
MIN(TRY_CONVERT(DATE, Flight_date, 1)),
MAX(TRY_CONVERT(DATE, Flight_date, 1))
FROM bronze.fact_flights

--Checking key columns for any whitespaces
--Expectation: No results 
SELECT *
FROM bronze.fact_flights
WHERE Reporting_airline != TRIM(Reporting_airline)
OR Origin != TRIM(Origin)
OR Destination != TRIM(Destination)
