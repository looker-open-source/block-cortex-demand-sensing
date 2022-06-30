view: correlation_table_pdt {
    derived_table: {
      sql: (WITH Sales AS (
            SELECT DISTINCT SalesOrders.MaterialNumber_MATNR AS Product,
              SalesOrders.RequestedDeliveryDate_VDATU AS date,
              SalesOrders.CumulativeOrderQuantity_KWMENG AS SalesOrderQuantity,
              Customers.City_ORT01 AS Location,
              Customers.PostalCode_PSTLZ AS PostalCode,
              FIRST_VALUE(SalesOrders.RequestedDeliveryDate_VDATU) OVER (ORDER BY SalesOrders.RequestedDeliveryDate_VDATU DESC) AS MaxDate
            FROM
              `@{GCP_PROJECT}.@{REPORTING_DATASET}.SalesOrders` AS SalesOrders
            LEFT JOIN
              `@{GCP_PROJECT}.@{REPORTING_DATASET}.CustomersMD` AS Customers
              ON
                SalesOrders.Client_MANDT = Customers.Client_MANDT
                AND SalesOrders.ShipToPartyItem_KUNNR = Customers.CustomerNumber_KUNNR
            WHERE
              SalesOrders.Client_MANDT = "@{CLIENT}"
          )

        SELECT DISTINCT Sales.Product,
        Sales.Location,
        CORR(Sales.SalesOrderQuantity,
        (Weather.MaxTemp + Weather.MinTemp) / 2) OVER(PARTITION BY Sales.product, Sales.Location) AS CorrValue
        FROM
        Sales
        LEFT JOIN
        `@{GCP_PROJECT}.@{REPORTING_DATASET}.Weather` AS Weather
        ON
        Sales.PostalCode = Weather.PostCode
        AND Sales.date = Weather.WeekStartDate
        WHERE
        EXTRACT(YEAR FROM
        Sales.date) >= (SELECT DISTINCT EXTRACT(YEAR FROM MaxDate) - 3 FROM Sales))
        ;;
      interval_trigger: "730 hour"
    }
}
