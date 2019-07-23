--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no AS "Employee Number", 
	e.last_name AS "Last Name",
	e.first_name AS "First Name",
	e.gender AS "Gender",
	s.salary AS "Salary"
FROM employees e
LEFT JOIN salaries s ON e.emp_no = s.emp_no;
		
--2. List employees who were hired in 1986.
SELECT * 
FROM employees 
WHERE EXTRACT(YEAR FROM hire_date) = 1986;
		
--3. List the manager of each department with the following information: department number, department name, 
--the manager's employee number, last name, first name, and start and end employment dates.
SELECT d.dept_no AS "Department Number", 
	d.dept_name AS "Department Name", 
	dm.emp_no AS "Mgr Employee Number",
	e.last_name AS "Mgr Last Name",
	e.first_name AS "Mgr First Name",
	dm.from_date AS "Start Date",
	dm.to_date AS "End Date"
FROM departments d
LEFT JOIN dept_manager dm ON d.dept_no=dm.dept_no AND EXTRACT(year FROM to_date)=9999
		LEFT JOIN employees e ON dm.emp_no=e.emp_no;


--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no ,e.last_name,e.first_name,d.dept_name
FROM employees e
	LEFT JOIN  dept_emp de ON e.emp_no=de.emp_no AND EXTRACT(year from to_date)=9999
	RIGHT JOIN departments d ON de.dept_no=d.dept_no;
		
--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * 
		FROM employees
		WHERE first_name='Hercules' AND last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
--This list includes only those employees who are still working in the Sales department and not previously worked.
SELECT de.emp_no AS "Employee Number",
	e.last_name AS "Last Name",
	e.first_name AS "First Name",
	d.dept_name AS "Department Name"
FROM dept_emp de 
		INNER JOIN employees e ON de.emp_no=e.emp_no AND EXTRACT(year from de.to_date)=9999
		INNER JOIN departments d ON de.dept_no=d.dept_no AND d.dept_name='Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT de.emp_no AS "Employee Number",
	e.last_name AS "Last Name",
	e.first_name AS "First Name",
	d.dept_name AS "Department Name"
FROM dept_emp de 
	INNER JOIN employees e ON de.emp_no=e.emp_no AND EXTRACT(year from de.to_date)=9999
	INNER JOIN departments d ON de.dept_no=d.dept_no AND d.dept_name IN ('Sales','Development');
	        
--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name AS "Employee Last Name", count(last_name) AS "Count"
FROM employees e
		GROUP BY last_name
		ORDER BY "Count" DESC;