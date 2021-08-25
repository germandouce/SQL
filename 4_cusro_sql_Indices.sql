#INDICES

create database if not exists curso_sql_indices;
use curso_sql_indices;

/*DEF: Un indice es un tipo de archivo, con 2 entradas, uno de data y uno de puntero
Posibilita el acceso directo y rapido haciendo mas eficiente la busqueda. Sin indice se
debe recorrer secuencialmente toda la tabla. Con los indices se disminuye el timepo de busqueda
de datos en la tabla. Unica desventaja: Ocupa espacio en el disco
*Se crean indices en aquellos campos por los cuales se realizan operaciones de busqueda con frecuencia
*Pueden ser multicolumna, es decir pueden estar formados por mas de un campo
*Maximo de 64 indices x tabla, cada nombre tiene long maxima de 64 chars
*/
#INDICES: 

#PRIMARY :  primry key, clave primaria
/*no se pueden repeir, no pueden ser nulos, una sola por tabla/*

#UNIQUE :  unique key, clave unica 
/*indice para el cual los valores deben ser unicos y diferentes*/

#INDEX (KEY) : Indice comun,
/*no son unicos, podemos darle un nombre o uno por defecto, aceptan null, varios por tabla */

#PRIMARY KEY, debe ser numerico o caracteres. Mejor con tipo numerico. deben ser unicos y no nulos
create table if not exists libros(
id int unsigned auto_increment not null,
titulo varchar(100),
autor varchar(50),
descripcion text,
editorial varchar (15),
primary key(id) #Craecion de indice primary key
);

show tables;
select * from libros;
show index from libros;

#INDICE COMUN (KEY): Un campo en el q vayamos a hacer frecuentemente consultas
create table if not exists libros_2(
id int unsigned auto_increment not null,
titulo varchar(100),
autor varchar(50) not null,
descripcion text,
editorial varchar (15) not null,

primary key(id),
Index i_autor_editorial (autor, editorial) #creacion de 2 indices comun a la vez
);
#drop table libros_2;
show index from libros_2;

#UNIQUE KEY (unico): permite nulos y el regustro debe ser unico

create table if not exists libros_3(
id int unsigned auto_increment not null,
titulo varchar(100),
autor varchar(50) not null,
descripcion text,
editorial varchar (15) not null,

primary key(id),
Index i_autor (autor),
unique uq_titulo (titulo) #Creacion de index unique
);
show index from libros_3;

#ejemplo de error al agregar campo repetido a indice unique
insert into libros_3 (titulo, autor, editorial) values ('Java en 10 minutos', 'Alejandro', 'La Maravilla');
insert into libros_3 (titulo, autor, editorial) values ('Java en 11 minutos', 'Alejandro', 'La Maravilla');

select * from libros_3;

#ELIMINAR UN INDICE
drop index i_autor on libros_3;
show index from libros_3;
drop index uq_titulo on libros_3;

#Crear indices una tabla ya creada

create table if not exists libros_4(
id int unsigned auto_increment not null,
titulo varchar(100),
autor varchar(50) not null,
descripcion text,
editorial varchar (15) not null,

primary key(id)
);

create index i_editorial on libros_4 (editorial); #create index "index_name" on "table_name("campo")"
create unique index uq_titulo on libros_4 (titulo); #idem antes

show index from libros_4;
select * from libros_4;