import pandas as pd
from sqlalchemy import create_engine, text
from urllib.parse import quote_plus

username = "root"
password = "Anvesh@8866"

encoded_password = quote_plus(password)

engine = create_engine(
    f"mysql+pymysql://{username}:{encoded_password}@localhost:3306/employee_attrition"
)

with engine.connect() as connection:
    connection.execute(text("SELECT 1"))
    print("MySQL connection successful!")

df = pd.read_sql(
    "SELECT * FROM employees LIMIT 5",
    engine
)

print("\nEmployee data:")
print(df)

print("\nRows:", len(df))
print("Columns:", len(df.columns))