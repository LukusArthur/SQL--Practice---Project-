# Introduction 
📊Dive into the Data Job Market in 2023! Focusing on Data Scientist roles, this projects explores top-paying jobs, 🔥in-demand skills, and 📈where high demand meets high salary in data scientists.

SQL queries? Check them out here: [project_sql_folder](/Project_SQL/)

Here is the Data SourceFiles
[Click Here to View the Project Data Source Folder](https://drive.google.com/drive/folders/1yJokNeAcqdvfOCw-sYrGzIlDY_ZxNVxe?usp=drive_link)

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
* **Wide Salary Range:** Top 10 paying remote data scientist roles span from $200,000 to $475,000, indicating significant salary potential in the field.
* **Diverse Employers:** Companies like Glocomms, Algo Capital Group, and IBM Careers are among those offering high salaries, showing a broad interest across different industries.
* **Job Title Variety:** There's a clear mix in job titles, from Data Scientist to Senior Data Scientist, reflecting varied roles and specializations within data science.


### 2.  Skills for Top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
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
LIMIT 25;
```

### Visualizing Top Paying Skills
Below is the data visualization capturing the exact skill frequency distribution across these top-tier, high-compensation roles:

![Skill Count for Top-Paying Data Scientist Jobs In 2023](/assets/Skills_Count.png)

Here's the breakdown of the most demanded skills for the top-paying data scientist jobs in 2023:
* **SQL** is leading with a bold count of **4**.
* **Python**, **Java**, **Cassandra**, **Spark**, **Hadoop**, and **Tableau** follow closely, each with a bold count of **3**.
* Other specialized skills like **C++**, **AWS**, and **Airflow** show precise individual counts of **1**, representing targeted infra additions to core science platforms.

3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT 
	skills_dim.skills,
	COUNT(job_postings_fact.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim 
	ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
	ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title IN ('Data Scientist', 'Senior Data Scientist', 'Machine Learning Engineer') 
AND job_work_from_home = True
GROUP BY skills_dim.skills
ORDER BY demand_count DESC
LIMIT 5;
```
Here's the breakdown of the most demanded skills for data scientists in 2023:
- Python and SQL remain fundamental, emphasizing the need for strong foundational skills in data processing and database manipulation.
- Statistical Modeling and Cloud Infrastructure like R, AWS, and Spark are essential, pointing towards the increasing importance of technical skills in scalable computing and advanced analytics.


###  3. In-Demand Skills for Data Scientists

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT 
	skills_dim.skills,
	COUNT(job_postings_fact.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim 
	ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
	ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title IN ('Data Scientist', 'Senior Data Scientist', 'Machine Learning Engineer') 
AND job_work_from_home = True
GROUP BY skills_dim.skills
ORDER BY demand_count DESC
LIMIT 5;
```

| Skills | Demand Count |
|---|---|
| python | 4077 |
| sql | 2730 |
| r | 1649 |
| aws | 1226 |
| spark | 905 |

*Table of the demand for the top 5 skills in data scientist job postings*

### 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
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
```

| Skills | Avg. Salary ($) |
|---|---|
| watson | 222,132 |
| cassandra | 198,875 |
| php | 183,333 |
| crystal | 183,310 |
| neo4j | 182,324 |
| html | 181,250 |
| unify | 175,000 |
| zoom | 175,000 |
| powerpoint | 171,200 |
| dynamodb | 167,500 |

*Table of the average salary for the top 10 highest paying skills in data scientist job postings*

## 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql

SELECT 
	skills_dim.skill_id,
	skills_dim.skills AS skill_name,
	COUNT(skills_job_dim.job_id) AS demand_count,
	ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim 
	ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
	ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title IN ('Data Scientist', 'Senior Data Scientist') AND
	job_postings_fact.salary_year_avg IS NOT NULL AND 
	job_work_from_home = True
GROUP BY 
	skills_dim.skill_id
HAVING
	COUNT(skills_job_dim.job_id) > 10
ORDER BY avg_salary DESC,
		 demand_count DESC
LIMIT 25;
```

| Skills | Demand Count | Avg. Salary ($) |
|---|---|---|
| java | 35 | 155,352 |
| airflow | 17 | 152,649 |
| matplotlib | 11 | 150,721 |
| c | 15 | 147,510 |
| numpy | 34 | 146,758 |
| spark | 74 | 146,056 |
| scala | 27 | 144,572 |
| databricks | 20 | 144,466 |
| nosql | 20 | 142,461 |
| pandas | 52 | 142,186 |

*Table of the most optimal skills for data scientist job postings (high demand and high salary)*

Here's a breakdown of the most optimal skills for Data Scientists in 2023:
- High-Demand Programming Languages: Python and SQL stand out for their high demand, with demand counts of 323 and 261 respectively. Despite their high demand, their average salaries are around $135,875 for Python and $134,993 for SQL, indicating that proficiency in these languages is highly valued but also widely available as core foundations.
- Cloud Tools and Technologies: Skills in specialized technologies such as AWS, Spark, Hadoop, and Snowflake show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis at scale.
- Business Intelligence and Visualization Tools: Tableau, with a demand count of 85 and an average salary around $139,855, highlights the critical role of data visualization and business intelligence in deriving actionable insights from data.
Database Technologies: The demand for skills in traditional and NoSQL databases (NoSQL) with an average salary of $142,461, reflects the enduring need for data storage, retrieval, and management expertise.
# What I learned 
Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

🧩 Complex Query Crafting: Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.

📊 Data Aggregation: Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.

💡 Analytical Wizardry: Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions 

### Insights

From the analysis, several general insights emerged:

1. **Top-Paying Data Scientist Jobs**: The highest-paying jobs for data scientists that allow remote work offer a wide range of salaries, the highest at $375,000!
2. **Skills for Top-Paying Jobs**: High-paying data scientist jobs require advanced proficiency across a diverse tech stack, heavily featuring SQL, Python, and big data tools (Spark, Hadoop, Cassandra), suggesting they are critical skills for earning a top salary.
3. **Most In-Demand Skills**: Python is the most demanded skill in the data scientist job market, closely followed by SQL, making them absolutely essential for job seekers.
4. **Skills with Higher Salaries**: Specialized and niche tools, such as Watson and Cassandra, are associated with the highest average salaries, indicating a premium on specialized architecture and AI expertise.
5. **Optimal Skills for Job Market Value**: Python and SQL lead heavily in demand while offering high average salaries (around $135,000+), positioning them as some of the most optimal skills for data scientists to learn to maximize their market value.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data science job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data scientists can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data science and machine learning.


