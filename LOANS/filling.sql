INSERT INTO credit_types(type_name, circs, bid) VALUES ('Ипотечный',
					'Прописка на территории РФ, возраст от 21 года, особый статус',6.71),
('Автомобильный','Возраст от 23 лет, сумма до 20 млн',4),
('Портребительский','Средний доход заемщика не менее 30000',5),
('Инвестиционный','Годовая выручка не превышает 400 млн рублей',2.5),
('Рефинансирование','Отсутствие текущей просроченной задолженности по кредиту',5.9);


INSERT INTO payments(debt_id, payment_date, payment_amount) VALUES (4,'2023-10-09', 5500000)
INSERT INTO credits(type_id, client_id, summa, date_given, limit_month) VALUES (2,3,12900000,'2021-03-30','16 month')

INSERT INTO clients(organisation, property, address, phone, client_name, passport)
VALUES ('ВкусВилл','Коммерческая','Люблинская ул. 24','+79883124532','Крондштатский Иван Алексеевич','24 31 880976'),
('Частное лицо','Жилая','Фестивальная ул. 43','+79681219500','Южный Петр Петрович','43 38 850116'),
('Онейлс','Коммерческая','Первый пр-т. 21','+79883124532','Ростовой Иван Сергеевич','44 33 860077'),
('Царский квас','Коммерческая','Цветная ул. 4','+79683144433','Чижиков Владимир Алексеевич','21 06 202314')

INSERT INTO clients(organisation, property, address, phone, client_name, passport)
VALUES ('Грозная птица','Коммерческая','Поперечная ул. 11','+79111433220','Курц Тимур Эмилевич','89 76 122112'),
('Частное лицо','Жилая','Полянка ул. 34','+79651235589','Андреев Андрей Антонович','44 12 568734'),
('БетаБанк','Некоммерческая','Рубцовская ул. 53','+79674445687','Ростовой Иван Сергеевич','78 98 007755'),
('Дождь','Предприятие','Барболина ул. 1','+79881425476','Барбоскин Иван Псович','66 76 899889')
INSERT INTO clients(organisation, property, address, phone, client_name, passport)
VALUES
('Коровник 1','Фермерское хозяйство','Школьная ул. 12','+79556137890','Козлов Артур Владимирович','55 44 765641')

select * from payments
select * from credits
select * from clients
select * from debts

INSERT INTO credits(type_id, client_id, summa, date_given, limit_month) VALUES
(1,7,900000,'2020-04-24','36 month'),
(1,6,17500000,'2020-05-09','40 month'),
(1,5,300000,'2020-02-06','21 month'),
(2,6,5100000,'2021-06-20','10 month'),
(2,10,4500000,'2021-04-25','9 month'),
(2,7,11100000,'2021-11-12','27 month'),
(3,8,1500000,'2022-10-01','24 month'),
(3,9,16900000,'2021-09-21','48 month'),
(3,10,700000,'2021-12-14','32 month'),
(3,11,900000,'2022-02-12','18 month'),
(4,11,7700000,'2023-11-30','18 month'),
(4,10,8700000,'2023-04-07','12 month'),
(4,9,100000,'2023-01-30','6 month'),
(4,8,500000,'2022-05-10','4 month'),
(5,7,4300000,'2021-02-11','12 month'),
(5,6,2600000,'2020-05-08','18 month'),
(5,5,1300000,'2021-03-22','22 month'),
(5,2,1400000,'2020-08-17','12 month');


INSERT INTO credits(type_id, client_id, summa, date_given, limit_month) VALUES
(5,2,1000000,'2023-05-21','16 month')
select debt_id,debts.credit_id,debt_amount, status_red, date_given, limit_date from debts, credits where debts.credit_id = credits.credit_id
select * from payments
select * from fines
select * from debts


