/*How many active Area Sales Managers are currently employed*/

SELECT COUNT(*) AS Active_Area_Sales_Managers
FROM [dbo].[employee_data]
WHERE EmployeeStatus = 'Active' AND Title = 'Area Sales Manager';
/*Which Business Unit has the highest turnover rate based on the Exit Dates*/
SELECT BusinessUnit, 
       COUNT(*) AS Total_Exits,
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM [dbo].[employee_data] WHERE EmployeeStatus = 'Active') AS Turnover_Rate
FROM [dbo].[employee_data]
WHERE EmployeeStatus = 'Future Start'
GROUP BY BusinessUnit
ORDER BY Turnover_Rate DESC;
/*What is the distribution of employees across different email domains*/
SELECT
    RIGHT(ADEmail, LEN(ADEmail) - CHARINDEX('@', ADEmail)) AS EmailDomain,
    COUNT(*) AS EmployeeCount
FROM[dbo].[employee_data]
    
GROUP BY
    RIGHT(ADEmail, LEN(ADEmail) - CHARINDEX('@', ADEmail))
ORDER BY
    EmployeeCount DESC;
/*Are there any patterns in the exit dates of employees who have left the company*/
	SELECT
    YEAR(ExitDate) AS ExitYear,
    MONTH(ExitDate) AS ExitMonth,
    COUNT(*) AS ExitCount
FROM[dbo].[employee_data]
    
WHERE
    ExitDate IS NOT NULL
GROUP BY
    YEAR(ExitDate),
    MONTH(ExitDate)
ORDER BY
    ExitYear, ExitMonth;
/*How many employees are currently active and how many are listed as future starters*/
SELECT
    SUM(CASE WHEN EmployeeStatus = 'Active' THEN 1 ELSE 0 END) AS ActiveEmployees,
    SUM(CASE WHEN EmployeeStatus = 'Future Start' THEN 1 ELSE 0 END) AS FutureStarters
FROM
    [dbo].[employee_data];

/*how many employee has left the company ans reason*/
SELECT
    TerminationType,
    COUNT(*) AS TerminationCount
FROM[dbo].[employee_data]
    
WHERE
    ExitDate IS NOT NULL
GROUP BY
    TerminationType
ORDER BY
    TerminationCount DESC;