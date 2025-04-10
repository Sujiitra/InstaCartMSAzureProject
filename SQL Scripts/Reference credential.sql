--Reference credential in external data source
CREATE EXTERNAL DATA SOURCE source_silver
WITH (
    LOCATION = 'https://instacartdatalake1.dfs.core.windows.net/silver',
    CREDENTIAL = cred_instacart
);
