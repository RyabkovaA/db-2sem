--1. Триггер, который проверяет правильность ввода паспортных данных и преобразовывает их в формат XX XX XXXXXX
CREATE OR REPLACE FUNCTION passport_check()
RETURNS TRIGGER
AS $$
BEGIN
IF NOT(NEW.passport  LIKE '__ __ ______') 
THEN 
RAISE EXCEPTION 'Your passport information is of the wrong type!';
END IF;
RETURN NEW;
END; 
$$
LANGUAGE plpgsql;

CREATE TRIGGER passport_check_trigger BEFORE INSERT
ON clients FOR EACH ROW EXECUTE FUNCTION passport_check();

INSERT INTO clients(organisation, property, address, phone, client_name, passport)
VALUES ('Мишлэндс','Коммерческая','Скрипичная ул. 36','+79182123232',
		'Кошаков Петр Валерьевич','22 22 880976')

--2. Триггер, который расчитывает общую сумму выплат по кредиту, дату полного погашения кредита и создает запись в таблице задолженности
CREATE OR REPLACE FUNCTION debts_record ()
RETURNS TRIGGER
AS $$
DECLARE 
monthss double precision;
new_date date;
new_date_int timestamp;
staaavka double precision;
full_sum double precision;
BEGIN
staaavka = (select bid from credit_types where credit_types.type_id = NEW.type_id);
monthss = date_part('month',NEW.limit_month);
full_sum = round(((NEW.summa * staaavka/12/100)*monthss+NEW.summa)::numeric,2);
new_date_int = NEW.date_given + NEW.limit_month;
new_date = TO_CHAR(new_date_int::date, 'yyyy-mm-dd');
INSERT INTO debts(credit_id, debt_amount, status_red, limit_date)
VALUES (NEW.credit_id,full_sum,0,new_date);
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER debts_record_trigger AFTER INSERT ON credits FOR EACH ROW EXECUTE FUNCTION debts_record()

delete from payments where payment_id = 8
delete from debts where debt_id = 36
delete from credits where credit_id = 70
select * from debts where debt_id = 7
select * from fines
SELECT * FROM credits
select * from clients
select * from payments where debt_id = 7
update debts set status_red = 0 where debt_id = 3
INSERT INTO payments(debt_id, payment_date, payment_amount) VALUES (4,'2023-10-09', 5500000)
INSERT INTO credits(type_id, client_id, summa, date_given, limit_month) VALUES (5,8,1900000,'2023-06-23','10 month')
INSERT INTO credits(type_id, client_id, summa, date_given, limit_month) VALUES (1,11,12000000,'2023-04-30','8 month')


--3. Триггер, который создает запись в таблице штрафов во время внесения платежа после окончания договорного срока погашения
--штраф расчитывается по формуле остаток задолженности * 10% 
CREATE OR REPLACE FUNCTION fines_record()
RETURNS TRIGGER 
AS $$
DECLARE limdate date;
finn double precision;
pays double precision;
leftpays double precision;
lastpaydate date;
clientss integer;
BEGIN
limdate = (select limit_date from debts where debt_id = NEW.debt_id);
pays = (select debt_amount from debts where debt_id = NEW.debt_id);
leftpays = pays - (select sum(payment_amount) from payments where debt_id = NEW.debt_id)+NEW.payment_amount;
clientss = (select client_id from credits,debts where credits.credit_id = debts.credit_id and debts.debt_id = NEW.debt_id);
lastpaydate = NEW.payment_date;
finn = leftpays * 0.1;
IF lastpaydate > limdate THEN
INSERT INTO fines(debt_id, client_id, fine_amount) VALUES (NEW.debt_id, clientss, finn);
END IF;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER fines_record_trigger AFTER INSERT ON payments FOR EACH ROW EXECUTE FUNCTION fines_record();

--4. Триггер, который изменяет статус погашения кредита после внесения последнего платежа и погашения задолженности
CREATE OR REPLACE FUNCTION status_edit()
RETURNS TRIGGER 
AS $$
DECLARE sum_pay DOUBLE PRECISION;
full_summa DOUBLE PRECISION;
BEGIN
sum_pay = (SELECT SUM(payment_amount) from payments where debt_id = NEW.debt_id);
sum_pay = sum_pay + NEW.payment_amount;
full_summa = (SELECT debt_amount from debts where debt_id = NEW.debt_id);
IF full_summa <= sum_pay THEN
	UPDATE debts SET status_red = 1 where debt_id = NEW.debt_id;
