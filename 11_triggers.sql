##TRIGERS
#Sirven para ejecutar una accion sobre una tabla automaticamente
#(e indirectamente) antes o despues de hacer de realizar otra accion. 
#Justamente se llaman disparadores xq se disparan al momento de ejecutar
#otra operacion en alguna tabla. Seria como un "efecto secundario" deseado
#de la operacion incial.


CREATE DATABASE IF NOT EXISTS disparadores_triggers;
USE disparadores_triggers;

drop table if exists usuarios;
drop table if exists clavesanteriores;


create table usuarios(
 nombre varchar(30),
 clave varchar(30),
 primary key (nombre)
);

create table clavesanteriores(
 numero int auto_increment,
 nombre varchar(30),
 clave varchar(30),
 primary key (numero)
);

##SINTAXIS BASICA
#create trigger NOMBRETRIGGER
#[before/ after] [insert/delete/update]
#on TABLA
#for each row
#begin
#end

#Eliminacion
#drop trigger if exists NOMBRETRIGGER

#Cuando un usuario actualize su contraseña se va a guardar 
#en claves_anteriores

##TRIGGERS - UPDATE
delimiter //
create trigger before_usuarios_update 
before update #Antes de q se actualize 
on usuarios #usuarios
for each row
begin
	insert into clavesanteriores(nombre, clave) values(old.nombre, old.clave);
end //
delimiter ;

insert into usuarios(nombre, clave) values('Juan', '1234');
insert into usuarios(nombre, clave) values('Pepe', '1234');
insert into usuarios(nombre, clave) value('Martin', '1234');

select * from usuarios;

#El trigger se va a disparar cuando ejecutemos una actiualizacion en
# la tabla usuarios con UPDATE
select * from clavesanteriores;
#x ahora esta vacia xq no hemos hecho ningun cambio...

#pero si ahora actulizamos la contraseña de juan x ejemplo...
update usuarios set clave ='5678' where nombre = 'juan';
update usuarios set clave ='1111' where nombre = 'Pepe';
update usuarios set clave ='1010' where nombre = 'Martin';

#Vemos q en usuarios juan tiene como contraseña 5678...
select * from usuarios;

#y como se disparo el trigger, 
#se ha guardado su vieja contraseña en clavesanteriores
select * from clavesanteriores;


##TRIGGERS - INSERT
#Ahora el Trigger se disparara solo cuando se inserte un valor en la tabla
#con el evento INSERT

drop table if exists ventas;
drop table if exists libros;

create table libros(
  codigo int auto_increment,
  titulo varchar(50),
  autor varchar(50),
  editorial varchar(30),
  precio float, 
  stock int,
  primary key (codigo)
 );

 create table ventas(
  numero int auto_increment,
  codigolibro int,
  precio float,
  cantidad int,
  primary key (numero)
 );

 insert into libros(titulo, autor, editorial, precio, stock)
  values('Uno','Richard Bach','Planeta',15,100);   
 insert into libros(titulo, autor, editorial, precio, stock)
  values('Ilusiones','Richard Bach','Planeta',18,50);
 insert into libros(titulo, autor, editorial, precio, stock)
  values('El aleph','Borges','Emece',25,200);
 insert into libros(titulo, autor, editorial, precio, stock)
  values('Aprenda PHP','Mario Molina','Emece',45,200);
  
#Vamos a hacer lo siguiente:
#Cada vez q se produzca una venta, vamos actualizar libros sacando
#del stock el numero de libros q se hayan 
#vendido a través de un Trigger

delimiter //
create trigger before_ventas_insert
before insert
on ventas
for each row
begin
	update libros set stock = libros.stock - new.cantidad	#new hace referencia a la nueva
    where new.codigolibro = libros.codigo;				#cant que insertamos
end //
delimiter ;

drop trigger before_ventas_insert;

select * from libros;

#Inserto una venta
insert into ventas(codigolibro, precio, cantidad) values(3, 25, 25);

#Ahora en ventas aparece la venta y en libros hay 175 unidades de stock de el Aleph
#(Antes habia 200)
select * from ventas;
select * from libros;


##TRIGGERS - DELETE
#Ahora el Trigger se disparara solo cuando se inserte un valor en la tabla
#con el evento DELETE

#Supongo q el que compro el libro lo devuelve, o es una biblioteca o alquiler
#Entonces el stock volverá a su estado inicial

delimiter //
create trigger  before_ventas_delete
before delete	#antes de que se elimine en ventas
on ventas
for each row
begin
	# #old hace referencia a la "vieja" cantidad en ventas (la que elminamos)
	update libros set stock = libros.stock + old.cantidad 
    where  libros.codigo = old.codigolibro;	
end //								
delimiter ;

#(aclaracion N:B: insert -> new.campo, update/delete -> old.campo)
#Pues si voy a insertar tengo q agregar un new campo mientras que si elimino,
#tengo que ir a buscar el viejo campo que elimine

#Vemos que quedan 175 libros de el aleph
select * from libros;

#y si eliminamos (delete) una venta (equivalente a devolver un libro o cancelarla)
#volvemos a tener 200 ejemplares de el Aleph 
#xq salta el trigger q acabamos de crear

delete from ventas where numero = 1;
select * from libros;
select * from ventas;

#y ventas queda vacia


