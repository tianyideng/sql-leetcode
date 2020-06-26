| *#* | *Title* | *Difficulty*| *Note* | *Link* | *Solution* |  
| --- | -------- | ---------- | -------| -| -| 
| 175 | Combine Two Tables | Easy | | | |
| 176 | Second Highest Salary | NOT Easy| Need consider about NULL. If NULL, will return ' ', but the expect is 'NULL'. So we have to use MAX(). Also, if NULL, when we do DESC, the NULL will be TOPs. | | | | 
| 177 | Nth Highest Salary| Medium | Need set up N/M, because OFFSET only contains numbers. Also, take care duplicate values.(Try window functions, but not accepted all) | | | |   
| 178 | Rank Scores | Medium | dense_rank()/two tables compare(distinct table w/ original table, 注意syntax别名，还有join时ON直接用>=, 或者无join，直接选两个表)  
| 180 | Consecutive Number | Medium | 3 tables id +1 = Num. Lead function + CTE |  
| 181 | Employees Earning More Than Managers | Easy | Self join as e and m, and conditions select，注意是什么id = 什么id，别弄反了 |  
| 182 | Duplicate Emails | Easy | group by and count > 1 |  
| 183 | Customers Who Never Order | Easy | subquery |  
| 184 | Department Highest Salary | Medium | should max() in subquery, or only show one max salary in the all. Should select departmentid and salary together in subquery, or will error for highst salary in other departments |  
| 185 | Department Top Three Salaries| Hard | Dense_Rank() and select <= 3. OR always COUNT()|  
| 196 | Delete Duplicate Emails | NOT EASY | NOT IN need a wrap. |
| 197 | Rising Temperature | NOT EASY | TO_DAYS()/DATEDIFF() |  
| 262 | Trips and Users | Hard | two CTEs, be careful the SUM/COUNT. 主要多注意SUM/COUNT在没有数据的时候如何计算为0. |  
| 511 | Game Play Analysis I | Easy | MIN() + GROUP BY |
| 512 | Game Play Analysis II | Easy | Rank() or subquery |  
| 534 | Game Play Analysis III | Medium | window function SUM(). Self join |  
| 550 | Game Play Analysis IV | Medium | window function Lead + subquery. self join |
| 569 | Median Employee Salary | Hard | window function Row_number() + ??? |
| 1179 | Deformat department table | Easy | 利用sum（case when then else null end）去把每个月一次写出 |



