import os
import joblib
import pandas as pd
import streamlit as st
import plotly.express as px


# ============================================================
# PAGE CONFIGURATION
# ============================================================

st.set_page_config(
    page_title="Employee Attrition Intelligence",
    page_icon="📊",
    layout="wide"
)


# ============================================================
# PROJECT PATHS
# ============================================================

BASE_DIR = os.path.dirname(
    os.path.dirname(os.path.abspath(__file__))
)

MODEL_PATH = os.path.join(
    BASE_DIR,
    "models",
    "attrition_model.pkl"
)

ENCODER_PATH = os.path.join(
    BASE_DIR,
    "models",
    "label_encoders.pkl"
)

DATA_PATH = os.path.join(
    BASE_DIR,
    "data",
    "processed",
    "hr_featured.csv"
)


# ============================================================
# LOAD MODEL, ENCODERS AND DATA
# ============================================================

try:
    model = joblib.load(MODEL_PATH)
    encoders = joblib.load(ENCODER_PATH)
    df = pd.read_csv(DATA_PATH)

except Exception as e:
    st.error("❌ Unable to load project files.")
    st.exception(e)
    st.stop()


# ============================================================
# HEADER
# ============================================================

st.title("📊 Employee Attrition Intelligence")

st.markdown(
    """
    ### AI-Powered Employee Attrition Prediction

    Analyze employee characteristics, explore workforce trends,
    and estimate employee attrition risk using a trained
    **Random Forest machine-learning model**.
    """
)

st.divider()


# ============================================================
# WORKFORCE OVERVIEW
# ============================================================

st.subheader("📊 Workforce Overview")

st.caption(
    "Key workforce metrics derived from the employee dataset."
)

col1, col2, col3, col4 = st.columns(4)


with col1:
    st.metric(
        label="👨‍💼 Total Employees",
        value=len(df)
    )


with col2:
    attrition_rate = df["Attrition"].mean() * 100

    st.metric(
        label="📉 Attrition Rate",
        value=f"{attrition_rate:.2f}%"
    )


with col3:
    average_age = df["Age"].mean()

    st.metric(
        label="🎂 Average Age",
        value=f"{average_age:.0f} Years"
    )


with col4:
    average_income = df["MonthlyIncome"].mean()

    st.metric(
        label="💰 Avg Monthly Income",
        value=f"${average_income:,.0f}"
    )


# ============================================================
# WORKFORCE ANALYTICS
# ============================================================

st.markdown("---")

st.subheader("📊 Workforce Analytics")

st.caption(
    "Explore workforce composition and employee attrition patterns."
)

col1, col2 = st.columns(2)


# ============================================================
# EMPLOYEES BY DEPARTMENT
# ============================================================

with col1:

    department_counts = (
        df["Department"]
        .value_counts()
        .reset_index()
    )

    department_counts.columns = [
        "Department",
        "Employees"
    ]

    fig_department = px.bar(
        department_counts,
        x="Department",
        y="Employees",
        text="Employees",
        title="Employees by Department"
    )

    fig_department.update_traces(
        textposition="outside",
        marker_line_width=0
    )

    fig_department.update_layout(
        height=420,
        margin=dict(
            l=20,
            r=20,
            t=70,
            b=20
        ),
        xaxis_title="",
        yaxis_title="Employees",
        showlegend=False
    )

    st.plotly_chart(
        fig_department,
        use_container_width=True
    )


# ============================================================
# ATTRITION DISTRIBUTION
# ============================================================

with col2:

    attrition_counts = (
        df["Attrition"]
        .value_counts()
        .reset_index()
    )

    attrition_counts.columns = [
        "Attrition",
        "Employees"
    ]

    attrition_counts["Status"] = (
        attrition_counts["Attrition"]
        .map({
            0: "Stayed",
            1: "Left",
            "0": "Stayed",
            "1": "Left",
            "No": "Stayed",
            "Yes": "Left"
        })
    )

    fig_attrition = px.pie(
        attrition_counts,
        names="Status",
        values="Employees",
        hole=0.55,
        title="Attrition Distribution"
    )

    fig_attrition.update_traces(
        textposition="inside",
        textinfo="percent+label"
    )

    fig_attrition.update_layout(
        height=420,
        margin=dict(
            l=20,
            r=20,
            t=70,
            b=20
        ),
        showlegend=True,
        legend=dict(
            orientation="h",
            yanchor="bottom",
            y=-0.05,
            xanchor="center",
            x=0.5
        )
    )

    st.plotly_chart(
        fig_attrition,
        use_container_width=True
    )


