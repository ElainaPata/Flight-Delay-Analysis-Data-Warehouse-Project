/*
========================================
DDL Script: Create Bronze Tables
========================================
Script Purpose: 
  This script creates tables in the 'bronze' schema while dropping any existing tables with the same name. Run this script to redefine the structure of the 'bronze' tables. 
  */
--Creating bronze tables (using dim and fact csv files)
IF OBJECT_ID('bronze.dim_airline', 'U') IS NOT NULL
    DROP TABLE bronze.dim_airline
CREATE TABLE bronze.dim_airline (
    Reporting_airline NVARCHAR(50),
    Airline_name NVARCHAR(50)
)
GO

IF OBJECT_ID('bronze.dim_airport', 'U') IS NOT NULL
    DROP TABLE bronze.dim_airport
GO
CREATE TABLE bronze.dim_airport (
    Airport_code NVARCHAR(50),
    Airport_name NVARCHAR((255),
    City NVARCHAR(50),
    State NVARCHAR(50),
    Latitude NVARCHAR(50),
    Longitude NVARCHAR(50)
)
GO

IF OBJECT_ID('bronze.dim_date', 'U') IS NOT NULL
    DROP TABLE bronze.dim_date
GO
CREATE TABLE bronze.dim_date (
    Flight_date NVARCHAR(50),
    Calendar_year NVARCHAR(50), 
    Month_number NVARCHAR(50),
    Date_number NVARCHAR(50),
    Day_of_week NVARCHAR(50),
    Day_name NVARCHAR(50), 
    Is_weekend NVARCHAR(50),
    Quarter_name NVARCHAR(50)
)
GO

IF OBJECT_ID('bronze.dim_route', 'U') IS NOT NULL
    DROP TABLE bronze.dim_route 
GO
CREATE TABLE bronze.dim_route (
    Route_id NVARCHAR(50), 
    Origin NVARCHAR(50), 
    Destination NVARCHAR(50)
    )
GO

IF OBJECT_ID('bronze.dim_weather', 'U') IS NOT NULL 
    DROP TABLE bronze.dim_weather
GO
CREATE TABLE bronze.dim_weather (
    Airport_code NVARCHAR(50), 
    Airport_name NVARCHAR(50), 
    Flight_date NVARCHAR(50), 
    Wind NVARCHAR(50), 
    Precipitation NVARCHAR(50), 
    Snow NVARCHAR(50), 
    Avg_temp NVARCHAR(50)
)
GO

IF OBJECT_ID('bronze.fact_flights', 'U') IS NOT NULL
    DROP TABLE bronze.fact_flights
GO
CREATE TABLE bronze.fact_flights (
  Flight_date NVARCHAR(50),
  Reporting_airline NVARCHAR(50),
  Origin NVARCHAR(50), 
  Destination NVARCHAR(50), 
  Route_id NVARCHAR(50), 
  Dep_delay NVARCHAR(50), 
  Taxi_out NVARCHAR(50), 
  Taxi_in NVARCHAR(50),
  Arr_delay NVARCHAR(50), 
  Cancelled NVARCHAR(50), 
  Diverted NVARCHAR(50), 
  Distance NVARCHAR(50)
)
GO
