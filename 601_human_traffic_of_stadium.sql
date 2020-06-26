SELECT s1.id, s1.visit_date, s1.people
FROM(
    SELECT 
    s.id, 
    s.visit_date, 
    s.people, 
    lead(people) OVER (ORDER BY id ASC) as next1,
    lead(people,2) OVER (ORDER BY id ASC ) as next2,
    lag(people) OVER (ORDER BY id ASC) as prev1,
    lag(people,2) OVER (ORDER BY id ASC ) as prev2
    FROM stadium as s
    ) AS s1	
WHERE (people>=100 and 
       ((next1>=100 and next2>=100)
        or (prev1>=100 and prev2>=100)
        or (prev1>=100 and next1>=100) -- <-this one is missing
       ));


SELECT DISTINCT a.*
FROM stadium a, stadium b, stadium c
WHERE a.people >= 100 AND b.people >= 100 AND c.people >= 100
AND (
    (a.id + 1 = b.id AND a.id + 2 = c.id) OR -- a, b, c
    (b.id + 1 = a.id AND b.id + 2 = c.id) OR -- b, a, c
    (c.id + 1 = b.id AND c.id + 2 = a.id)    -- c, b, a
)
ORDER BY a.id