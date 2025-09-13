SELECT * FROM vcet_data.sece_23;

alter table sece_23 add column student_contact int after student_name;
alter table sece_23 add column hr_email varchar(300) after company_name;
alter table sece_23 add column hr_contact varchar(300) after hr_email;

alter table sece_23 modify student_contact varchar(10);
update sece_23 set student_contact = NULL;

update sece_23 set student_contact = trim(substring_index(student_name, '-', -1));

update sece_23 set student_name = trim(substring_index(student_name, '-', 1));

update sece_23 set hr_contact = trim(substring_index(substring_index(company_name, '-', -1), ' ', -1)); 

SELECT TRIM(
    SUBSTRING_INDEX(              
        SUBSTRING_INDEX(company_name, '-', -1),
        ' ', (LENGTH(SUBSTRING_INDEX(company_name, '-', -1)) - LENGTH(REPLACE(SUBSTRING_INDEX(company_name, '-', -1), ' ', '')))
    )
) AS hr_email
FROM sece_23;

update sece_23 set hr_email =  TRIM(
    SUBSTRING_INDEX(             
        SUBSTRING_INDEX(company_name, '-', -1),
        ' ', (LENGTH(SUBSTRING_INDEX(company_name, '-', -1)) - LENGTH(REPLACE(SUBSTRING_INDEX(company_name, '-', -1), ' ', '')))
    )
);

select trim(substring_index(company_name, '-', 1)) as company_name from sece_23;

update sece_23 set company_name =  trim(substring_index(company_name, '-', 1));

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'sece_23' AND COLUMN_NAME = 'salary';

SET SQL_SAFE_UPDATES = 0;

UPDATE sece_23 SET salary = CAST(REPLACE(salary, ',', '') AS UNSIGNED);

select * from sece_23 order by salary desc;

ALTER TABLE sece_23 MODIFY salary INT UNSIGNED;

SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'sece_23' AND COLUMN_NAME = 'salary';

alter table sece_23 add column salary_range text;

update sece_23 set salary_range = (CASE 
	WHEN salary >= 700000 THEN 'ABOVE_7_LPA'
    WHEN salary >= 500000 THEN '5_TO_7_LPA'
    WHEN salary >= 400000 THEN '4_TO_5_LPA'
    WHEN salary >= 300000 THEN '3_TO_4_LPA'
    ELSE 'BELOW_3_LPA'
    END
);

SELECT salary_range, count(student_name) as number_of_students from sece_23
GROUP BY salary_range ORDER BY number_of_students desc;

select count(student_name) from sece_23;


