# Dense_Rank()
SELECT tmp.Department, tmp.Employee, tmp.Salary
FROM (
    SELECT d.Name 'Department', e.Name 'Employee', e.Salary 'Salary',
        Dense_Rank() OVER (PARTITION BY d.Id ORDER BY e.Salary DESC) 'Rank'
    FROM Employee e
    JOIN Department d
    ON e.DepartmentId = d.Id) tmp
WHERE tmp.Rank <= 3;

# Always COUNT()
SELECT d.Name 'Department', e1.Name 'Employee', e1.Salary 'Salary'
FROM Employee e1
JOIN Department d
ON e1.DepartmentId = d.Id
WHERE (
    SELECT COUNT(DISTINCT e2.Salary)
    FROM Employee e2
    WHERE e2.Salary > e1.Salary
    AND e2.DepartmentId = e1.DepartmentId) < 3
ORDER BY d.Name, e1.Salary DESC;