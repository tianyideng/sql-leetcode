# window function solution
SELECT Score, Dense_Rank() OVER (ORDER BY Score DESC) AS Rank
FROM Scores
ORDER BY Score DESC;

# Always count and compare distinct table with original table
SELECT s.Score, count(distinct t.score) 'Rank'
FROM Scores s JOIN Scores t ON s.Score <= t.score
GROUP BY s.Id
ORDER BY s.Score DESC;

# count, no join 这个好理解，count大的数量有多少，越大比他大的就越少，就是排名。
SELECT S.Score, COUNT(S2.Score) AS 'Rank' FROM Scores S,
(SELECT DISTINCT Score FROM Scores) S2
WHERE S.Score<=S2.Score
GROUP BY S.Id 
ORDER BY S.Score DESC;


