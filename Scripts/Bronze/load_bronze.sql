/*
====================================================
Insert Data from source files into Bronze layer
====================================================
Script Purpose: 
   This script performs a bulk insert of the source csv files into 
   each table created in the Bronze layer. 
=========================================================================
*/

--Performing bulk insert of csv files into each table
Bulk INSERT bronze.dim_airline
From '/data/dim_airline.csv'
With (
   FIRSTROW = 2,
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n',
   TABLOCK
)
GO

Bulk INSERT bronze.dim_airport
From '/data/dim_airport.csv'
With (
   FIRSTROW = 2,
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '0x0a', --added due to an error related to the updated nvarchar length for Airport_name
   TABLOCK
)
GO

Bulk INSERT bronze.dim_date
From '/data/dim_date.csv'
With (
   FIRSTROW = 2,
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n',
   TABLOCK
)
GO

Bulk INSERT bronze.dim_route
From '/data/dim_route.csv'
With (
   FIRSTROW = 2,
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n',
   TABLOCK
)
GO

Bulk INSERT bronze.dim_weather
From '/data/dim_weather.csv'
With (
   FIRSTROW = 2,
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n',
   TABLOCK
)
GO

Bulk INSERT bronze.fact_flights
From '/data/fact_flights.csv'
With (
   FIRSTROW = 2,
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n',
   TABLOCK
)
GO
