CREATE TABLE credit_types (
	type_id SERIAL PRIMARY KEY,
	type_name VARCHAR NOT NULL,
	circs VARCHAR NOT NULL,
	bid DOUBLE PRECISION
);

CREATE TABLE clients (
	client_id SERIAL PRIMARY KEY,
	organisation VARCHAR NOT NULL,
	property VARCHAR,
	address VARCHAR NOT NULL,
	phone VARCHAR NOT NULL,
	client_name VARCHAR NOT NULL,
	passport VARCHAR NOT NULL
);



CREATE TABLE credits(
	credit_id SERIAL PRIMARY KEY,
	type_id INTEGER REFERENCES credit_types(type_id) NOT NULL,
	client_id INTEGER REFERENCES clients(client_id) NOT NULL,
	summa DOUBLE PRECISION, CHECK (summa > 0),
	date_given DATE,
	limit_month INTEGER, CHECK (limit_month > 0)
);

CREATE TABLE debts(
	debt_id SERIAL PRIMARY KEY,
	credit_id INTEGER REFERENCES credits(credit_id) NOT NULL,
	debt_amount DOUBLE PRECISION, CHECK (debt_amount > 0),
	status_red BOOL,
	limit_date DATE
);

CREATE TABLE payments(
	payment_id SERIAL PRIMARY KEY,
	debt_id INTEGER REFERENCES debts(debt_id) NOT NULL,
	payment_date DATE,
	payment_amount DOUBLE PRECISION, CHECK (payment_amount > 0)
);


CREATE TABLE fines(
	fine_id SERIAL PRIMARY KEY,
	debt_id INTEGER REFERENCES debts(debt_id) NOT NULL,
	client_id INTEGER REFERENCES clients(client_id) NOT NULL,
	fine_amount DOUBLE PRECISION NOT NULL
);

select * from pg_settings where name = 'port'
























