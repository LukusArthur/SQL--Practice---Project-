-- ADD the specific skills required for those roles 
-- why? Job Seekers Need Information Of the Skills They Have To Have Before Job Hunting For A Specific Roles 


/* Think About This , there might be some jobs that really don't require so using INNER JOIN is much wiser to filter down 
   only the jobs that needs some skills to get in. */



WITH top_paying_jobs AS (
	SELECT 
	c.name AS Company,
	job_postings_fact.job_id,
	job_postings_fact.job_title,
	job_postings_fact.job_location,
	job_postings_fact.job_schedule_type AS job_type,
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
)

SELECT 
	top_paying_jobs.*,
	skills
FROM top_paying_jobs
INNER JOIN skills_job_dim 
	ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
	ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY yearly_salary DESC
LIMIT 10;

-- Here is the Json File Of Overview Of The Top 10 Skills They Are Asking 
/*[
  {
    "company": "Algo Capital Group",
    "job_id": 627602,
    "job_title": "Senior Data Scientist",
    "job_location": "Anywhere",
    "job_type": "Full-time",
    "yearly_salary": 375000.0,
    "skills": "sql"
  },
  {
    "company": "Algo Capital Group",
    "job_id": 627602,
    "job_title": "Senior Data Scientist",
    "job_location": "Anywhere",
    "job_type": "Full-time",
    "yearly_salary": 375000.0,
    "skills": "python"
  },
  {
    "company": "Algo Capital Group",
    "job_id": 627602,
    "job_title": "Senior Data Scientist",
    "job_location": "Anywhere",
    "job_type": "Full-time",
    "yearly_salary": 375000.0,
    "skills": "java"
  },
  {
    "company": "Algo Capital Group",
    "job_id": 627602,
    "job_title": "Senior Data Scientist",
    "job_location": "Anywhere",
    "job_type": "Full-time",
    "yearly_salary": 375000.0,
    "skills": "c++"
  },
  {
    "company": "Algo Capital Group",
    "job_id": 627602,
    "job_title": "Senior Data Scientist",
    "job_location": "Anywhere",
    "job_type": "Full-time",
    "yearly_salary": 375000.0,
    "skills": "cassandra"
  },
  {
    "company": "Algo Capital Group",
    "job_id": 627602,
    "job_title": "Senior Data Scientist",
    "job_location": "Anywhere",
    "job_type": "Full-time",
    "yearly_salary": 375000.0,
    "skills": "spark"
  },
  {
    "company": "Algo Capital Group",
    "job_id": 627602,
    "job_title": "Senior Data Scientist",
    "job_location": "Anywhere",
    "job_type": "Full-time",
    "yearly_salary": 375000.0,
    "skills": "hadoop"
  },
  {
    "company": "Algo Capital Group",
    "job_id": 627602,
    "job_title": "Senior Data Scientist",
    "job_location": "Anywhere",
    "job_type": "Full-time",
    "yearly_salary": 375000.0,
    "skills": "tableau"
  },
  {
    "company": "Algo Capital Group",
    "job_id": 1131472,
    "job_title": "Data Scientist",
    "job_location": "Anywhere",
    "job_type": "Full-time",
    "yearly_salary": 375000.0,
    "skills": "sql"
  },
  {
    "company": "Algo Capital Group",
    "job_id": 1131472,
    "job_title": "Data Scientist",
    "job_location": "Anywhere",
    "job_type": "Full-time",
    "yearly_salary": 375000.0,
    "skills": "python"
  }
]
*/

