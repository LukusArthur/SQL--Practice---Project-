/* Question: What are the top paying jobs analyst jobs? 
	-Identify the top 10 highest_paying Data Analyst roles that we can work remotely worldwide
	-Focuses on job postings with specified salaries( remove nulls )
	-Why ? Hightlight the top_paying opportunities for Data Analyst jobs, offering insights into job_seekers around the world
*/

-- Firstly, we look for any available jobs related with Data Scientist 


SELECT 
	c.name AS Company,
	job_postings_fact.job_title,
	job_postings_fact.job_location,
	job_postings_fact.job_schedule_type AS job_type,
	job_postings_fact.job_posted_date::DATE AS Date,
	job_postings_fact.salary_year_avg AS yearly_salary
FROM job_postings_fact 
LEFT JOIN company_dim AS c
	ON job_postings_fact.company_id = c.company_id
WHERE 
	job_postings_fact.job_title IN ('Data Scientist', 'Senior Data Scientist') AND
    job_postings_fact.job_location = 'Anywhere' AND
	job_postings_fact.salary_year_avg IS NOT NULL AND-- In case there are some internship which does not pay Salary Or Sth
	job_postings_fact.job_schedule_type IS NOT NULL
ORDER BY job_postings_fact.salary_year_avg DESC
LIMIT 10;




