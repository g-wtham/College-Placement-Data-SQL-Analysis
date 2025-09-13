ALTER TABLE vcet_23 
RENAME COLUMN `Name of student placed  with his/her contact details` TO student_name,
RENAME COLUMN `Programme completed` TO branch,
RENAME COLUMN `Name of the  employer with contact details` TO company_name,
RENAME COLUMN `Pay package at the time of appointment` TO annual_pay;

ALTER TABLE vcet_23 ADD COLUMN salary_decimal DOUBLE;

UPDATE vcet_23 
SET salary_decimal = CAST(REGEXP_REPLACE(annual_pay, '[^0-9.]', '') AS DOUBLE);

-- fix edge cases like 96k salary
UPDATE vcet_23 SET salary_decimal = 0.96 WHERE salary_decimal = 96;

ALTER TABLE vcet_23 ADD COLUMN salary_in_lpa INT;

UPDATE vcet_23 SET salary_in_lpa = salary_decimal * 100000;

CREATE TABLE final_placements_23 AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY MAX(salary_in_lpa) DESC) AS s_no,
    student_name,
    branch,
    company_name,
    MAX(salary_in_lpa) AS salarydetails2
FROM vcet_23
GROUP BY student_name, branch, company_name
ORDER BY salary DESC;

ALTER TABLE final_placements_23 ADD COLUMN salary_range VARCHAR(50);

UPDATE final_placements_23 
SET salary_range = CASE 
    WHEN salary >= 700000 THEN 'ABOVE_7_LPA'
    WHEN salary >= 500000 THEN '5_TO_7_LPA'
    WHEN salary >= 400000 THEN '4_TO_5_LPA'
    WHEN salary >= 300000 THEN '3_TO_4_LPA'
    ELSE 'BELOW_3_LPA'
END;

-- total students placed
SELECT COUNT(student_name) AS total_students FROM final_placements_23;

-- distribution by salary range
SELECT salary_range, COUNT(student_name) AS number_of_students
FROM final_placements_23
GROUP BY salary_range
ORDER BY number_of_students DESC;

-- frequency by exact salary
SELECT salary, COUNT(student_name) AS number_of_students
FROM final_placements_23
GROUP BY salary
ORDER BY number_of_students DESC;
