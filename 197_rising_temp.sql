# TO_DAYS()
SELECT w2.Id 'Id'
FROM Weather w1, Weather w2
WHERE w2.Temperature > w1.Temperature
AND TO_DAYS(w2.RecordDate)-TO_DAYS(w1.RecordDate)=1

# DATEDIFF()
SELECT w2.Id 'Id'
FROM Weather w1, Weather w2
WHERE w2.Temperature > w1.Temperature
AND DATEDIFF(w2.RecordDate, w1.RecordDate)=1