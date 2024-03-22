-- Flota de Vehiculos Keepcoding
-- Juan David Pardo 

-- Creamos el Esquema

create schema flota_keepcoding;

-- A continuación, creamos todas las tablas con sus claves primarias

create table flota_keepcoding.vehiculos (
	id_vehiculo serial primary key,
	matricula varchar (30) not null,
	num_chasis varchar(30) not null,
	kilometros numeric not null,
	fecha_adquisicion date not null,
	id_aseguradora int not null,
	id_modelo int not null,
	id_color int not null
);

create table flota_keepcoding.grupo (
	id_grupo serial primary key,
	nombre_grupo varchar (60) not null
);

create table flota_keepcoding.marca (
	id_marca serial primary key,
	nombre_marca varchar (30) not null,
	id_grupo int not null
);

create table flota_keepcoding.modelo (
	id_modelo serial primary key,
	nombre_modelo varchar (30) not null,
	id_marca int  not null
);

create table flota_keepcoding.color (
	id_color serial primary key,
	nombre_color varchar (30) not null
);

create table flota_keepcoding.compania_aseguradora (
	id_aseguradora serial primary key,
	nombre_aseguradora varchar (30) not null
);

create table flota_keepcoding.poliza (
	id_poliza serial primary key,
	num_poliza numeric not null,
	nombre_poliza varchar (30) not null,
	inicio_cobertura date not null,
	vigencia_poliza boolean not null,
	id_vehiculo int not null,
	id_aseguradora int not null
);

create table flota_keepcoding.mantenimientos (
	id_mantenimientos serial primary key,
	kilometraje numeric not null,
	fecha_revision date not null,
	valor_importe numeric not null,
	id_vehiculo int not null,
	id_moneda int not null
);

create table  flota_keepcoding.moneda (
	id_moneda serial primary key,
	nombre varchar(30) not null
);

-- Una vez creadas las tablas, podemos proceder a crear las relaciones

alter table flota_keepcoding.marca add constraint pk_marca_grupo foreign key (id_grupo) references flota_keepcoding.grupo(id_grupo);
alter table flota_keepcoding.modelo add constraint pk_modelo_marca foreign key (id_marca) references flota_keepcoding.marca(id_marca);
alter table flota_keepcoding.vehiculos add constraint pk_vehiculos_modelo foreign key (id_modelo) references flota_keepcoding.modelo(id_modelo);
alter table flota_keepcoding.vehiculos add constraint pk_vehiculos_color foreign key (id_color) references flota_keepcoding.color(id_color);
alter table flota_keepcoding.poliza add constraint pk_poliza_vehiculos foreign key (id_vehiculo) references flota_keepcoding.vehiculos(id_vehiculo);
alter table flota_keepcoding.poliza add constraint pk__poliza_aseguradora foreign key (id_aseguradora) references flota_keepcoding.compania_aseguradora(id_aseguradora);
alter table flota_keepcoding.mantenimientos add constraint pk_mantenimientos_vehiculos foreign key (id_vehiculo) references flota_keepcoding.vehiculos(id_vehiculo);
alter table flota_keepcoding.mantenimientos add constraint pk_mantenimientos_moneda foreign key (id_moneda) references flota_keepcoding.moneda(id_moneda);

-- Ahora cargamos todos los datos:

