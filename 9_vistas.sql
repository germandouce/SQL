#VISTAS
#sirven principalmente xa no tener que acceder a toda la tabla con toda la informacion sino solo a una parte de
#ella a tarves de una vista

CREATE DATABASE IF NOT EXISTS vistas;
USE vistas;

drop table if exists empleados;
drop table if exists secciones;

 create table secciones(
  codigo int auto_increment,
  nombre varchar(30),
  sueldo decimal(5,2),
  primary key (codigo)
 );

 create table empleados(
  legajo int auto_increment,
  documento char(8),
  sexo char(1),
  apellido varchar(40),
  nombre varchar(30),
  domicilio varchar(30),
  seccion int not null,
  cantidadhijos int,
  estadocivil char(10),
  fechaingreso date,
  primary key (legajo)
 );

insert into secciones(nombre,sueldo) values('Administracion', 300);
insert into secciones(nombre,sueldo) values('Contaduría', 400);
insert into secciones(nombre,sueldo) values('Sistemas', 500);

select * from secciones;

 insert into empleados (documento,sexo,apellido,nombre,domicilio,seccion,cantidadhijos,estadocivil,fechaingreso)
   values ('22222222','f','Lopez','Ana','Colon 123',1,2,'casado','2010-10-10');
 insert into empleados (documento,sexo,apellido,nombre,domicilio,seccion,cantidadhijos,estadocivil,fechaingreso)   
   values('23333333','m','Lopez','Luis','Sucre 235',1,0,'soltero','2010-02-10');
 insert into empleados (documento,sexo,apellido,nombre,domicilio,seccion,cantidadhijos,estadocivil,fechaingreso)
   values('24444444','m','Garcia','Marcos','Sarmiento 1234',2,3,'divorciado','2018-07-12');
 insert into empleados (documento,sexo,apellido,nombre,domicilio,seccion,cantidadhijos,estadocivil,fechaingreso)
   values('25555555','m','Gomez','Pablo','Bulnes 321',3,2,'casado','2018-10-09');
 insert into empleados (documento,sexo,apellido,nombre,domicilio,seccion,cantidadhijos,estadocivil,fechaingreso)
   values('26666666','f','Perez','Laura','Peru 1254',3,3,'casado','2019-05-09');

select * from empleados;

#Hay dos formas de crearlas,
#1)
#SINTAXIS BASICA: create view NOMBREVISTA as SENTENCIASSELECT from TABLA; 

create view vista_empleados as 
	select concat(apellido, ' ',e.nombre) as nombre,
		sexo as genero,
		s.nombre as seccion,
		cantidadhijos 
	from empleados as e
	join secciones as s on s.codigo = seccion;

drop view vista_empleados;

select * from vista_empleados;

select seccion, count(*) as cantidad	#creo la col cantidad con el count(*) de secciones
	from vista_empleados 
    group by seccion;

drop view vista_empleados;

#2) 
#SINTAXIS BASICA: create view NOMBREVISTA (NOMBRESDEENCABEZADOS) as SETENCIASSELECT from TABLA;

create view vista_empleados_ingreso (fecha_de_ingreso, cantidad) as
	select extract(year from fechaingreso)  as fecha_de_ingreso, #EXTRACT() returns a number
		count(*) as cantidad 								#which represents the month of the date.
    from empleados
    group by fecha_de_ingreso;

drop view vista_empleados_ingreso;

select * from vista_empleados_ingreso;


#VISTAS BASADAS EN OTRAS VISTAS

#Supongo q quiero ver todos los empleados que tengan mas de un hijo
 
select * from vista_empleados;

create view vista_empleados_con_hijos as 
	select nombre, genero, seccion, cantidadhijos
    from vista_empleados
    where cantidadhijos>0;
    
drop view vista_empleados_con_hijos;

select * from vista_empleados_con_hijos;


#---VISTAS ACTUALIZABLES---
#Insert-Update

/*Se pueden actualizar e insertar nuevos registros */
#MUY IMPORTATE:
#Si yo modifico una vista se modifica tambien en la tabla original
# *No se puede afcetar a mas de una tabla consultada
# *No se pueden cambiar los campos que son resultados de un campo
# *Las vistas no se pueden usar funciones de agrupamiento (count, max,
# min, avg
# *No puede haber clausulas distinct, left join, outer join, union, group by
# *No pueden tener su consulta en la clausula select
#Las vistas deben sersencillas para facilitar su actualización

drop table if exists alumnos;
drop table if exists profesores;

create table alumnos(
documento char (8),
nombre varchar(30),
nota decimal(4,2),
codigoprofesor int,
primary key (documento)
);

create table profesores (
codigo int auto_increment,
nombre varchar (30),
primary key(codigo)
);

 insert into alumnos values('30111111','Ana Algarbe', 5.1, 1);
 insert into alumnos values('30222222','Bernardo Bustamante', 3.2, 1);
 insert into alumnos values('30333333','Carolina Conte',4.5, 1);
 insert into alumnos values('30444444','Diana Dominguez',9.7, 1);
 insert into alumnos values('30555555','Fabian Fuentes',8.5, 2);
 insert into alumnos values('30666666','Gaston Gonzalez',9.70, 2);

 insert into profesores(nombre) values ('Yoselin Valdez');
 insert into profesores(nombre) values ('Luis Agromonte');
 
#Supongamos q quiero obtener los datos de los alumnos q aprbaron suponiendo 
#que se aprueba con 7 o mas junto al nombre del profe q lo califico

create view vista_nota_alumnos_aprobados as
	select 
    documento, 
    a.nombre as nombrealumno,
    p.nombre as nombreprofesor,
    nota,
    codigoprofesor 
	from alumnos as a
    join profesores as p 
    on a.codigoprofesor = p.codigo
    where nota >= 7;
    
drop view vista_nota_alumnos_aprobados;

select * from vista_nota_alumnos_aprobados;

#INSERTAR ALUMNO CALIFICADO A LA TABLA A TRAVÉS DE LA VISTA:

insert into vista_nota_alumnos_aprobados(
	documento, nombrealumno, nota, codigoprofesor)
    values('86876768', 'Juan Pablo', '10','1');

#Ver q en la tabla alumnos también se inserto el registro
select * from alumnos;
select * from vista_nota_alumnos_aprobados;

#Si intentamos actualizar un registro de alguien que SI esta en la TABLA, pero
#a traves de la vista, y que NO CUMPLE las condiciones de la VISTA
#NO se actualiza ni la VISTA ni la TABLA.
#(Carolina tenia un 4.5, es decir no estaba aprobada)

update vista_nota_alumnos_aprobados 
	set nota = 10 
	where documento = '30333333';	#Carolina Conte

#Ahora actulizamos el registro de alguien que SI CUMPLE la condiciones de la VISTA
#(esta efectivamente en la vista) y vemos que SI se actualiza la VISTA y 
#la TABLA original

update vista_nota_alumnos_aprobados 
	set nota = 10 
	where documento = '30444444';	#Diana Dominguez (9.70 -> 10)
    
select * from alumnos;
select * from vista_nota_alumnos_aprobados;

#Inserto a alguien en la vista con nota menor a 7 y 
#vemos q SI se agrega a la TABLA original pero
#NO a la VISTA (

insert into vista_nota_alumnos_aprobados(
	documento, nombrealumno, nota, codigoprofesor)
    values('86586932', 'Alejandro Martinez', '5','2');
    
select * from alumnos;
select * from vista_nota_alumnos_aprobados;