# ============================================================
# ATTRITION ANALYSIS
# ============================================================

st.markdown("---")

st.subheader("🔍 Attrition Analysis")

st.caption(
    "Identify departments and roles with higher employee attrition."
)

col1, col2 = st.columns(2)


# ============================================================
# ATTRITION BY DEPARTMENT
# ============================================================

with col1:

    dept_attrition = (
        df.groupby("Department")["Attrition"]
        .mean()
        .reset_index()
    )

    dept_attrition["Attrition Rate"] = (
        dept_attrition["Attrition"] * 100
    )

    fig_dept_attrition = px.bar(
        dept_attrition,
        x="Department",
        y="Attrition Rate",
        text="Attrition Rate",
        title="Attrition Rate by Department"
    )

    fig_dept_attrition.update_traces(
        texttemplate="%{text:.1f}%",
        textposition="outside"
    )

    fig_dept_attrition.update_layout(
        height=420,
        margin=dict(
            l=20,
            r=20,
            t=70,
            b=20
        ),
        xaxis_title="",
        yaxis_title="Attrition Rate (%)",
        showlegend=False
    )

    st.plotly_chart(
        fig_dept_attrition,
        use_container_width=True
    )


# ============================================================
# ATTRITION BY JOB ROLE
# ============================================================

with col2:

    role_attrition = (
        df.groupby("JobRole")["Attrition"]
        .mean()
        .reset_index()
    )

    role_attrition["Attrition Rate"] = (
        role_attrition["Attrition"] * 100
    )

    role_attrition = role_attrition.sort_values(
        "Attrition Rate",
        ascending=True
    )

    fig_role_attrition = px.bar(
        role_attrition,
        x="Attrition Rate",
        y="JobRole",
        orientation="h",
        text="Attrition Rate",
        title="Attrition Rate by Job Role"
    )

    fig_role_attrition.update_traces(
        texttemplate="%{text:.1f}%",
        textposition="outside"
    )

    fig_role_attrition.update_layout(
        height=420,
        margin=dict(
            l=20,
            r=40,
            t=70,
            b=20
        ),
        xaxis_title="Attrition Rate (%)",
        yaxis_title="",
        showlegend=False
    )

    st.plotly_chart(
        fig_role_attrition,
        use_container_width=True
    )


# ============================================================
# EMPLOYEE PREDICTION SIDEBAR
# ============================================================

