-- =====================================================================================================================================================================
-- EMPLOYEE ATTRITION INTELLIGENCE PROJECT
-- SQL ANALYSIS QUERIES
-- AUTHOR: ANVESH REDDY
-- =====================================================================================================================================================================
USE  employee_attrition;
SHOW databases;
SELECT*FROM Employees;
SELECT COUNT(*) FROM EMPLOYEES;
DESCRIBE EMPLOYEES;
-- =====================================================================================================================================================================
-- BASIC ANLYSIS
-- =====================================================================================================================================================================
-- TOTAL EMPLOYEES
SELECT COUNT(*) AS TOTALEMPLOYEES FROM EMPLOYEES;
-- EMPLOYEES LEFT
SELECT SUM(ATTRITION) AS EMPLOYEESLEFT FROM EMPLOYEES;
-- ATTRITION RATE
SELECT ROUND(AVG(ATTRITION)*100,2) AS ATTRITIONRATE FROM EMPLOYEES;
--  DEPARTMENT WISE ATTRITION 
SELECT DEPARTMENT,SUM(ATTRITION) AS EMPLOYEESLEFT FROM EMPLOYEES
GROUP BY DEPARTMENT 
ORDER BY EMPLOYEESLEFT DESC;
-- JOB ROLE WISE ATTRITION
SELECT JOBROLE, SUM(ATTRITION) AS EMPLOYEESLEFT
FROM EMPLOYEES
GROUP BY JOBROLE
ORDER BY EMPLOYEESLEFT DESC;
-- AVERAGE SALARY BY DEPARTMENT
SELECT DEPARTMENT,
ROUND(AVG(MONTHLYINCOME),2) AS AVGSALARY
FROM EMPLOYEES
GROUP BY DEPARTMENT;
-- OVERTIME VS ATTRITION
SELECT OVERTIME,
SUM(ATTRITION) AS ATTRITIONCOUNT
FROM EMPLOYEES
GROUP BY OVERTIME;
-- HIGHEST SALARY
SELECT MAX(MONTHLYINCOME) 
FROM EMPLOYEES;
-- LOWEST SALARY
SELECT MIN(MONTHLYINCOME)
FROM EMPLOYEES;
-- AVERAGE AGE
SELECT ROUND(AVG(AGE),2)
FROM EMPLOYEES;
-- ATTRITION RATE BY DEPARTMENT
SELECT DEPARTMENT,COUNT(*) AS TOTALEMPLOYEES,
SUM(ATTRITION) AS EMPLOYEESLEFT,
ROUND((SUM(ATTRITION) * 100.0)/COUNT(*),2) AS ATTRITIONRATE
FROM EMPLOYEES
GROUP BY DEPARTMENT
ORDER BY ATTRITIONRATE DESC;
-- ATTRITION BY JOB ROLE
SELECT JOBROLE,COUNT(*) AS TOTALEMPLOYEES,SUM(ATTRITION) AS EMPLOYEESLEFT,
ROUND((SUM(ATTRITION) * 100.0)/COUNT(*),2) AS ATTRITIONRATE
FROM EMPLOYEES
GROUP BY JOBROLE
ORDER BY ATTRITIONRATE DESC;
-- OVERTIME IMPACT
SELECT OVERTIME,COUNT(*) AS TOTLAEMPLOYEES,SUM(ATTRITION) AS EMPLOYEESLEFT,
ROUND((SUM(ATTRITION) * 100.0)/ COUNT(*),2) AS ATTRITIONRATE
FROM EMPLOYEES
GROUP BY OVERTIME;
-- AVERAGE SALARY BY JOB ROLE
SELECT JOBROLE,ROUND(AVG(MONTHLYINCOME),2)
AS AVERAGESALARY
FROM EMPLOYEES
GROUP BY JOBROLE
ORDER BY AVERAGESALARY DESC;
-- AVERAGE YEARS AT COMPANY
SELECT DEPARTMENT, ROUND(AVG(YEARSATCOMPANY),2) AS AVGYEARS
FROM EMPLOYEES
GROUP BY DEPARTMENT;
-- WORK LIFE BALANCE
SELECT WORKLIFEBALANCE,COUNT(*) AS EMPLOYEES 
FROM EMPLOYEES
GROUP BY WORKLIFEBALANCE;
-- EMPLOYEE SATISFACTION 
SELECT JOBSATISFACTION,
COUNT(*) AS EMPLOYEES
FROM EMPLOYEES
GROUP BY JOBSATISFACTION;
-- TOP 10 HIGHEST PAID EMPLOYEES
SELECT EMPLOYEENUMBER,
JOBROLE,
DEPARTMENT,
MONTHLYINCOME
FROM EMPLOYEES
ORDER BY MONTHLYINCOME DESC
LIMIT 10;
-- AVERAGE INCOME NY EDUCATION 
SELECT EDUCATION,
ROUND(AVG(MONTHLYINCOME),2) AS AVGSALARY
FROM EMPLOYEES
GROUP BY EDUCATION
ORDER BY AVGSALARY DESC;
-- EMPLOYEES NEAR RETIREMENT
SELECT EMPLOYEENUMBER,
AGE,
YEARSATCOMPANY,
JOBROLE
FROM EMPLOYEES
WHERE AGE >= 55;
USE employee_attrition;

