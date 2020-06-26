#Subquery + self join

SELECT ROUND(COUNT(DISTINCT tmp.player_id)/(SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS 'fraction'
FROM (SELECT player_id, MIN(event_date) AS event_date
    FROM Activity
    GROUP BY player_id) tmp, Activity a
WHERE tmp.player_id = a.player_id
AND TO_DAYS(tmp.event_date) + 1 = TO_DAYS(a.event_date)
;


# window function
SELECT ROUND(COUNT(DISTINCT player_id)/(SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS 'fraction'
FROM
    (SELECT player_id, event_date,
        Lead(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS nextDay,
        @@注意必须要有order by，否则就漏掉了之后的数据。
        MIN(event_date) OVER(PARTITION BY player_id) AS firstDay
    FROM Activity) tmp
WHERE tmp.nextDay - 1 = tmp.event_date
AND tmp.event_date = tmp.firstDay
;

