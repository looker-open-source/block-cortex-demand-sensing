<h1><span style="color:#2d7eea">Google Cloud Cortex Framework for SAP</span></h1>

<h2><span style="color:#2d7eea">Data Foundation Demand Sensing</span></h2>

What does this Looker Block do for me?
- **Demand Sensing Summary Dashboard** - This dashboard provides the Alerts details on the quantity of sales, for a particular period of time frame, Ship to location, product name and customer based on the weather forecast which is outside the statistical range. However the filters can be applied to slice the data and the user has complete privilege on what should be displayed on the dashboard for that particular location and data range. 
- **Demand Sensing Temperature** - This dashboard provides the Alerts details on the quantity of sales, for a particular period of time frame, Ship to location, product name and customer based on the weather forecast which is specific to temperature. However the filters can be applied to slice the data and the user has complete privilege on what should be displayed on the dashboard for that particular location, customer, product and the data range. 
- **Demand Sensing Trends** - This dashboard provides the Alerts details on the quantity of sales, for a particular period of time frame, Ship to location, product name and customer based on the Customer Trends. This trends dashboard shows us about the quantity of trends occurring in various insights of products. It specifically  gives the trends happening in that particular time.Based on different filters, all values in the tiles will be changed in the dashboard.
- **Demand Sensing Forecast Outside Statistical Range** - This dashboard provides the Alerts details on the quantity of sales, for a particular period of time frame, Ship to location, product name and customer based on the forecast which is outside the statistical range. However the filters can be applied to slice the data and the user has complete privilege on what should be displayed on the dashboard for that particular location and data range. 
- **Demand Sensing Promo Differential** - This dashboard provides the Alerts details on the quantity of sales, for a particular period of time frame, Ship to location, product name and customer Promo Differential shows us about the retail prices of products per unit in Syndicated Point-of-Sale Data.

<h2><span style="color:#2d7eea">Required Data</span></h2>

The datasets required by this block can be obtained by following the installation and configuration instructions for the application.
- [Google Cloud Cortex Framework](https://github.com/GoogleCloudPlatform/cortex-data-foundation)

The related LookML Block also leverages these same datasets.
- [Google Cloud Cortex Framework for SAP](https://github.com/looker-open-source/block-cortex-sap/) 


<h2><span style="color:#2d7eea">Required Customizations</span></h2>

- **Connection**: In the manifest.lkml file, update the value of the CONNECTION_NAME 

- **GCP Project**: The GCP project name where the SAP reporting dataset resides in BigQuery (not project id).

- **Reporting Dataset**: The deployed Cortex Data Foundation _REPORTING dataset where the SAP views reside within the GCP BigQuery project.

- **ClientId**: Input the Client ID from the dataset.

- **Years_Past_Data**: Control the number of years of data displayed on the dashboard.

- **(Optional)** Unhide additional dimensions and measure: Most dimensions and measures have been hidden to simplify reporting and data understanding. However should you find anything valuable missing, simply update the hidden parameters to No in the relevant views.

<h2><span style="color:#2d7eea">Additional Resources</span></h2>

To learn more about LookML and how to develop visit:
- [Looker User Guide](https://looker.com/guide)
- [Looker Help Center](https://help.looker.com)
- [Looker University](https://training.looker.com/)

