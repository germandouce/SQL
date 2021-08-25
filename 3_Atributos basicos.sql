#ATRIBUTOS BASICOS
#null, default
use curso_sql_2;

create table if not exists libros(
id int unsigned auto_increment, 
titulo varchar (40) not null, # el not null ALERTA SI el usuraio no coloca nada OJO SI AGREGA EL RESTO DE LOS DATOS
editorial varchar (15), #si no aclaro not null, si el usuario no ingresa nada, queda el campo VACIO (NULL)
autor varchar(30) default 'Desconocido', #si el usuraio no ingresa nada, queda por default 'desconocido'
Precio decimal (5,2) unsigned default 8.25,
cantidad mediumint unsigned not null,
primary key (id) #Observar que el id es primary key enntonces no puede ser null
);

insert into libros (titulo, editorial, autor, precio, cantidad) values('c# en una hora','SQL','Miguel',15.2, 50); 
insert into libros (editorial, autor) values('LAL','Fer'); 
insert into libros (titulo, cantidad) values('SQL', 200); 
select * from libros;
describe libros;

#zerofill Coloca 0's antes de un numero
create table if not exists libros_2(
id int zerofill unsigned auto_increment, 
titulo varchar (40) not null, # el not null ALERTA SI el usuraio no coloca nada OJO SI AGREGA EL RESTO DE LOS DATOS
editorial varchar (15), #si no aclaro not null, si el usuario no ingresa nada, queda el campo VACIO (NULL)
autor varchar(30) default 'Desconocido', #si el usuraio no ingresa nada, queda por default 'desconocido'
Precio decimal (5,2) unsigned default 8.25,
cantidad mediumint zerofill unsigned not null,
primary key (id) #Observar que el id es primary key enntonces no puede ser null
);
insert into libros_2 (titulo, editorial, autor, precio, cantidad) values('c# en una hora','SQL','Miguel',15.2, 50);
select * from libros_2;

select * from libros;

