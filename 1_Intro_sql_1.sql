create database curso_sql;

/*show databases;
	drop databse*/
use curso_sql; /* indico q base datos voy a usar, en este caso: curso_sql*/

create table usuario(
nombre varchar (50),
edad int 
);

show tables; #muestra todas las tablas
describe usuario; #muestra los campos de la tabla, no los datos
#drop table usuario; #borra completamente la tabla usuario

create table alumnos(
nombre varchar(50),
apellido varchar(50),
direccion varchar (100),
telefono varchar(15),
edad int
);
/*insertar datos en una tabla*/
/*especificando todos los campos y datos*/
insert into alumnos(nombre, apellido, direccion, telefono, edad)
values ('juan','Martinez', 'Barrio Duarte', '824628364835285',35); 
/*especificando solo datos EN ORDEN*/
insert into alumnos values('jose','Montero','27 de febrero','156473546374645',30);
/*especificando los campos que quiero modificar y respectivos datos*/
insert into alumnos (nombre, telefono, edad) values ('Miguel','123456789012345',32); 

#SELECT funciona similar a un console.log o print por consola. 

select * from alumnos; /*selecciona toda (*) la tabla alumnos*/
select edad, apellido from alumnos; /*xa seleccionar un campo especifico*/

select *from alumnos where nombre = 'Juan';
select nombre, edad from alumnos where nombre='juan' and edad=32;

#operadores relacionales
# = 
# < > distinto
# > mayor, menor, 
select * from alumnos where nombre <> 'juan';
select nombre, apellido from alumnos where edad > 15;
select * from alumnos where edad < 40;
select * from alumnos where edad <= 30;
select * from alumnos;

#Borrar registros de una tabla

#delete from alumnos; 
/*borra toda la tabla 
SI ESTA PUESTO SAFE UPDATE, no se pueden borrar (preferencias)*/

#delete from alumnos where nombre = 'juan'; #borra toda la fila juan

#Update, modificar un campo especifico set nombre del campo

update alumnos set edad = 33; #actaulizar EL CAMPO edad DE TODAS las columnas
update alumnos set edad = 15 where nombre = 'pedro';
update alumnos set direccion = 'Mendoza', telefono = '5678567342' where edad= '32';
update alumnos set apellido = 'Alvarez' where nombre = 'Miguel';
update alumnos set apellido = ' Montero' where nombre = 'jose' or nombre = 'pedro';
select * from alumnos;
describe alumnos;



