#聪明的方法，运用row_number，比较between -1 + 1
SELECT Id, Company, Salary
FROM (
SELECT *, ROW_NUMBER() OVER(PARTITION BY COMPANY ORDER BY Salary ASC, Id ASC) AS RN_ASC,
ROW_NUMBER() OVER(PARTITION BY COMPANY ORDER BY Salary DESC, Id DESC) AS RN_DESC
FROM Employee
) AS temp
WHERE RN_ASC BETWEEN RN_DESC - 1 AND RN_DESC + 1
ORDER BY Company, Salary;

#
select t1.Id as Id, t1.Company, t1.Salary
from Employee as t1 inner join Employee as t2
on t1.Company = t2.Company
group by t1.Id
having abs(sum(CASE when t2.Salary<t1.Salary then 1
                  when t2.Salary>t1.Salary then -1
                  when t2.Salary=t1.Salary and t2.Id<t1.Id then 1
                  when t2.Salary=t1.Salary and t2.Id>t1.Id then -1
                  else 0 end)) <= 1
order by t1.Company, t1.Salary, t1.Id

#公式？
with t1 as(
select *, row_number() over(partition by Company order by Salary) as row,
count(Id) over(partition by Company) as cnt
from Employee )

select Id, Company, Salary
from t1
where row between cnt/2.0 and cnt/2.0+1;