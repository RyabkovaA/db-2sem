--0. Вывод всей информации о клиентах
select * from clients

--1. Вывести названия видов кредитов и условия их получения.
select type_name as "Название вида кредита", circs as "Условия получения" from credit_types;

--2. Вывести информацию о типах недвижимости клиентов.
select distinct property from clients;

--3. Вывести средний размер суммы кредита за все время. !!!!!
select round(avg(summa)::numeric,2) as "Средняя сумма" from credits;

--4. Вывести информацию о количестве взятых кредитов для каждого ФИО клиента
select count(credit_id) as "Количество кредитов", client_name as "ФИО клиента" 
from clients join credits on credits.client_id = clients.client_id group by clients.client_name;

--5. Вывести количество выданных в 2023 году кредитов.
select count(credit_id) as "Количество кредитов" 
from credits where extract(year from date_given) = 2023;

--6. Вывести, сколько было выдано в кредит в 2020 году. 
select sum(summa) as "Сумма" from credits where extract(year from date_given)=2020;

--7. Вывести количество и год, в который было взято больше всего кредитов вида Ипотека.
select count(credit_id),extract(year from date_given) as "Год" from 
credits, credit_types where credits.type_id = credit_types.type_id and type_name = 'Ипотечный'
group by extract(year from date_given) order by count(credit_id) desc limit 1;

--8. Вывести максимальное количество платежей, за которые был выплачен кредит.
select count(payment_id) as "Количество платежей" from payments, debts
where debts.debt_id = payments.debt_id 
and debts.status_red = 1 group by payments.debt_id 
order by count(payment_id) desc limit 1;

--9. Вывести ФИО и номера телефонов клиентов, которые имеют штрафы
select distinct client_name as "ФИО", phone as 
"Номер телефона" from clients, fines where fines.client_id = clients.client_id;

--10. Вывести характеристику суммы, взятой в кредит, выше она средней суммы кредита в году или ниже
select summa as "Сумма кредита", case 
when summa > summmm then 'Больше средней в году'
when summa < summmm then 'Меньше средней в году'
when summa = summmm then 'Равно средней в году'
end as "Описание"
from credits join (select avg(summa) as summmm,  
				   extract(year from date_given) as yyyear 
from credits group by extract(year from date_given)) as a 
on a.yyyear = extract(year from date_given)

--11. Вывести размеры ставок для каждого вида кредита в формате <3% низкая, 3-5% средняя, 5%< высокая.
select bid as "Ставка", case 
when bid < 3 then 'Низкая'
when bid between 3 and 5 then 'Средняя'
when bid >5 then 'Высокая'
end as "Описание" from credit_types

--12. Вывести ФИО клиентов, которым необходимо выплатить по кредитам более 1млн рублей
select distinct client_name as "Клиент" from clients, payments,credits,debts 
join (select debt_id as iid, sum(payment_amount)
as pay from payments group by debt_id ) as a on a.iid = debts.debt_id where 
credits.credit_id = debts.credit_id and debts.debt_id = payments.debt_id and credits.client_id 
= clients.client_id and debts.status_red = 0 and debts.debt_amount - a.pay > 1000000

--13. Вывод списка всех платежей, сделанных за последние три месяца
select * from payments where extract(year from payment_date) = 2023 
and (extract(month from payment_date) = 6 or  extract(month from payment_date) 
	 = 5 or extract(month from payment_date) = 4)

--14. Вывод списка информации о клиентах, взявших кредиты в этом году
select distinct client_name, organisation, property, address, phone,
client_name, passport from clients, credits
where credits.client_id = clients.client_id and extract(year from date_given) = 2023;

--15. Вывод списка дат выдачи погашенных без задержек кредитов
select date_given as "Дата выдачи кредита" from credits, debts where 
debts.credit_id = credits.credit_id and debts.status_red = 1
and debts.debt_id not in (select debt_id from fines);

--16. Вывод максимального размера штрафа по задолженности !!!!
--!!!!
select round(max(fine_amount)::numeric,2) as "Максимальный штраф" from fines 

--17. Вывод минимального срока, на который был выдан кредит
select min(limit_month) as "Минимальный срок" from credits

--18. Вывода списка ставок по кредитам в порядке возрастания и названий типов кредитов
select bid as "Ставка", type_name as "Тип кредита"
from credit_types group by type_name order by min(bid) 

--19. Вывод списка всех кредитов, у которых срок выдачи истекает в следующем месяце, и соответствующие им задолженности.
select credits.credit_id as "Код кредита", summa as "Сумма кредита", debt_amount
as "Сумма выплат" from
credits, debts where debts.credit_id = credits.credit_id and
extract(month from limit_date) = 7 and extract(year from limit_date) = 2023

--20. Вывод списка организаций и ФИО всех клиентов, у которых брали кредиты на сумму более 1000000 рублей и срок выдачи более 1 года 
select distinct client_name as "ФИО", organisation as "Организация"  from clients, credits where
credits.client_id = clients.client_id and limit_month > '1 year' and summa > 1000000







