/*
===============================================================================
Gold Layer Quality Checks
===============================================================================
Script Purpose:
    Validate the integrity, consistency, and usability of the Gold layer views.

Checks include:
    - Uniqueness of natural keys in dimension views
    - Referential integrity between fact and dimension views
    - Null checks on key fields
    - Validation of expected date range
===============================================================================
*/

-- 1. Check airline key uniqueness
--Expectation: No results
SELECT Reporting_airline, COUNT(*) AS record_count
FROM gold.dim_airline
GROUP BY Reporting_airline
HAVING COUNT(*) > 1

-- 2. Check airport key uniqueness
--Expectation: No results
SELECT Airport_code, COUNT(*) AS record_count
FROM gold.dim_airport
GROUP BY Airport_code
HAVING COUNT(*) > 1

-- 3. Check route key uniqueness
--Expectation: No results
SELECT Route_id, COUNT(*) AS record_count
FROM gold.dim_route
GROUP BY Route_id
HAVING COUNT(*) > 1

-- 4. Check date key uniqueness
--Expectation: No results
SELECT Flight_date, COUNT(*) AS record_count
FROM gold.dim_date
GROUP BY Flight_date
HAVING COUNT(*) > 1

-- 5. Check weather uniqueness by airport/date
--Expectation: No results
SELECT Airport_code, Flight_date, COUNT(*) AS record_count
FROM gold.dim_weather
GROUP BY Airport_code, Flight_date
HAVING COUNT(*) > 1

-- 6. Check fact table key fields for nulls
--Expectation: No results
SELECT *
FROM gold.fact_flights
WHERE Flight_date IS NULL
   OR Reporting_airline IS NULL
   OR Origin IS NULL
   OR Destination IS NULL
   OR Route_id IS NULL

-- 7. Check fact airlines exist in airline dimension
--Expectation: No results
SELECT DISTINCT f.Reporting_airline
FROM gold.fact_flights f
LEFT JOIN gold.dim_airline a
    ON f.Reporting_airline = a.Reporting_airline
WHERE a.Reporting_airline IS NULL

-- 8. Check fact origins exist in airport dimension
--Expectation: No results
SELECT DISTINCT f.Origin
FROM gold.fact_flights f
LEFT JOIN gold.dim_airport a
    ON f.Origin = a.Airport_code
WHERE a.Airport_code IS NULL

-- 9. Check fact destinations exist in airport dimension
--Expectation: No results
SELECT DISTINCT f.Destination
FROM gold.fact_flights f
LEFT JOIN gold.dim_airport a
    ON f.Destination = a.Airport_code
WHERE a.Airport_code IS NULL

-- 10. Check fact routes exist in route dimension
--Expectation: No results
SELECT DISTINCT f.Route_id
FROM gold.fact_flights f
LEFT JOIN gold.dim_route r
    ON f.Route_id = r.Route_id
WHERE r.Route_id IS NULL

-- 11. Check fact dates exist in date dimension
--Expectation: No results
SELECT DISTINCT f.Flight_date
FROM gold.fact_flights f
LEFT JOIN gold.dim_date d
    ON f.Flight_date = d.Flight_date
WHERE d.Flight_date IS NULL

-- 12. Check weather records join to airport dimension
--Expectation: No results
SELECT DISTINCT w.Airport_code
FROM gold.dim_weather w
LEFT JOIN gold.dim_airport a
    ON w.Airport_code = a.Airport_code
WHERE a.Airport_code IS NULL

-- 13. Check expected fact date range
--Expectation: Jan 2019-01-01 through Jan 2019-31-01
SELECT
    MIN(Flight_date) AS min_flight_date,
    MAX(Flight_date) AS max_flight_date
FROM gold.fact_flights
