import pandas as pd

# Load cleaned dataset
df = pd.read_csv("data/processed/hr_cleaned.csv")

# Experience Level
df["ExperienceLevel"] = pd.cut(
    df["TotalWorkingYears"],
    bins=[0, 5, 10, 20, 40],
    labels=["Entry", "Mid", "Senior", "Expert"]
)

# Distance Category
df["DistanceCategory"] = pd.cut(
    df["DistanceFromHome"],
    bins=[0, 5, 10, 20, 30],
    labels=["Near", "Moderate", "Far", "Very Far"]
)

# Years at Company Category
df["CompanyTenure"] = pd.cut(
    df["YearsAtCompany"],
    bins=[0, 2, 5, 10, 40],
    labels=["New", "Junior", "Experienced", "Veteran"]
)

# Save dataset
df.to_csv("data/processed/hr_featured.csv", index=False)

print("Feature Engineering Completed Successfully!")
print(df.head())