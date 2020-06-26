CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN

  RETURN (
      # Write your MySQL query statement below.
      SELECT e1.Salary
      FROM (SELECT DISTINCT Salary FROM Employee) e1
      WHERE (N - 1) = (SELECT COUNT(*)
                        FROM (SELECT DISTINCT Salary FROM Employee) e2
                      WHERE e2.Salary > e1.Salary)
      
  );
END
# 注意去重

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
DECLARE M INT;
SET M=N-1;
  RETURN (
      # Write your MySQL query statement below.
      SELECT DISTINCT Salary FROM Employee ORDER BY Salary DESC LIMIT M, 1
  );
END
/# 注意提前设好M, 因为MySQL only takes numeric constants in the LIMIT syntax. /



