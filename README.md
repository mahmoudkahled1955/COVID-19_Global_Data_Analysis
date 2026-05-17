# 🦠 COVID-19 Global Data Analysis (MySQL)

![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
![Data Analysis](https://img.shields.io/badge/SQL-EDA_&_Data_Cleaning-blue?style=for-the-badge)

## 📋 Project Overview
This project focuses on executing a comprehensive Exploratory Data Analysis (EDA) and data cleaning process on a global COVID-19 dataset using **MySQL**. The objective is to standardize raw data, handle inconsistencies, and extract meaningful insights regarding confirmed cases, deaths, and recoveries across different countries and timeframes.

## ⚙️ SQL Skills & Techniques Demonstrated
This project heavily relies on writing efficient and complex SQL queries, showcasing the following skills:
* **Data Cleaning & Standardization:** Using `STR_TO_DATE` and `ALTER TABLE` to convert string fields into proper `DATE` formats.
* **Null Value Handling:** Identifying and managing missing data points across critical columns.
* **Advanced Aggregations:** Utilizing `SUM`, `AVG`, `MIN`, and `MAX` grouped by extracted months and years (`SUBSTR`, `YEAR`).
* **Common Table Expressions (CTEs):** Using the `WITH` clause to create temporary result sets for complex multi-step calculations.
* **Window Functions:** Implementing `RANK() OVER` to logically rank countries based on the severity of confirmed cases.

---

## 📊 Key Questions Answered
Through SQL queries, this project answers several critical questions about the pandemic's progression:
1. **Timeframe Analysis:** What is the exact date range and the total number of months covered in the dataset?
2. **Monthly Trends:** What are the monthly averages and totals for confirmed cases, deaths, and recoveries globally?
3. **Yearly Extremes:** What were the highest and lowest recorded cases per year (excluding zero values)?
4. **Country Rankings:** Which countries experienced the highest overall volume of confirmed cases, and how do they rank against each other?

---

## 💻 Code Structure Example
Here is a snippet from the project demonstrating the use of **CTEs and Window Functions** to rank countries by confirmed cases:

```sql
WITH Country_Totals AS (
    SELECT 
        `Country/Region` AS Country,
        SUM(Confirmed) AS Total_Confirmed
    FROM corona_data
    GROUP BY Country
)
SELECT 
    Country,
    Total_Confirmed,
    RANK() OVER (ORDER BY Total_Confirmed DESC) AS Country_Rank
FROM Country_Totals
ORDER BY Country_Rank;
