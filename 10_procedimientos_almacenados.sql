#PROCEDIMIENTOS ALMACENADOS
#Puden hacer referencia a tablas, vistas u otros procedimientos almacenados
#e incluir cualquier cantidad de instrucciones
#Sirven para ejecutar una accion sobre una tabla y guardar
#esta ""acion"" u ""operacion""  bajo el nombre que se le de.
#Son una especie de funcion definida

create database if not exists procedimientosalmacenados;
use procedimientosalmacenados;

drop table if exists libros;

create table libros(
	codigo int auto_increment,
    titulo varchar(40),
    autor varchar(30),
    editorial varchar(20),
    precio decimal (4,2),
    stock int,
    primary key (codigo)
);

 insert into libros(titulo,autor,editorial,precio,stock) 
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00, 9);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00, 50);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('Aprenda PHP','Mario Molina','Siglo XXI',40.00, 3);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('El aleph','Borges','Emece',10.00, 18);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('Ilusiones','Richard Bach','Planeta',15.00, 22);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('Java en 10 minutos','Mario Molina','Siglo XXI',50.00, 7);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('Martin Fierro','Jose Hernandez','Planeta',20.00, 3);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('Martin Fierro','Jose Hernandez','Emece',30.00, 70);
 insert into libros(titulo,autor,editorial,precio,stock)
  values('Uno','Richard Bach','Planeta',10.00, 120);

#SINTAXIS BASICA:

#CREACION
#delimeter //
#create procedure NOMBREPROCEDIMIENTO()
#begin
# 	INSTRUCCIONES
#end;
#delimeter ;

#LLAMADO/INVOCACION:
#call NOMBREPROCEDIMIENTO();

#ELIMINACION:
#drop procedure if exists NOMRBEPROCEDIMIENTO;

#Voy a hacer un procedimiento para ver los libros cuyo stock es menor a 10
delimiter //
create procedure pa_libros_stock()
begin
	select * from libros where stock <=10;
end //
delimiter ;

#Delimeter: it changes the statement delimiter from ; to //. This is so 
#you can write ; in your trigger definition without the MySQL client 
#misinterpreting that as meaning you're done with it.


#Una vez creado lo puedo llamar 

call pa_libros_stock();


#PARAMETROS DE ENTRADA Y SALIDA
#Los procedimientos pueden recibir y devolver infromacion y para ellos se
#emplean parametros de entrada y de salida respectivamente
#El nombre/ contenido del parametro debe ser envidado en el momento de la invocacion
#(Funciona como una funcion de cualquier otro lenguaje de programacion)

#delimeter //
#create procedure NOMBREPROCEDIMIENTO(in NOMBREPARAMETRO TIPODEDATO)
#begin
#	sentencia select
#end //

delimiter //
create procedure pa_libros_autor(in p_autor varchar(30))
begin
	select titulo, editorial, precio from libros where autor = p_autor;
end //
delimiter ;
 
#Si lo llamamos y no le mandamos parametros...
call pa_libros_autor();
#tira error

#si le mando algun parametro (siempre y cuando cumpla las condiciones ...)
call pa_libros_autor('Richard Bach');

#Podemos mandarle varios parametros...

delimiter //
create procedure pa_libros_autor_editorial( 
	in p_autor varchar(30),
    in p_editorial varchar(20)
    )
begin
	select titulo, editorial, precio from libros 
    where autor = p_autor and editorial = p_editorial;
end //
delimiter ;

drop procedure if exists pa_libros_autor_editorial;

call pa_libros_autor_editorial('Richard Bach', 'Planeta');
call pa_libros_autor_editorial('Borges', 'Emece');


##PARAMETROS DE SALIDA DE PROCEDIENTOS ALMACENADOS

#SINTAXIS BASICA

/*create procedure NOMBREPROCEDIMIENTO(out NOMBREPARAMETRO TIPODEDATO)
begin
end // */

#Pirmero creo el procedimiento
delimiter //
create procedure pa_autor_total_y_promedio(
	in p_autor varchar(30),
	out suma decimal(6,2),
	out promedio decimal (6,2)
)
begin
	select titulo, editorial, precio from libros where autor = p_autor;
    select sum(precio) into suma from libros where autor = p_autor;
    select avg (precio) into promedio from libros where autor = p_autor;
end //
delimiter ;

#Lo llamo para obtener los valores calculados deseados
#Muestra las columnas de la tabla auxiliar que cree para obtener los valroes deseados
call pa_autor_total_y_promedio('Richard Bach', @suma, @promedio);

#OJO! CADA VEZ A GUARDO UN VALOR EN UNA VARIABLE ESA VARIABLE QUEDA OCUPADA CON EL 
#ULTIMO VALOR QUE LE CARGUE A MENOS QUE LE CAMBIE EL VALOR!!!

select @suma, @promedio;








