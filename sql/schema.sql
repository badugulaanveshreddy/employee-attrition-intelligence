-- ============================================
-- EMPLOYEE ATTRITION INTELLIGENCE
-- DATABASE SCHEMA
-- ============================================

-- Create database
CREATE DATABASE IF NOT EXISTS employee_attrition;

-- Select database
USE employee_attrition;


-- Create employees table if it does not already exist
CREATE TABLE IF NOT EXISTS employees ( 

    Age INT,

    BusinessTravel VARCHAR(30),

    DailyRate INT,

    Department VARCHAR(100),

    DistanceFromHome INT,

    Education INT,

    EducationField VARCHAR(100),

    EmployeeCount INT,

    EmployeeNumber INT PRIMARY KEY,

    EnvironmentSatisfaction INT,

    Gender VARCHAR(20),

    HourlyRate INT,

    JobInvolvement INT,

    JobLevel INT,

    JobRole VARCHAR(100),

    JobSatisfaction INT,

    MaritalStatus VARCHAR(30),

    MonthlyIncome INT,

    MonthlyRate INT,

    NumCompaniesWorked INT,

    Over18 VARCHAR(5),

    OverTime VARCHAR(10),

    PercentSalaryHike INT,

    PerformanceRating INT,

    RelationshipSatisfaction INT,

    StandardHours INT,

    StockOptionLevel INT,

    TotalWorkingYears INT,

    TrainingTimesLastYear INT,

    WorkLifeBalance INT,

    YearsAtCompany INT,

    YearsInCurrentRole INT,

    YearsSinceLastPromotion INT,

    YearsWithCurrManager INT,

    Attrition VARCHAR(10)

);