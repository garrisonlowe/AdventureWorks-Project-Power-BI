-- Active: 1723943270470@@127.0.0.1@1868@AdventureWorksDW2019@dbo
SELECT
    "ProductKey",
    "OrderDateKey",
    "DueDateKey",
    "ShipDateKey",
    "CustomerKey",
    "SalesOrderNumber",
    "SalesAmount"
FROM
    "FactInternetSales"
WHERE
    LEFT ("OrderDateKey", 4) >= YEAR (GETDATE()) - 6
ORDER BY
    "OrderDateKey" ASC
;