/*
	The HR Department want to gather several KPIs
	1. Total Employees	- Expected 1470 (Passed)
	2. Attrition Count	- Expected 237 (Passed)
	3. Attrition Rate	- Expected 16% (Passed)
	4. Active Employees	- Expected 1233 (Passed)
	5. Average Age		- Expected 37 (Passed)
*/

SELECT
	emp_no,
    gender,
    marital_status,
    age_band,
    age,
	department,
    education,
    education_field,
    job_role,
    business_travel,
    employee_count,
    attrition,
    attrition_label,
    job_satisfaction,
    active_employee
FROM hrdata;

-- 1. Total employees
SELECT
	COUNT(emp_no) AS [Total Employees]
FROM hrdata;

-- 2. Attrition count
SELECT
	COUNT(active_employee) AS [Attrition Count]
FROM hrdata
WHERE active_employee = 0;

-- 3. Attrition Rate
SELECT 
    ROUND(
        (CAST(COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) AS FLOAT) / 
        (SELECT COUNT(*) FROM hrdata)) * 100, 
    2) AS [Attrition Rate %]
FROM hrdata;

-- 4. Active Employees
SELECT
	COUNT(active_employee) AS [Active Employee]
FROM hrdata
WHERE active_employee = 1;

-- 5. Average Age
SELECT
	ROUND(AVG(age),0) AS [Average Age]
FROM hrdata;

/*
	The HR team wants the dashboard to show several insights:
	1. Attrition per Department - (Passed)
	2. Number of Employees per Age Group - (Passed)
	3. Attrition per Education Field - (Passed)
	4. Attrition Count by Gender per Age Group - (Passed)
*/

-- 1. Attrition per Department
SELECT
	department,
	COUNT(active_employee) AS [Attrition Count]
FROM hrdata
WHERE active_employee = 0
GROUP BY department;

-- 2. Number of Employees per Age Group
SELECT
	age_band,
	COUNT(emp_no) AS [No. of Employees]
FROM hrdata
GROUP BY age_band
ORDER BY age_band DESC;

-- 3. Attrition per Education Field
SELECT
	education_field,
	COUNT(active_employee) AS [Attrition Count]
FROM hrdata
WHERE active_employee = 0
GROUP BY education_field
ORDER BY [Attrition Count] DESC;

-- 4. Attrition Count by Gender per Age Group
SELECT
	gender,
	age_band,
	COUNT(active_employee) AS [Attrition Count]
FROM hrdata
WHERE active_employee = 0
GROUP BY gender, age_band
ORDER BY age_band DESC;
