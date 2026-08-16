import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import ( accuracy_score,confusion_matrix,classification_report)
import joblib
df = pd.read_csv("data/processed/hr_featured.csv")
print(df.head())
print(df.info())
print(df.select_dtypes(include=['object']).columns)
X = df.drop('Attrition', axis=1)
print(X.columns.to_list())
Y = df['Attrition']
from sklearn.preprocessing import LabelEncoder
encoders = {}
for column in X.select_dtypes(include=['object']).columns:
    encoder = LabelEncoder()
    X[column] = encoder.fit_transform(X[column])
    encoders[column] = encoder

joblib.dump(encoders,"models/label_encoders.pkl")
print(type(encoders))
print(encoders.keys)
print("Features shape:", X.shape)
print("Target shape:", Y.shape)
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.2, random_state=42)
print("Training Features:", X_train.shape)
print("Testing Features:", X_test.shape)
print("Training Target:", Y_train.shape)
print("Testing Target:", Y_test.shape)  
model = RandomForestClassifier(random_state=42)
model.fit(X_train, Y_train)
print("Model training completed.")
y_pred = model.predict(X_test)
print("Accuracy:", accuracy_score(Y_test, y_pred))
print(confusion_matrix(Y_test, y_pred))
print(classification_report(Y_test, y_pred))
joblib.dump(encoders,"models/label_encoders.pkl")
joblib.dump(model,"models/attrition_model.pkl")

print("Model and encoders saved successfully.")