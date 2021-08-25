#SUBCONSULTAS: Una combinacion join siempre puede ser expresada como una subconsulta
#pero no al reves! (no toda subconsulta se puede expresar con join)

###Expresion basica

/*Creamos la Base de Datos.*/
CREATE DATABASE IF NOT EXISTS subconsultas;
USE subconsultas;

CREATE TABLE IF NOT EXISTS libros (
    codigo INT AUTO_INCREMENT,
    titulo VARCHAR(40),
    autor VARCHAR(30),
    editorial VARCHAR(20),
    precio DECIMAL(5 , 2 ),
    PRIMARY KEY (codigo)
);

insert into libros(titulo,autor,editorial,precio) 
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00);
 insert into libros(titulo,autor,editorial,precio)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00);
 insert into libros(titulo,autor,editorial,precio)
  values('Aprenda PHP','Mario Molina','Siglo XXI',40.00);
 insert into libros(titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',10.00);
 insert into libros(titulo,autor,editorial,precio)
  values('Ilusiones','Richard Bach','Planeta',15.00);
 insert into libros(titulo,autor,editorial,precio)
  values('Java en 10 minutos','Mario Molina','Siglo XXI',50.00);
 insert into libros(titulo,autor,editorial,precio)
  values('Martin Fierro','Jose Hernandez','Planeta',20.00);
 insert into libros(titulo,autor,editorial,precio)
  values('Martin Fierro','Jose Hernandez','Emece',30.00);
 insert into libros(titulo,autor,editorial,precio)
  values('Uno','Richard Bach','Planeta',10.00);
  
select * from libros;

/*Sintaxis básica Subconsultas*/
/*select CAMPOS from TABLA where CAMPO OPERADOR(SUBCONSULTA);*/	#SUBCONSULTA debe devolver un escalar, x eso en gral se usa select
/*select CAMPO OPERADOR(SUBCONSULTA) from TABLA;*/

#quiero saber el precio determinado de un libro y su diferencia con el libro mas costoso

select titulo, precio, precio - (select max(precio) from libros) #devuelve el max precio de libros
as diferencia from libros		#crea una columna diferencia xa ese valor
where titulo = 'uno';
#si no agrego el where me devuelve la diferencia de precio con cada uno de los libros

#supongamos q quiero ver el titulo y autor del libro con precio mas costoso
select titulo, autor, precio from libros where precio = (select max(precio) from libros); # ver que la subconsulta m deuvuelve un escalar (el max precio)

##CON IN y Not IN
#in o not in deben estar "aplicadas" a una lista

drop table if exists editoriales;
drop table if exists libros;


 create table editoriales( #contiene el nombre de la editorial y su respectivo codigo (campo codigo)
  codigo int auto_increment,
  nombre varchar(30),
  primary key (codigo)
 );
 
 create table libros ( #contiene el nombre del libro, etc etc y el CODIGO DE LA EDITORIAL (campo codigoeditorial)
  codigo int auto_increment,
  titulo varchar(40),
  autor varchar(30),
  codigoeditorial smallint,
  primary key(codigo)
 );

 insert into editoriales(nombre) values('Planeta');
 insert into editoriales(nombre) values('Emece');
 insert into editoriales(nombre) values('Paidos');
 insert into editoriales(nombre) values('Siglo XXI');

 insert into libros(titulo,autor,codigoeditorial) values('Uno','Richard Bach',1);
 insert into libros(titulo,autor,codigoeditorial) values('Ilusiones','Richard Bach',1);
 insert into libros(titulo,autor,codigoeditorial) values('Aprenda PHP','Mario Molina',4);
 insert into libros(titulo,autor,codigoeditorial) values('El aleph','Borges',2);
 insert into libros(titulo,autor,codigoeditorial) values('Puente al infinito','Richard Bach',2);
 
 select * from editoriales;
 select * from libros;

#quiero ver los nombres de las editoriales que han publicado libros de un determinado autor

select nombre from editoriales where codigo in (select codigoeditorial from libros where autor = 'Richard bach'); #ver q devuelve una lista

#opcion 2: solo consulatando tabla libros (solo puedo traer el codigo de la editorial y no el nombre)

select codigoeditorial from libros where autor ='Richard bach';

#opcion 3: con JOIN

select distinct nombre from editoriales as e
join libros as l
on codigoeditorial = e.codigo
where autor = 'Richard Bach';

#con Not in, para ver cuales no tienen libros de Richard Bach

select nombre from editoriales where codigo not in (select codigoeditorial from libros where autor = "Richard Bach");

##CON ANY-SOME (Sinonimos) - ALL
#devuelven True o Flase segun se cumpla o no la condicion

drop table if exists editoriales;
 drop table if exists libros;
 
 create table editoriales(
  codigo int auto_increment,
  nombre varchar(30),
  primary key (codigo)
 );
 
 create table libros (
  codigo int auto_increment,
  titulo varchar(40),
  autor varchar(30),
  codigoeditorial smallint,
  precio decimal(5,2),
  primary key(codigo)
 );

 insert into editoriales(nombre) values('Planeta');
 insert into editoriales(nombre) values('Emece');
 insert into editoriales(nombre) values('Paidos');
 insert into editoriales(nombre) values('Siglo XXI');

 insert into libros(titulo,autor,codigoeditorial,precio) values('Uno','Richard Bach',1,15);
 insert into libros(titulo,autor,codigoeditorial,precio) values('Ilusiones','Richard Bach',4,18);
 insert into libros(titulo,autor,codigoeditorial,precio) values('Puente al infinito','Richard Bach',2,20);
 insert into libros(titulo,autor,codigoeditorial,precio) values('Aprenda PHP','Mario Molina',4,40);
 insert into libros(titulo,autor,codigoeditorial,precio) values('El aleph','Borges',2,10);
 insert into libros(titulo,autor,codigoeditorial,precio) values('Antología','Borges',1,20);
 insert into libros(titulo,autor,codigoeditorial,precio) values('Cervantes y el quijote','Borges',3,25);
 
select * from editoriales;
select * from libros;

#Quiero ver si las editoriales de los libros de borges coinciden con las de alguno de los libros de richar bach
#Any - Some : mira que haya alguna, no necesariamente todas

select titulo from libros where autor = 'Borges' and codigoeditorial = any (
select e.codigo #devuelve los codigos
from editoriales as e
join libros as l 
on codigoeditorial = e.codigo
where l.autor = 'Richard Bach'); # de los libros de Richard Bach

#la consulta interna retorna una lista de valores de un solo cammpo (codigo)
#y la subconsulta externa compara cada codigo de editorial de Borges con las de Richard Bach
#comparo la lista de valores de la consulta externa con la lista de valores de la consulta interna
#nos devuelve las 2 editoriales q publicaron libros de ambos

#Ejemplo xa All. Voy a ver si TODAS las editoriales q han publicados libros de borges coinciden con
#las de Richard Bach

select titulo from libros where autor = 'Borges' and codigoeditorial = all(
select e.codigo
from editoriales as e
join libros as l
on codigoeditorial = e.codigo
where l.autor = "Richard Bach");
#como no coincide con todas, no me devuelve nada

#Quiero ver si algun precio de los libros de Borges es mayor que el de los libros de Bach

select titulo precio from libros where autor = "borges" and precio > any (
select precio from libros where autor = 'Richard Bach');
#me devuelve solo los libros de Bach con mayor precio q los de Borges

##CON EXIST- NOT EXISTS
#Se emplean xa ver si hay o no datos en una lista de valores
#devuelven True o False segun devuelve o no registro
drop table if exists facturas;
drop table if exists detalles;
 
 create table facturas(
  numero int not null,
  fecha date,
  cliente varchar(30),
  primary key(numero)
 );

 create table detalles(
  numerofactura int not null,
  numeroitem int not null, 
  articulo varchar(30),
  precio decimal(5,2),
  cantidad int,
  primary key(numerofactura,numeroitem)
 );

 insert into facturas values(1200,'2019-01-15','Juan Lopez');
 insert into facturas values(1201,'2012-01-15','Luis Torres');
 insert into facturas values(1202,'2019-01-15','Ana Garcia');
 insert into facturas values(1300,'2019-01-20','Juan Lopez');

 insert into detalles values(1200,1,'lapiz',1,100);
 insert into detalles values(1200,2,'goma',0.5,150);
 insert into detalles values(1201,1,'regla',1.5,80);
 insert into detalles values(1201,2,'goma',0.5,200);
 insert into detalles values(1201,3,'cuaderno',4,90);
 insert into detalles values(1202,1,'lapiz',1,200);
 insert into detalles values(1202,2,'escuadra',2,100);
 insert into detalles values(1300,1,'lapiz',1,300);
 
select * from facturas;
select * from detalles;

#exists
#Quiero los clientes que compraron lapices

select cliente, numero from facturas as f where exists(	#se 
select * from detalles as d 					#cumpla esto: (True o False)
where f.numero = d.numerofactura and articulo = 'lapiz');	#coinciden las facturas (de clientes y detalles)
															#y el articulo sea un lapiz
#not exists (los q no compraron lapices)
select cliente, numero from facturas as f where not exists( #no se cumpla esto
select * from detalles as d						#los que no compraron lapices
where f.numero = d.numerofactura and articulo = 'lapiz');

##CON UPDATE Y DELETE 

 drop table if exists editoriales;
 drop table if exists libros;
 
 create table editoriales(
  codigo int auto_increment,
  nombre varchar(30),
  primary key (codigo)
 );
 
 create table libros (
  codigo int auto_increment,
  titulo varchar(40),
  autor varchar(30),
  codigoeditorial smallint,
  precio decimal(5,2),
  primary key(codigo)
 );

 insert into editoriales(nombre) values('Planeta');
 insert into editoriales(nombre) values('Emece');
 insert into editoriales(nombre) values('Paidos');
 insert into editoriales(nombre) values('Siglo XXI');

 insert into libros(titulo,autor,codigoeditorial,precio) 
   values('Uno','Richard Bach',1,15);
 insert into libros(titulo,autor,codigoeditorial,precio)
   values('Ilusiones','Richard Bach',2,20);
 insert into libros(titulo,autor,codigoeditorial,precio)
   values('El aleph','Borges',3,10);
 insert into libros(titulo,autor,codigoeditorial,precio)
   values('Aprenda PHP','Mario Molina',4,40);
 insert into libros(titulo,autor,codigoeditorial,precio)
   values('Poemas','Juan Perez',1,20);
 insert into libros(titulo,autor,codigoeditorial,precio)
   values('Cuentos','Juan Perez',3,25);
 insert into libros(titulo,autor,codigoeditorial,precio)
   values('Java en 10 minutos','Marcelo Perez',2,30);

#voy a actualziar el precio de todos los libros de la editorial Emece con aumento del 10% (inflacion papá)

#update
#Sintaxis:
#update TABLA set CAMPO = NUEVO_VALOR where CAMPO = (Subconsulta)
update libros set precio = precio*(110/100) 
where codigoeditorial = (
select codigo from editoriales as e where nombre = 'Emece');

select * from libros;

#Delete
#voy a eliminar la editorial planeta (2 registros)
#Sintaxis:
#delete from TABLA where CAMPO = (Subconsulta)
delete from libros where codigoeditorial = (
select codigo from editoriales
where nombre = "planeta")
