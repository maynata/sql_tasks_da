--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
Компьютерная фирма: Вывести список всех продуктов и производителя с указанием 
типа продукта (pc, printer, laptop). Вывести: model, maker, type

select model, maker, type
from product

--task14 (lesson3)
Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, 
у кого цена вышей средней PC - "1", у остальных - "0"

select * , case when price > (select avg (price) from pc) then 1
else 0 end flag
from printer 

--task15 (lesson3)
Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)

select name
from
(select name, class
from ships
union
select o.ship, s.class 
from outcomes o
left join ships s
on o.ship=s.name) as t1
where class is null


select o.ship
from outcomes o
left join ships s
on o.ship=s.name
where s.class is null

--task16 (lesson3)
Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.

select name
from battles 
where  extract (year from date) not in (select distinct launched from ships)

--task17 (lesson3)
Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.

select battle
from outcomes 
where ship in 
(select name 
from ships 
where class='Kongo')

--task1  (lesson4)
Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) 
с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag

create view all_products_flag_300 as

select model, price, case when price >300 then 1
else 0 end flag
from pc 
union
select model, price, case when price >300 then 1
else 0 end flag
from printer 
union
select model, price, case when price >300 then 1
else 0 end flag
from laptop 

select *
from all_products_flag_300

--task2  (lesson4)
Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop)
 с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag
 
create view all_products_flag_avg_price as

select model, price, case when price > (select avg (price) from pc) then 1
else 0 end flag
from pc 
union
select model, price, case when price >(select avg (price) from printer) then 1
else 0 end flag
from printer 
union
select model, price, case when price >(select avg (price) from laptop) then 1
else 0 end flag
from laptop 

select *
from all_products_flag_avg_price

--task3  (lesson4)
Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам 
производителя = 'D' и 'C'. Вывести model

select p.model
from printer p
join product p2 
on p.model =p2.model 
where p2.maker= 'A' and price > 

(select avg (price)
from printer p
join product p2 
on p.model =p2.model 
where p2.maker in ('D','C'))

--task4 (lesson4)
Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам
 производителя = 'D' и 'C'. Вывести model
 
 select distinct model from
 (select p.model, p.price, p2.maker
 from printer p
 join product p2 
 on p.model =p2.model 
 union
 select p3.model, p3.price, p2.maker
 from pc p3
 join product p2 
 on p3.model =p2.model 
 union
 select l.model, l.price, p2.maker
 from laptop l
 join product p2 
 on l.model =p2.model) as t
 where maker ='A' and price > 

(select avg (price)
from printer p
join product p2 
on p.model =p2.model 
where p2.maker in ('D','C'))

--task5 (lesson4)
Компьютерная фирма: Какая средняя цена среди  продуктов производителя = 'A' (printer & laptop & pc)

select avg (price) from
 (select p.model, p.price, p2.maker
 from printer p
 join product p2 
 on p.model =p2.model 
 union all
 select p3.model, p3.price, p2.maker
 from pc p3
 join product p2 
 on p3.model =p2.model 
 union all
 select l.model, l.price, p2.maker
 from laptop l
 join product p2 
 on l.model =p2.model) as t
 where maker ='A'

--task6 (lesson4)
Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers)
 по каждому производителю. Во view: maker, count

 create view count_products_by_makers as

 select maker, count (model)
 from product 
 group by maker
 
 select * from count_products_by_makers
 
--task7 (lesson4)
По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)

--task8 (lesson4)
Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры
производителя 'D'

create table printer_updated as 
table printer  

select * from printer_updated

delete from printer_updated
where model in
(select p1.model 
from printer_updated p1
join product p2 
on p1.model=p2.model
where maker='D')

--task9 (lesson4)
Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя 
(название printer_updated_with_makers)

create view printer_updated_with_makers as

select pu.code ,pu.model , pu.color , pu."type" , pu.price , p.maker  
from printer_updated pu
join product p
on pu.model=p.model 

select * from printer_updated_with_makers

--task10 (lesson4)
Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes).
Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)

create view sunk_ships_by_classes as

select count (ship), coalesce  (class, '0') as class
from outcomes
left join ships 
on ships.name=outcomes.ship
where result = 'sunk'
group by class

select * from sunk_ships_by_classes

--task11 (lesson4)
Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)

--task12 (lesson4)
Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: 
если количество орудий больше или равно 9 - то 1, иначе 0

create table classes_with_flag as 
select *, case when numguns >=9 then 1
else 0 end flag
from classes

select * from classes_with_flag

--task13 (lesson4)
Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)

select country, count (class) 
from classes 
group by country

--task14 (lesson4)
Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".

select count (*)
from (
select name
from ships 
union 
select ship
from outcomes) as t
where name like 'O%' or name like 'M%' 

--task15 (lesson4)
Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.

select count (*)
from (
select name
from ships 
union 
select ship
from outcomes) as t
where name like '% %'

--task16 (lesson4)
Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)

select launched, count (name)
from ships 
group by launched 