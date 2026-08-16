-- ============================================================
-- EMPLOYEE ATTRITION INTELLIGENCE
-- SQL ANALYSIS QUERIES
-- ============================================================

USE employee_attrition;

-- ============================================================
-- DATABASE / TABLE INSPECTION
-- ============================================================

SHOW DATABASES;

SELECT *
FROM employees;

SELECT COUNT(*) AS total_employees
FROM employees;

DESCRIBE employees;


-- ============================================================
-- BASIC ANALYSIS
-- ============================================================

-- 1. TOTAL EMPLOYEES
SELECT COUNT(*) AS total_employees
FROM employees;


-- 2. EMPLOYEES WHO LEFT
SELECT
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left
FROM employees;


-- 3. EMPLOYEES WHO STAYED
SELECT
    SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS employees_stayed
FROM employees;


-- 4. OVERALL ATTRITION RATE
SELECT
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees;


-- ============================================================
-- DEPARTMENT ANALYSIS
-- ============================================================

-- 5. DEPARTMENT-WISE EMPLOYEES LEFT
SELECT
    Department,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left
FROM employees
GROUP BY Department
ORDER BY employees_left DESC;


-- 6. ATTRITION RATE BY DEPARTMENT
SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Department
ORDER BY attrition_rate DESC;


-- ============================================================
-- JOB ROLE ANALYSIS
-- ============================================================

-- 7. JOB ROLE-WISE ATTRITION
SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY JobRole
ORDER BY attrition_rate DESC;


-- ============================================================
-- OVERTIME ANALYSIS
-- ============================================================

-- 8. OVERTIME VS ATTRITION
SELECT
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY OverTime
ORDER BY attrition_rate DESC;


-- ============================================================
-- SALARY ANALYSIS
-- ============================================================

-- 9. AVERAGE SALARY BY DEPARTMENT
SELECT
    Department,
    ROUND(AVG(MonthlyIncome), 2) AS average_salary
FROM employees
GROUP BY Department
ORDER BY average_salary DESC;


-- 10. AVERAGE SALARY BY JOB ROLE
SELECT
    JobRole,
    ROUND(AVG(MonthlyIncome), 2) AS average_salary
FROM employees
GROUP BY JobRole
ORDER BY average_salary DESC;


-- 11. HIGHEST SALARY
SELECT
    MAX(MonthlyIncome) AS highest_salary
FROM employees;


-- 12. LOWEST SALARY
SELECT
    MIN(MonthlyIncome) AS lowest_salary
FROM employees;


-- ============================================================
-- EMPLOYEE DEMOGRAPHICS
-- ============================================================

-- 13. AVERAGE AGE
SELECT
    ROUND(AVG(Age), 2) AS average_age
FROM employees;


-- 14. AVERAGE YEARS AT COMPANY BY DEPARTMENT
SELECT
    Department,
    ROUND(AVG(YearsAtCompany), 2) AS average_years_at_company
FROM employees
GROUP BY Department
ORDER BY average_years_at_company DESC;


-- ============================================================
-- WORK-LIFE & SATISFACTION ANALYSIS
-- ============================================================

-- 15. WORK-LIFE BALANCE
SELECT
    WorkLifeBalance,
    COUNT(*) AS employees
FROM employees
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance;


-- 16. JOB SATISFACTION
SELECT
    JobSatisfaction,
    COUNT(*) AS employees
FROM employees
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;


-- ============================================================
-- TOP PAID EMPLOYEES
-- ============================================================

-- 17. TOP 10 HIGHEST-PAID EMPLOYEES
SELECT
    EmployeeNumber,
    JobRole,
    Department,
    MonthlyIncome
FROM employees
ORDER BY MonthlyIncome DESC
LIMIT 10;


-- ============================================================
-- EDUCATION & INCOME
-- ============================================================

-- 18. AVERAGE INCOME BY EDUCATION LEVEL
SELECT
    Education,
    ROUND(AVG(MonthlyIncome), 2) AS average_salary
FROM employees
GROUP BY Education
ORDER BY average_salary DESC;


-- ============================================================
-- EMPLOYEES NEAR RETIREMENT
-- ============================================================

-- 19. EMPLOYEES AGED 55 OR ABOVE
SELECT
    EmployeeNumber,
    Age,
    YearsAtCompany,
    JobRole
FROM employees
WHERE Age >= 55
ORDER BY Age DESC;


-- ============================================================
-- ATTRITION BY GENDER
-- ============================================================

-- 20. ATTRITION RATE BY GENDER
SELECT
    Gender,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Gender
ORDER BY attrition_rate DESC;


-- ============================================================
-- ATTRITION BY MARITAL STATUS
-- ============================================================

-- 21. ATTRITION RATE BY MARITAL STATUS
SELECT
    MaritalStatus,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY MaritalStatus
ORDER BY attrition_rate DESC;


-- ============================================================
-- ATTRITION BY JOB LEVEL
-- ============================================================

-- 22. ATTRITION RATE BY JOB LEVEL
SELECT
    JobLevel,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY JobLevel
ORDER BY attrition_rate DESC;