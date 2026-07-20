/*===========================================================
Project: Cancer Patient Outcomes Analysis (2022–2025)
Organization: World Health Organization (WHO)
Analyst: Isatu Bah

Project Objective:
Analyze cancer patient data to understand demographic
patterns, cancer prevalence, treatment utilization,
disease severity, and patient outcomes to support
evidence-based healthcare decision-making.

===========================================================*/
/*===========================================================
SECTION 1: Connect to the Project Database

Business Question:
Which database will be used for this analysis?

Purpose:
Sets the active database so all subsequent queries are
executed against the correct dataset.
===========================================================*/
USE cancerpatientanalysis;
GO
/*===========================================================
SECTION 2: Identify Available Tables

Business Question:
What tables are available in the database?

Purpose:
Confirms the project table exists before beginning
the analysis.
===========================================================*/
SELECT name
FROM sys.tables;
/*===========================================================
SECTION 3: Dataset Overview

Business Question:
How many patient records are available?

Purpose:
Determines the size of the dataset before analysis.
===========================================================*/
SELECT COUNT(*) AS TotalPatients
FROM [india_cancer_patients_2022_2025];
/*===========================================================
SECTION 4: Review Data Structure

Business Question:
What variables are available for analysis?

Purpose:
Displays column names and data types to understand
the structure of the dataset.
===========================================================*/
SELECT COLUMN_NAME,
       DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='india_cancer_patients_2022_2025';
/*===========================================================
SECTION 5: Preview Dataset

Business Question:
What does the raw data look like?

Purpose:
Displays the first 10 records to familiarize the analyst
with the dataset.
===========================================================*/

SELECT TOP 10 *
FROM [india_cancer_patients_2022_2025];

SELECT COUNT(*) AS MissingAge
FROM india_cancer_patients_2022_2025
WHERE Age IS NULL;

SELECT COUNT(*) AS MissingCancer_type
FROM india_cancer_patients_2022_2025
WHERE Cancer_Type IS NULL;

SELECT COUNT(*) AS Missingh0spital_Name
FROM india_cancer_patients_2022_2025
WHERE Hospital_Name IS NULL;

SELECT COUNT(*) AS MissingCity
FROM india_cancer_patients_2022_2025
WHERE City IS NULL;

SELECT COUNT(*) AS Missinggender
FROM india_cancer_patients_2022_2025
WHERE Gender IS NULL;

SELECT COUNT(*) AS Missingstate
FROM india_cancer_patients_2022_2025
WHERE State IS NULL;

SELECT COUNT(*) AS Missingstage
FROM india_cancer_patients_2022_2025
WHERE Stage IS NULL;

SELECT COUNT(*) AS MissingTreatment_type
FROM india_cancer_patients_2022_2025
WHERE Treatment_Type IS NULL;

SELECT COUNT(*) AS Missingsurvival_month
FROM india_cancer_patients_2022_2025
WHERE Survival_Months IS NULL;

SELECT COUNT(*) AS MissingDiagnosis_Date
FROM india_cancer_patients_2022_2025
WHERE Diagnosis_Date IS NULL;

SELECT COUNT(*) AS Missingstatus
FROM india_cancer_patients_2022_2025
WHERE Status IS NULL;

SELECT Patient_ID,
COUNT(*) AS DuplicateCount
FROM [india_cancer_patients_2022_2025]
GROUP BY Patient_ID
HAVING COUNT(*) > 1;

SELECT
    MIN(Age) AS YoungestPatient,
    MAX(Age) AS OldestPatient,
    AVG(CAST(Age AS FLOAT)) AS AverageAge
FROM india_cancer_patients_2022_2025;

SELECT MIN(Survival_Months) AS Min_Months,
       MAX(Survival_Months) AS Max_Months,
       AVG(Survival_Months) AS Avg_Months
FROM india_cancer_patients_2022_2025;

SELECT DISTINCT Gender
FROM india_cancer_patients_2022_2025;

SELECT DISTINCT State
FROM india_cancer_patients_2022_2025
ORDER BY State;

SELECT DISTINCT Treatment_Type
FROM india_cancer_patients_2022_2025;

SELECT DISTINCT Status
FROM india_cancer_patients_2022_2025
ORDER BY Status;

SELECT DISTINCT Stage
FROM india_cancer_patients_2022_2025
ORDER BY Stage;

SELECT
    Gender,
    COUNT(*) AS TotalPatients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM india_cancer_patients_2022_2025
GROUP BY Gender
ORDER BY TotalPatients DESC;

    SELECT
    Cancer_Type,
    COUNT(*) AS TotalPatients
FROM india_cancer_patients_2022_2025
GROUP BY Cancer_Type;

SELECT
    Cancer_Type,
    COUNT(*) AS TotalPatients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM india_cancer_patients_2022_2025
GROUP BY Cancer_Type
ORDER BY TotalPatients DESC;

SELECT
    Gender,
    Cancer_Type,
    COUNT(*) AS TotalPatients
FROM india_cancer_patients_2022_2025
GROUP BY
    Gender,
    Cancer_Type
ORDER BY
    Gender,
    TotalPatients DESC;

    SELECT
    State,
    COUNT(*) AS TotalPatients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM india_cancer_patients_2022_2025
GROUP BY State
ORDER BY TotalPatients DESC;

SELECT
    Stage,
    COUNT(*) AS TotalPatients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM india_cancer_patients_2022_2025
GROUP BY Stage
ORDER BY Stage;

SELECT
    Treatment_Type,
    COUNT(*) AS TotalPatients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM india_cancer_patients_2022_2025
GROUP BY Treatment_Type
ORDER BY TotalPatients DESC;

SELECT
    Cancer_Type,
    COUNT(*) AS TotalPatients,
    ROUND(AVG(Survival_Months), 2) AS AvgSurvivalMonths
FROM india_cancer_patients_2022_2025
GROUP BY Cancer_Type
ORDER BY AvgSurvivalMonths DESC;

SELECT
    Stage,
    COUNT(*) AS TotalPatients,
    ROUND(AVG(Survival_Months), 2) AS AvgSurvivalMonths
FROM india_cancer_patients_2022_2025
GROUP BY Stage
ORDER BY AvgSurvivalMonths DESC;

SELECT
    Treatment_Type,
    COUNT(*) AS TotalPatients,
    ROUND(AVG(Survival_Months), 2) AS AvgSurvivalMonths
FROM india_cancer_patients_2022_2025
GROUP BY Treatment_Type
ORDER BY AvgSurvivalMonths DESC;

SELECT
    Status,
    COUNT(*) AS TotalPatients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM india_cancer_patients_2022_2025
GROUP BY Status
ORDER BY TotalPatients DESC;