--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

select case when t2.Grade >= 8 then t1.Name when t2.Grade <= 8 then null end as Name, t2.Grade, t1.Marks from Students t1 inner join Grades t2 on t1.Marks between t2.Min_Mark and Max_Mark order by t2.Grade desc, t1.Name asc, t1.Marks asc;

--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem


select *
from (select case when Occupation = 'Doctor' then Name else null end as Doctor, 
case when Occupation = 'Actor' then Name else null end as Actor, 
case when Occupation = 'Singer' then Name else null end as Singer, case when Occupation = 'Professor' then Name else null end as Professor 
from  Occupations order by Name) t
order by Doctor, Actor, Singer, Professor;


--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem

select distinct city from Station where not (City Like 'A%' or City like 'E%' or City like 'I%' or City like 'O%' or City like 'U%');

--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem

select distinct city from Station where not (City Like '%a' or City like '%e' or City like '%i' or City like '%o' or City like '%u');

--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem

select distinct city from Station where not (City Like '%a' or City like '%e' or City like '%i' or City like '%o' or City like '%u') or not (City Like 'A%' or City like 'E%' or City like 'I%' or City like 'O%' or City like 'U%');

--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem

select distinct city from Station where not (City Like '%a' or City like '%e' or City like '%i' or City like '%o' or City like '%u') and not (City Like 'A%' or City like 'E%' or City like 'I%' or City like 'O%' or City like 'U%');

--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem

select Name from Employee where salary > 2000 and months < 10 order by Employee_id;

--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

select case when t2.Grade >= 8 then t1.Name when t2.Grade <= 8 then null end as Name, t2.Grade, t1.Marks from Students t1 inner join Grades t2 on t1.Marks between t2.Min_Mark and Max_Mark order by t2.Grade desc, t1.Name asc, t1.Marks asc;
