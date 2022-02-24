--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. 
Вывести: класс и число потопленных кораблей.

select  class, sum (case when result ='sunk' then 1
else 0 end)
from ships
left join outcomes 
on ships.name=outcomes.ship  
group by class

--task2
Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. 
Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. 
Вывести: класс, год.

select "class" , launched
from ships s where name=class
union 
select class, min (launched)
from ships s where class not in (select class from ships s where name=class)
group by class

--task3
Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, 
вывести имя класса и число потопленных кораблей.

select class, count (name) as qnt_sunk
from ships 
join outcomes 
on ships.name=outcomes.ship
where result='sunk' and class in (select class
from ships
group by class
having count (name) >=3)
group by class

--task4
Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей 
такого же водоизмещения (учесть корабли из таблицы Outcomes).

Корабли с максимальным количеством орудий среди каждого значения водоизмещения:

select name, numguns, displacement from ships 
join classes 
on ships.class=classes.class
where displacement =29000 and numguns = (select max (numguns) from ships 
join classes 
on ships.class=classes.class where displacement =29000
group by displacement )
group by name, numguns, displacement 

union

select name, numguns, displacement from ships 
join classes 
on ships.class=classes.class
where displacement =32000 and numguns = (select max (numguns) from ships 
join classes 
on ships.class=classes.class where displacement =32000
group by displacement )
group by name, numguns, displacement 

union

select name, numguns, displacement from ships 
join classes 
on ships.class=classes.class
where displacement =37000 and numguns = (select max (numguns) from ships 
join classes 
on ships.class=classes.class where displacement =37000
group by displacement )
group by name, numguns, displacement 

union

select name, numguns, displacement from ships 
join classes 
on ships.class=classes.class
where displacement =46000 and numguns = (select max (numguns) from ships 
join classes 
on ships.class=classes.class where displacement =46000
group by displacement )
group by name, numguns, displacement 

union

select name, numguns, displacement from ships 
join classes 
on ships.class=classes.class
where displacement =65000 and numguns = (select max (numguns) from ships 
join classes 
on ships.class=classes.class where displacement =65000
group by displacement )
group by name, numguns, displacement 
order by displacement

Корабли с максимальным количеством орудий среди кораблей с максималным водоизмещением:

select name, max (numguns)
from ships 
join classes 
on ships.class=classes.class
where displacement = (select max (displacement) from classes)
group by name

--task5
Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM 
и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker

select distinct maker
from product
where type = 'Printer'
and maker in 
( 
select maker
from pc
join product 
on pc.model=product.model 
where ram = (select min (ram) from pc) and 
speed = (select max (speed) from pc where ram = (select min (ram) from pc))
 )