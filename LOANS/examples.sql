--Демонстрация базы данных
select * from credit_types
select * from credits
select * from clients
select * from debts
select * from fines
select * from payments


--Проверка функции 
--Функция, которая рассчитывает долю
--взятых кредитов по видам за определенный год

select * from credits, credit_types where extract(year from date_given) = 2021
select * from type_credit_perc(2021) 


--Проверка триггера
--Триггер, который рассчитывает общую сумму выплат по кредиту 
--по формуле (сумма займа*ставка/12)*срок в месяцах + сумма займа, 
--дату полного погашения кредита и создает запись в таблице «Задолженности»

select * from debts;
select * from credit_types where type_id = 1;
--ставка по кредиту 6,71%
--сумма займа 12000000
--срок в месяцах 14
--формула: (12000000*6.71/100/12)*14 + 12000000 = 12134200
select * from credits;
INSERT INTO credits(type_id, client_id, summa, date_given, limit_month) VALUES (1,13,12000000,'2023-07-03','14 month')
