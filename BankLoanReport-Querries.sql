SELECT *
FROM financial_loan fl 

SELECT COUNT(*)
from financial_loan fl --- total row of data : 38576

ALTER TABLE financial_loan 
ADD COLUMN con_issue_date date; -- added column to fix 'issue date' column


-- converting the date values in the 'issue date' column to a valid date format and adding values into the new column that created
UPDATE financial_loan
SET con_issue_date =
    CASE 
        WHEN issue_date LIKE '__/__/____' THEN DATE(SUBSTR(issue_date, 7, 4) || '-' 
        || SUBSTR(issue_date, 4, 2) || '-' || SUBSTR(issue_date, 1, 2)) -- Converts DD/MM/YYYY to YYYY-MM-DD
        WHEN issue_date LIKE '__-__-____' THEN DATE(SUBSTR(issue_date, 7, 4) 
        || '-' || SUBSTR(issue_date, 4, 2) || '-' || SUBSTR(issue_date, 1, 2)) -- Converts DD-MM-YYYY to YYYY-MM-DD
        WHEN issue_date LIKE '____-__-__' THEN DATE(issue_date) -- Already in YYYY-MM-DD format
        ELSE NULL
    END

ALTER TABLE financial_loan 
DROP COLUMN issue_date; -- dropped ex date column


ALTER TABLE financial_loan 
ADD COLUMN con_last_credit_pull_date date; -- added column to fix 'last_credit_pull_date' column

-- converting the date values in the 'last_credit_pull_date' column to a valid date format and 
--adding values into the new column that created
UPDATE financial_loan
SET con_last_credit_pull_date =
    CASE 
        WHEN last_credit_pull_date LIKE '__/__/____' THEN DATE(SUBSTR(last_credit_pull_date, 7, 4) || '-' || 
        SUBSTR(last_credit_pull_date, 4, 2) || '-' || SUBSTR(last_credit_pull_date, 1, 2)) -- Converts DD/MM/YYYY to YYYY-MM-DD
        WHEN last_credit_pull_date LIKE '__-__-____' THEN DATE(SUBSTR(last_credit_pull_date, 7, 4) || '-' || 
        SUBSTR(last_credit_pull_date, 4, 2) || '-' || SUBSTR(last_credit_pull_date, 1, 2)) -- Converts DD-MM-YYYY to YYYY-MM-DD
        WHEN last_credit_pull_date LIKE '____-__-__' THEN DATE(last_credit_pull_date) -- Already in YYYY-MM-DD format
        ELSE NULL
    END

ALTER TABLE financial_loan 
DROP COLUMN last_credit_pull_date; -- dropped ex date column



ALTER TABLE financial_loan 
ADD COLUMN con_next_payment_date date; -- added column to fix 'next_payment_date' column

-- converting the date values in the 'next_payment_date' column to a valid date format and 
--adding values into the new column that created
UPDATE financial_loan
SET con_next_payment_date =
    CASE 
        WHEN next_payment_date LIKE '__/__/____' THEN DATE(SUBSTR(next_payment_date, 7, 4) || '-' || 
        SUBSTR(next_payment_date, 4, 2) || '-' || SUBSTR(next_payment_date, 1, 2)) -- Converts DD/MM/YYYY to YYYY-MM-DD
        WHEN next_payment_date LIKE '__-__-____' THEN DATE(SUBSTR(next_payment_date, 7, 4) || '-' || 
        SUBSTR(next_payment_date, 4, 2) || '-' || SUBSTR(next_payment_date, 1, 2)) -- Converts DD-MM-YYYY to YYYY-MM-DD
        WHEN next_payment_date LIKE '____-__-__' THEN DATE(next_payment_date) -- Already in YYYY-MM-DD format
        ELSE NULL
    END

ALTER TABLE financial_loan 
DROP COLUMN next_payment_date; -- dropped ex date column


ALTER TABLE financial_loan 
ADD COLUMN con_last_payment_date date; -- added column to fix 'last_payment_date' column

-- converting the date values in the 'last_payment_date' column to a valid date format and 
--adding values into the new column that created
UPDATE financial_loan
SET con_last_payment_date =
    CASE 
        WHEN last_payment_date LIKE '__/__/____' THEN DATE(SUBSTR(last_payment_date, 7, 4) || '-' || 
        SUBSTR(last_payment_date, 4, 2) || '-' || SUBSTR(last_payment_date, 1, 2)) -- Converts DD/MM/YYYY to YYYY-MM-DD
        WHEN last_payment_date LIKE '__-__-____' THEN DATE(SUBSTR(last_payment_date, 7, 4) || '-' || 
        SUBSTR(last_payment_date, 4, 2) || '-' || SUBSTR(last_payment_date, 1, 2)) -- Converts DD-MM-YYYY to YYYY-MM-DD
        WHEN last_payment_date LIKE '____-__-__' THEN DATE(last_payment_date) -- Already in YYYY-MM-DD format
        ELSE NULL
    END

