-- Active: 1723943270470@@127.0.0.1@1868@AdventureWorksDW2019@dbo
SELECT
    c.customerkey AS CustomerKey,
    c."FirstName" AS "FirstName",
    c."LastName" AS "LastName",
    c."FirstName" + ' ' + c."LastName" AS FullName,
    CASE c."Gender"
        WHEN 'M' THEN 'Male'
        WHEN 'F' THEN 'Female'
    END AS Gender,
    c."DateFirstPurchase" AS DateFirstPurchase,
    g."City" AS CustomerCity
FROM
    "DimCustomer" AS c
    LEFT JOIN "DimGeography" AS g ON g."GeographyKey" = c."GeographyKey"
ORDER BY
    "CustomerKey" ASC
;

