# Employee Database: Data Modeling, Engineering, and Analysis

## Background

The task is a research project on employees of a corporation from the 1980s and 1990s. All that remain of the database of employees from that period are six CSV files.

The objectives are: design the tables to hold data in the CSVs, import the CSVs into a SQL database, and answer questions about the data. In other words:

1. Data Modeling

2. Data Engineering

3. Data Analysis

## Data Modeling

Created and designed initial db Schema with the help of quickdatabasediagrams.com.

![db schema](/EmployeeSQL/ERD.png)

## Data Engineering

* Used the information to create a table schema for each of the six CSV files given (while specifying data types, primary keys, foreign keys, and other constraints).

```sql
CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" CHAR(4)   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(255)   NOT NULL,
    "last_name" VARCHAR(255)   NOT NULL,
    "gender" CHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "departments" (
    "dept_no" CHAR(4)   NOT NULL,
    "dept_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" CHAR(4)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR(255)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");
```

* Imported each CSV file into the corresponding SQL table.

## Data Analysis

1. Listed the following details of each employee: employee number, last name, first name, gender, and salary.
    
```sql
SELECT e.emp_no, e.last_name,
e.first_name, e.gender, s.salary
FROM employees e
JOIN salaries s ON e.emp_no=s.emp_no;
```

2. Listed employees who were hired in 1986.
```sql
SELECT emp_no, first_name, last_name, hire_date FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;
```

3. Listed the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
```sql
SELECT d.dept_no, dep.dept_name, d.emp_no, e.last_name,
e.first_name, d.from_date, d.to_date
FROM dept_manager d
JOIN departments dep ON d.dept_no=dep.dept_no
JOIN employees e ON d.emp_no=e.emp_no;
```

4. Listed the department of each employee with the following information: employee number, last name, first name, and department name.

```sql
SELECT e.emp_no, e.last_name, e.first_name,
d.dept_name
FROM employees e
JOIN dept_emp dep ON e.emp_no=dep.emp_no
JOIN departments d ON d.dept_no=dep.dept_no;
```

5. Listed all employees whose first name is "Hercules" and last names begin with "B."

```sql
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name='Hercules'
AND last_name LIKE 'B%';
```

6. Listed all employees in the Sales department, including their employee number, last name, first name, and department name.

```sql
SELECT e.emp_no, e.last_name, e.first_name, dep.dept_name
FROM employees e
JOIN dept_emp d ON e.emp_no=d.emp_no
JOIN departments dep ON d.dept_no=dep.dept_no
WHERE dept_name = 'Sales';
```

7. Listed all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

```sql
SELECT e.emp_no, e.last_name, e.first_name, dep.dept_name
FROM employees e
JOIN dept_emp d ON e.emp_no=d.emp_no
JOIN departments dep ON d.dept_no=dep.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';
```

8. Listed the frequency count of employee last names in descending order. (i.e., how many employees share each last name.)

```sql
SELECT last_name, COUNT(last_name) name_count
FROM employees
GROUP BY last_name
ORDER BY name_count DESC;
```

## Bonus - Using `sqlalchemy` to Visualize Data in Python

1. Imported the SQL database into Pandas.

   ```sql
   from sqlalchemy import create_engine
   engine = create_engine('postgresql://localhost:5432/sql-challenge')
   connection = engine.connect()
   ```

2. Created a histogram to visualize the most common salary ranges for employees.


3. Created a bar chart of average salary by title.
