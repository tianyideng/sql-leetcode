# NOT IN 
DELETE FROM Person 
WHERE Id NOT IN
    (SELECT * FROM (SELECT MIN(Id)
        FROM Person 
        GROUP BY Email) tmp    
    ) @这里需要注意，需要wrap一下，否则会有运行error
     @不能在delete/update里用目标的table去进行WHERE操作。
;

# Sample one
DELETE p1
FROM Person p1, Person p2
WHERE p1.Email = p2.Email 
AND p1.Id > p2.Id;