ALTER TABLE financial_loan 
DROP COLUMN last_payment_date; -- dropped ex date column


-- calculating total application recieved
SELECT COUNT(id) AS total_loan_applications
from financial_loan fl --38576

-- calculating MTD (Month to Date) total loan applications
SELECT COUNT(id) AS MTD_total_loan_applications
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '12'
AND strftime('%Y', con_issue_date) = '2021'; --4314

SELECT COUNT(id) AS PMTD_total_loan_applications -- PMTD (Previous Month to Date)
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '11'
AND strftime('%Y', con_issue_date) = '2021'; --4035

--calculating MOM (Month over Month) Total Loan Applications
WITH MTD_app AS(
SELECT cast(COUNT(id) as real) AS MTD_total_loan_applications
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '12'
AND strftime('%Y', con_issue_date) = '2021'
),
PMTD_app AS (
SELECT cast(COUNT(id) as real) AS PMTD_total_loan_applications
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '11'
AND strftime('%Y', con_issue_date) = '2021'
)
SELECT ((MTD.MTD_total_loan_applications - PMTD.PMTD_total_loan_applications)/PMTD.PMTD_total_loan_applications * 100.00)
as MOM_total_loan_applications
FROM MTD_app MTD, PMTD_app PMTD --6.91449814126394


--Calculating total funded amount
SELECT SUM(fl.loan_amount ) as total_funded_amount
FROM financial_loan fl --435757075

--Calculating MTD total loan amount
SELECT  SUM(fl.loan_amount ) as MTD_total_funded_amount
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '12'
AND strftime('%Y', con_issue_date) = '2021'; --53981425

SELECT SUM(fl.loan_amount ) as PMTD_total_funded_amount
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '11'
AND strftime('%Y', con_issue_date) = '2021'; --47754825

--calculating MOM Total Loan Funded
WITH MTD_funded AS(
SELECT cast(SUM(fl.loan_amount ) as real) AS MTD_total_funded_amount
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '12'
AND strftime('%Y', con_issue_date) = '2021'
),
PMTD_funded AS (
SELECT cast(SUM(fl.loan_amount ) as real) AS PMTD_total_funded_amount
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '11'
AND strftime('%Y', con_issue_date) = '2021'
)
SELECT ((MTD.MTD_total_funded_amount - PMTD.PMTD_total_funded_amount)/PMTD.PMTD_total_funded_amount * 100.00)  
as MOM_total_funded_amount
FROM MTD_funded MTD, PMTD_funded PMTD --13.038682478681473


--Calculating total recieved amount
SELECT SUM(fl.total_payment ) as total_recieved_amount
FROM financial_loan fl --473070933

--Calculating MTD total recieved amount
SELECT  SUM(fl.total_payment ) as MTD_total_received_amount
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '12'
AND strftime('%Y', con_issue_date) = '2021'; --58074380

SELECT SUM(fl.total_payment ) as PMTD_total_recieved_amount
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '11'
AND strftime('%Y', con_issue_date) = '2021'; --50132030

--calculating MOM Total Payment Recieved
WITH MTD_recieved AS(
SELECT cast(SUM(fl.total_payment ) as real) AS MTD_total_recieved_amount
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '12'
AND strftime('%Y', con_issue_date) = '2021'
),
PMTD_recieved AS (
SELECT cast(SUM(fl.total_payment ) as real) AS PMTD_total_recieved_amount
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '11'
AND strftime('%Y', con_issue_date) = '2021'
)
SELECT ((MTD.MTD_total_recieved_amount - PMTD.PMTD_total_recieved_amount)/PMTD.PMTD_total_recieved_amount * 100.00)  
as MOM_total_recieved_amount
FROM MTD_recieved MTD, PMTD_recieved PMTD --15.842865329810104


--calculating average interest rate
SELECT AVG(fl.int_rate)*100 as avg_int_rate
FROM financial_loan fl --0.12048831397760265

--Calculating MTD average interest rate
SELECT  AVG(fl.int_rate)*100 as MTD_avg_int_rate
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '12'
AND strftime('%Y', con_issue_date) = '2021'; --12.3560407974038

SELECT AVG(fl.int_rate)*100 as PMTD_avg_int_rate
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '11'
AND strftime('%Y', con_issue_date) = '2021'; --11.94171747211896

--calculating MOM average interest rate
WITH MTD_average AS(
SELECT cast(AVG(fl.int_rate)*100 as real) AS MTD_avg_int_rate
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '12'
AND strftime('%Y', con_issue_date) = '2021'
),
PMTD_average AS (
SELECT cast(AVG(fl.int_rate)*100 as real) AS PMTD_avg_int_rate
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '11'
AND strftime('%Y', con_issue_date) = '2021'
)
SELECT ((MTD.MTD_avg_int_rate - PMTD.PMTD_avg_int_rate)/PMTD.PMTD_avg_int_rate * 100.00)  as MOM_avg_int_rate
FROM MTD_average MTD, PMTD_average PMTD --3.4695455344022816


