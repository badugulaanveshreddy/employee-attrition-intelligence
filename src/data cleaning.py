import pandas as pd

# Load the dataset
df = pd.read_csv("data/raw/WA_Fn-UseC_-HR-Employee-Attrition.csv")

print("Original Shape:", df.shape)

# Remove duplicate rows (if any)
df.drop_duplicates(inplace=True)

# Check for missing values
print("\nMissing Values:")
print(df.isnull().sum())

# Convert Attrition to numeric
df["Attrition"] = df["Attrition"].map({"Yes": 1, "No": 0})

# Create Age Groups
df["AgeGroup"] = pd.cut(
    df["Age"],
    bins=[18, 25, 35, 45, 55, 65],
    labels=["18-25", "26-35", "36-45", "46-55", "56-65"]
)

# Create Monthly Income Groups
df["IncomeGroup"] = pd.cut(
    df["MonthlyIncome"],
    bins=[0, 5000, 10000, 15000, 20000],
    labels=["Low", "Medium", "High", "Very High"]
)

# Save cleaned dataset
df.to_csv("data/processed/hr_cleaned.csv", index=False)

print("\nCleaning Completed Successfully!")
print("Cleaned Shape:", df.shape)
print("File saved to: data/processed/hr_cleaned.csv")