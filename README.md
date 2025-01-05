# Bank-Loan-Project
This project offers insights into key bank loan metrics, including applications, funded amounts, repayments, and risk assessment calculated via SQL queries and Tableau. It supports informed decision-making with visualizations of trends, regional data, and borrower profiles with Tableau.

Here is the link of Tableau Dashboard: https://public.tableau.com/views/BankLoanReport_17359976396220/Details?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

Here’s a summary of the what has beed done in SQL Queries:

1.Data Cleaning:
-Adding new columns (con_issue_date, con_last_credit_pull_date, etc.) to standardize date formats.
-Updating the newly added columns to store dates in a consistent format.
-Dropping old columns with invalid or inconsistent formats.
    
2.Loan Application and Funding Analytics:
-Calculating the total number of loan applications and funded amounts.
-Calculating the Month-to-Date (MTD) and Previous Month-to-Date (PMTD) loan applications and funded amounts.
-Analyzing Month-over-Month (MOM) changes in loan applications and funded amounts.

3.Interest Rate and DTI:
-Calculating the average interest rate and DTI (Debt-to-Income ratio) for all loans.
-Analyzing the MTD and PMTD changes in interest rate and DTI.

4.Loan Status Analysis:
-Identifying "good loans" (Fully Paid or Current) and "bad loans" (Charged Off).
-Calculating percentages of good and bad loans, total amounts funded, and received for both categories.
-Analyzing loss from bad loans and calculating the number of good loan applications required to recover that loss.

5.Loan Reports by Various Categories:
-Generating monthly, state-based, term-based, and employee-length-based reports.
-Calculating the total number of loan applications, funded amounts, and total payments received for each category, along with the percentage of total loan applications.

    
Here’s a summary of the what has beed done in Tablea Dashboard:

Key Features:
1.Loan Application Metrics:
-Total Loan Applications: Tracks the total number of loan applications within a specific period, with Month-to-Date (MTD) and Month-over-Month (MoM) comparisons.
-Total Funded Amount: Monitors the total funds disbursed as loans and analyzes MTD and MoM changes.
-Total Amount Received: Tracks loan repayments, with MTD and MoM analysis.
-Average Interest Rate & Debt-to-Income Ratio (DTI): Provides insights into the average interest rates and financial health of borrowers across all loans.

2.Good vs. Bad Loan KPIs:
-Good Loans: Includes loans with 'Fully Paid' or 'Current' status, with KPIs such as the percentage of good loan applications, funded amounts, and total payments received.
-Bad Loans: Focuses on loans with a 'Charged Off' status, tracking the percentage of bad loan applications, funded amounts, and repayments received.

3.Loan Status Overview:
-A grid view categorizing loans by status, displaying important KPIs such as total applications, funded amounts, received amounts, and averages related to interest rates and DTI.

4.Visual Analytics:
-Monthly Trends: Line charts depicting changes in loan applications, funded amounts, and repayments over time.
-Regional Analysis: A filled map visualizing loan data by state, showing regional trends and disparities.
-Loan Term Analysis: A donut chart for loan statistics based on different loan terms.
-Employment Length Impact: Bar charts analyzing loan metrics by employee length categories.
-Loan Purpose Breakdown: Bar charts illustrating loan applications and funded amounts based on different purposes (e.g., debt consolidation).
-Home Ownership Analysis: A tree map displaying loan metrics categorized by home ownership status.

5.Details Dashboard:
-Provides a consolidated view of all essential loan-related data, allowing users to access key insights and borrower information efficiently.