--calculating average debt to income ratio
SELECT AVG(fl.dti)*100 as avg_dti
FROM financial_loan fl --13.327433119037742

--Calculating MTD debt to income ratio
SELECT  AVG(fl.dti)*100 as MTD_dti
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '12'
AND strftime('%Y', con_issue_date) = '2021'; --13.665537783959202

SELECT AVG(fl.dti)*100 as PMTD_dti
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '11'
AND strftime('%Y', con_issue_date) = '2021'; --13.302733581164809

--calculating MOM debt to income ratio
WITH MTD_dti AS(
SELECT cast(AVG(fl.dti)*100 as real) AS MTD_dti
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '12'
AND strftime('%Y', con_issue_date) = '2021'
),
PMTD_dti AS (
SELECT cast(AVG(fl.dti)*100 as real) AS PMTD_dti
FROM financial_loan fl
WHERE strftime('%m', con_issue_date) = '11'
AND strftime('%Y', con_issue_date) = '2021'
)
SELECT ((MTD.MTD_dti - PMTD.PMTD_dti)/PMTD.PMTD_dti * 100.00)  as MOM_dti
FROM MTD_dti MTD, PMTD_dti PMTD --2.727290602196858


--Good Loan
--calculation good loan application percentage
SELECT (COUNT(
			CASE 
				WHEN fl.loan_status = 'Fully Paid' OR fl.loan_status = 'Current' THEN id
			END)*100)/CAST(COUNT(fl.id) as REAL) as good_loan_percentage
FROM financial_loan fl --86.17534218166736

-- calculation total good loan applications
SELECT COUNT(
			CASE 
				WHEN fl.loan_status = 'Fully Paid' OR fl.loan_status = 'Current' THEN fl.id 
			END) as good_loan_applications
FROM financial_loan fl --33243

--same as
SELECT COUNT(id) as good_loan_applications
FROM financial_loan fl 
WHERE  fl.loan_status = 'Fully Paid' OR fl.loan_status = 'Current'


-- calculation total good loan funding
SELECT SUM(fl.loan_amount)
FROM financial_loan fl 
WHERE  fl.loan_status = 'Fully Paid' OR fl.loan_status = 'Current' --370224850


-- calculation total good loan received amount
SELECT SUM(fl.total_payment)
FROM financial_loan fl 
WHERE  fl.loan_status = 'Fully Paid' OR fl.loan_status = 'Current' --435786170


--Bad Loan
--calculation bad loan application percentage
SELECT (COUNT(
			CASE 
				WHEN fl.loan_status = 'Charged Off' THEN id
			END)*100)/CAST(COUNT(fl.id) as REAL) as bad_loan_percentage
FROM financial_loan fl --13.824657818332643


-- calculation total bad loan applications
SELECT COUNT(CASE 
				WHEN fl.loan_status = 'Charged Off' THEN fl.id 
			END) as bad_loan_applications
FROM financial_loan fl --5333

--same as
SELECT COUNT(id)
FROM financial_loan fl 
WHERE  fl.loan_status = 'Charged Off'


-- calculation total bad loan funding
SELECT SUM(fl.loan_amount)
FROM financial_loan fl 
WHERE  fl.loan_status = 'Charged Off' --65532225


-- calculation total bad loan received amount
SELECT SUM(fl.total_payment)
FROM financial_loan fl 
WHERE  fl.loan_status = 'Charged Off' --37284763

-- calculating bad loan loss
SELECT SUM(fl.loan_amount) - SUM(fl.total_payment) as total_loss
FROM financial_loan fl 
WHERE  fl.loan_status = 'Charged Off' --28247462

-- calculating gain per application from good loans
SELECT ((SUM(fl.total_payment) - SUM(fl.loan_amount))/CAST(COUNT(id) as REAL)) as gain_per_application
FROM financial_loan fl 
WHERE  fl.loan_status = 'Fully Paid' OR fl.loan_status = 'Current' --1972.1842192341244

-- calculating the number of good loan applications to recover loss from bad loans
with total_loss as(
SELECT SUM(fl.loan_amount) - SUM(fl.total_payment) as total_loss
FROM financial_loan fl 
WHERE  fl.loan_status = 'Charged Off' --28247462
),
gain_per_app AS(
SELECT ((SUM(fl.total_payment) - SUM(fl.loan_amount))/CAST(COUNT(id) as REAL)) as gain_per_application
FROM financial_loan fl 
WHERE  fl.loan_status = 'Fully Paid' OR fl.loan_status = 'Current' --1972.1842192341244
)
SELECT tl.total_loss / gpa.gain_per_application
FROM total_loss tl, gain_per_app gpa --14322.9





