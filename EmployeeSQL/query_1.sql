SELECT e.emp_no, e.last_name,
e.first_name, e.gender, s.salary
FROM employees e
JOIN salaries s ON e.emp_no=s.emp_no;