-- Asegúrate de que hayan datos en la tabla flota_keepcoding.color
insert into flota_keepcoding.color (nombre_color) 
select distinct nombre_color 
from( 
	values ('Rojo'),	('Gris Plateado'),	('Gris Plateado'),	('Blanco'),	('Blanco'),	('Blanco'),	('Negro')
) as valores(nombre_color)
;
-- Asegúrate de que hayan datos en la tabla flota_keepcoding.moneda
insert into flota_keepcoding.moneda (nombre) 
select distinct nombre 
from( 
	values ('Peso Colombiano'),	('Dólar'),	('Euro'),	('Peso Colombiano'),	('Peso Colombiano'),	('Euro'),	('Peso Colombiano'),	('Dólar'),	('Peso Mexicano'),	('Peso Mexicano'),	('Peso Mexicano'),	('Euro')
) as valores(nombre)
;
-- Asegúrate de que hayan datos en la tabla flota_keepcoding.grupo
insert into flota_keepcoding.grupo (nombre_grupo) values
('Renault-Nissan-Mitsubishi Alliance'),	('PSA Peugeot S.A.'),	('Hyundai Motor Group')
;
-- Ahora puedes insertar datos en la tabla flota_keepcoding.marca
insert into flota_keepcoding.marca (nombre_marca, id_grupo) values
('Renault',1),	('Citroën',2),	('Nissan',3)
;
-- Ahora puedes insertar datos en la tabla flota_keepcoding.marca
insert into flota_keepcoding.modelo (nombre_modelo, id_marca) values
('Clio',1),	('DS4',3),	('DS4',3),	('Leaf',3),	('Ceed',3),	('Ceed',3),	('206',2),	('206',2),	('206',2),	('206',2),	('Qashqai',1),	('Rio',3)
;
-- Ahora puedes insertar datos en la tabla flota_keepcoding.compañia_aseguradora
insert into flota_keepcoding.compania_aseguradora (nombre_aseguradora)
select distinct nombre_aseguradora
from(
values ('Allianz'),	('Allianz'), ('Axa'), ('Allianz'),	('Allianz'), ('Mapfre'))
as valores(nombre_aseguradora)
;
-- Ahora puedes insertar datos en la tabla flota_keepcoding.vehiculos
insert into flota_keepcoding.vehiculos (matricula, num_chasis, kilometros, fecha_adquisicion, id_aseguradora, id_modelo, id_color)
values ('7343FRT', 510803, 47644, '2009/06/01', 1, 1, 1),('2438GSV', 442284, 52349, '2010/04/17', 2, 2, 1),('9666FZC', 556817, 39533, '2008/03/03', 1, 3, 3),('7221BJG', 426457, 70197, '1999/09/30', 4, 2, 2),('6756GXW', 426511, 112881, '2011/07/19', 2, 3, 3),('9314JHS', 468948, 41064, '2017/10/10', 1, 3, 4)
;
-- Ahora puedes insertar datos en la tabla flota_keepcoding.poliza
insert into flota_keepcoding.poliza (num_poliza, nombre_poliza, inicio_cobertura, vigencia_poliza, id_vehiculo, id_aseguradora) 
values (25786,'Esencial','2009-06-01',true,1,1),(195443,'Esencial','2010-04-17',true,1,1),(110761,'Basico','2011-08-23',true,2,2),(79841,'Basico','2008-03-03',true,2,2),(112320,'Amplio Plus','1999-09-30',true,2,3),(135515,'Esencial','2001-04-05',true,3,1),(142266,'Amplio Plus','2011-07-19',true,3,2),(142266,'Amplio','2011-07-19',true,3,2),(142266,'Basico','2011-07-19',true,4,2),(159753,'Basico','2012-10-22',true,4,3)
;
-- Ahora puedes insertar datos en la tabla flota_keepcoding.mantenimiento
insert into flota_keepcoding.mantenimientos (id_vehiculo, kilometraje, fecha_revision, valor_importe, id_moneda)
values (1,29564,'2020/07/07',1076032.5,2),	(2,12028,'2010/05/13',734.1,3),	(2,28312,'2016/05/17',460,4),(3,19543,'2017/12/13',344330.4,2),	(4,12066,'2000/05/18',1162115.1,2),	(4,41764,'2008/05/24',800,4),	(5,21955,'2012/01/19',3615469.2,2),	(5,50738,'2012/04/02',697.5,3),	(5,74499,'2012/06/28',11869.2,1),	(5,94670,'2013/06/24',3579.6,1),	(6,24441,'2019/09/04',14695.2,1),	(1,11140,'2021/12/04',730,4),	(2,20410,'2022/07/08',7912.8,1),	(6,19245,'2014/05/16',570,4),	(5,16209,'2014/02/10',120.9,3),	(3,27845,'2014/04/27',80,4)
;


-- Crear la consulta

--consulta de mantenmientos e importes

SELECT vehiculos.matricula, mantenimientos.kilometraje, mantenimientos.fecha_revision, mantenimientos.valor_importe, moneda.nombre 
FROM flota_keepcoding.mantenimientos
INNER JOIN flota_keepcoding.moneda ON mantenimientos.id_moneda = moneda.id_moneda
INNER JOIN flota_keepcoding.vehiculos ON vehiculos.id_vehiculo = mantenimientos.id_vehiculo;

--consulta listado de coches activos en Keepcoding

SELECT grupo.nombre_grupo, marca.nombre_marca, modelo.nombre_modelo, vehiculos.fecha_adquisicion, vehiculos.matricula, vehiculos.num_chasis, color.nombre_color, vehiculos.kilometros, compania_aseguradora.nombre_aseguradora, poliza.num_poliza
FROM flota_keepcoding.vehiculos
INNER JOIN flota_keepcoding.modelo ON vehiculos.id_modelo = modelo.id_modelo
INNER JOIN flota_keepcoding.marca ON modelo.id_marca = marca.id_marca
INNER JOIN flota_keepcoding.color ON vehiculos.id_color = color.id_color
INNER JOIN flota_keepcoding.poliza ON vehiculos.id_vehiculo = poliza.id_vehiculo
INNER JOIN flota_keepcoding.compania_aseguradora ON poliza.id_aseguradora = compania_aseguradora.id_aseguradora
INNER JOIN flota_keepcoding.grupo ON marca.id_grupo = grupo.id_grupo
WHERE poliza.vigencia_poliza = true;


