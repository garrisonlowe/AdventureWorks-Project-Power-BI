-- Active: 1723943270470@@127.0.0.1@1868@AdventureWorksDW2019@dbo
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