--calculating loan count, total amount recieved, total funded amoun, interest rate, dti on the bases of loan status
SELECT loan_status,
COUNT(id) as loan_count,
SUM(total_payment) as total_amount_received,
SUM(loan_amount) as total_funded_amount,
AVG(int_rate * 100) as interest_rate,
AVG(dti * 100) as DTI
FROM financial_loan fl 
GROUP BY loan_status 


--calculating  mtd total amount recieved, mtd total funded amount on the bases of loan status
SELECT loan_status,
SUM(total_payment) as MTD_total_amount_recieved,
SUM(loan_amount)  as MTD_total_amount_funded
FROM financial_loan fl 
WHERE strftime('%m', con_issue_date) = '12' AND strftime('%Y', con_issue_date) = '2021'
GROUP BY loan_status


--calculating montly total loan applications, total funded amount and total amount received
--BANK LOAN REPORT | OVERVIEW - Month
WITH data AS(
SELECT CAST(strftime('%m', con_issue_date) as NUMBER) as month_number,
    CASE strftime('%m', con_issue_date)
        WHEN '01' THEN 'January'
        WHEN '02' THEN 'February'
        WHEN '03' THEN 'March'
        WHEN '04' THEN 'April'
        WHEN '05' THEN 'May'
        WHEN '06' THEN 'June'
        WHEN '07' THEN 'July'
        WHEN '08' THEN 'August'
        WHEN '09' THEN 'September'
        WHEN '10' THEN 'October'
        WHEN '11' THEN 'November'
        WHEN '12' THEN 'December'
    END AS month_name, fl.loan_amount, fl.total_payment, fl.id
FROM financial_loan fl)
SELECT d.month_number, d.month_name,
    COUNT(d.id) as total_loan_applications,
    SUM(d.loan_amount) as total_funded_amount,
    SUM(d.total_payment) as total_recieved_amount,
	(CAST(COUNT(d.id) as REAL) / (SELECT COUNT(id) FROM financial_loan fl))*100 as percentage_of_total_applications
FROM data d
GROUP BY d.month_number, d.month_name


--BANK LOAN REPORT | OVERVIEW - State 
SELECT fl.address_state as state, 
COUNT(id)  as total_loan_applications,
SUM(fl.loan_amount)  as total_funded_amount,
SUM(fl.total_payment) as total_recieved_amount,
(CAST(COUNT(id) as REAL) / (SELECT COUNT(id) FROM financial_loan fl))*100 as percentage_of_total_applications
FROM financial_loan fl
GROUP BY fl.address_state 


--BANK LOAN REPORT | OVERVIEW - TERM 
SELECT fl.term as term, 
COUNT(id)  as total_loan_applications,
SUM(fl.loan_amount)  as total_funded_amount,
SUM(fl.total_payment) as total_recieved_amount,
(CAST(COUNT(id) as REAL) / (SELECT COUNT(id) FROM financial_loan fl))*100 as percentage_of_total_applications
FROM financial_loan fl
GROUP BY fl.term



--BANK LOAN REPORT | OVERVIEW - EMPLOYEE LENGHT 
SELECT fl.emp_length as employee_lenght, 
COUNT(id)  as total_loan_applications,
SUM(fl.loan_amount)  as total_funded_amount,
SUM(fl.total_payment) as total_recieved_amount,
(CAST(COUNT(id) as REAL) / (SELECT COUNT(id) FROM financial_loan fl))*100 as percentage_of_total_applications
FROM financial_loan fl
GROUP BY fl.emp_length 


--BANK LOAN REPORT | OVERVIEW - PURPOSE
SELECT fl.purpose as purpose, 
COUNT(id)  as total_loan_applications,
SUM(fl.loan_amount)  as total_funded_amount,
SUM(fl.total_payment) as total_recieved_amount,
(CAST(COUNT(id) as REAL) / (SELECT COUNT(id) FROM financial_loan fl))*100 as percentage_of_total_applications
FROM financial_loan fl
GROUP BY fl.purpose 
order by COUNT(id) DESC 


--BANK LOAN REPORT | OVERVIEW - HOME OWNERSHIP
SELECT fl.home_ownership, 
COUNT(id)  as total_loan_applications,
SUM(fl.loan_amount)  as total_funded_amount,
SUM(fl.total_payment) as total_recieved_amount,
(CAST(COUNT(id) as REAL) / (SELECT COUNT(id) FROM financial_loan fl))*100 as percentage_of_total_applications
FROM financial_loan fl
GROUP BY fl.home_ownership 
order by COUNT(id) DESC 


SELECT *
FROM financial_loan fl 