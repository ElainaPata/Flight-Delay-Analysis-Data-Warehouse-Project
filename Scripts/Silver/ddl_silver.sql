/*
-----------------------------------------------------
DDL script: Create Silver Tables
-----------------------------------------------------
Script Purpose: 
  This script creates tables in the 'silver' schema, dropping exsisting tables if they already exsist.
  Run this script to redefine the DDL structure of the silver table.
------------------------------------------------------------------------------------------------------
*/
IF OBJECT_ID('silver.dim_airline', 'U') IS NOT NULL
    DROP TABLE silver.dim_airline
CREATE TABLE silver.dim_airline (
    Reporting_airline NVARCHAR(50),
    Airline_name NVARCHAR(50),
    Dwh_create_date DATETIME2 DEFAULT GETDATE()
)
GO

IF OBJECT_ID('silver.dim_airport', 'U') IS NOT NULL
    DROP TABLE silver.dim_airport
GO
CREATE TABLE silver.dim_airport (
    Airport_code NVARCHAR(50),
    Airport_name NVARCHAR(255),
    City NVARCHAR(50),
    State NVARCHAR(50),
    Latitude NVARCHAR(50),
    Longitude NVARCHAR(50),
    Dwh_create_date DATETIME2 DEFAULT GETDATE()
)
GO

IF OBJECT_ID('silver.dim_date', 'U') IS NOT NULL
    DROP TABLE silver.dim_date
GO
CREATE TABLE silver.dim_date (
    Flight_date NVARCHAR(50),
    Calendar_year NVARCHAR(50), 
    Month_number NVARCHAR(50),
    Date_number NVARCHAR(50),
    Day_of_week NVARCHAR(50),
    Day_name NVARCHAR(50), 
    Is_weekend NVARCHAR(50),
    Quarter_name NVARCHAR(50),
    Dwh_create_date DATETIME2 DEFAULT GETDATE()
)
GO

IF OBJECT_ID('silver.dim_route', 'U') IS NOT NULL
    DROP TABLE silver.dim_route 
GO
CREATE TABLE silver.dim_route (
    Route_id NVARCHAR(50), 
    Origin NVARCHAR(50), 
    Destination NVARCHAR(50),
    Dwh_create_date DATETIME2 DEFAULT GETDATE()
  )
GO

IF OBJECT_ID('silver.dim_weather', 'U') IS NOT NULL 
    DROP TABLE silver.dim_weather
GO
CREATE TABLE silver.dim_weather (
    Airport_code NVARCHAR(50), 
    Airport_name NVARCHAR(255), 
    Flight_date NVARCHAR(50), 
    Wind FLOAT,
    Precipitation FLOAT,
    Snow FLOAT,
    Avg_temp FLOAT,
    Dwh_create_date DATETIME2 DEFAULT GETDATE()
)
GO

IF OBJECT_ID('silver.fact_flights', 'U') IS NOT NULL
    DROP TABLE silver.fact_flights
GO
CREATE TABLE silver.fact_flights (
  Flight_date NVARCHAR(50),
  Reporting_airline NVARCHAR(50),
  Origin NVARCHAR(50), 
  Destination NVARCHAR(50), 
  Route_id NVARCHAR(50), 
  Dep_delay FLOAT,
  Taxi_out FLOAT,
  Taxi_in FLOAT,
  Arr_delay FLOAT,
  Cancelled INT,
  Diverted INT,
  Distance FLOAT,
  Dwh_create_date DATETIME2 DEFAULT GETDATE()
)
GO
