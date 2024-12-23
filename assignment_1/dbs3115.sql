
/* question 14 */
SELECT e.first_name|| ' ' ||e.last_name, 
        e.salary,
        jg.grade, 
        SUM((ol.price * ol.qty) * e.commission_pct)
        FROM job_grades jg, employees e
        JOIN orders o
        ON e.employee_id = o.rep_no
        JOIN orderlines ol
        ON o.order_no = ol.order_no
        GROUP BY e.employee_id,e.first_name, e.last_name, e.salary, e.job_id, jg.grade, e.commission_pct
        HAVING e.job_id LIKE 'SA_REP'
        AND SUM((ol.price * ol.qty) * e.commission_pct) > 20000
        AND e.salary >= (SELECT lowest_sal 
                        FROM job_grades
                        WHERE grade = 'C')
        AND e.salary <= (SELECT highest_sal 
                        FROM job_grades
                        WHERE grade = 'C')
        AND jg.grade = 'C'
        ORDER BY 3;
        
        
        