#ALTER TABLE
/*Trabaja (aproximadamente) haciendo una copia de la tabla original, 
le realiza todos los cambios a la copia, borra la tabla original y 
renombra la copia*/
#alter table "NOMBRETABLA" operacion;

#Operaciones:
#add drop: Agregar y eliminar campos
#modify: Modifica el tipo de dato de un campo
#change: Cambia el nombre de un campo
#add unique key(CAMPO)/ primary key(CAMPO)/ index(CAMPO): agrega un indice
#rename: Cambia nombre de una tabla

create database if not exists curso_sql_alter_table;
use curso_sql_alter_table;

create table productos(
id int unsigned not null auto_increment,
nombre varchar(50),
primary key (id)
);

#AGREGAR Y ELIMINAR CAMPOS: add & drop

alter table productos add precio int; #agrega el campo precio
alter table productos add cantidad smallint unsigned not null;
alter table productos drop precio; #Elimina la col precio
alter table productos drop precio, drop cantidad; #Elimino dos campos a la vez
#OJO, SI UN CAMPO TIENE UN INDICE Y LO BORRO, BORRO EL INDICE TAMBIÉN

#MODIFICAR TIPO DE DATO DE LOS CAMPOS DE UNA TABLA: modify

alter table productos modify nombre varchar(100) not null;
alter table productos modify precio decimal(5,2) not null;
/*SI ACHICO EL RANGO DE UN TIPO DE DATO (X EJEMPLO DE CHAR(100) CHAR PASO A CHAR(50)),
LOS CARACTERES DE MÁS SE BORRAN)
SI PASO DE NULL A NOT NULL, PASARA AL VALOR DEFAULT */

#MODIFICAR EL NOMBRE DE UN CAMPO: change

alter table productos change cantidad stock int; #cambio el nombre del campo cantidad a stock
alter table productos change titulo_p titulo_p varchar(50) not null; #de nombre a titulo_P

#AGREAR INDICES

#CLAVE PRIMARIA

create table productos_2(
id int unsigned not null,
nombre varchar (50)
);
#AGREGRA: add primary key
alter table productos_2 add primary key(id);
alter table productos_2 modify id int unsigned auto_increment not null;

#ELIMINAR: 1º modify (sacar autoincrement) 2º drop primary key
alter table productos_2 drop primary key; #OJO NO funciona si no borramos el auto_increment
alter table productos_2 modify id int unsigned;

#AGREGAR INDICES COMUNES (kEY): add-drop-index

alter table productos_2 add precio int; #agrega el campo precio
alter table productos_2 add cantidad smallint unsigned not null;

alter table productos_2 add index i_precio (precio); #Agrego el indice i_precio en precio
alter table productos_2 drop index i_precio; #Lo saco

alter table productos_2 add index i_Precio_Cantidad (precio, cantidad); /*Agrego un indice llamada i_Precio_Ca... a 
los campos precio y cantidad*/
alter table productos_2 drop index i_Precio_Cantidad; #Lo saco
describe productos_2;

#CAMBIAR EL NOMBRE A UNA TABLA: Rename, to

show tables;
describe clientes;
describe productos_2;

alter table productos_2 rename clientes; #Cambio el nombre de productos_2 a clientes
rename table clientes to productos_2; #clientes -> productos_2 OJO NO va alter table
rename table productos_2 to auxiliar, #La segunda tabla q cree ahora se llama auxiliar
productos to productos_2, #la primera, productos, se llama productos_2
auxiliar to clientes; #La segunda tabla q cree se llama clientes#