INSERT INTO payments(debt_id, payment_date, payment_amount) VALUES 
(4,'2023-10-09', 5500000),
(3,'2023-06-09', 4800000),
(4,'2023-06-09', 4800000)
INSERT INTO payments(debt_id, payment_date, payment_amount) VALUES 
(1,'2023-02-01', 500000),
(1,'2023-03-01', 500000),
(1,'2023-06-01', 600000),
(2,'2023-02-28', 110000000),
(2,'2023-04-28', 120000000),
(3,'2023-04-30', 800000),
(3,'2023-05-30', 800000),
(3,'2023-06-30', 800000),
(7,'2020-06-24', 225000),
(7,'2021-06-24', 225000),
(7,'2022-06-24', 225000),
(7,'2023-06-24', 225000),
(8,'2020-06-09', 1490000),
(8,'2020-08-09', 1490000),
(8,'2020-11-09', 1490000),
(8,'2021-02-09', 1490000),
(8,'2021-06-09', 1490000),
(8,'2021-09-09', 1490000),
(8,'2022-01-09', 1490000),
(8,'2022-04-09', 1490000),
(8,'2022-12-09', 1490000),
(9,'2020-03-06', 39387.1875),
(9,'2020-05-06', 39387.1875),
(9,'2020-08-06', 39387.1875),
(9,'2020-11-06', 39387.1875),
(9,'2021-01-06', 39387.1875),
(9,'2021-03-06', 39387.1875),
(9,'2021-06-24', 39387.1875),
(9,'2021-11-24', 39387.1875),
(10,'2021-06-20', 39387.1875),
(10,'2021-08-20', 39387.1875),
(10,'2021-10-20', 39387.1875),
(10,'2021-12-20', 39387.1875),
(10,'2022-01-20', 39387.1875),
(10,'2022-02-20', 39387.1875),
(10,'2022-03-20', 39387.1875),
(11,'2021-05-25', 39387.1875),
(11,'2022-03-25', 39387.1875),
(11,'2023-04-25', 39387.1875),
(12,'2021-05-25', 2802750),
(12,'2022-03-25', 2802750),
(12,'2022-04-25', 2802750),
(12,'2023-04-25', 2802750),
(13,'2022-02-10', 300000),
(13,'2022-03-10', 300000),
(13,'2023-04-10', 300000),
(13,'2023-06-10', 300000),
(14,'2021-10-21', 1300000),
(14,'2022-10-21', 1300000),
(14,'2022-12-21', 1300000),
(15,'2022-01-14', 90416.66),
(15,'2022-04-14', 90416.66),
(15,'2023-01-14', 90416.66),
(15,'2023-04-14', 90416.66),
(16,'2022-03-12', 184500),
(16,'2022-08-12', 184500),
(16,'2023-01-12', 184500),
(16,'2023-04-12', 184500),
(17,'2022-03-12', 1559250),
(17,'2022-08-12', 155925),
(17,'2023-01-12', 155925),
(17,'2023-04-12', 155925),
(18,'2023-04-20', 580000),
(18,'2023-05-20', 580000),
(18,'2023-06-12', 580000),
(18,'2023-06-20', 580000),
(19,'2023-02-20', 16875),
(19,'2023-03-20', 16875),
(19,'2023-04-30', 16875),
(19,'2023-05-30', 16875),
(19,'2023-06-20', 16875),
(20,'2022-08-20', 250000),
(20,'2022-08-30', 250000),
(20,'2022-10-30', 4166.67),
(21,'2021-05-11', 1075000),
(21,'2021-08-11', 1075000),
(21,'2021-11-11', 1075000),
(21,'2022-01-11', 1075000),
(22,'2020-06-08', 669175),
(22,'2020-08-11', 669175),
(22,'2021-05-11', 669175),
(22,'2021-11-08', 669175),
(23,'2021-04-23', 650000),
(23,'2021-05-11', 650000),
(23,'2022-11-08', 63916.67),
(24,'2020-10-11', 700000),
(24,'2021-08-18', 700000);
























