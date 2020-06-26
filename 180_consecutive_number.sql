#三个表，id依次+1，但是值一样
SELECT DISTINCT l1.Num AS 'ConsecutiveNums'
FROM Logs l1, Logs l2, Logs l3
WHERE l1.Num = l2.Num 
AND l1.Id +1 = l2.Id 
AND l2.Num = l3.Num 
AND l2.Id +1 = l3.Id;

#同样逻辑，更简便写法
select distinct Num as 'ConsecutiveNums'
from Logs
where (Id + 1, Num) in (select * from Logs)
AND (Id + 2, Num) in (select * from Logs);

# window function Lead + CTE。 注意cte嵌套效果慢
With leading as (
SELECT
NUM,
LEAD(num) OVER(order by id) as lead1,
LEAD(num,2) OVER(order by id) as lead2
FROM Logs)

Select DISTINCT NUM as ConsecutiveNums
From leading
Where NUM = lead1 
AND NUM = lead2

# Using Lead
SELECT DISTINCT(Num) ConsecutiveNums
FROM(SELECT Id,
Num,
LEAD(Num,1) OVER(ORDER BY Id) AS lead1,
LEAD(Num,2) OVER(ORDER BY Id) AS lead2
FROM Logs)tmp
WHERE Num = lead1 AND Num = lead2
