

-- What is the distribution of loan applicants based on gender?

SELECT Gender, COUNT(*) AS Count
FROM loan
GROUP BY Gender;



-- How does the marital status affect loan approval rates?

SELECT Married, Loan_Status, COUNT(*) AS Count
FROM loan
GROUP BY Married, Loan_Status;


-- What is the average income of loan applicants?


SELECT AVG(ApplicantIncome) AS AverageIncome
FROM loan;


-- Is there any relationship between the number of dependents and loan approval?

SELECT Dependents, Loan_Status, COUNT(*) AS Count
FROM loan
GROUP BY Dependents, Loan_Status;


-- How does education level impact the loan amount requested?

SELECT Education, AVG(LoanAmount) AS AverageLoanAmount
FROM loan
GROUP BY Education;



-- Are self-employed applicants more or less likely to get their loans approved?


SELECT Self_Employed, Loan_Status, COUNT(*) AS Count
FROM loan
GROUP BY Self_Employed, Loan_Status;


-- What are the most common property areas for loan applicants?

SELECT Property_Area, COUNT(*) AS Count
FROM loan
GROUP BY Property_Area
ORDER BY Count DESC;


-- What is the average loan amount and loan term for approved and rejected applications?

SELECT Loan_Status, AVG(LoanAmount) AS AverageLoanAmount, AVG(Loan_Amount_Term) AS AverageLoanTerm
FROM loan
GROUP BY Loan_Status;


-- How does credit history influence the chances of loan approval?

SELECT Credit_History, Loan_Status, COUNT(*) AS Count
FROM loan
GROUP BY Credit_History, Loan_Status;


-- Are there any patterns in the loan status based on the applicant's income and coapplicant's income?


SELECT ApplicantIncome, CoapplicantIncome, Loan_Status
FROM loan;




-- ** five intermediate-level questions along with their SQL queries ** 


-- What is the average loan amount for each combination of "Property_Area" and "Education"?


SELECT Property_Area, Education, AVG(LoanAmount) AS AverageLoanAmount
FROM loan
GROUP BY Property_Area, Education;



-- What is the percentage of approved loans for each "Dependents" category?

SELECT Dependents, 
       SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS Approved_Count,
       COUNT(*) AS Total_Count,
       (SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*) * 100) AS Approval_Percentage
FROM loan
GROUP BY Dependents;




-- What are the top 5 loan applicants with the highest total income (ApplicantIncome + CoapplicantIncome)?

SELECT Loan_ID, 
       ApplicantIncome + CoapplicantIncome AS TotalIncome
FROM loan
ORDER BY TotalIncome DESC
LIMIT 5;


-- How does the loan approval rate vary for different loan amount terms (Loan_Amount_Term)?

SELECT Loan_Amount_Term,
       SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS Approved_Count,
       COUNT(*) AS Total_Count,
       (SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*) * 100) AS Approval_Percentage
FROM loan
GROUP BY Loan_Amount_Term;





-- What is the average loan amount for each combination of "Property_Area" and "Married" status, but only for those with a credit history (Credit_History = 1)?

SELECT Property_Area, Married, AVG(LoanAmount) AS AverageLoanAmount
FROM loan
WHERE Credit_History = 1
GROUP BY Property_Area, Married;






-- What is the average loan amount requested by self-employed individuals compared to those who are not self-employed?


SELECT Self_Employed, AVG(LoanAmount) AS AverageLoanAmount
FROM loan
GROUP BY Self_Employed;




-- How does the loan approval rate vary for each combination of "Education" and "Property_Area"?


SELECT Education, Property_Area, 
       SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS Approved_Count,
       COUNT(*) AS Total_Count,
       (SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*) * 100) AS Approval_Percentage
FROM loan
GROUP BY Education, Property_Area;



-- What are the top 5 loan applicants with the highest debt-to-income ratio (LoanAmount divided by TotalIncome)?

SELECT Loan_ID, 
       LoanAmount / (ApplicantIncome + CoapplicantIncome) AS DebtToIncomeRatio
FROM loan
ORDER BY DebtToIncomeRatio DESC
LIMIT 5;



-- For each "Dependents" category, what is the average loan amount requested by individuals with a credit history
--  (Credit_History = 1)?

SELECT Dependents, AVG(LoanAmount) AS AverageLoanAmount
FROM loan
WHERE Credit_History = 1
GROUP BY Dependents;



-- What is the percentage of approved loans for each "Married" status, 
-- considering only those with a credit history (Credit_History = 1)? 


SELECT Married, 
       SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS Approved_Count,
       COUNT(*) AS Total_Count,
       (SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*) * 100) AS Approval_Percentage
FROM loan
WHERE Credit_History = 1
GROUP BY Married;



-- How does the loan approval rate vary for different loan terms (Loan_Amount_Term), 
-- considering only those with a credit history (Credit_History = 1)? 


SELECT Loan_Amount_Term,
       SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS Approved_Count,
       COUNT(*) AS Total_Count,
       (SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*) * 100) AS Approval_Percentage
FROM loan
WHERE Credit_History = 1
GROUP BY Loan_Amount_Term;



--  What is the average loan amount requested by individuals with different levels of education,
--  considering only those with a credit history (Credit_History = 1) and a loan term of 360 months? 


SELECT Education, AVG(LoanAmount) AS AverageLoanAmount
FROM loan
WHERE Credit_History = 1 AND Loan_Amount_Term = 360
GROUP BY Education;




-- How does the loan approval rate vary for each "Dependents" category among individuals
-- with different levels of education,considering only those with a credit history (Credit_History = 1)? 



SELECT Dependents, Education,
       SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END) AS Approved_Count,
       COUNT(*) AS Total_Count,
       (SUM(CASE WHEN Loan_Status = 'Y' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*) * 100) AS Approval_Percentage
FROM loan
WHERE Credit_History = 1
GROUP BY Dependents, Education;
