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
# LOAD EMPLOYEE DATA
# ============================================================

query = """
SELECT *
FROM employees;
"""

df = pd.read_sql(query, engine)

# ============================================================
# BASIC INFORMATION
# ============================================================

print("Data loaded successfully!")

print("\nShape:")
print(df.shape)

print("\nColumns:")
print(df.columns.tolist())

print("\nFirst 5 rows:")
print(df.head())

print("\nData types:")
print(df.dtypes)

print("\nMissing values:")
print(df.isnull().sum())