with st.sidebar:

    st.title("🤖 Attrition Predictor")

    st.caption(
        "Enter employee information to estimate attrition risk."
    )

    st.divider()


    # ========================================================
    # PERSONAL DETAILS
    # ========================================================

    with st.expander(
        "👤 Personal Details",
        expanded=True
    ):

        age = st.number_input(
            "Age",
            min_value=18,
            max_value=60,
            value=30
        )

        gender = st.selectbox(
            "Gender",
            ["Male", "Female"]
        )

        marital_status = st.selectbox(
            "Marital Status",
            ["Single", "Married", "Divorced"]
        )

        education = st.selectbox(
            "Education",
            [1, 2, 3, 4, 5]
        )

        education_field = st.selectbox(
            "Education Field",
            list(encoders["EducationField"].classes_)
        )


    # ========================================================
    # JOB DETAILS
    # ========================================================

    with st.expander("💼 Job Details"):

        business_travel = st.selectbox(
            "Business Travel",
            list(encoders["BusinessTravel"].classes_)
        )

        department = st.selectbox(
            "Department",
            list(encoders["Department"].classes_)
        )

        job_role = st.selectbox(
            "Job Role",
            list(encoders["JobRole"].classes_)
        )

        job_level = st.selectbox(
            "Job Level",
            [1, 2, 3, 4, 5]
        )

        job_involvement = st.selectbox(
            "Job Involvement",
            [1, 2, 3, 4]
        )

        job_satisfaction = st.selectbox(
            "Job Satisfaction",
            [1, 2, 3, 4]
        )

        environment_satisfaction = st.selectbox(
            "Environment Satisfaction",
            [1, 2, 3, 4]
        )

        overtime = st.selectbox(
            "OverTime",
            ["Yes", "No"]
        )


    # ========================================================
    # SALARY DETAILS
    # ========================================================

    with st.expander("💰 Salary Details"):

        monthly_income = st.number_input(
            "Monthly Income",
            min_value=1000,
            max_value=20000,
            value=5000,
            step=500
        )

        daily_rate = st.number_input(
            "Daily Rate",
            min_value=100,
            max_value=2000,
            value=800
        )

        hourly_rate = st.number_input(
            "Hourly Rate",
            min_value=30,
            max_value=100,
            value=60
        )

        percent_salary_hike = st.number_input(
            "Percent Salary Hike",
            min_value=0,
            max_value=100,
            value=15
        )

        stock_option_level = st.selectbox(
            "Stock Option Level",
            [0, 1, 2, 3]
        )


    # ========================================================
    # EXPERIENCE DETAILS
    # ========================================================

    with st.expander("📈 Experience Details"):

        years_at_company = st.number_input(
            "Years at Company",
            min_value=0,
            max_value=40,
            value=5
        )

        total_working_years = st.number_input(
            "Total Working Years",
            min_value=0,
            max_value=40,
            value=10
        )

        years_in_current_role = st.number_input(
            "Years in Current Role",
            min_value=0,
            max_value=20,
            value=4
        )

        years_since_last_promotion = st.number_input(
            "Years Since Last Promotion",
            min_value=0,
            max_value=15,
            value=1
        )

        years_with_current_manager = st.number_input(
            "Years With Current Manager",
            min_value=0,
            max_value=20,
            value=4
        )

        num_companies_worked = st.number_input(
            "Number of Companies Worked",
            min_value=0,
            max_value=10,
            value=2
        )

        training_times_last_year = st.number_input(
            "Training Times Last Year",
            min_value=0,
            max_value=10,
            value=2
        )


    # ========================================================
    # ADDITIONAL DETAILS
    # ========================================================

    with st.expander("📋 Additional Details"):

        distance_from_home = st.number_input(
            "Distance From Home",
            min_value=1,
            max_value=30,
            value=10
        )

        performance_rating = st.selectbox(
            "Performance Rating",
            [1, 2, 3, 4]
        )

        relationship_satisfaction = st.selectbox(
            "Relationship Satisfaction",
            [1, 2, 3, 4]
        )

        work_life_balance = st.selectbox(
            "Work Life Balance",
            [1, 2, 3, 4]
        )

        distance_category = st.selectbox(
            "Distance Category",
            ["Near", "Medium", "Far"]
        )

        age_group = st.selectbox(
            "Age Group",
            list(encoders["AgeGroup"].classes_)
        )

        income_group = st.selectbox(
            "Income Group",
            ["Low", "Medium", "High"]
        )

        experience_level = st.selectbox(
            "Experience Level",
            list(encoders["ExperienceLevel"].classes_)
        )

        company_tenure = st.selectbox(
            "Company Tenure",
            list(encoders["CompanyTenure"].classes_)
        )


    st.divider()

    predict = st.button(
        "🚀 Predict Attrition",
        use_container_width=True,
        type="primary"
    )


# ============================================================
# PREDICTION
# ============================================================

