-- Orders View
CREATE OR ALTER VIEW gold.orders_view AS
SELECT *
FROM OPENROWSET(
    BULK 'orders/',
    DATA_SOURCE = 'source_silver',
    FORMAT = 'PARQUET'
)
WITH (
    order_id VARCHAR(50),
    user_id VARCHAR(50),
    eval_set VARCHAR(20),
    order_number VARCHAR(50),
    order_dow VARCHAR(50),
    order_hour_of_day VARCHAR(50),
    days_since_prior_order VARCHAR(50)
) AS orders_data;
GO

-- Products View
CREATE OR ALTER VIEW gold.products_view AS
SELECT *
FROM OPENROWSET(
    BULK 'products/',
    DATA_SOURCE = 'source_silver',
    FORMAT = 'PARQUET'
)
WITH (
    product_id VARCHAR(50),
    product_name VARCHAR(255),
    aisle_id VARCHAR(50),
    department_id VARCHAR(50)
) AS products_data;
GO

-- Prior Orders View
CREATE OR ALTER VIEW gold.order_products_prior_view AS
SELECT *
FROM OPENROWSET(
    BULK 'order_products_prior/',
    DATA_SOURCE = 'source_silver',
    FORMAT = 'PARQUET'
)
WITH (
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    add_to_cart_order VARCHAR(50),
    reordered VARCHAR(50)
) AS prior_data;
GO

-- Train Orders View
CREATE OR ALTER VIEW gold.order_products_train_view AS
SELECT *
FROM OPENROWSET(
    BULK 'order_products_train/',
    DATA_SOURCE = 'source_silver',
    FORMAT = 'PARQUET'
)
WITH (
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    add_to_cart_order VARCHAR(50),
    reordered VARCHAR(50)
) AS train_data;
GO

-- Departments View
CREATE OR ALTER VIEW gold.departments_view AS
SELECT *
FROM OPENROWSET(
    BULK 'departments/',
    DATA_SOURCE = 'source_silver',
    FORMAT = 'PARQUET'
)
WITH (
    department_id VARCHAR(50),
    department_name VARCHAR(255)
) AS dept_data;
GO

-- Aisles View
CREATE OR ALTER VIEW gold.aisles_view AS
SELECT *
FROM OPENROWSET(
    BULK 'aisles/',
    DATA_SOURCE = 'source_silver',
    FORMAT = 'PARQUET'
)
WITH (
    aisle_id VARCHAR(50),
    aisle_name VARCHAR(255)
) AS aisle_data;
GO
