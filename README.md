# Introduction 
📊Dive into the Data Job Market in 2023! Focusing on Data Scientist roles, this projects explores top-paying jobs, 🔥in-demand skills, and 📈where high demand meets high salary in data scientists.

SQL queries? Check them out here: [project_sql_folder](/Project_SQL/)

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data scientist jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data scientists?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Background
Driven by a quest to navigate the data scientist job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others' work to find optimal jobs.

# Tools I used 
For this project, I leveraged several key tools to analyze the data scientist job market and uncover optimal skills:

*   **SQL:** The backbone of this project, allowing me to query the database and extract critical insights regarding demand and salaries.
*   **PostgreSQL:** The relational database management system chosen to host and organize the job posting data.
*   **pgAdmin 4:** The web-based administration tool used to interact with PostgreSQL, run script testing, and execute my queries.
*   **Git & GitHub Desktop:** Essential for version control, tracking changes across my SQL scripts, and pushing the final repository to GitHub.

# The Analysis 
Each query for this project aimed at investigating specific aspects of the data scientist job market. Here’s how I approached each question:

1. Top Paying Data Scientist Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
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

```
Here's the breakdown of the top data scientist jobs in 2023:
* **Wide Salary Range:** Top 10 paying remote data scientist roles span from $200,000 to $475,000, indicating significant salary potential in the field[cite: 2].
* **Diverse Employers:** Companies like Glocomms, Algo Capital Group, and IBM Careers are among those offering high salaries, showing a broad interest across different industries[cite: 2].
* **Job Title Variety:** There's a clear mix in job titles, from Data Scientist to Senior Data Scientist, reflecting varied roles and specializations within data science[cite: 2].

# What I learned 

# Conclusions 