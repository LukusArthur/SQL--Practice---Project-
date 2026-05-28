/* Now We Want To Focus On How Companies Are Willing To Pay high Salary For Certain Type Of Skill*/

/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Scientist positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Scientists and
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
	skills_dim.skills,
	ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim 
	ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
	ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title IN ('Data Scientist', 'Senior Data Scientist') AND
	job_postings_fact.salary_year_avg IS NOT NULL AND 
	job_work_from_home = True
GROUP BY skills_dim.skills
ORDER BY avg_salary DESC
LIMIT 25;


-- Here is the breakdown of the skills and their average salary & Some keyinsights into it
/* [
  {
    "skills": "watson",
    "avg_salary": 222132
  },
  {
    "skills": "cassandra",
    "avg_salary": 198875
  },
  {
    "skills": "php",
    "avg_salary": 183333
  },
  {
    "skills": "crystal",
    "avg_salary": 183310
  },
  {
    "skills": "neo4j",
    "avg_salary": 182324
  },
  {
    "skills": "html",
    "avg_salary": 181250
  },
  {
    "skills": "unify",
    "avg_salary": 175000
  },
  {
    "skills": "zoom",
    "avg_salary": 175000
  },
  {
    "skills": "powerpoint",
    "avg_salary": 171200
  },
  {
    "skills": "dynamodb",
    "avg_salary": 167500
  },
  {
    "skills": "rust",
    "avg_salary": 166000
  },
  {
    "skills": "sap",
    "avg_salary": 161780
  },
  {
    "skills": "julia",
    "avg_salary": 157500
  },
  {
    "skills": "node.js",
    "avg_salary": 156107
  },
  {
    "skills": "vue",
    "avg_salary": 156107
  },
  {
    "skills": "java",
    "avg_salary": 155352
  },
  {
    "skills": "aurora",
    "avg_salary": 155000
  },
  {
    "skills": "ruby",
    "avg_salary": 154500
  },
  {
    "skills": "windows",
    "avg_salary": 153411
  },
  {
    "skills": "airflow",
    "avg_salary": 152649
  },
  {
    "skills": "mongodb",
    "avg_salary": 151708
  },
  {
    "skills": "matplotlib",
    "avg_salary": 150721
  },
  {
    "skills": "linux",
    "avg_salary": 149938
  },
  {
    "skills": "hugging face",
    "avg_salary": 148487
  },
  {
    "skills": "seaborn",
    "avg_salary": 148311
  }

Specialized AI/database tools such as IBM Watson and Cassandra show extremely high salary averages, suggesting niche expertise is highly rewarded in the market.
Some non-technical tools like HTML, Zoom, and PowerPoint appear with inflated salaries because they were included in a few executive-level or senior roles, creating outlier distortion in the data.
Core data science tools including Airflow, Matplotlib, and Seaborn consistently stay within a stable salary range, highlighting their importance as foundational industry skills.
  
] */