END IF;
RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER status_edit_trigger AFTER INSERT ON payments FOR EACH ROW EXECUTE FUNCTION status_edit();

delete from credits where credit_id = 61
delete from debts where debt_id = 28
select * from debts where debt_id = 29
select * from fines
select * from credit_types
select sum(payment_amount) from payments where debt_id = 29
INSERT INTO payments(debt_id, payment_date, payment_amount) VALUES (29,'2023-06-09',416.68)
INSERT INTO credits(type_id, client_id, summa, date_given, limit_month)
VALUES (3,13,100000,'2023-05-30','1 month')


--5. Триггер, который при добавлении записи в таблицу кредитов выводит предупреждение, 
--если у этого клиента есть текущие задолженности по кредитам данного типа
CREATE OR REPLACE FUNCTION client_debt_check()
RETURNS TRIGGER 
AS $$
BEGIN
IF EXISTS(SELECT debt_id from debts, credits where credits.credit_id = debts.credit_id and 
		   credits.client_id = NEW.client_id and credits.type_id = NEW.type_id and debts.status_red = 0)
THEN
RAISE EXCEPTION 'У этого клиента есть непогашенные кредиты данного типа!';
END IF;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER client_debt_check_trigger BEFORE INSERT ON credits FOR EACH ROW EXECUTE FUNCTION client_debt_check();

SELECT debt_id from debts, credits where credits.credit_id = debts.credit_id and 
		   credits.client_id = 3 and credits.type_id = 2 and debts.status_red = 0

--54, 24,55,2
select credits.client_id, credits.type_id from debts,credits
where debts.credit_id = credits.credit_id
and credits.client_id = 2 and type_id = 3 and status_red = 0
select * from debts
select * from credits
INSERT INTO credits(type_id, client_id, summa, date_given, limit_month)
VALUES (3,2,1900000,'2023-06-23','11 month')



--1. Функция расчета суммы всех выплат клиента
CREATE OR REPLACE FUNCTION pay_sum(our_client int)
RETURNS double precision
AS $$
DECLARE paysss double precision;
finesss double precision;
BEGIN
paysss = (SELECT sum(debt_amount) from credits, debts where 
		   debts.credit_id = credits.credit_id and credits.client_id = our_client);
finesss = (select sum(fine_amount) from fines where client_id = our_client);
paysss = paysss + finesss;
return paysss;
end;
$$
language plpgsql;

DROP FUNCTION pay_sum(integer)

select pay_sum(3) as "Выплаты"

--2. Функция расчета взятой клиентами в кредит общей суммы в промежуток между датой 1 и датой 2
CREATE OR REPLACE FUNCTION credits_sum_period (date1 date, date2 date)
returns double precision
as $$
begin
return (select sum(summa) from credits where date_given between date1 and date2);
end;
$$
language plpgsql;

select credits_sum_period('2020-01-02','2022-01-01')

--3. Функция, которая рассчитывает процент взятых кредитов по видам за определенный год
create or replace function type_credit_perc(our_year integer)
returns table ("Доля в %" numeric, "Тип кредита" text)
as $$
declare 
credits_all double precision;
begin
credits_all = (select count(credit_id) from credits where extract(year from date_given) = our_year);
return query
(select 
round(((count(credit_id)/credits_all)*100)::numeric, 2) as "Доля в %",
case 
when credits.type_id = 1 then 'Ипотечный'
when credits.type_id = 2 then 'Автомобильный'
when credits.type_id = 3 then 'Портребительский'
when credits.type_id = 4 then 'Инвестиционный'
when credits.type_id = 5 then 'Рефинансирование'
end as "Тип кредита"
from credits where extract(year from date_given) = our_year group by type_id);
end;
$$
language plpgsql;

select * from type_credit_perc(2023) 

DROP FUNCTION type_credit_perc(integer)
select * from credit_types


select 
round((count(credit_id)/100)::numeric,2 )as "Доля в %",
case 
when credits.type_id = 1 then 'Ипотечный'
when credits.type_id = 2 then 'Автомобильный'
when credits.type_id = 3 then 'Портребительский'
when credits.type_id = 4 then 'Инвестиционный'
when credits.type_id = 5 then 'Рефинансирование'
end as "Тип кредита"
from credits where extract(year from date_given) = 2023 group by type_id


select * from credits










