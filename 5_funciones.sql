#FUNCIONES EN TABLAS

#drop database if exists curso_sql;

create database if not exists curso_sql_3;
use curso_sql_3;

create table if not exists productos(
id integer unsigned not null auto_increment,
nombre varchar(50),
proveedor varchar(50),
descripcion text,
precio decimal(5,2) unsigned,
cantidad smallint unsigned,
primary key(id)
);

insert into productos(nombre, proveedor, descripcion, precio, cantidad) values('Laptop HP','HP','Las mejores laptop',155.69,50);
insert into productos(nombre, proveedor, descripcion, precio, cantidad) values('Mouse','Logitech','Las mejores mouse',20.86,30);
insert into productos(nombre, proveedor, descripcion, precio, cantidad) values('Teclado','Logitech','Las mejores teclados',80.12,100);
insert into productos(nombre, proveedor, descripcion, precio, cantidad) values('Laptop DELL','Dell','Las mejores laptop',200.8,15);
insert into productos(nombre, proveedor, descripcion, precio, cantidad) values('Pantalla','HP','Las mejores Pantallas',155.69,50);
insert into productos(nombre, proveedor, descripcion, precio, cantidad) values('Impresora','HP','Las mejores Impresoras',155,70);
insert into productos(nombre, proveedor, descripcion, precio, cantidad) values('Camaras','logitech','Las mejores Camaras',500,20);
insert into productos(nombre, proveedor, descripcion, precio, cantidad) values('Xbox 360','Xbox Microsoft','Las mejores Consolas',103,10);
insert into productos(nombre, proveedor, descripcion, precio, cantidad) values('PlayStation 4','Sony','Las mejores play',15.69,50);
insert into productos(nombre, proveedor, descripcion, precio, cantidad) values('Lenovo 310','Lenovo','Las mejores laptop',155.69,50);


#COLUMNAS CALCULADAS: Columnas no visibles fisicamente

select nombre, precio, cantidad from productos;


#Me muestra una columna adicional con el resultado de la operacion pedida
select nombre, precio, cantidad, precio*cantidad from productos;

#hago un 10% de descuento por ej
select nombre, precio, precio*0.1, precio-(precio*0.1) from productos;

#FUNCIONES DE MANEJO DE CADENA
#OJO ALGUNAS NO LLEVAN ESPACIO ANTES DEL PARENTESIS

select concat('hola,',' ', 'como estas?'); #concatena la cadena
select concat_ws('-','Miguel','Lopez','Martinez'); # WD wid separator(parametro de separacion, palabras a separar (y concatenar)
select length ('Hola a todos'); #Muestra la longitud del string
select left ('Buenas Noches',8); #muestra hasta el caracter 8 dde la izq
select right ('Buenas Noches',8); #idem pero dde der
select ltrim('      Udemy   '); #quita los espacios dde la izq 
select rtrim(' Udemy    '); #quita espacios a izquierda
select trim('     Udemy    '); #quita espacios a ambos lados
select replace('rrr.udemy.com','r','w');#reemplazo
select repeat ('SQL', 3); #repito SQL  3 veces
select reverse('namreG'); #da vuelta el texto
select lcase('HOla COmO EstAS?'); #lower case, pone * el texto en minuscula
select lower('HOla COmO EstAS?'); #idem
select upper('HolA cOmO EStas?'); #idem pero mayuscula
select ucase('hola amigos');#idem

#APLICADOS A UNA TABLA
select concat_ws('/',nombre, precio) from productos; #concateno los campos de la tabla productos con una / entre palabras
select left (nombre, 5) from productos; #dejo con 5 chars los campos de la columna nombre de la tabla prductos
select lower(nombre), upper(descripcion) from productos; #devuelve el min los campos de la col nombre y en mayuscula los de la col descripcion

#FUNCIONES MATEMATICAS COMUNES

select nombre, precio from productos;
select ceiling(precio) from productos; #Redondea HACIA ARRIBA SIEMPRE, en este caso precio
select floor(precio) from productos; #Redondea HACIA ABAJO SIEMPRE,
select round(10.499);#Redondea con criterio de 0.5 (
select mod(10,3); # = 1 nos devuelve el resto de la division (equivalente a % en .js o Python)
select mod (10,2); # = 0 resto cero xd
select power (2,3); # =8 Potencia (2 elevado a la, 3 en este caso)

#CLAUSULA ORDER BY: Ordena los resultados de un select segun una condicion
select nombre, precio from productos;