ALTER TABLE employees
ADD COLUMN AgeGroup VARCHAR(20),
ADD COLUMN IncomeGroup VARCHAR(20);
 
SELECT
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    COUNT(*) - SUM(Attrition) AS employees_stayed,
    ROUND(SUM(Attrition) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees;
SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(SUM(Attrition) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY Department
ORDER BY attrition_rate DESC;
SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(SUM(Attrition) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY JobRole
ORDER BY attrition_rate DESC;
SELECT
    OverTime,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(SUM(Attrition) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM employees
GROUP BY OverTime
ORDER BY attrition_rate DESC;
-- ============================================================
-- BUSINESS TRAVEL VS ATTRITION
-- ============================================================

SELECT
    BusinessTravel,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY BusinessTravel
ORDER BY attrition_rate DESC;
-- ============================================================
-- MARITAL STATUS VS ATTRITION
-- ============================================================

SELECT
    MaritalStatus,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY MaritalStatus
ORDER BY attrition_rate DESC;
-- ============================================================
-- GENDER VS ATTRITION
-- ============================================================

SELECT
    Gender,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Gender
ORDER BY attrition_rate DESC;
-- ============================================================
-- AGE GROUP VS ATTRITION
-- ============================================================

SELECT
    AgeGroup,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY AgeGroup
ORDER BY attrition_rate DESC;
-- ============================================================
-- INCOME GROUP VS ATTRITION
-- ============================================================

SELECT
    IncomeGroup,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY IncomeGroup
ORDER BY attrition_rate DESC;
-- ============================================================
-- SALARY RANGE VS ATTRITION
-- ============================================================

SELECT
    CASE
        WHEN MonthlyIncome < 3000 THEN 'Below 3000'
        WHEN MonthlyIncome BETWEEN 3000 AND 6000 THEN '3000 - 6000'
        WHEN MonthlyIncome BETWEEN 6001 AND 10000 THEN '6001 - 10000'
        ELSE 'Above 10000'
    END AS salary_range,

    COUNT(*) AS total_employees,

    SUM(Attrition) AS employees_left,

    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY salary_range

ORDER BY attrition_rate DESC;
-- ============================================================
-- SALARY HIKE VS ATTRITION
-- ============================================================

SELECT
    PercentSalaryHike,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY PercentSalaryHike
ORDER BY PercentSalaryHike;
-- ============================================================
-- YEARS AT COMPANY VS ATTRITION
-- ============================================================

SELECT
    YearsAtCompany,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY YearsAtCompany
ORDER BY YearsAtCompany;
-- ============================================================
-- TOTAL WORKING YEARS VS ATTRITION
-- ============================================================

SELECT
    TotalWorkingYears,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY TotalWorkingYears
ORDER BY TotalWorkingYears;
-- ============================================================
-- YEARS IN CURRENT ROLE VS ATTRITION
-- ============================================================

SELECT
    YearsInCurrentRole,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY YearsInCurrentRole
ORDER BY YearsInCurrentRole;
-- ============================================================
-- YEARS SINCE LAST PROMOTION VS ATTRITION
-- ============================================================

SELECT
    YearsSinceLastPromotion,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion;
-- ============================================================
-- JOB SATISFACTION VS ATTRITION
-- ============================================================

SELECT
    JobSatisfaction,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;
-- ============================================================
-- ENVIRONMENT SATISFACTION VS ATTRITION
-- ============================================================

SELECT
    EnvironmentSatisfaction,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY EnvironmentSatisfaction
ORDER BY EnvironmentSatisfaction;
-- ============================================================
-- RELATIONSHIP SATISFACTION VS ATTRITION
-- ============================================================

SELECT
    RelationshipSatisfaction,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY RelationshipSatisfaction
ORDER BY RelationshipSatisfaction;
-- ============================================================
-- WORK-LIFE BALANCE VS ATTRITION
-- ============================================================

SELECT
    WorkLifeBalance,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance;
-- ============================================================
-- STEP 20: EMPLOYEE RISK CLASSIFICATION
-- ============================================================

SELECT
    EmployeeNumber,
    Age,
    JobRole,
    MonthlyIncome,
    JobSatisfaction,
    OverTime,
    YearsAtCompany,
    Attrition,

    CASE
        WHEN OverTime = 'Yes'
             AND JobSatisfaction <= 2
             AND YearsAtCompany <= 3
            THEN 'High Risk'

        WHEN OverTime = 'Yes'
             OR JobSatisfaction <= 2
             OR YearsAtCompany <= 3
            THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS risk_level

FROM employees;
-- ============================================================
-- STEP 21: RISK LEVEL SUMMARY
-- ============================================================

SELECT
    CASE
        WHEN OverTime = 'Yes'
             AND JobSatisfaction <= 2
             AND YearsAtCompany <= 3
            THEN 'High Risk'

        WHEN OverTime = 'Yes'
             OR JobSatisfaction <= 2
             OR YearsAtCompany <= 3
            THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS risk_level,

    COUNT(*) AS total_employees,

    SUM(Attrition) AS employees_left,

    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY risk_level

ORDER BY
    CASE risk_level
        WHEN 'High Risk' THEN 1
        WHEN 'Medium Risk' THEN 2
        WHEN 'Low Risk' THEN 3
    END;
    -- ============================================================
-- STEP 22: HIGH-RISK EMPLOYEES
-- ============================================================

SELECT
    EmployeeNumber,
    Age,
    Gender,
    Department,
    JobRole,
    MonthlyIncome,
    OverTime,
    JobSatisfaction,
    YearsAtCompany,
    Attrition

FROM employees

WHERE
    OverTime = 'Yes'
    AND JobSatisfaction <= 2
    AND YearsAtCompany <= 3

ORDER BY
    MonthlyIncome ASC;
    -- ============================================================
-- STEP 23: DEPARTMENT RISK ANALYSIS USING CTE
-- ============================================================

WITH department_stats AS (
    SELECT
        Department,
        COUNT(*) AS total_employees,
        SUM(Attrition) AS employees_left,
        ROUND(
            SUM(Attrition) * 100.0 / COUNT(*),
            2
        ) AS attrition_rate
    FROM employees
    GROUP BY Department
)

SELECT
    Department,
    total_employees,
    employees_left,
    attrition_rate,

    CASE
        WHEN attrition_rate >= 20 THEN 'High Risk'
        WHEN attrition_rate >= 15 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_level

FROM department_stats
ORDER BY attrition_rate DESC;
-- ============================================================
-- STEP 24: DEPARTMENT WITH HIGHEST ATTRITION
-- ============================================================

SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY Department

HAVING
    SUM(Attrition) * 100.0 / COUNT(*) = (
        SELECT MAX(dept_attrition_rate)
        FROM (
            SELECT
                SUM(Attrition) * 100.0 / COUNT(*) AS dept_attrition_rate
            FROM employees
            GROUP BY Department
        ) AS department_rates
    );
    -- ============================================================
-- STEP 25: JOB ROLE WITH HIGHEST ATTRITION
-- ============================================================

WITH job_role_stats AS (
    SELECT
        JobRole,
        COUNT(*) AS total_employees,
        SUM(Attrition) AS employees_left,
        ROUND(
            SUM(Attrition) * 100.0 / COUNT(*),
            2
        ) AS attrition_rate
    FROM employees
    GROUP BY JobRole
)

SELECT
    JobRole,
    total_employees,
    employees_left,
    attrition_rate

FROM job_role_stats

ORDER BY attrition_rate DESC

LIMIT 1;
-- ============================================================
-- STEP 26: RANK JOB ROLES BY ATTRITION RATE
-- ============================================================

WITH job_role_stats AS (
    SELECT
        JobRole,
        COUNT(*) AS total_employees,
        SUM(Attrition) AS employees_left,
        ROUND(
            SUM(Attrition) * 100.0 / COUNT(*),
            2
        ) AS attrition_rate
    FROM employees
    GROUP BY JobRole
)

SELECT
    JobRole,
    total_employees,
    employees_left,
    attrition_rate,

    RANK() OVER (
        ORDER BY attrition_rate DESC
    ) AS attrition_rank

FROM job_role_stats
ORDER BY attrition_rank;
-- ============================================================
-- STEP 27: RANK DEPARTMENTS BY ATTRITION RATE
-- ============================================================

WITH department_stats AS (
    SELECT
        Department,
        COUNT(*) AS total_employees,
        SUM(Attrition) AS employees_left,
        ROUND(
            SUM(Attrition) * 100.0 / COUNT(*),
            2
        ) AS attrition_rate
    FROM employees
    GROUP BY Department
)

SELECT
    Department,
    total_employees,
    employees_left,
    attrition_rate,

    RANK() OVER (
        ORDER BY attrition_rate DESC
    ) AS attrition_rank

FROM department_stats
ORDER BY attrition_rank;
-- ============================================================
-- STEP 28: SALARY RANK WITHIN EACH DEPARTMENT
-- ============================================================

SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,

    RANK() OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome DESC
    ) AS salary_rank

FROM employees
ORDER BY
    Department,
    salary_rank;
    -- ============================================================
-- STEP 29: TOP 3 PAID EMPLOYEES PER DEPARTMENT
-- ============================================================

WITH ranked_employees AS (
    SELECT
        EmployeeNumber,
        Department,
        JobRole,
        MonthlyIncome,

        RANK() OVER (
            PARTITION BY Department
            ORDER BY MonthlyIncome DESC
        ) AS salary_rank

    FROM employees
)

SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    salary_rank

FROM ranked_employees

WHERE salary_rank <= 3

ORDER BY
    Department,
    salary_rank;
    -- ============================================================
-- STEP 43: SQL DATA VALIDATION
-- ============================================================

SELECT COUNT(*) AS total_rows
FROM employees ;

SELECT COUNT(*) AS total_rows,
    COUNT(DISTINCT EmployeeNumber) AS unique_employee_numbers
FROM employees;
SELECT
    SUM(Age IS NULL) AS null_age,
    SUM(Attrition IS NULL) AS null_attrition,
    SUM(Department IS NULL) AS null_department,
    SUM(JobRole IS NULL) AS null_jobrole,
    SUM(MonthlyIncome IS NULL) AS null_income,
    SUM(OverTime IS NULL) AS null_overtime,
    SUM(JobSatisfaction IS NULL) AS null_job_satisfaction
FROM employees;
SELECT
    Attrition,
    COUNT(*) AS employee_count
FROM employees
GROUP BY Attrition
ORDER BY Attrition;
SELECT DISTINCT Department
FROM employees;
SELECT DISTINCT JobRole
FROM employees;
SELECT DISTINCT OverTime
FROM employees;