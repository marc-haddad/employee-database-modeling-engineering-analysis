SELECT last_name, COUNT(last_name) name_count
FROM employees
GROUP BY last_name
ORDER BY name_count DESC;