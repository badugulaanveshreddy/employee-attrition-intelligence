import pandas as pd

# Load cleaned dataset
df = pd.read_csv("data/processed/hr_cleaned.csv")

# -----------------------------
# Basic Information
# -----------------------------
print("Dataset Shape:", df.shape)

print("\nEmployee Attrition Count:")
print(df["Attrition"].value_counts())

print("\nEmployee Attrition Percentage:")
print(df["Attrition"].value_counts(normalize=True) * 100)

# -----------------------------
# Department-wise Attrition
# -----------------------------
print("\nDepartment-wise Attrition:")
print(pd.crosstab(df["Department"], df["Attrition"]))

# -----------------------------
# Job Role-wise Attrition
# -----------------------------
print("\nJob Role-wise Attrition:")
print(pd.crosstab(df["JobRole"], df["Attrition"]))

# -----------------------------
# Gender-wise Attrition
# -----------------------------
print("\nGender-wise Attrition:")
print(pd.crosstab(df["Gender"], df["Attrition"]))

# -----------------------------
# Overtime vs Attrition
# -----------------------------
print("\nOvertime vs Attrition:")
print(pd.crosstab(df["OverTime"], df["Attrition"]))

# -----------------------------
# Average Salary
# -----------------------------
print("\nAverage Monthly Income:")
print(df["MonthlyIncome"].mean())

# -----------------------------
# Average Age
# -----------------------------
print("\nAverage Age:")
print(df["Age"].mean())