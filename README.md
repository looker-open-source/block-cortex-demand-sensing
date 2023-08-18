<h1><span style="color:#2d7eea">Google Cloud Cortex Framework for SAP</span></h1>

<h2><span style="color:#2d7eea">Data Foundation Demand Sensing</span></h2>

What does this Looker Block do for me?
Provides several different dashboards showing variations of weekly demand plan with forecasts from weather, promotion and customer trends.

- **Demand Sensing Summary Dashboard** - This dashboard provides weekly sales quantity and weather forecasts outside the statistical range for a select time frame, location, product and customer in a tabular format.

- **Demand Sensing Temperature** - This dashboard provides weekly sales quantity and temperature details for a select time frame, ship-to location, product and customer.

- **Demand Sensing Trends** - This dashboard provides weekly sales quantity and customer trends details for a select time frame, ship-to location, product and customer.

- **Demand Sensing Forecast Outside Statistical Range** - This dashboard provides weekly sales quantity and weather forecasts outside the statistical range for a select time frame, ship-to location, product and customer.

- **Demand Sensing Promo Differential** - This dashboard provides weekly sales quantity and promo differential for a select time frame, ship-to location, product and customer. Promo Differential details include the retail prices of products per unit in Syndicated Point-of-Sale Data.

<h2><span style="color:#2d7eea">Required Data</span></h2>

The datasets required by this block can be obtained by following the installation and configuration instructions for both:
- [Google Cloud Cortex Framework](https://github.com/GoogleCloudPlatform/cortex-data-foundation)
- [Google Cloud Cortex Demand Sensing Solution](https://storage.googleapis.com/cortex-public-documents/Cortex%20Demand%20Sensing%20-%20User%20Guide.pdf) (available for download through Google Cloud Marketplace)

The related LookML Block also leverages many of the same datasets.
- [Google Cloud Cortex Framework for SAP](https://github.com/looker-open-source/block-cortex-sap/)

<h2><span style="color:#2d7eea">Installation Instructions</span></h2>

This LookML model can be manually installed following the steps below.

  <h4><span style="color:#2d7eea">Option A: Marketplace Install via Git</span></h4>
  
  Refer to the [Looker Docs for installing a tool from Marketplace](https://cloud.google.com/looker/docs/marketplace#installing_a_tool_from_a_git_url). Provide values for the required prompts as outlined in next section **Required Parameters**.

  <h4><span style="color:#2d7eea">Option B: Manual Install via Fork of this Repository</span></h4>
  
  - [Fork this GitHub repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo#forking-a-repository)
  - [Create a blank LookML project](https://cloud.google.com/looker/docs/create-projects#creating_a_blank_project) with any name (e.g., cortex_demand_sensing)
  - [Connect the new LookML project to the forked repository](https://cloud.google.com/looker/docs/setting-up-git-connection)
  - Update the values of constants in the `manifest.lkml` file as described in the next section **Required Parameters**
  - [Commit and deploy changes to production](https://cloud.google.com/looker/docs/version-control-and-deploying-changes#getting_your_changes_to_production)

<h2><span style="color:#2d7eea">Required Parameters</span></h2>
>   ❕ These required values are configured during the Marketplace Installation process, or if this Block was installed from a forked Git repository, you will update the values for these constants in the `manifest.lkml` file for the project.

- **Connection**: In the manifest.lkml file, update the value of the CONNECTION_NAME

- **GCP Project ID**: The GCP project where the SAP reporting dataset resides in BigQuery (i.e., GCP project ID). [Identifying Project ID](https://cloud.google.com/resource-manager/docs/creating-managing-projects#identifying_projects).

- **Reporting Dataset**: The deployed Cortex Data Foundation REPORTING dataset where the SAP views reside within the GCP BigQuery project.

- **K9 Reporting Dataset**: The deployed Cortex Data Foundation K9_REPORTING dataset where the HolidayCalendar, Trends, Weather and Weather views reside within the GCP BigQuery project. If using Cortex Data Framework 4.2 and earlier, REPORTING_DATASET and K9_REPORTING_DATASET constants can use the same dataset name.

- **Client**: Input the Client ID from the dataset.

- **Years_Past_Data**: Control the number of years of data displayed on the dashboard.

- **(Optional)** Unhide additional dimensions and measure: Most dimensions and measures have been hidden to simplify reporting and data understanding. However should you find anything valuable missing, simply update the hidden parameters to No in the relevant views.

<h2><span style="color:#2d7eea">Additional Resources</span></h2>

To learn more about LookML and how to develop visit:
- [Looker Best Practices](https://cloud.google.com/looker/docs/best-practices/home)
- [Looker/Google Cloud Training](https://www.cloudskillsboost.google/catalog)
