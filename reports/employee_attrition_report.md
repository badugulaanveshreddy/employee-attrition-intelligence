# Employee Attrition Intelligence — Analysis Report

## 1. Executive Summary

This project analyzes employee attrition using the IBM HR Employee Attrition dataset. The objective is to identify major factors associated with employee turnover and provide actionable insights for employee-retention strategies.

The dataset contains **1,470 employees**. **237 employees left**, giving an overall attrition rate of **16.12%**, while **1,233 employees stayed**.

### Key findings
- Overall employee attrition is **16.12%**.
- **Sales** has the highest department attrition rate at **20.63%**.
- **Human Resources** follows at **19.05%**.
- **Research & Development** has the lowest department attrition rate at **13.84%**.
- Employees working **overtime** have a much higher attrition rate (**30.53%**) than employees who do not work overtime (**10.44%**).
- Attrition varies considerably by job role, indicating that retention measures should be targeted rather than identical across all roles.

## 2. Dataset Overview

| Metric | Value |
|---|---:|
| Total employees | 1,470 |
| Employees who left | 237 |
| Employees who stayed | 1,233 |
| Overall attrition rate | 16.12% |

## 3. Department-wise Attrition

| Department | Attrition rate |
|---|---:|
| Sales | 20.63% |
| Human Resources | 19.05% |
| Research & Development | 13.84% |

Sales and Human Resources show higher turnover than Research & Development. This suggests that retention strategies should prioritize departments with elevated attrition.

## 4. Overtime Analysis

| Overtime | Attrition rate |
|---|---:|
| Yes | 30.53% |
| No | 10.44% |

The attrition rate among employees working overtime is approximately three times the rate among employees not working overtime. Overtime is therefore one of the strongest patterns identified in this analysis.

This does not by itself prove that overtime causes attrition; further investigation should consider workload, compensation, job role, work-life balance and other employee characteristics.

## 5. Job-role Analysis

The analysis shows substantial variation in attrition across job roles. Sales Representatives show the highest observed job-role attrition rate, while several managerial and specialist roles have considerably lower rates.

This indicates that retention programs should consider job-role-specific factors such as workload, career progression, compensation, job satisfaction and working hours.

## 6. Salary Analysis

Average salary was compared across departments and job roles. The analysis shows differences in average compensation between departments and roles.

Salary should therefore be considered together with attrition rather than treated as an isolated factor. Compensation benchmarking, promotion opportunities and career progression can be used to investigate whether high-turnover groups are also experiencing compensation or growth concerns.

## 7. Business Recommendations

1. **Reduce excessive overtime** by monitoring workload and staffing levels.
2. **Prioritize Sales and HR retention programs** because these departments have relatively higher attrition.
3. **Investigate high-risk job roles** and identify role-specific causes of turnover.
4. **Strengthen career-development programs** through training, promotion pathways and internal mobility.
5. **Review compensation and incentives** for high-turnover roles.
6. **Monitor employee satisfaction and work-life balance** regularly.
7. **Use predictive attrition modeling** to identify employees or employee profiles with elevated attrition risk.

## 8. Project Deliverables

- Exploratory data analysis notebook
- Department-wise attrition analysis
- Job-role attrition analysis
- Overtime analysis
- Salary analysis
- Power BI Employee Attrition Intelligence dashboard
- Machine-learning model and label encoders
- Streamlit application
- SQL scripts and database analysis

## 9. Conclusion

The analysis demonstrates that employee attrition is not evenly distributed across the organization. Department, job role and overtime status show meaningful differences in observed attrition rates.

The strongest pattern is the difference between overtime and non-overtime employees, while Sales and Human Resources also require attention. These findings can help HR teams design targeted retention strategies instead of applying the same approach to every employee group.
