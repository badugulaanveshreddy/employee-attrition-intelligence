import pandas as pd
from sqlalchemy import create_engine
from urllib.parse import quote_plus

# ============================================================
# MYSQL CONNECTION
# ============================================================

username = "root"
password = "Anvesh@8866"

encoded_password = quote_plus(password)

engine = create_engine(
    f"mysql+pymysql://{username}:{encoded_password}@localhost:3306/employee_attrition"
)

# ============================================================
# LOAD DATA
# ============================================================

df = pd.read_sql(
    "SELECT * FROM employees",
    engine
)
# Convert Attrition to numeric
df["Attrition"] = pd.to_numeric(df["Attrition"], errors="coerce")

print("Data loaded successfully!")
print("Shape:", df.shape)

# ============================================================
# BASIC ANALYSIS
# ============================================================

print("\n========== EMPLOYEE ATTRITION ANALYSIS ==========")

# Total employees
total_employees = len(df)

# Employees who left
employees_left = df["Attrition"].sum()

# Employees who stayed
employees_stayed = total_employees - employees_left

# Attrition rate
attrition_rate = (
    employees_left / total_employees
) * 100

print("\nTotal Employees:", total_employees)
print("Employees Left:", employees_left)
print("Employees Stayed:", employees_stayed)
print("Attrition Rate:", round(attrition_rate, 2), "%")

# ============================================================
# DEPARTMENT ANALYSIS
# ============================================================

print("\n========== DEPARTMENT ATTRITION ==========")

department_analysis = (
    df.groupby("Department")
    .agg(
        total_employees=("EmployeeNumber", "count"),
        employees_left=("Attrition", "sum"),
        average_income=("MonthlyIncome", "mean"),
        average_years=("YearsAtCompany", "mean")
    )
    .reset_index()
)

department_analysis["attrition_rate"] = (
    department_analysis["employees_left"]
    / department_analysis["total_employees"]
) * 100

department_analysis = department_analysis.sort_values(
    "attrition_rate",
    ascending=False
)

print(department_analysis)

# ============================================================
# JOB ROLE ANALYSIS
# ============================================================

print("\n========== JOB ROLE ATTRITION ==========")

jobrole_analysis = (
    df.groupby("JobRole")
    .agg(
        total_employees=("EmployeeNumber", "count"),
        employees_left=("Attrition", "sum"),
        average_income=("MonthlyIncome", "mean")
    )
    .reset_index()
)

jobrole_analysis["attrition_rate"] = (
    jobrole_analysis["employees_left"]
    / jobrole_analysis["total_employees"]
) * 100

jobrole_analysis = jobrole_analysis.sort_values(
    "attrition_rate",
    ascending=False
)

print(jobrole_analysis)

# ============================================================
# OVERTIME ANALYSIS
# ============================================================

print("\n========== OVERTIME ANALYSIS ==========")

overtime_analysis = (
    df.groupby("OverTime")
    .agg(
        total_employees=("EmployeeNumber", "count"),
        employees_left=("Attrition", "sum")
    )
    .reset_index()
)

overtime_analysis["attrition_rate"] = (
    overtime_analysis["employees_left"]
    / overtime_analysis["total_employees"]
) * 100

print(overtime_analysis)

print("\n========== ANALYSIS COMPLETED ==========")
# ============================================================
# SAVE ANALYSIS RESULTS
# ============================================================

department_analysis.to_csv(
    "outputs/department_analysis.csv",
    index=False
)

jobrole_analysis.to_csv(
    "outputs/jobrole_analysis.csv",
    index=False
)

overtime_analysis.to_csv(
    "outputs/overtime_analysis.csv",
    index=False
)

print("\nAnalysis results saved successfully!")