/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_airline
-- =============================================================================
IF OBJECT_ID('gold.dim_airline', 'V') IS NOT NULL
    DROP VIEW gold.dim_airline;
GO

CREATE VIEW gold.dim_airline AS
SELECT
    Reporting_airline,
    Airline_name
FROM silver.dim_airline;
GO

IF OBJECT_ID('gold.dim_airport', 'V') IS NOT NULL
    DROP VIEW gold.dim_airport;
GO


-- =============================================================================
-- Create Dimension: gold.dim_airport
-- =============================================================================
CREATE VIEW gold.dim_airport AS
SELECT
    Airport_code,
    Airport_name,
    City,
    State,
    Latitude,
    Longitude
FROM silver.dim_airport;
GO



  -- =============================================================================
-- Create Dimension: gold.dim_date
-- =============================================================================
IF OBJECT_ID('gold.dim_date', 'V') IS NOT NULL
    DROP VIEW gold.dim_date;
GO

CREATE VIEW gold.dim_date AS
SELECT
    Flight_date,
    Calendar_year,
    Month_number,
    Date_number,
    Day_of_week,
    Day_name,
    Is_weekend,
    Quarter_name
FROM silver.dim_date;
GO


-- =============================================================================
-- Create Dimension: gold.dim_route
-- =============================================================================
IF OBJECT_ID('gold.dim_route', 'V') IS NOT NULL
    DROP VIEW gold.dim_route;
GO

CREATE VIEW gold.dim_route AS
SELECT
    Route_id,
    Origin,
    Destination
FROM silver.dim_route;
GO


-- =============================================================================
-- Create Dimension: gold.dim_weather
-- =============================================================================
IF OBJECT_ID('gold.dim_weather', 'V') IS NOT NULL
    DROP VIEW gold.dim_weather;
GO

CREATE VIEW gold.dim_weather AS
SELECT
    Airport_code,
    Airport_name,
    Flight_date,
    Wind,
    Precipitation,
    Snow,
    Avg_temp
FROM silver.dim_weather;
GO



  -- =============================================================================
-- Create Dimension: gold.fact_flights
-- =============================================================================
IF OBJECT_ID('gold.fact_flights', 'V') IS NOT NULL
    DROP VIEW gold.fact_flights;
GO

CREATE VIEW gold.fact_flights AS
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
FROM silver.fact_flights;
GO

