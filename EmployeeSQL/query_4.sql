SELECT e.emp_no, e.last_name, e.first_name,
d.dept_name
FROM employees e
JOIN dept_emp dep ON e.emp_no=dep.emp_no
JOIN departments d ON d.dept_no=dep.dept_no;

