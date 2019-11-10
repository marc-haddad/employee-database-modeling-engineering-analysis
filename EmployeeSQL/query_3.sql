SELECT d.dept_no, dep.dept_name, d.emp_no, e.last_name,
e.first_name, d.from_date, d.to_date
FROM dept_manager d
JOIN departments dep ON d.dept_no=dep.dept_no
JOIN employees e ON d.emp_no=e.emp_no;

