[Try it out here!](https://app.powerbi.com/view?r=eyJrIjoiY2UxNDI1NTMtMGExZS00ZjY4LTk5Y2QtN2FiMDcxZDMzNzBhIiwidCI6ImJkMGNhZWQyLTBiNTctNDllNy1hMjY2LTYzMWZhNmE2YzIyYSJ9)

# Adventure Works Analysis Dashboard

In this project, we are given some requirements from Steve over at Adventure Works to create a dashboard for his sales team to use.

## Project Requirements

Let's take a look at the email.

> Steven  - Sales Manager:
>
> Hi!
> I hope you are doing well. We need to improve our internet sales reports and want to move from static reports to visual dashboards.
> Essentially, we want to focus it on how much we have sold of what products, to which clients and how it has been over time.
> Seeing as each sales person works on different products and customers it would be beneficial to be able to filter them also.
> We measure our numbers against budget so I added that in a spreadsheet so we can compare our values against performance. 
> The budget is for 2023 and we usually look 2 years back in time when we do analysis of sales.
> Let me know if you need anything else!
>
> // Steven

From this email, we can pick out that we need the following things:

- Internet Sales Report
- Interactive Visual Dashboards
- How much we have sold of what product
- To which clients we have sold to
- How sales have been over time
- Filter on customer demographics
- Measure against a budget
- Look at least 2 years into the past.

#### **Business Demand Overview:**
-	Reporter: Steven – Sales Manager
-	Value of Change: Visual dashboards and improved Sales reporting or follow up or sales force
-	Necessary Systems: Power BI, CRM System
-	Other Relevant Info: Budgets have been delivered in Excel for 2021
User Stories:

| No # | As a (role)          | I want (request / demand)                            | So that I (user value)                                                    | Acceptance Criteria                                                    |
|------|----------------------|------------------------------------------------------|---------------------------------------------------------------------------|------------------------------------------------------------------------|
| 1    | Sales Manager        | To get a dashboard overview of internet sales        | Can follow better which customers and products sells the best             | A Power BI dashboard which updates data once a day                     |
| 2    | Sales Representative | A detailed overview of Internet Sales per Customers  | Can follow up my customers that buys the most and who we can sell ore to  | A Power BI dashboard which allows me to filter data for each customer  |
| 3    | Sales Representative | A detailed overview of Internet Sales per Products   | Can follow up my Products that sells the most                             | A Power BI dashboard which allows me to filter data for each Product   |
| 4    | Sales Manager        | A dashboard overview of internet sales               | Follow sales over time against budget                                     | A Power Bi dashboard with graphs and KPIs comparing against budget.    |


## Data Collection

Using the raw database, we're going to run SQL queries to extract and transform the data that we need to meet the requirements.

**Query 1:** The Calendar Table

```sql
SELECT
       "DateKey",
       "FullDateAlternateKey" AS Date,
       "EnglishDayNameOfWeek" AS Day,
       "WeekNumberOfYear" AS WeekNr,
       "EnglishMonthName" AS Month,
       LEFT ("EnglishMonthName", 3) AS MonthShort,
       "MonthNumberOfYear" AS MonthNo,
       "CalendarQuarter" AS Quarter,
       "CalendarYear" AS Year
FROM
       "DimDate"
WHERE
       "CalendarYear" >= 2019
;
```

**Query 2:** The Customer Table

```sql
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
```

**Query 3:** The Product Table

```sql
SELECT
    p."ProductKey",
    p."ProductAlternateKey" AS ProductItemCode,
    p."EnglishProductName" AS ProductName,
    ps."EnglishProductSubcategoryName" AS SubCategory, -- Joined in from Sub Category Table
    pc."EnglishProductCategoryName" AS ProductCategory, -- Joined in from Category Table
    p."Color" AS ProductColor,
    p."Size" AS ProductSize,
    p."ProductLine" AS ProductLine,
    p."ModelName" AS ProductModelName,
    p."EnglishDescription" AS ProductDescription,
    ISNULL (p."Status", 'Outdated') AS ProductStatus
FROM
    "DimProduct" as p
    LEFT JOIN "DimProductSubcategory" AS ps ON ps."ProductSubcategoryKey" = p."ProductSubcategoryKey"
    LEFT JOIN "DimProductCategory" AS pc ON ps."ProductCategoryKey" = pc."ProductCategoryKey"
order by
    p."ProductKey" ASC
```

**Query 4:** The Sales Table 

```sql
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
```

Once we have our usable data, we can run the queries inside of PowerBI and create our data model.

## Data Visualization

First, let's create the data model.

![AdventureWorks Data Model](https://github.com/user-attachments/assets/96823bc6-3b20-4086-80a6-a6766c8cf8cf)

### Next, design the report.

### Sales Overview
![Image](https://github.com/user-attachments/assets/19bc1897-933a-4f1e-8cb8-3361ad474e80)

### Customer Details
![Image](https://github.com/user-attachments/assets/af5d57b4-ceac-46c6-9296-76e2962b1c3e)

### Product Details
![Image](https://github.com/user-attachments/assets/5c1ea009-8ba4-4de9-bb80-afe46869b85f)





