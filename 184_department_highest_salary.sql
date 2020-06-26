# max() 在subquery里面才行，否则只返回一个max salary，如果有duplicate就无法显示了。
SELECT d.Name AS 'Department', e.Name AS 'Employee', e.Salary AS 'Salary'
FROM Employee e, Department d
WHERE e.DepartmentId = d.Id
AND (e.DepartmentId, e.Salary) IN (SELECT e.DepartmentId, MAX(e.Salary)
          FROM Employee e
          GROUP BY e.DepartmentId
          ORDER BY e.Salary DESC); 
#注意要departmentid 和 salary同时选取，否则有可能选出别的部门最高薪水放在了另一个部门了