#ordeno segun la columna nombre. Por default segun orden la alfabetico (ascendente) de los campos de esa columna (A-Z)
select nombre, descripcion, precio from productos order by nombre;

#ordeno segun col nombre, x default, por orden alfabetico. con desc, ( De la Z-A)
select nombre, precio, cantidad from productos order by nombre  desc;

#Ordeno segun 2 campos, cuando coincide el 1ero, ordeno segun el 2do
#hay varias xbox, todas coincciden en nombre y precio. Cambio el precio a una 
update productos set precio=130.45 where Id = 8;
select * from productos;
#La  Xbox con mayor precio va a aparecer ultima xq ordeno segun precio asc
select nombre, precio, cantidad from productos order by 
nombre desc, precio asc;

#OPERADORES LOGICOS

#and = "y" :INTERSECCION 
#or = "y/o": UNION
#xor "o": UNION -(menos) INTERSECCION
#not = "not": EXCEPTO (CUANDO NO)

select * from productos;

select * from productos where (proveedor ='HP') and (precio <= 200); #se tienen q cumplir las 2 condiciones
select * from productos where (proveedor ='HP') or (descripcion = 'Las mejores Laptop'); #Trae todas las q sean HP y ademas todas las que tengan descripcion 'las mejores..'
select * from productos where (proveedor = 'HP') xor (descripcion = 'Las mejores Laptop');/*Trae las HP y las q tenga esa descripcion 
PERO NO LAS QUE CUMPLAN LAS 2 COSAS, es decir no va a traer ninguna HP qude diga La meor Laptop pero si de otros proveedores*/
select * from productos where (proveedor = 'HP') xor (precio <= 200); #Trae las HP o las de menos de 200 PERO NO LAS HP DE MENOS DE 200
select * from productos where not (proveedor = 'Logitech'); #traer todos menos los de Logitech

#OPERADORES RELACIONALES BETWEEN - IN: para simplificar selecciones con and y or

#BETWEEN (and)
select * from productos where precio >= 100 and precio<=150 ; #entre 100 y 150
select * from productos where precio between 20 and 40; #lo mismo q arriba pero con una funcion mas corta
select * from productos where not precio between 20 and 40; #mayor a 60 y menor a 40 ( entre 40 y 60 no lo muestra) 
#IN (or)
select * from productos where proveedor = 'HP' or proveedor='Dell'; #provedor es hp o dell
select * from productos where proveedor in('HP', 'Dell'); #lo mismo de arriba pero simplificado

#BUSQUEDA DE PATRONES 
#con LIKE - NOT LIKE: ayuda a buscar trozos de cadena en nuestros campos
# %txt : TERMINA con TXT
# txt% : EMPIEZA con TXT
# %txt% : INCLUYE txt

select * from productos;
select * from productos where descripcion ='laptop'; #No trae nada xq estoy comparando la cadena completa
select * from productos where descripcion ='las mejores laptop'; #trae todo lo q diga las.. compara cadena entera
select * from productos where descripcion like '%laptop%'; # trae todo lo q tenga en descripcion incluida la plbra laptop
select * from productos where descripcion not like '%laptop%';# Todo lo q no tenga la plbra laptop en la descrip
select * from productos where nombre like 'm%'; #todo lo q COMIENZE con la letra m
select * from productos where nombre like 'Laptop%'; #todo lo q COMIENZE con la plbra laptop
select * from productos where descripcion like '%ouse'; #todo lo q TERMINE con ouse
#(not like, no comienza, o no termina)

# con REGEXP - NOT REGEXP: muy similar a like y not like
select * from productos where proveedor regexp 'logi'; #contiene el texto logi
select * from productos where proveedor regexp '[h e i]'; #los q contengan las letras includias en los corchetes
select * from productos where proveedor regexp '[a-d]'; #que contenga cualquier letras dde la a hasta la d
select * from productos where proveedor regexp '^D'; #que comienzen con la  letra D
select * from productos where proveedor regexp 'o..t'; #q contenga una o, tantos caracteres como puntos y dsps una i  
select * from productos where nombre regexp 'a.*a.*a'; #q tenga 3 a's  .*letra

#FUNCIONES DE AGRUPAMIENTOS

#COUNT
select count(*) from productos; #cuenta los registros
select count(*) from productos where proveedor = 'HP';
select count(*) from productos where descripcion like '%laptop%';

#SUM : suma las cantidades de la columna indicada
select sum(cantidad) from productos; #Nos suma las cantidades (de la columna cantidad)
select sum(cantidad) from productos where proveedor = 'HP';

