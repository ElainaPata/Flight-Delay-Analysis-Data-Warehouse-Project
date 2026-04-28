/*
===============================================================================
Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This step performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
===============================================================================
*/
TRUNCATE TABLE silver.dim_airline;
GO
INSERT INTO silver.dim_airline (
    Reporting_airline,
    Airline_name
)
SELECT
    UPPER(TRIM(Reporting_airline)) AS Reporting_airline,
    TRIM(Airline_name) AS Airline_name
FROM bronze.dim_airline
GO


TRUNCATE TABLE silver.dim_airport;
GO
INSERT INTO silver.dim_airport (
    Airport_code,
    Airport_name,
    City,
    State,
    Latitude,
    Longitude
)
SELECT
    UPPER(TRIM(Airport_code)) AS Airport_code,
    TRIM(Airport_name) AS Airport_name,
    TRIM(City) AS City,
    UPPER(TRIM(State)) AS State,
    TRY_CONVERT(DECIMAL(9,6), Latitude) AS Latitude,
    TRY_CONVERT(DECIMAL(9,6), Longitude) AS Longitude
FROM bronze.dim_airport
GO


TRUNCATE TABLE silver.dim_date;
GO
INSERT INTO silver.dim_date (
    Flight_date,
    Calendar_year,
    Month_number,
    Date_number,
    Day_of_week,
    Day_name,
    Is_weekend,
    Quarter_name
)
SELECT
    TRY_CONVERT(DATE, Flight_date, 1) AS Flight_date,
    TRY_CONVERT(INT, Calendar_year) AS Calendar_year,
    TRY_CONVERT(INT, Month_number) AS Month_number,
    TRY_CONVERT(INT, Date_number) AS Date_number,
    TRIM(Day_of_week) AS Day_of_week,
    TRIM(Day_name) AS Day_name,
    TRIM(Is_weekend) AS Is_weekend,
    TRIM(Quarter_name) AS Quarter_name
FROM bronze.dim_date
GO


TRUNCATE TABLE silver.dim_route;
GO
INSERT INTO silver.dim_route (
    Route_id,
    Origin,
    Destination
)
SELECT
    CONCAT(UPPER(TRIM(Origin)), '-', UPPER(TRIM(Destination))) AS Route_id,
    UPPER(TRIM(Origin)) AS Origin,
    UPPER(TRIM(Destination)) AS Destination
FROM bronze.dim_route
GO


TRUNCATE TABLE silver.dim_weather;
GO
INSERT INTO silver.dim_weather (
    Airport_code,
    Airport_name,
    Flight_date,
    Wind,
    Precipitation,
    Snow,
    Avg_temp
)
SELECT
    UPPER(TRIM(Airport_code)) AS Airport_code,
    TRIM(Airport_name) AS Airport_name,
    TRY_CONVERT(DATE, Flight_date) AS Flight_date,
    TRY_CONVERT(FLOAT, Wind) AS Wind,
    TRY_CONVERT(FLOAT, Precipitation) AS Precipitation,
    TRY_CONVERT(FLOAT, Snow) AS Snow,
    TRY_CONVERT(FLOAT, Avg_temp) AS Avg_temp
FROM bronze.dim_weather
GO

TRUNCATE TABLE silver.fact_flights;
GO
INSERT INTO silver.fact_flights (
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
)
SELECT
    TRY_CONVERT(DATE, Flight_date, 1) AS Flight_date,
    UPPER(TRIM(Reporting_airline)) AS Reporting_airline,
    UPPER(TRIM(Origin)) AS Origin,
    UPPER(TRIM(Destination)) AS Destination,
    CONCAT(UPPER(TRIM(Origin)), '-', UPPER(TRIM(Destination))) AS Route_id,

    TRY_CONVERT(FLOAT, Dep_delay) AS Dep_delay,
    TRY_CONVERT(FLOAT, Taxi_out) AS Taxi_out,
    TRY_CONVERT(FLOAT, Taxi_in) AS Taxi_in,
    TRY_CONVERT(FLOAT, Arr_delay) AS Arr_delay,

    TRY_CONVERT(INT, Cancelled) AS Cancelled,
    TRY_CONVERT(INT, Diverted) AS Diverted,
    TRY_CONVERT(FLOAT, Distance) AS Distance
FROM bronze.fact_flights
GO
