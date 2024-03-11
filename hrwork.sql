USE system;
select * from hrdata;


--with cte as
--(
--select * , rank() over(partition by gender,marital_status,age_band,age,department,education,education_field,job_role,business_travel,attrition,attrition_label
--,job_satisfaction,active_employee order by emp_no) as duplicated
--from hrdata
--)
--select * from cte
--where duplicated > 1
--order by age;


// --------------------------------------------------------------- --------------------------------------------------------------- //
// --------------------------------------------------------------- --------------------------------------------------------------- //
-------------------------------------------------- GET All KPIS REQUIREMENTS --------------------------------------------------
// ---------------------------------------------------------------  --------------------------------------------------------------- //
// ---------------------------------------------------------------  --------------------------------------------------------------- //


-- Employee Count
select count(emp_no) from hrdata; -- 1470

-- Attrition Count
select count(attrition) from hrdata
where attrition = 1; -- 237

-- Attrition Rate
select 1/(cast(count(attrition) as float)/(select count(attrition) from hrdata where attrition = 1))*100
from hrdata; -- 16.12

select * from hrdata

-- Attrition Rate  -- 16.12 --
select round((select count(attrition) from hrdata where attrition = 1)*100/cast(count(attrition) as float),2) as attrion_rate from hrdata; 


-- Active Employee
select count(attrition)
from hrdata
where attrition = 0; -- 1233

-- Avg Age
select avg(age) from hrdata; -- 36

select * from hrdata;

-- Attrition By Gender
select gender, count(attrition) count
from hrdata
where attrition = 1
group by gender;   -- Male: 150  ,  Female: 87

-- Department By Attrition
select department, count(attrition)
from hrdata
where attrition = 1
group by department; -- HR: 12  ,  R&D: 133  ,  Sales: 92


--select count(attrition) from hrdata where attrition = 1;-- 237

select department, count(attrition) as attrition_count, round(cast(count(attrition) as float)/(select count(attrition) from hrdata where attrition = 1),4)*100 as PCT
from hrdata
where attrition = 1
group by department
order by attrition_count desc;


-- No of Employees By Age Group
select age_band, count(emp_no)
from hrdata
group by age_band;

-- Education Field By Attrition
select attrition, education_field, count(education_field) as count
from hrdata
where attrition = 1
group by attrition, education_field
order by count desc;

-- Attrition Rate By Gender and Age Group
select gender, age_band, count(attrition), count(attrition)/(select cast(count(attrition) as float) from hrdata where attrition = 1)*100
from hrdata
where attrition = 1
group by gender, age_band
order by age_band;


-- Job Role & Job Satisfaction
--select * from hrdata
--select distinct Job_Role from hrdata

select job_role, Job_Satisfaction, count(emp_no)
from hrdata
group by job_role, Job_Satisfaction
order by job_role, Job_Satisfaction;