SELECT * from kec_raw;

alter table kec_raw
RENAME COLUMN `Name of student placed  with his/her contact details` TO student_name,
RENAME COLUMN `Programme completed` TO branch,
RENAME COLUMN `Name of the  employer with contact details` TO company_name,
RENAME COLUMN `Pay package at the time of appointment` TO annual_pay;

UPDATE kec_raw SET annual_pay = CAST(REPLACE(annual_pay, ',', '') AS UNSIGNED);
ALTER TABLE kec_raw MODIFY annual_pay INT UNSIGNED;

SELECT  DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'kec_raw' AND COLUMN_NAME = 'annual_pay';

SELECT * from kec_raw order by annual_pay desc;

Alter table kec_raw add column salary_range text;

update kec_raw set salary_range = (
	CASE
		WHEN annual_pay >= 700000 THEN 'ABOVE_7_LPA'
		WHEN annual_pay >= 500000 THEN '5_TO_7_LPA'
		WHEN annual_pay >= 400000 THEN '4_TO_5_LPA'
		WHEN annual_pay >= 300000 THEN '3_TO_4_LPA'
		ELSE 'BELOW_3_LPA'
    END
);

SELECT * from kec_raw;

-- check if serial number is added correctly and create the final table

SELECT 
	ROW_NUMBER() over (order by annual_pay desc) as s_no,
    student_name,
    branch,
    company_name,
    annual_pay,
    salary_range
from kec_raw GROUP BY student_name, branch, company_name, annual_pay, salary_range
ORDER BY annual_pay desc;

SELECT 
	ROW_NUMBER() over (order by annual_pay desc) as s_no,
    student_name,
    branch,
    company_name,
    annual_pay,
    salary_range
from kec_raw GROUP BY student_name, branch, company_name, annual_pay, salary_range
ORDER BY annual_pay desc;

create table kec_22 as 
SELECT 
	ROW_NUMBER() over (order by annual_pay desc) as s_no,
    student_name,
    branch,
    company_name,
    annual_pay,
    salary_range
from kec_raw GROUP BY student_name, branch, company_name, annual_pay, salary_range
ORDER BY annual_pay desc;

select count(*) as total_placed_students from kec_22;

select salary_range, count(student_name) as number_of_students FROM kec_22 group by salary_range order by number_of_students desc;
