#Eliminar la bsase de datos ya existente
#drop database if exists cursocompleto;

#show databases;

create database if not exists curso_sql_2;
use curso_sql_2;

#Primary Key, los campos no pueden ser null por predeterminado, y debn ser unicos

create table if not exists usuario(
nombre varchar (50),
apellido varchar (50),
correo varchar (100),
primary key (nombre)
);
insert into usuario values ('juan', 'perez', 'juan@juan.com');
insert into usuario values ('juan', 'Lopez', 'juan@jlopez.com'); #tira error porque nombre es primary key
describe usuario;

create table if not exists productos(
id int auto_increment,
producto varchar (50),
descripcion text,
precio float (11),
primary key (id)
);

describe productos;  #Muetsra los nombres de las columnas

insert into productos values(null,'laptop','La mejor laptop del mercado',128.6);
insert into productos values(null,'Mouse','Prende luz',32.67);
insert into productos (id, producto, descripcion, precio) values (null,'laptop', 'la mejor', 45.80);
select * from productos;

#delete from productos; #borra toda la tabla productos, pero continua la el auto increment
#truncate table productos; #borra toda la tabla producto pero comienza dese cero el autoincrement, vuelve a valores orig

create table personas(
	id integer unsigned not null, #unsigned es sin signo, todos positivos
	nombre varchar (50),
	edad integer unsigned, #
	primary key (id)
);

describe personas;

#TIPOS DE DATOS
#NUMERICOS

#ENTERO
/* van de negativos a positivos
TINYINT: numeros entre: -127 128 UNSIGNED (o 255 con signo)
SMALLINT:  65 mil numeros
MEDIUMINT: 5 Millones aprox
INT	o INTEGER: 200 Millones aprox
BIGINT: 2 mil Millones aprox
*/
#DECIMAL
/*
FLOAT: float(6.24) (digitos_enteros.digitos_decimale) en prox versiones el decimal se asume solo
DOUBLE: double (4.53)
DECIMAL: decimal (64 digitos totales) (.30 max) NO REDONDEA, CORTA 
*/

#CADENAS
/* 
CHAR: (255 chars max) ocupa lo q coloco entre parentesis
nombre char (9) juan -ocupa 9-
VARCHAR: 255 - 65 mil
nombre varchar (9) juan -ocupa 4-, se dapata al datoq meto MUY UTIL
BINARY Y VARBINARY: (ceros y 1's xa estados en general)
TEXT: xa textos no muy util
BLOB: 65mil bytes xa imagenes, archivos binarios pesados
TINYBLOB 255bytes , MEDIUMBLOB Y LONGBLOB (4GB)
ENUM: 65mil bytes creo una enumeracion y no se puede guardar ningun tipo datos que no este en esa lista
SET: 64 opciones conjunto, similar a enum pero PERMITE EL VACIO
*/

#FECHA
/*
DATE: AAAA-MM-DD
DATETIME: AAAA-MM-DD HH:MM:SS usa un campo distinto para le fecha y xa la hora
TIME: HH-MM-SS
TIMESTAMP: AAAA-MM-DD o sino AA-MM-DD
YEAR 
*/

