create table customer (
	customer_id SERIAL primary key,
	customer_name VARCHAR(100),
	billing_info VARCHAR(100)
);

create table salesperson (
	salesperson_id SERIAL primary key,
	salesperson_name VARCHAR(100),
	shift_time VARCHAR(10)
);

create table car (
	car_id SERIAL primary key,
	make VARCHAR(100),
	model VARCHAR(100),
	car_year VARCHAR(4),
	color VARCHAR(100),
	in_stock VARCHAR(3),
	used_not_used VARCHAR(100),
	car_cost FLOAT(10)
);

create table bought_car (
	bought_id SERIAL primary key,
	date_bought VARCHAR(10),
	customer_id INTEGER not null,
	car_id INTEGER not null,
	salesperson_id INTEGER not null,
	foreign key(customer_id) references customer(customer_id),
	foreign key(car_id) references car(car_id),
	foreign key(salesperson_id) references salesperson(salesperson_id)
);

create table invoice (
	invoive_id SERIAL primary key,
	total FLOAT(10),
	salesperson_id INTEGER not null,
	customer_id INTEGER not null,
	bought_id INTEGER not null,
	foreign key(salesperson_id) references salesperson(salesperson),
	foreign key(customer_id) references customer(customer_id),
	foreign key(bought_id) references bought_car(bought_id)
);

create table mechanic (
	mechanic_id SERIAL primary key,
	postition VARCHAR(100),
	shift_time VARCHAR(10)
);


create table service_ticket (
	ticket_id SERIAL primary key,
	parts_required BOOLEAN,
	service_cost FLOAT(10),
	customer_id INTEGER not null,
	car_id INTEGER not null,
	foreign key(customer_id) references customer(customer_id),
	foreign key(car_id) references car(car_id)
);

create table mechanic_group (
	mg_id SERIAL primary key,
	mechanic_id INTEGER not null,
	ticket_id INTEGER not null,
	foreign key(mechanic_id) references mechanic(mechanic_id),
	foreign key(ticket_id) references service_ticket(ticket_id)
);


insert into customer (
	customer_id,
	customer_name,
	billing_info
) values (
	1,
	'John John',
	'1212-1313-1414-1515 125 12/24'
);

insert into customer (
	customer_id,
	customer_name,
	billing_info
) values (
	2,
	'Bill John',
	'0123-4567-8910-2345 135 01/24'
);

insert into car (
	car_id,
	make,
	model,
	car_year,
	color,
	in_stock,
	used_not_used,
	car_cost
) values (
	1,
	'Bean',
	'Beanton',
	'2012',
	'Red',
	'123',
	'used',
	1200.40
);

insert into car (
	car_id,
	make,
	model,
	car_year,
	color,
	in_stock,
	used_not_used,
	car_cost
) values (
	2,
	'Bean',
	'Express',
	'2014',
	'White',
	'20',
	'used',
	2400.00
);

insert into salesperson (
	salesperson_id,
	salesperson_name,
	shift_time
) values (
	1,
	'John Bean',
	'4th Shift'
);

insert into salesperson (
	salesperson_id,
	salesperson_name,
	shift_time
) values (
	2,
	'Benson Gregson',
	'2nd Shift'
);

insert into bought_car (
	bought_id,
	date_bought,
	customer_id,
	car_id,
	salesperson_id 
) values (
	1,
	'07/20/2020',
	1,
	2,
	1
);

insert into bought_car (
	bought_id,
	date_bought,
	customer_id,
	car_id,
	salesperson_id 
) values (
	2,
	'09/21/2020',
	2,
	1,
	2
);

create or replace function addmechanic(_mechanic_id INTEGER, _position VARCHAR, _shift_time VARCHAR)
returns void
as $MAIN$
begin 
	insert into mechanic(mechanic_id, postition, shift_time)
	values (_mechanic_id, _position, _shift_time);
end;
$MAIN$	
language plpgsql

select addmechanic(1, 'Head Mechanic', '3rd Shift');
select addmechanic(2, 'Supervisor', '1st Shift');


insert into service_ticket (
	ticket_id,
	parts_required,
	service_cost,
	customer_id,
	car_id
) values (
	1,
	True,
	1200.00,
	1,
	2
);

insert into service_ticket (
	ticket_id,
	parts_required,
	service_cost,
	customer_id,
	car_id
) values (
	2,
	false,
	1290.00,
	2,
	1
);

insert into mechanic_group (
	mg_id,
	mechanic_id,
	ticket_id
) values (
	1,
	1,
	2
);

insert into mechanic_group (
	mg_id,
	mechanic_id,
	ticket_id
) values (
	2,
	1,
	1
);
