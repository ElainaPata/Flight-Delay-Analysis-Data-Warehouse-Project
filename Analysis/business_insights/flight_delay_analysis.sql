/*
===========================================================
Flight Delay Analysis – Business Insights
===========================================================
Purpose:
    This script answers key business questions using the
    Gold layer of the data warehouse.
===========================================================
*/

/*
===========================================================
Flight Delay Analysis – Business Insights
===========================================================
Purpose:
    Answer key business questions using the Gold layer.
===========================================================
*/


-- =========================================================
-- 1. Which airlines have the highest average arrival delay?
-- =========================================================
SELECT
    a.Airline_name,
    COUNT(*) AS total_flights,
    AVG(f.Arr_delay) AS avg_arrival_delay
FROM gold.fact_flights f
LEFT JOIN gold.dim_airline a
    ON f.Reporting_airline = a.Reporting_airline
GROUP BY a.Airline_name
ORDER BY avg_arrival_delay DESC


-- =========================================================
-- 2. Which routes experience the highest average arrival delays?
-- =========================================================
SELECT
    f.Route_id,
    f.Origin,
    f.Destination,
    COUNT(*) AS total_flights,
    AVG(f.Arr_delay) AS avg_arrival_delay
FROM gold.fact_flights f
GROUP BY f.Route_id, f.Origin, f.Destination
ORDER BY avg_arrival_delay DESC;


-- =========================================================
-- 3. Which origin airports have the highest average departure delays?
-- =========================================================
SELECT
    a.Airport_name,
    a.City,
    a.State,
    COUNT(*) AS total_flights,
    AVG(f.Dep_delay) AS avg_departure_delay
FROM gold.fact_flights f
LEFT JOIN gold.dim_airport a
    ON f.Origin = a.Airport_code
GROUP BY a.Airport_name, a.City, a.State
ORDER BY avg_departure_delay DESC;


-- =========================================================
-- 4. How do weather conditions impact average arrival delay?
-- =========================================================
SELECT
    CASE 
        WHEN w.Precipitation > 0 THEN 'Precipitation'
        ELSE 'No Precipitation'
    END AS weather_condition,
    COUNT(*) AS total_flights,
    AVG(f.Arr_delay) AS avg_arrival_delay
FROM gold.fact_flights f
LEFT JOIN gold.dim_weather w
    ON f.Flight_date = w.Flight_date
   AND f.Origin = w.Airport_code
GROUP BY 
    CASE 
        WHEN w.Precipitation > 0 THEN 'Precipitation'
        ELSE 'No Precipitation'
    END
ORDER BY avg_arrival_delay DESC;


-- =========================================================
-- 5. Which airlines have the highest cancellation rate?
-- =========================================================
SELECT
    a.Airline_name,
    COUNT(*) AS total_flights,
    SUM(f.Cancelled) AS cancelled_flights,
    AVG(CAST(f.Cancelled AS FLOAT)) * 100 AS cancellation_rate_percent
FROM gold.fact_flights f
LEFT JOIN gold.dim_airline a
    ON f.Reporting_airline = a.Reporting_airline
GROUP BY a.Airline_name
ORDER BY cancellation_rate_percent DESC;


-- =========================================================
-- 6. Are weekends associated with higher average arrival delays?
-- =========================================================
SELECT
    d.Is_weekend,
    COUNT(*) AS total_flights,
    AVG(f.Arr_delay) AS avg_arrival_delay
FROM gold.fact_flights f
LEFT JOIN gold.dim_date d
    ON f.Flight_date = d.Flight_date
GROUP BY d.Is_weekend
ORDER BY avg_arrival_delay DESC;
