SELECT e.emp_no, e.last_name, e.first_name, dep.dept_name
FROM employees e
JOIN dept_emp d ON e.emp_no=d.emp_no
JOIN departments dep ON d.dept_no=dep.dept_no
WHERE dept_name = 'Sales';