#MAX Y MIN : Devuelve el minimo de la columna seleccionada
select max(precio) from productos; #Devuelve el maximo..;
select min(precio) from productos; #el minimo
select min(precio) from productos where nombre like '%laptop%';

#AVG: average, devuelve el promedio de los campos seleccionados

select avg(precio) from productos where nombre like '%Laptop%'; #Precio de la laptop promedio

#GROUP BY

create table if not exists visitantes(
  nombre varchar(30),
  edad tinyint unsigned,
  sexo char(1),
  domicilio varchar(30),
  ciudad varchar(20),
  telefono varchar(11),
  montocompra decimal (6,2) unsigned,
  primary key(nombre)
 );
 
insert into visitantes (nombre,edad, sexo,domicilio,ciudad,telefono,montocompra)
  values ('Susana Molina', 28,'f','Colon 123','Cordoba',null,45.50); 
insert into visitantes (nombre,edad, sexo,domicilio,ciudad,telefono,montocompra)
  values ('Marcela Mercado',36,'f','Avellaneda 345','Cordoba','4545454',0);
insert into visitantes (nombre,edad, sexo,domicilio,ciudad,telefono,montocompra)
  values ('Alberto Garcia',35,'m','Gral. Paz 123','Alta Gracia','03547123456',25); 
insert into visitantes (nombre,edad, sexo,domicilio,ciudad,telefono,montocompra)
  values ('Teresa Garcia',33,'f','Gral. Paz 123','Alta Gracia','03547123456',0);
insert into visitantes (nombre,edad, sexo,domicilio,ciudad,telefono,montocompra)
  values ('Roberto Perez',45,'m','Urquiza 335','Cordoba','4123456',33.20);
insert into visitantes (nombre,edad, sexo,domicilio,ciudad,telefono,montocompra)
  values ('Marina Torres',22,'f','Colon 222','Villa Dolores','03544112233',25);
insert into visitantes (nombre,edad, sexo,domicilio,ciudad,telefono,montocompra)
  values ('Julieta Gomez',24,'f','San Martin 333','Alta Gracia','03547121212',53.50);
insert into visitantes (nombre,edad, sexo,domicilio,ciudad,telefono,montocompra)
  values ('Roxana Lopez',20,'f','Triunvirato 345','Alta Gracia',null,0);
insert into visitantes (nombre,edad, sexo,domicilio,ciudad,telefono,montocompra)
  values ('Liliana Garcia',50,'f','Paso 999','Cordoba','4588778',48);
insert into visitantes (nombre,edad, sexo,domicilio,ciudad,telefono,montocompra)
  values ('Juan Torres',43,'m','Sarmiento 876','Cordoba','4988778',15.30);
  
select * from visitantes;

select count(*) from visitantes where ciudad ='Cordoba'; #cuenta cuantos de cordoba
select count(*) from visitantes where ciudad ='Alta gracia'; #cuantos de Alta gracia

select ciudad, count(*) from visitantes group by ciudad; #traeme las ciudades de visitantes y dsps conta cuantos visitantes hay de cada una
select sexo, sum(montocompra) from visitantes group by sexo;  #muestra una columna por sexo

# campos a agrupar, operacion (sum, count), goup by -columnas q quiero mostrar- 	
select sexo, max(montocompra), min(montocompra) from visitantes group by sexo; 
select ciudad, sexo, count(*) from visitantes group by ciudad, sexo; # cuantas personas de cada sexo hay de cada ciudad
select ciudad, count(*) from visitantes where ciudad <> 'cordoba' group by ciudad; #cuantos resgistros de cada ciudad ( 1 resgitro por personas) q no sea cordoba
select edad, count(*) from visitantes where ciudad <> 'cordoba' group by edad; /*ejemplo raro pero ayuda a entender

cuento cuanto regustros (1 persona por registro) de cada edad cuando la ciudad sea distinta de cordoba y los agrupo por edades, como todos tienen != edad, tengo tantas cols como personas*/

select ciudad, count(*) from visitantes group by ciudad order by count(*) asc; #ascendente, de menos visitantes a mas
select ciudad, count(*) from visitantes group by ciudad order by ciudad asc; #desc  de A a la Z
select ciudad, count(*) from visitantes group by ciudad order by ciudad desc; #desc  de Z a la A

#REGISTROS DUPLICAODS: 

#claúsula DISTINCT   
select * from productos;
select proveedor from productos;
select distinct proveedor from productos; #omite los proveedores duplicados
select distinct nombre from productos;
select distinct proveedor from productos group by proveedor order by proveedor asc;
