-- Create database
CREATE DATABASE IF NOT EXISTS ecomm_sales_project;
USE ecomm_sales_project;

-- Drop if exists
DROP TABLE IF EXISTS stage_combined;

-- Create staging table (all VARCHAR to avoid import errors)
CREATE TABLE stage_combined (
    Invoice VARCHAR(50),
    StockCode VARCHAR(50),
    Description TEXT,
    Quantity_Text VARCHAR(50),
    InvoiceDate_Text VARCHAR(50),
    Price_Text VARCHAR(50),
    CustomerID_Text VARCHAR(50),
    Country VARCHAR(100)
);