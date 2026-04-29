# Flight Delay Analysis Data Warehouse Project

Welcome to the Flight Delay Analysis Data Warehouse Project repository! This project demonstrates the design and implementation of a modern data warehouse using aviation and weather data to analyze flight delays and support real-world operational insights. It highlights best practices in data engineering, dimensional modeling, and SQL-based analytics.

---

## 📖 Project Overview

This project involves:

1. **Data Architecture**:
   Designing a modern data warehouse using a medallion architecture (Bronze, Silver, Gold) to structure raw, cleaned, and business-ready aviation data.

2. **Data Integration**:
   Combining multiple real-world data sources, including flight performance, weather conditions, airport metadata, and airline reference data into a unified analytical model.

3. **ETL Pipelines**:
   Extracting and loading structured CSV datasets into a SQL Server environment with transformations performed to standardize and prepare data for analysis.

4. **Data Modeling**:
   Developing a dimensional model consisting of a central fact table (flight performance) and supporting dimension tables (airline, airport, route, date, and weather).

5. **Analytics & Reporting**:
   Enabling SQL-based analysis to uncover insights into flight delays, airline performance, route reliability, and the impact of weather on operations.

---

## 🧠 Data Model

The data warehouse follows a dimensional modeling approach:

### **Fact Table**

* `fact_flights` – one row per flight, containing delay and performance metrics

### **Dimension Tables**

* `dim_airline`
* `dim_airport`
* `dim_route`
* `dim_date`
* `dim_weather`

### 🔗 Relationships

* fact_flights.Date = dim_date.Date
* fact_flights.Reporting_airline = dim_airline.Reporting_Airline
* fact_flights.Route_id = dim_route.Route_ID
* fact_flights.Origin = dim_airport.Airport_Code
* fact_flights.Destination = dim_airport.Airport_Code
* fact_flights.Date = dim_weather.Date
* fact_flights.Origin = dim_weather.Airport_code

---

## 🚀 Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objective

Design and implement a structured data warehouse to integrate aviation and weather data, enabling scalable analytics and insight into flight delay patterns.

#### Specifications

**Data Sources**
This project integrates multiple data sources to create a unified analytical dataset supporting flight performance and delay analysis.

* **Flight Data:**: Bureau of Transportation Statistics (BTS) Airline On-Time Performance dataset
* **Weather Data:**: Kaggle dataset with aviation and environmental attributes
* **Airport Data:**: Kaggle dataset enriched with geographic attributes
* **Airline Data:**: Derived and manually mapped from flight dataset
* **Route Data:**: Engineered from origin and destination airport codes
* **Date Data:**: Manually generated with time-based attributes

**Data Quality**:
Standardized formats, aligned datasets across a consistent timeframe, and ensured usability for transformation and analysis.

**Data Integration**:
Combined datasets using shared keys such as airport codes, dates, and route identifiers.

**Data Modeling**:
Designed a star schema with a central fact table and supporting dimension tables.

**Architecture**:

* Bronze → Raw ingestion
* Silver → Cleaned and standardized
* Gold → Business-ready analytical views

**Scope**:
Dataset limited to January 2019 to ensure consistency and avoid external anomalies.

---

## 📊 Analytics & Reporting

### Objective

Develop SQL-based analysis to generate insights into flight performance and operational efficiency for January 2019.

### Key Focus Areas:

* Airline performance and delay patterns
* Route-level reliability
* Airport-level delay trends
* Impact of weather conditions on flight delays

These insights support evaluating airline performance, identifying high-risk routes, and understanding operational drivers of delays.

---

# ✈️ Flight Delay Analysis Results

**Dataset Scope:** January 2019 (~600K+ flight records)

The following analysis was conducted using the Gold layer of the data warehouse. SQL queries were written to answer key business questions and uncover patterns in airline performance, route reliability, and operational factors.

## 🧠 Key Insights

* **Airline Performance:**
  JetBlue Airways and ExpressJet Airlines show the highest average arrival delays (13–14+ minutes), while Delta Air Lines and Southwest Airlines demonstrate strong on-time performance with near-zero or negative delays.

* **Route-Level Delays:**
  The most delayed routes are concentrated among lower-frequency regional routes (e.g., SYR → EWR, ASE → SFO), with average delays exceeding 60 minutes. These routes appear more vulnerable to operational disruptions.

* **Airport Operations:**
  Smaller regional airports, such as Jamestown Regional Airport and Ford Airport, exhibit significantly higher departure delays (50+ minutes), suggesting infrastructure or resource constraints.

* **Cancellation Trends:**
  Regional carriers like Envoy Air and ExpressJet Airlines have the highest cancellation rates (7%+), significantly higher than major airlines such as Delta and Hawaiian Airlines.

* **Weather Impact:**
  Flights without precipitation show slightly higher average delays than those with precipitation, suggesting that operational factors (traffic volume, scheduling) may outweigh weather impact in this dataset.

* **Scheduling Patterns:**
  Weekday flights experience higher delays than weekend flights, indicating that increased demand and traffic volume during weekdays contribute to operational congestion.

---

## 🔍 Detailed Analysis

👉 Full SQL queries and result screenshots:
**[`/Analysis`](./Analysis)**

---

## 🛠️ Tech Stack

* SQL Server (Azure Data Studio)
* Docker (containerized SQL environment)
* Excel (data preparation)
* CSV data sources (BTS, Kaggle, and custom engineered datasets through data enrichment)

---

## 🌟 About Me

Hi, I’m Elaina Pata. I recently graduated with a Master of Science in Data Analytics and have a strong interest in data engineering, data analytics, and building scalable data systems.

This project was created to demonstrate my ability to:

* Design and implement a data warehouse from scratch
* Integrate multiple real-world data sources
* Apply dimensional modeling techniques
* Build SQL-based data pipelines using a medallion architecture

My goal is to showcase my ability to transform raw data into structured datasets that support meaningful business insights and real-world analysis.
