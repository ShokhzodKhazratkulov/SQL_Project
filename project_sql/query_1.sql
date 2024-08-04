/*SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category
*/
-- SELECT 
--     COUNT(job_id),
--     CASE
--         WHEN salary_year_avg > 120000 THEN 'high'
--         WHEN salary_year_avg > 85000 THEN 'standard'
--         ELSE 'low'
--     END AS salary_rates
-- FROM job_postings_fact
-- WHERE job_title_short = 'Data Analyst'
-- GROUP BY salary_rates
-- ORDER BY salary_rates DESC;

-- SELECT *
-- FROM (
--     SELECT * FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) = 4
-- ) AS april_jobs;

-- WITH may_jobs AS (
--     SELECT * 
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) = 5
-- )


-- SELECT name AS company_name
-- FROM company_dim
-- WHERE company_id IN (
--     SELECT
--     company_id
--     FROM job_postings_fact
--     WHERE job_no_degree_mention = TRUE
-- )

-- WITH job_count_id AS(
--     SELECT
--         company_id,
--         COUNT(*) AS total_job_count
--     FROM 
--         job_postings_fact
--     GROUP BY
--         company_id  
-- )

-- SELECT 
--     company_dim.name AS company_name,
--     job_count_id.total_job_count
-- FROM company_dim
-- LEFT JOIN job_count_id ON job_count_id.company_id = company_dim.company_id


-- WITH top_skills AS( --ichki query yaratish
--     SELECT
--         skill_id,   --skill_id olindi gruhlash uchun va tekshirish uchun
--         COUNT(*) AS skill_count --skills hisoblandi
--     FROM skills_job_dim         --qayerdan olish kerakligi
--     GROUP BY skill_id          --id orqali gruhlab oldim
--     ORDER BY skill_count DESC  -- orqadan hisoblab chiqadi
--     LIMIT 5                    --beshtasini oladi shunda toplar qoladi
-- )
-- SELECT                       --outer query
--     skill.skill_id,    --skills_dim dan skill_id ni ovolamiz
--     skill.skills,      --skills_dim dan skill nomini olindi
--     top_skills.skill_count  --ichki query dan skill_count ni chiqaramiz
-- FROM top_skills             -- qaysi table ligi
-- LEFT JOIN skills_dim AS skill ON top_skills.skill_id = skill.skill_id
-- --left join skill_dim ni skill nomi ostida olib inner query table ga biriktir

-- -- Subquery to calculate total job postings per company
-- WITH JobCounts AS (
--     SELECT 
--         company_id, 
--         COUNT(*) AS job_count
--     FROM 
--         job_postings_fact
--     GROUP BY 
--         company_id
-- )

-- -- Classify companies based on job_count
-- SELECT 
--     company_id, 
--     job_count,
--     CASE
--         WHEN job_count < 10 THEN 'Small'
--         WHEN job_count BETWEEN 10 AND 50 THEN 'Medium'
--         ELSE 'Large'
--     END AS size_category
-- FROM 
--     JobCounts
-- ORDER BY 
--     company_id;


-- WITH remote_job_skills AS (
--     SELECT
--         skill_id,
--         COUNT(*) AS skills_count
--     FROM skills_job_dim AS skills_to_job
--     INNER JOIN job_postings_fact AS job_postings 
--     ON job_postings.job_id = skills_to_job.job_id 
--     WHERE 
--         job_postings.job_work_from_home = TRUE AND
--         job_postings.job_title_short = 'Data Analyst'
--     GROUP BY 
--         skill_id
-- )

-- SELECT
--     skills.skill_id,
--     skills AS skill_name,
--     skills_count
-- FROM remote_job_skills
-- INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
-- ORDER BY
--     skills_count DESC
-- LIMIT 5;


-- SELECT
--     job_title_short,
--     company_id,
--     job_location
-- FROM january_jobs
-- UNION ALL
-- SELECT
--     job_title_short,
--     company_id,
--     job_location
-- FROM february_jobs
-- UNION ALL
-- SELECT
--     job_title_short,
--     company_id,
--     job_location
-- FROM march_jobs

-- WITH skill AS(
--     SELECT
--         skills_to_job.skill_id,
--         skills,
--         type 
--     FROM skills_dim
--     INNER JOIN skills_job_dim AS skills_to_job ON skills_to_job.skill_id = skills_dim.skill_id
    
-- )
-- SELECT
--     skill_id
-- FROM skill
-- INNER JOIN job_postings_fact AS job_postings ON skill.job_id = jon_postings.job_id
-- WHERE
--     job_postings.salary_year_avg > 70000

-- Get jobs in Q1 with a salary greater than $70,000 along with their skills and skill types
-- SELECT 
--     jp.job_id, 
--     jp.salary_year_avg, 
--     s.skills, 
--     s.type
-- FROM job_postings_fact AS jp
-- LEFT JOIN skills_job_dim AS sj ON jp.job_id = sj.job_id
-- LEFT JOIN skills_dim AS s ON sj.skill_id = s.skill_id
-- WHERE 
--     EXTRACT(MONTH FROM jp.job_posted_date) IN (1, 2, 3)
--     AND jp.salary_year_avg > 70000

-- UNION ALL

-- -- Include jobs in Q1 with a salary greater than $70,000 that do not have any skills
-- SELECT 
--     jp.job_id, 
--     jp.salary_year_avg, 
--     NULL AS skills, 
--     NULL AS type
-- FROM job_postings_fact AS jp
-- LEFT JOIN skills_job_dim AS sj ON jp.job_id = sj.job_id
-- WHERE 
--     sj.job_id IS NULL
--     AND EXTRACT(MONTH FROM jp.job_posted_date) IN (1, 2, 3)
--     AND jp.salary_year_avg > 70000
-- ORDER BY 
--     jp.job_id;

-- SELECT
--     quarter_job_salary.job_title_short,
--     quarter_job_salary.job_location,
--     quarter_job_salary.job_posted_date::DATE,
--     quarter_job_salary.salary_year_avg
-- FROM(
--     SELECT *
--     FROM january_jobs
--     UNION ALL
--     SELECT *
--     FROM february_jobs
--     UNION ALL
--     SELECT *
--     FROM march_jobs
-- ) AS quarter_job_salary
-- WHERE
--     quarter_job_salary.salary_year_avg > 70000 AND
--     quarter_job_salary.job_title_short = 'Data Analyst'
-- ORDER BY
--     salary_year_avg DESC


