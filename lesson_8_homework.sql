--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/

select Department, Employee, salary
from
(select Department.name as Department, Employee.name as Employee, 
Employee.salary, dense_rank () over (partition by Employee.departmentId order by Employee.salary desc) as rn
from Employee 
join Department
on Employee.departmentId=Department.id)
where rn<=3

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17

select member_name, status, sum(amount * unit_price) as costs
from FamilyMembers
join Payments
on FamilyMembers.member_id = Payments.family_member
where YEAR(date) = 2005
group by member_name, status 


--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13

select name from
(select name, row_number () over (partition by name) as rn
from Passenger) as tab
WHERE rn>1

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

select COUNT(first_name) as count 
from Student
where first_name='Anna'

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35

select DISTINCT count (classroom) as count 
from Schedule
where MONTH(DATE)=9 and day (date)=2 and YEAR(DATE) =2019 

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

select COUNT(first_name) as count 
from Student
where first_name='Anna'

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32

select FLOOR (avg (year (current_date)-year (birthday))) as age
from FamilyMembers

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27

select GT.good_type_name, sum(P.amount * P.unit_price) as costs
from Payments as P
join Goods as G
on P.good = G.good_id
join GoodTypes as GT
on G.type=GT.good_type_id
where YEAR(date) = 2005
group by GT.good_type_name

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37
вариант1
select min (year (current_date) - year (birthday)) as year
from Student

вариант2
select year (current_date) - year (birthday) as year
from Student
where id=(
select id
from Student
where birthday=(select max (birthday) from Student))


--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44

select max (year (current_date)-year (birthday)) as max_year
from student as t1
join Student_in_class as t2
on t1.id=t2.student
join Class as t3
on t2.class=t3.id
where t3.name like ('10%')

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20

select FM.status, FM.member_name, sum(P.amount * P.unit_price) as costs
from Payments as P
join Goods as G
on P.good = G.good_id
join GoodTypes as GT
on G.type=GT.good_type_id
join FamilyMembers as FM
on P.family_member=FM.member_id
where good_type_name='entertainment'
group by FM.status, FM.member_name

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55

delete from Company
where id in ( 

select distinct company
from 
(select company, count (*) over (partition by company) as qvnt
from Trip) as t
where qvnt= (select min (qvnt) from (select company, count (*) over (partition by company) as qvnt
from Trip) as t2) 
)

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45

select distinct classroom
from 
(select classroom, count (*) over (partition by classroom) as qvnt
from Schedule) as t
where qvnt = (select max (qvnt) from (select  classroom, count (*) over (partition by classroom) as qvnt
from Schedule) as t2)

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43

select last_name
from Teacher as T
join Schedule as Sc
on T.id=Sc.teacher
join Subject as S 
on Sc.subject=S.id
where S.name = 'Physical Culture'
ORDER BY  last_name

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63

select concat (last_name,'.',left(first_name,1),'.',left(middle_name,1),'.') 
as name
from Student
order by name
