-- ============================================================
-- EMPLOYEE ATTRITION INTELLIGENCE
-- SQL ANALYTICAL VIEWS
-- ============================================================

USE employee_attrition;


-- ============================================================
-- VIEW 1: OVERALL ATTRITION SUMMARY
-- ============================================================

CREATE OR REPLACE VIEW vw_attrition_summary AS
SELECT
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    COUNT(*) - SUM(Attrition) AS employees_stayed,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees;


-- ============================================================
-- VIEW 2: DEPARTMENT ATTRITION
-- ============================================================

CREATE OR REPLACE VIEW vw_department_attrition AS
SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    COUNT(*) - SUM(Attrition) AS employees_stayed,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Department;


-- ============================================================
-- VIEW 3: JOB ROLE ATTRITION
-- ============================================================

CREATE OR REPLACE VIEW vw_jobrole_attrition AS
SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    COUNT(*) - SUM(Attrition) AS employees_stayed,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY JobRole;


-- ============================================================
-- VIEW 4: OVERTIME ATTRITION
-- ============================================================

CREATE OR REPLACE VIEW vw_overtime_attrition AS
SELECT
    OverTime,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    COUNT(*) - SUM(Attrition) AS employees_stayed,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY OverTime;


-- ============================================================
-- VIEW 5: EMPLOYEE RISK ANALYSIS
-- ============================================================

CREATE OR REPLACE VIEW vw_employee_risk AS
SELECT
    EmployeeNumber,
    Age,
    Gender,
    Department,
    JobRole,
    MonthlyIncome,
    OverTime,
    JobSatisfaction,
    EnvironmentSatisfaction,
    RelationshipSatisfaction,
    WorkLifeBalance,
    YearsAtCompany,
    YearsInCurrentRole,
    YearsSinceLastPromotion,
    TotalWorkingYears,
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
-- VIEW 6: RISK LEVEL SUMMARY
-- ============================================================

CREATE OR REPLACE VIEW vw_risk_summary AS
SELECT
    risk_level,
    COUNT(*) AS total_employees,
    SUM(Attrition) AS employees_left,
    COUNT(*) - SUM(Attrition) AS employees_stayed,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM vw_employee_risk
GROUP BY risk_level;


-- ============================================================
-- VIEW 7: DEPARTMENT RISK ANALYSIS
-- ============================================================

CREATE OR REPLACE VIEW vw_department_risk AS
SELECT
    Department,
    risk_level,
    COUNT(*) AS employee_count,
    SUM(Attrition) AS employees_left,
    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM vw_employee_risk
GROUP BY
    Department,
    risk_level;


-- ============================================================
-- VIEW 8: HIGH-RISK EMPLOYEES
-- ============================================================

CREATE OR REPLACE VIEW vw_high_risk_employees AS
SELECT
    EmployeeNumber,
    Age,
    Gender,
    Department,
    JobRole,
    MonthlyIncome,
    OverTime,
    JobSatisfaction,
    EnvironmentSatisfaction,
    RelationshipSatisfaction,
    WorkLifeBalance,
    YearsAtCompany,
    YearsInCurrentRole,
    YearsSinceLastPromotion,
    TotalWorkingYears,
    Attrition
FROM vw_employee_risk
WHERE risk_level = 'High Risk';


-- ============================================================
-- VIEW 9: MANAGEMENT KPI SUMMARY
-- ============================================================

CREATE OR REPLACE VIEW vw_management_kpis AS
SELECT
    COUNT(*) AS total_employees,

    SUM(Attrition) AS employees_left,

    COUNT(*) - SUM(Attrition) AS employees_stayed,

    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate,

    ROUND(AVG(Age), 2) AS average_age,

    ROUND(AVG(MonthlyIncome), 2) AS average_monthly_income,

    ROUND(AVG(YearsAtCompany), 2) AS average_years_at_company,

    SUM(
        CASE
            WHEN OverTime = 'Yes' THEN 1
            ELSE 0
        END
    ) AS overtime_employees

FROM employees;


-- ============================================================
-- VIEW 10: DEPARTMENT DASHBOARD DATA
-- ============================================================

CREATE OR REPLACE VIEW vw_department_dashboard AS
SELECT
    Department,

    COUNT(*) AS total_employees,

    SUM(Attrition) AS employees_left,

    COUNT(*) - SUM(Attrition) AS employees_stayed,

    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate,

    ROUND(AVG(MonthlyIncome), 2) AS average_income,

    ROUND(AVG(YearsAtCompany), 2) AS average_years_at_company,

    ROUND(AVG(JobSatisfaction), 2) AS average_job_satisfaction

FROM employees

GROUP BY Department;


-- ============================================================
-- VIEW 11: JOB ROLE DASHBOARD DATA
-- ============================================================

CREATE OR REPLACE VIEW vw_jobrole_dashboard AS
SELECT
    JobRole,

    COUNT(*) AS total_employees,

    SUM(Attrition) AS employees_left,

    COUNT(*) - SUM(Attrition) AS employees_stayed,

    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate,

    ROUND(AVG(MonthlyIncome), 2) AS average_income,

    ROUND(AVG(YearsAtCompany), 2) AS average_years_at_company,

    ROUND(AVG(JobSatisfaction), 2) AS average_job_satisfaction

FROM employees

GROUP BY JobRole;


-- ============================================================
-- VIEW 12: SATISFACTION DASHBOARD DATA
-- ============================================================

CREATE OR REPLACE VIEW vw_satisfaction_dashboard AS
SELECT
    JobSatisfaction,
    EnvironmentSatisfaction,
    RelationshipSatisfaction,
    WorkLifeBalance,

    COUNT(*) AS total_employees,

    SUM(Attrition) AS employees_left,

    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate

FROM employees

GROUP BY
    JobSatisfaction,
    EnvironmentSatisfaction,
    RelationshipSatisfaction,
    WorkLifeBalance;


-- ============================================================
-- VIEW 13: RISK DASHBOARD DATA
-- ============================================================

CREATE OR REPLACE VIEW vw_risk_dashboard AS
SELECT
    risk_level,

    COUNT(*) AS total_employees,

    SUM(Attrition) AS employees_left,

    COUNT(*) - SUM(Attrition) AS employees_stayed,

    ROUND(
        SUM(Attrition) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate,

    ROUND(AVG(MonthlyIncome), 2) AS average_income,

    ROUND(AVG(JobSatisfaction), 2) AS average_job_satisfaction,

    ROUND(AVG(YearsAtCompany), 2) AS average_years_at_company

FROM vw_employee_risk

GROUP BY risk_level;