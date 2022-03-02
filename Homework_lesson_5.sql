
--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- Компьютерная фирма: Сделать view (pages_all_products), в которой будет постраничная разбивка всех продуктов (не более двух продуктов на одной странице). Вывод: все данные из laptop, номер страницы, список всех страниц

sample:
1 1
2 1
1 2
2 2
1 3
2 3

create view pages_all_products as
select *, 
case when num % 2 = 1 then 1 else 2 end as num_in_page,
CASE WHEN num % 2 = 0 THEN num/2 ELSE num/2 + 1 END AS page_num
FROM (
select *, ROW_NUMBER() OVER(ORDER BY price DESC) AS num
from Laptop
) a 


--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type), в рамках которого будет процентное соотношение всех товаров по типу устройства. Вывод: производитель, тип, процент (%)

create view distribution_by_type as

select maker, type, cast (type_count/total_count*100 as numeric (18,2)) as percent
from 
(
select maker, type, count (*) as type_count, sum (sum (case when type is null then 0
else 1 end)) over (partition by maker) as total_count 
from product
group by type, maker
) as a

--task3 (lesson5)
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму. Пример https://plotly.com/python/histograms/


--task4 (lesson5)
-- Корабли: Сделать копию таблицы ships (ships_two_words), но название корабля должно состоять из двух слов

crtate table ships_two_words as
select * from ships
where name like ('% %')


--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"

select sh.name
from
(select name 
from ships
union
select ship
from outcomes) as sh
left join ships s
on sh.name=s.name
where class is null and sh.name like ('S%')


--task6 (lesson5)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'C' и три самых дорогих (через оконные функции). Вывести model

select model from 
( 
select model, row_number (*) over 
(order by price desc) as rn
from
(select p.code,p.model, p.color, p.type, p.price, p2.maker
from printer p
join product p2
on p.model=p2.model
where p2.maker='A' and p.price> coalesce  ((select avg (p.price)
from printer p
join product p2
on p.model=p2.model
where p2.maker='C'),0)) as a
) as a2
where rn<=3

