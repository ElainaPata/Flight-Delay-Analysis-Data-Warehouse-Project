# Flight Delay Analysis Data Warehouse Project
Welcome to the Flight Delay Analysis Data Warehouse Project repository! This project demonstrates the design and implementation of a modern data warehouse using aviation and weather data to analyze flight delays and support real-world operational insights. It highlights best practices in data engineering, dimensional modeling, and SQL-based analytics.

## 📖 Project Overview 
This project involves: 
1. **Data Architecture**:
Designing a modern data warehouse using a medallion architecture (Bronze, Silver, Gold) to structure raw, cleaned, and business-ready aviation data.
2. **Data Integration**:
Combining multiple real-world data sources, including flight performance, weather conditions, airport metadata, and airline reference data into a unified analytical model.
3. **ETL Pipelines**:
Extracting and loading structured csv datasets into a SQL Server environment with transformations performed to standardize and prepare data for analysis.
4. **Data Modeling**:
Developing a dimensional model consisting of a central fact table (flight performance) and supporting dimension tables (airline, airport, route, date, and weather).
5. **Analytics & Reporting**:
Enabling SQL-based analysis to uncover insights into flight delays, airline performance, route reliability, and the impact of weather on operations.

## 🧠 Data Model
The data warehouse follows a dimensional modeling approach:

- **Fact Table:**
  - `fact_flights` – one row per flight, containing delay and performance metrics  

- **Dimension Tables:**
  - `dim_airline`
  - `dim_airport`
  - `dim_route`
  - `dim_date`
  - `dim_weather`

### 🔗 Relationships

- fact_flights.Date = dim_date.Date  
- fact_flights.Reporting_airline = dim_airline.Reporting_Airline  
- fact_flights.Route_id = dim_route.Route_ID  
- fact_flights.Origin = dim_airport.Airport_Code  
- fact_flights.Destination = dim_airport.Airport_Code  
- fact_flights.Date = dim_weather.Date  
- fact_flights.Origin = dim_weather.Airport_code  

## 🚀 Project Requirements 

### Building the Data Warehouse (Data Engineering) 

#### Obejective 
Design and implement a structured data warehouse to integrate aviation and weather data, enabling scalable analytics and insight into flight delay patterns.

#### Specifications 
**Data Sources**: This project integrates multiple data sources to create a unified analytical dataset supporting flight performance and delay analysis.
Flight Data:
- Sourced from the Bureau of Transportation Statistics (BTS) Airline On-Time Performance dataset, providing detailed flight-level performance metrics.
Weather Data:
- Extracted from a Kaggle dataset containing integrated aviation and environmental attributes, and structured to align with flight data for multi-source analysis.
Airport Data:
- Sourced from Kaggle and used to enrich flight records with geographic attributes (city, state, and coordinates) using IATA airport codes.
Airline Data:
- Constructed by extracting unique carrier codes from the flight dataset and enriching them with descriptive airline names through manual mapping.
Route Data:
- Engineered by combining origin and destination airport codes to create a unique route identifier, enabling route-level aggregation and analysis.
Date Data:
- Manually generated to support time-based analysis, including derived attributes such as day of week, month, and weekend indicators.

**Data Quality**: Ensure consistency and usability of data by standardizing column formats, aligning datasets across a common timeframe, and preparing data for transformation within the SQL pipeline.

**Data Integration**: Combine multiple datasets into a unified analytical model using consistent keys such as airport codes, dates, and route identifiers to enable accurate joins across all sources.

**Data Modeling**: Design a dimensional data model consisting of a central fact table representing flight-level performance and supporting dimension tables for airline, airport, route, date, and weather data.

**Architecture**: Implement a medallion architecture to structure the data pipeline
- Bronze → Raw data ingestion  
- Silver → Cleaned and standardized data  
- Gold → Business-ready fact and dimension tables  

**Scope**: Limit the dataset to January 2019 to ensure consistency across all sources and avoid anomalies introduced by external disruptions such as COVID-19.

### 📊 Analytics & Reporting
#### Obejective 
Develop SQL-based analysis to generate insights into flight performance and operational efficiency for January 2019.
Key Focus Areas:
- Airline performance and delay patterns
- Route-level reliability
- Airport-level delay trends
- Impact of weather conditions on flight delays

These insights enable stakeholders to evaluate airline performance, identify high-risk routes, and understand how weather conditions impact flight delays, supporting more informed operational decision-making.

## 🛠️ Tech Stack
- SQL Server (Azure Data Studio)
- Docker (containerized SQL environment)
- Excel (data preparation)
- CSV data sources (BTS, Kaggle)

