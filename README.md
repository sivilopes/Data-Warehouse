# Data Warehouse Implementation in a PetShop
This project involved the creation of a unified data repository, leveraging Oracle as our database platform, and employing ETL procedures and the Star Schema model. Beyond data consolidation, this project includes data analysis with the integration of Power BI.

## Summary

This report provides an overview of the successful implementation of a Data Warehouse in a PetShop, highlighting the key steps taken in the process. The Data Warehouse was established to enhance data management, analytics capabilities, and data analysis and reporting with Power BI for improved decision-making.

_** All information in this project is fictitious/simulated._

## Introduction

### Background

The PetShop operates in a competitive market and collects vast amounts of data on its products, customers, and operations. To gain a competitive edge and extract valuable insights, a Data Warehouse was proposed as the solution.

### Objectives

The main objectives of this Data Warehouse implementation are:

> 1. Centralize data from sources for a unified view.
> 2. Improve data quality and consistency.
> 3. Facilitate data analysis and reporting.
> 4. Support strategic decision-making.

## Data Collection and Preparation

### Dataset Creation

The first step in the process was creating a comprehensive dataset, which included information about products, sales, suppliers, and customer profiles. The dataset was carefully curated to ensure it contained relevant and accurate data.

### Database Creation in Oracle

To house this dataset, an Oracle database was chosen for its reliability and scalability. The database was designed to accommodate the growing volume of data while ensuring optimal performance.

![Picture1](https://github.com/sivilopes/Data-Warehouse/assets/122314693/a39542f9-809e-4364-b7fd-5d6ddb289672)

## ETL Process

### Extract

In the ETL (Extract, Transform, Load) process, the data was extracted from the system with sales data, customers, suppliers, and orders records. This data was retrieved and prepared for further processing.

### Transform

Data transformation involves cleansing, structuring, and enriching the data. Inconsistencies and errors were resolved, and data was formatted to ensure compatibility with the Data Warehouse's architecture.

### Load

The transformed data was then loaded into the Data Warehouse, making it available for analytical purposes. The ETL process was executed using a series of procedures to automate and streamline data flow.

***Image

### Star Schema

To optimize query performance and facilitate data analysis, a Star Schema was implemented in the Data Warehouse. The Star Schema structure is well-suited for reporting and analytical purposes. It consists of a central fact table and dimension tables, which provide context to the facts.

### Fact Table

The central fact table contains quantitative data, such as sales transactions and tax rate metrics. It serves as the core of the Star Schema and is linked to dimension tables through foreign keys.

### Dimension Tables

Dimension tables store descriptive information, such as product and service attributes, supplier and customer information, and time-related data. These tables are linked to the fact table, enabling multidimensional analysis.

*** image

## Data Analysis and Reporting with Power BI

The implementation of the Data Warehouse in the PetShop extends beyond data consolidation and management. One of the key objectives of this project was to empower the organization with data analysis and reporting capabilities. To achieve this, Power BI, a powerful business intelligence tool, was integrated with the Data Warehouse architecture.

### Data Visualization and Analysis

Power BI enables users to create interactive and visually appealing reports and dashboards. By connecting to the Data Warehouse, employees across various departments now have access to real-time data and can perform in-depth analysis with ease. This facilitates the identification of trends, opportunities, and areas for improvement.

** image

## Conclusion

The successful implementation of a Data Warehouse in the PetShop has provided the organization with a robust platform for data analysis and reporting. It has streamlined data management, enhanced decision-making capabilities, and positioned the PetShop for continued growth and success.
