-- STEP 1: Create Master Key (only once per DB)
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'sujiInstacart@2025';
GO

-- STEP 2: Create Credential using Managed Identity
CREATE DATABASE SCOPED CREDENTIAL cred_instacart
WITH IDENTITY = 'Managed Identity';
GO

-- STEP 3: Create External Data Source pointing to GOLD container
CREATE EXTERNAL DATA SOURCE source_gold
WITH (
    LOCATION = 'https://instacartdatalake1.dfs.core.windows.net/gold',
    CREDENTIAL = cred_instacart
);
GO

-- STEP 4: Create External File Format
CREATE EXTERNAL FILE FORMAT format_parquet
WITH (
    FORMAT_TYPE = PARQUET
);
GO

-- STEP 5: Create External Table (materialized from view)
-- Orders
CREATE EXTERNAL TABLE gold.orders_external
WITH (
    LOCATION = 'external/orders/',
    DATA_SOURCE = source_silver,
    FILE_FORMAT = format_parquet
)
AS SELECT * FROM gold.orders_view;
GO

-- Products
CREATE EXTERNAL TABLE gold.products_external
WITH (
    LOCATION = 'products_external',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.products_view;
GO

-- Prior Order Products
CREATE EXTERNAL TABLE gold.order_products_prior_external
WITH (
    LOCATION = 'order_products_prior_external',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.order_products_prior_view;
GO

-- Train Order Products
CREATE EXTERNAL TABLE gold.order_products_train_external
WITH (
    LOCATION = 'order_products_train_external',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.order_products_train_view;
GO

-- Departments
CREATE EXTERNAL TABLE gold.departments_external
WITH (
    LOCATION = 'departments_external',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.departments_view;
GO

-- Aisles
CREATE EXTERNAL TABLE gold.aisles_external
WITH (
    LOCATION = 'aisles_external',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.aisles_view;
GO