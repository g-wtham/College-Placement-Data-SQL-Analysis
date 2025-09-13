# College Placement Data SQL Analysis

SQL scripts designed to clean, transform, and analyze college placement data from various years and institutions. The project focuses on preparing raw placement records for reporting and deriving insights into salary distributions and student placements.

## Project Overview

What the set of SQL files does :
*   Renaming columns for clarity.
*   Casting data types (e.g., converting `annual_pay` from text to numeric).
*   Cleaning string data (removing special characters, extracting contact details, trimming whitespace).
*   Handling inconsistent salary formats (e.g., '96k' vs. '960000').
*   Categorizing numerical data into logical ranges (e.g., 'ABOVE_7_LPA', 'BELOW_3_LPA').
*   Creating aggregated views to count students within specific salary brackets.
*   Generating final, cleaned tables for reporting.

## SQL Operations Demonstrated

The repository includes examples of:

*   **`ALTER TABLE ... RENAME COLUMN`**: For standardizing column names.
*   **`UPDATE ... SET` with `REPLACE`, `CAST`, `REGEXP_REPLACE`**: For cleaning and converting `annual_pay` into a usable numeric format (`annual_pay`, `salary_decimal`, `salary_in_lpa`).
*   **`ALTER TABLE ... MODIFY`**: To change data types after cleaning.
*   **`CASE` statements**: For creating `salary_range` categories based on `annual_pay`.
*   **`ROW_NUMBER() OVER (ORDER BY ...)`**: For adding sequential serial numbers to sorted results.
*   **`GROUP BY` and Aggregate Functions (`COUNT`, `MAX`)**: For summarizing data, such as counting students per salary range or finding the maximum salary for each student.
*   **`CREATE TABLE AS SELECT`**: To create new, cleaned, and summarized tables.
*   String manipulation functions like `SUBSTRING_INDEX`, `LENGTH`, `REPLACE`, `TRIM` for advanced data extraction.

## Data Source :

The scripts process data from several college placement tables (e.g., `kec_raw`, `vcet_23`, `sece_23`, `vcet_24`), for which the data is obtained from official AQAR Reports (5.2.1 Subsection for placement data as excel files) published by the colleges for the year 2022, 2023 and 2024, available on their websites. The CSV Files are imported using MySQL Workbench Table Import Wizard to convert those CSV files to MySQL Tables. 

These tables contain information such as:
*   `student_name` (Name of student placed)
*   `branch` (Programme completed)
*   `company_name` (Name of the employer)
*   `annual_pay` (Pay package at the time of appointment)
*   `student_contact` (Extracted from student name)
*   `hr_email`, `hr_contact` (Extracted from company name)


## How to Use

To use these SQL scripts:

1.  **Database:** These scripts are written for a MySQL-compatible database.
2.  **Schema:** Assume an existing database schema (e.g., `vcet_data`) and initial raw tables (e.g., `kec_raw`, `vcet_23`, `sece_23`, `vcet_24`) with the original column names as inferred from the `RENAME` statements.
3.  **Execution:** Run the SQL statements sequentially. Ensure you understand each step, especially the `SET SQL_SAFE_UPDATES = 0;` and `SET SQL_SAFE_UPDATES = 1;` commands, which disable/enable safe update mode respectively.

## Derived Insights

After running the scripts, you can obtain insights such as:

*   Total number of students placed.
*   Distribution of students across different salary ranges (e.g., how many students received offers `ABOVE_7_LPA`, `5_TO_7_LPA`, etc.).
*   Top placed students by salary.
*   Company-wise placement counts.
*   Branch-wise salary statistics.

## Final Tables Created

The scripts ultimately lead to cleaned and structured tables like:
*   `kec_22`
*   `vcet_23`
*   `vcet_24`
*   `sece_23`
