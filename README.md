# Analytics Engineer Certification Project

## Database Used
The database used in this project was [AdventureWorks](https://learn.microsoft.com/pt-br/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms).

## Project Objectives
- **Data Processing**: Transform the data to meet the required format for analysis within the company.
- **KPIs Visualization**: Design dashboards that reflect the status of the key KPIs to be monitored by the management team, enabling data-driven decision-making.

## Tools Used in the Project
AdventureWorks uses PostgreSQL as its transactional database, which contains 68 tables and 5 schemas, storing data from the following systems:
- SAP (ERP)
- Salesforce (CRM)
- Google Analytics (Web Analytics)
- WordPress (Site)

The method used for data processing was **ELT** (Extract, Load, Transform), where data is extracted, loaded into a database, and then transformed. The tools used were:

- **dbt**: Used for processing the data loaded into the database. **Snowflake** was chosen as the storage platform, and the database was structured using the **star schema** topology.
- **Power BI**: The tool chosen for data visualization. The semantic model was created in Power BI based on the **star schema** after processing the data in dbt. It is important to note that, due to the size of the processed database not exceeding Power BI’s storage capacity, the **Import** method was used in place of **DirectQuery**.

## Project Pipeline
Aligned with the implementation model of the **Modern Data Stack (MDS)**, the project aims to build a more flexible cloud architecture capable of handling the large volume of data that companies receive today.

Below is an image illustrating the project pipeline as a whole. To represent the entire flow, **Fivetran** was chosen as the software responsible for extracting data from the OLTP.

![image](https://github.com/user-attachments/assets/6aa417d8-8009-4ecc-8f35-2a84ced00026)

## Project Results
- [**Conceptual Model**](https://github.com/user-attachments/files/18137872/conceptual_model_adventure_works.pdf): A conceptual model was created based on the OLTP, serving as a guide for the project and a translation of the data processing steps.
- [**Semantic Model**](https://github.com/user-attachments/files/18137871/semantic_model_adventure_works.pdf): To illustrate the outcome structured by the conceptual model, a PDF of the semantic model was provided. It shows the relationships between tables in Power BI after the data was processed in dbt.
- [**Dashboard**](https://drive.google.com/file/d/1GT24C4IE9hPZpaM2MdnL8Xc_x_0ydxIn/view?usp=sharing): The main deliverable of the project, a data product that the company will use to monitor key KPIs, supporting data-driven decision-making.
- **Explanatory Video**: An explanatory video was provided to present how the project was developed, the tests conducted during processing, and how to use the BI tool.
