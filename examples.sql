SELECT * FROM sql_hr.employees;
SELECT 
    e.employee_id, e.first_name, e.last_name, e.salary, o.city
FROM
    employees e
        JOIN
    offices o ON e.office_id = o.office_id;
SELECT 
    e.employee_id, e.first_name, e.last_name, e.salary, o.city
FROM
    employees e
        JOIN
    offices o ON e.office_id = o.office_id
WHERE
    e.salary >= 70000;

SELECT 
    SUM(CASE
        WHEN empl.salary > 70000 THEN 1
        ELSE 0
    END) AS n_seniors
FROM
    (SELECT 
        e.employee_id, e.first_name, e.last_name, e.salary, o.city
    FROM
        employees e
    JOIN offices o ON e.office_id = o.office_id) empl;
    
SELECT 
    count(*) AS n_ny_based
FROM (SELECT 
        e.employee_id, e.first_name, e.last_name, e.salary, o.city
    FROM
        employees e
    JOIN offices o ON e.office_id = o.office_id) empl where city='New York City';
    
-- answer to stratascratch question

SELECT 
    CASE
        WHEN n_seniors > n_ny_based THEN 'More seniors'
        ELSE 'More USA-based'
    END AS winner
FROM
    (SELECT 
    SUM(CASE
        WHEN empl.salary > 70000 THEN 1
        ELSE 0
    END) AS n_seniors
FROM
    (SELECT 
        e.employee_id, e.first_name, e.last_name, e.salary, o.city
    FROM
        employees e
    JOIN offices o ON e.office_id = o.office_id) empl) seniors
        LEFT JOIN
    (SELECT 
    count(*) AS n_ny_based
FROM (SELECT 
        e.employee_id, e.first_name, e.last_name, e.salary, o.city
    FROM
        employees e
    JOIN offices o ON e.office_id = o.office_id) empl where city='New York City') us_based ON TRUE;
    
-- answer to stratascratch question

    with empl as (SELECT 
        e.employee_id, e.first_name, e.last_name, e.salary, o.city
    FROM
        employees e
    JOIN offices o ON e.office_id = o.office_id) 
    SELECT 
    CASE
        WHEN n_seniors > n_ny_based THEN 'More seniors'
        ELSE 'More USA-based'
    END AS winner
FROM
    (SELECT 
        COUNT(*) AS n_seniors
    FROM
        empl
    WHERE
        salary > 70000) seniors
        LEFT JOIN
    (SELECT 
        COUNT(*) AS n_ny_based
    FROM
        empl
    WHERE
        city = 'New York City') us_based ON TRUE;

-- Select number of seniors and ny_based employees
        SELECT 
    *
FROM
    (SELECT 
        SUM(CASE
                WHEN empl.salary > 70000 THEN 1
                ELSE 0
            END) AS n_seniors
    FROM
        (SELECT 
        e.employee_id, e.first_name, e.last_name, e.salary, o.city
    FROM
        employees e
    JOIN offices o ON e.office_id = o.office_id) empl) seniors
        LEFT JOIN
    (SELECT 
        COUNT(*) AS n_ny_based
    FROM
        (SELECT 
        e.employee_id, e.first_name, e.last_name, e.salary, o.city
    FROM
        employees e
    JOIN offices o ON e.office_id = o.office_id) AS empl
    WHERE
        city = 'New York City') us_based ON TRUE;
SELECT 
        e.employee_id, e.first_name, e.last_name, e.salary, o.city
    FROM
        employees e
    JOIN offices o ON e.office_id = o.office_id