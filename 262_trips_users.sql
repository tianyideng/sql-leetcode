#Two CTEs
WITH cancelled (Day, cancellation)
AS (
    SELECT t.Request_at, SUM(t.Status != 'completed') 
    @注意这里是SUM函数，如果用COUNT，需要WHERE里面加取消的行程，但会导致2号没有数据。
    @或者可以用COUNT，但是要CASE 1/0 这样COUNT。
    FROM Trips t
    JOIN Users c
    ON t.Client_Id = c.Users_Id
    JOIN Users d
    ON d.Users_Id = t.Driver_Id
    WHERE c.Banned = 'No' AND d.Banned = "No"   
    GROUP BY t.Request_at
    ), 
    
request (Day, requested)
@注意这里必须要有Day，之后需要day = day才能出现准确数据。
AS
    (SELECT t.Request_at, COUNT(*)
    FROM Trips t
    JOIN Users c
    ON t.Client_Id = c.Users_Id
    JOIN Users d
    ON d.Users_Id = t.Driver_Id
    WHERE c.Banned = 'No' AND d.Banned = "No"
    GROUP BY t.Request_at) 

SELECT cancelled.Day, ROUND((cancelled.cancellation / request.requested), 2) AS 'Cancellation Rate'
FROM cancelled
LEFT JOIN request 
ON cancelled.Day = request.Day
WHERE cancelled.Day BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY cancelled.Day
ORDER BY cancelled.Day;

# 正常写法 + INNER JOIN
SELECT 
t.Request_at Day, 
ROUND(SUM(CASE WHEN t.Status LIKE 'cancelled_%' THEN 1 ELSE 0 END)/COUNT(*), 2) 'Cancellation Rate'
FROM Trips t 
INNER JOIN Users u 
ON t.Client_Id = u.Users_Id AND u.Banned='No'
WHERE t.Request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY t.Request_at;

#最快写法，subquery
SELECT t.Request_at 'Day', ROUND(COUNT(IF(t.Status != 'completed', TRUE, NULL)) / COUNT(*), 2) 'Cancellation Rate'
FROM trips t
WHERE t.Request_at BETWEEN '2013-10-01' AND '2013-10-03'
AND t.Client_id NOT IN (
    SELECT u.Users_Id
    FROM Users u 
    WHERE u.Banned = "Yes"
) 
AND t.Driver_Id NOT IN (
    SELECT
    FROM Users u 
    WHERE u.Banned = "Yes"
)
GROUP BY t.Request_at;

#和第一个方法一样，只不过没用CTE
SELECT total.Request_at AS 'Day', ROUND(cancelled.cancel / total.totalRequest, 2) AS 'Cancellation Rate'
FROM (
    SELECT COUNT(*) AS "totalRequest", t.Request_at
    FROM Trips t
    JOIN Users u
    ON t.Client_Id = u.Users_Id
    JOIN Users d
    ON d.Users_Id = t.Driver_Id
    WHERE d.Banned = "No"
    AND u.Banned = "No"
    GROUP BY t.Request_at
    ORDER BY t.Request_at
    ) AS total
JOIN (
    SELECT SUM(t.Status LIKE "cancelled%") AS cancel, t.Request_at
    FROM Trips t
    JOIN Users u
    ON t.Client_Id = u.Users_Id
    JOIN Users d
    ON d.Users_Id = t.Driver_Id
    WHERE d.Banned = "No"
    AND u.Banned = "No"
 
    GROUP BY t.Request_at
    ORDER BY t.Request_at) AS cancelled
ON cancelled.Request_at = total.Request_at
WHERE total.Request_at BETWEEN '2013-10-01' AND "2013-10-03";
