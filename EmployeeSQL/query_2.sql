SELECT emp_no, first_name, last_name, hire_date FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;