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

df = pd.read_sql("SELECT * FROM employees", engine)

print("========== DATA QUALITY CHECK ==========")

# Shape
print("\n1. Dataset Shape")
print(df.shape)

# Duplicate rows
print("\n2. Duplicate Rows")
print(df.duplicated().sum())

# Missing values
print("\n3. Missing Values")
print(df.isnull().sum())

# Attrition distribution
print("\n4. Attrition Distribution")
print(df["Attrition"].value_counts())

# Unique departments
print("\n5. Departments")
print(df["Department"].unique())

# Unique job roles
print("\n6. Job Roles")
print(df["JobRole"].unique())

# Overtime
print("\n7. Overtime")
print(df["OverTime"].value_counts())

# Basic statistics
print("\n8. Numerical Summary")
print(df.describe())

print("\n========== CHECK COMPLETED ==========")