if predict:

    input_data = pd.DataFrame({

        "Age": [age],
        "BusinessTravel": [business_travel],
        "DailyRate": [daily_rate],
        "Department": [department],
        "DistanceFromHome": [distance_from_home],
        "Education": [education],
        "EducationField": [education_field],
        "EmployeeCount": [1],
        "EmployeeNumber": [1],
        "EnvironmentSatisfaction": [environment_satisfaction],
        "Gender": [gender],
        "HourlyRate": [hourly_rate],
        "JobInvolvement": [job_involvement],
        "JobLevel": [job_level],
        "JobRole": [job_role],
        "JobSatisfaction": [job_satisfaction],
        "MaritalStatus": [marital_status],
        "MonthlyIncome": [monthly_income],
        "MonthlyRate": [10000],
        "NumCompaniesWorked": [num_companies_worked],
        "Over18": ["Y"],
        "OverTime": [overtime],
        "PercentSalaryHike": [percent_salary_hike],
        "PerformanceRating": [performance_rating],
        "RelationshipSatisfaction": [relationship_satisfaction],
        "StandardHours": [80],
        "StockOptionLevel": [stock_option_level],
        "TotalWorkingYears": [total_working_years],
        "TrainingTimesLastYear": [training_times_last_year],
        "WorkLifeBalance": [work_life_balance],
        "YearsAtCompany": [years_at_company],
        "YearsInCurrentRole": [years_in_current_role],
        "YearsSinceLastPromotion": [years_since_last_promotion],
        "YearsWithCurrManager": [years_with_current_manager],
        "AgeGroup": [age_group],
        "IncomeGroup": [income_group],
        "ExperienceLevel": [experience_level],
        "DistanceCategory": [distance_category],
        "CompanyTenure": [company_tenure]
    })


    # ========================================================
    # ENCODE CATEGORICAL VARIABLES
    # ========================================================

    try:

        for col in encoders:

            input_data[col] = (
                encoders[col]
                .transform(input_data[col])
            )

    except Exception as e:

        st.error(
            "❌ Error while encoding employee information."
        )

        st.exception(e)
        st.stop()


    # ========================================================
    # MODEL PREDICTION
    # ========================================================

    try:

        prediction = model.predict(input_data)

        probability = model.predict_proba(
            input_data
        )[0][1]

    except Exception as e:

        st.error("❌ Model prediction failed.")
        st.exception(e)
        st.stop()


    # ========================================================
    # RISK ASSESSMENT
    # ========================================================

    st.markdown("---")

    st.subheader("🎯 Employee Risk Assessment")

    if prediction[0] == 1:

        st.error(
            "⚠️ Employee is likely to leave."
        )

    else:

        st.success(
            "✅ Employee is likely to stay."
        )


    st.metric(
        "Attrition Probability",
        f"{probability * 100:.2f}%"
    )

    st.progress(float(probability))


    # ========================================================
    # RISK LEVEL
    # ========================================================

    if probability >= 0.75:

        st.error(
            "🔴 Risk Level: HIGH"
        )

        risk_level = "High"

    elif probability >= 0.50:

        st.warning(
            "🟠 Risk Level: MEDIUM"
        )

        risk_level = "Medium"

    else:

        st.success(
            "🟢 Risk Level: LOW"
        )

        risk_level = "Low"


    # ========================================================
    # HR RECOMMENDATIONS
    # ========================================================

    st.markdown("---")

    st.subheader("💡 HR Recommendations")


    if risk_level == "High":

        st.warning(
            """
            ### Immediate Actions

            - Schedule a one-on-one discussion with the employee.
            - Review workload and work-life balance.
            - Discuss career growth opportunities.
            - Consider salary and benefits review.
            - Increase employee engagement.
            """
        )


    elif risk_level == "Medium":

        st.info(
            """
            ### Recommended Actions

            - Monitor employee satisfaction.
            - Encourage participation in training programs.
            - Discuss future career plans.
            - Improve manager-employee communication.
            """
        )


    else:

        st.success(
            """
            ### Employee Status

            - Employee appears relatively stable.
            - Continue regular performance reviews.
            - Maintain engagement initiatives.
            - Encourage professional development.
            """
        )


# ============================================================
# FEATURE IMPORTANCE
# ============================================================

st.markdown("---")

st.subheader("🔍 Key Attrition Drivers")

st.caption(
    "Top factors contributing to the machine-learning model's prediction."
)


try:

    feature_names = model.feature_names_in_

    importance = model.feature_importances_

    importance_df = pd.DataFrame({

        "Feature": feature_names,

        "Importance": importance

    })


    importance_df["Importance (%)"] = (
        importance_df["Importance"] * 100
    )


    importance_df = importance_df.sort_values(
        by="Importance",
        ascending=False
    )


    top10 = (
        importance_df
        .head(10)
        .sort_values(
            by="Importance",
            ascending=True
        )
    )


    fig_importance = px.bar(

        top10,

        x="Importance (%)",

        y="Feature",

        orientation="h",

        text="Importance (%)",

        title="Top 10 Features Influencing Attrition"

    )


    fig_importance.update_traces(

        texttemplate="%{text:.1f}%",

        textposition="outside"

    )


    fig_importance.update_layout(

        height=500,

        margin=dict(

            l=20,

            r=40,

            t=80,

            b=20

        ),

        xaxis_title="Importance (%)",

        yaxis_title="",

        showlegend=False

    )


    st.plotly_chart(
          fig_importance,
            use_container_width=True
    )


except Exception as e:

    st.warning(
        "Feature importance visualization is unavailable."
    )


# ============================================================
# FOOTER
# ============================================================

st.markdown("---")

st.caption(
    "Employee Attrition Intelligence • "
    "Python • SQL • Power BI • Machine Learning • Streamlit"
)

st.caption(
    "Educational and portfolio project. "
    "Predictions should be validated with organizational data "
    "before being used for real HR decisions."
)

