#self join
SELECT a1.player_id, a1.event_date, 
    SUM(a2.games_played) AS 'games_played_so_far'
FROM Activity a1, Activity a2
WHERE a1.player_id = a2.player_id
AND a1.event_date >= a2.event_date
@@如果没有event_date的条件，只会得到最终的总和的值（12）
GROUP BY a1.player_id, a1.event_date
ORDER BY a1.player_id, a1.event_date;

# Window function with SUM()
SELECT player_id, event_date, 
    SUM(games_played) OVER(PARTITION BY player_id ORDER BY event_date) AS 'games_played_so_far'
    @@注意一定要order by event_date，否则sum的column里全部都是最终的总和的值。
FROM Activity
ORDER BY player_id, event_date;