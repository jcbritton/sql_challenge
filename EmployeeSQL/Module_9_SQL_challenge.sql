CREATE TABLE departments (
    dept_no VARCHAR(30) NOT NULL,
    dept_name VARCHAR(30) NOT NULL,
	PRIMARY KEY (dept_no)
);

CREATE TABLE dept_emp (
    emp_no INTEGER NOT NULL,
    dept_no VARCHAR(30) NOT NULL,
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE titles (
    title_id VARCHAR(30) NOT NULL,
    title VARCHAR(30) NOT NULL,
	PRIMARY KEY (title_id)
);

CREATE TABLE employees (
    emp_no INTEGER NOT NULL,
    emp_title_id VARCHAR(30) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    sex VARCHAR(30) NOT NULL,
    hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

CREATE TABLE dept_manager (
    dept_no VARCHAR(30) NOT NULL,
    emp_no INTEGER NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE salaries (
    emp_no INTEGER NOT NULL,
    salary INTEGER NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT de.emp_no, emp.last_name, emp.first_name, emp.sex, s.salary
FROM dept_emp AS de
JOIN employees AS emp ON 
de.emp_no = emp.emp_no
JOIN salaries AS s ON 
de.emp_no = s.emp_no;

SELECT emp.first_name, emp.last_name, emp.hire_date
FROM employees AS emp
WHERE EXTRACT(YEAR FROM emp.hire_date) = 1986;

SELECT dm.dept_no, d.dept_name, dm.emp_no, emp.last_name, emp.first_name
FROM dept_manager dm
JOIN departments d ON 
dm.dept_no = d.dept_no
JOIN employees emp ON 
dm.emp_no = emp.emp_no
WHERE dm.emp_no IN 
(
	SELECT emp_no 
    FROM dept_manager
)
ORDER BY dm.dept_no;

SELECT de.dept_no, emp.emp_no, emp.last_name, emp.first_name, d.dept_name
FROM employees emp
JOIN dept_emp de ON 
emp.emp_no = de.emp_no
JOIN departments d ON 
de.dept_no = d.dept_no
ORDER BY de.dept_no, emp.emp_no;

SELECT first_name, last_name, sex
FROM employees
WHERE 
    first_name = 'Hercules'
    AND last_name LIKE 'B%'
ORDER BY 
    last_name;

SELECT emp.emp_no, emp.last_name, emp.first_name
FROM employees emp
JOIN dept_emp de ON 
emp.emp_no = de.emp_no
JOIN departments d ON
de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'
ORDER BY emp.emp_no;

SELECT emp.emp_no, emp.last_name, emp.first_name, d.dept_name
FROM employees emp
JOIN dept_emp de ON 
emp.emp_no = de.emp_no
JOIN departments d ON 
de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development')
ORDER BY d.dept_name, emp.emp_no;

SELECT last_name,
COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC, last_name;
