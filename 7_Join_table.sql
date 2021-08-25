####JOIN

#CLAVE FORANEA O FOREIGN KEY
#Def: Es la representacion de un campo q es la clave primaria de otra tabla

create database curso_sql_join;
use curso_sql_join;

#OJO! ES MUY IMPORTANTE CARGAR PRIMERO LA TABLA PROVEEDOR XQ LA TABAL PRODUCTOS HACE REFERENCIA A ELLA, 
#LO MISMO AL CARGARLA!!!

create table if not exists proveedor(
id int unsigned not null auto_increment,
nombre varchar(50),
primary key(id),
unique index (nombre)
); 

create table if not exists productos(
id int unsigned not null auto_increment,
nombre varchar (50) not null,
descripcion text,
proveedorid int unsigned not null, #este campo es la representacion del PRIMARY KEY de la tabla PROVEEDOR
precio decimal (5,2),
cantidad smallint unsigned default 0,

primary key (id),
unique index (nombre),
foreign key (proveedorid) references proveedor (id) #referencia a la tabla proveeddor (id)
#   "  campo a referenciar   "  nombre de la tabla (campo)
);

#drop table proveedor;
#drop table productos;


#agrego resgistros a la tabla proveedor
insert into proveedor (nombre) values('Lenovo');
insert into proveedor (nombre) values('Logitech');
insert into proveedor (nombre) values('Microsoft'); 
insert into proveedor (nombre) values('HP');

#agrego registros a la tabla PRODUCTOS
insert into productos(nombre, descripcion, proveedorid, precio, cantidad) 
values('Lenovo 310', 'La mejor laptop', 1, 100, 50);
insert into productos(nombre, descripcion, proveedorid, precio, cantidad) 
values('Mouse', 'mouse inalambrico', 2, 15.96, 5);
insert into productos(nombre, descripcion, proveedorid, precio, cantidad) 
values('Office 360', 'Paquete de Ofice', 3, 150.69, 30);
insert into productos(nombre, descripcion, proveedorid, precio, cantidad) 
values('HP Y700', 'La mejor laptop del mercado', 4, 10, 15);
insert into productos(nombre, descripcion, proveedorid, precio, cantidad) 
values('Alfombra Lenovo', 'Alfombras asombrosas', 1, 300, 40);
insert into productos(nombre, descripcion, proveedorid, precio, cantidad) 
values('laptop HP 1000', 'No funciona muy bien',4 , 500, 3);
insert into productos(nombre, descripcion, proveedorid, precio, cantidad) 
values('Volante Gamer', 'El mejor volante para jugar', 2, 800, 5);
insert into productos(nombre, descripcion, proveedorid, precio, cantidad) 
values('Disco duro', 'Obten mas capacidad', 3, 70, 80);

show tables;
describe productos;
describe proveedor;

select * from productos;
select* from proveedor;

#ESTRUCTURA DEL JOIN BASICO: efectuo la "union" entre las 2 tablas con la key correspondiente 

select * from productos #Elijo la tabla y o columna
join proveedor #La tabla q quiero unirle
on productos.proveedorid=proveedor.id; # Condicion xa unirlas segun los valores del campo proveeedorid de la tabla productos
#campo tabla original= campo_tabla q quiero unirle 
    
#solo elijo algunos campos xa la consulta
select p.nombre, p.descripcion, p.precio, pro.nombre from productos as p #as p es el alias de productos
#se lee: el campo nombre de p, campo descripcion de p ---->donde p es productos
join proveedor as pro #pro es alias de proveedor
on p.proveedorid=pro.id;

#LEFT JOIN: 
/*Se usa para coincidir registros de una tabla izquierda con una tabla derecha
Si un valor de la tabla izquierda no encuentra coincidencia en la tabla de la derecha se genera 
una fila extra en la tabla IZQUIERDA x cada valor no encontrado, con todos los campos seteados a nulo*/
#lee la tabla de izquierda a derecha

select * from productos
left join proveedor # coloca a la izq de productos la tabla proveedor 
on  proveedor.id = productos.proveedorid; #en el campo proveedor unime la tabla productos.proveedor.id
# tabla.campo q quiero unir = campo.tabla original
#tabla proveedor = campo tabla productos
#OJO se da vuelta como costumbre, pero el resultado es el mismo, primero la tabla proveedor y dsps la productos

#RIGHT JOIN: 
/*idem que el left join solo q la busqueda de coincidencia se realiza de derecha a izq,
se chequean los valores de la tabla derecha primero y dsps los de la tabla izquierda. 
Si no hay coincidencia de un valor en la tabla de la izquierda se genera una fila extra
en la tabla DERECHA x cada valor no encontrado*/

select * from proveedor
right join productos #coloca a la derecha de proveedor la tabla productos
on proveedor.id=productos.proveedorid;

#SI INVIERTO PROVEEDOR Y PRODUCTOS (en select.. y join..) funciona
#COLOCA AL REVES LAS TABLAS

#INNER JOIN
/*Idem q join pero si hay datos q no coinciden, 
los descarta o no los muestra*/

select p.nombre, p.descripcion, p.precio, pro.nombre from proveedor as pro
inner join productos as p
on pro.id=p.proveedorid;

#STRAIGHT JOIN
/*idem a join pero siempre lee la tabkla d eizquierda a derecha*/
select p.nombre, p.descripcion, p.precio, pro.nombre, pro.id, p.proveedorid from proveedor as pro
straight_join productos as p
on pro.id=p.proveedorid;

#FUNCIONES DE AGRUPAMIENTO GROUP BY
/*quiero ver lo proveedores agrupados por nombre e indicando la 
cantidad de productos de cada uno */
select pro.nombre, count(p.proveedorid) as 'cantidad de Productos' #
#muestro una nueva columna llamada cantidad de productos al lado del campo nombre de la tabla proveedor
from proveedor as pro #pro hace referencia a tabla proveedor, en la tabla proveedor
join productos as p #o hace referencia a tabla productos
on pro.id=p.proveedorid #los uno segun correspondan el campo id de la taba proveedor y el campo proveedorid de la tabla productos
group by pro.nombre; #ordenarnos alfabeticamente segun el nombre

/* Muestro el precio del producto mas caro de cada proveedor*/
select pro.nombre, max(p.precio) as 'Precio del producto más caro'
from proveedor as pro
join productos as p
on  p.proveedorid=pro.id
group by pro.nombre;

#JOIN CON + DE 2 MAS TABLAS
/*Creo algunas tablas para el ejemplo*/

create table libros(
codigo int unsigned auto_increment,
titulo varchar(40) not null,
autor varchar(20) default 'Desconocido',
primary key (codigo)
);

create table socios(
documento char(8) not null,
nombre varchar(30),
domicilio varchar(30),
primary key(documento)
);

create table prestamos(
documento char(8) not null,
codigolibro int unsigned,
fechaprestamo date not null,
fechadedevolucion date not null,
primary key (codigolibro,fechaprestamo)
);

#No tengo datos para insertar, trabajo sin datos
#(dsps veo si agrego algunos datos por tabla)

select * from prestamos;

#Ver todos los prestamos que coincidan
#join en socios y join en libros
select nombre, titulo, fechaprestamo #campos q quiero ver
from prestamos as p #indico nombre de la tabla inicial
join socios as s #tabla a la q la uno
on s.documento=p.documento #nombre de los campos a traves de ls/cls se combinan
join libros as l #nombre de la tabla q quiero unir
on codigolibro=codigo; #campo de comparacion de segunda tabla

#Ver todos los prestamos, 
#incluso los q no tengan coincidencia ni en tabla libros ni en socios
#(Left join en ambas tablas)
select nombre, titulo, fechaprestamo 
from prestamos as p
left join socios as s
on p.documento=s.documento
left join libros as l
on l.codigo=codigolibro;

#Ver aquellos q coinciden en la tabla libros pero 
#xa socios con o sin coincidencia
#(Join simple en socios y Left join solo en libros)
select nombre, titulo, fechaprestamo
from prestamos as p
left join socios as s
on p.documento=s.documento
join libros as l
on p.codigolibro=l.codigo;

#IF CASE - varias tablas
/*Quiero ver si tengo productos de todos los proveedores*/

#IF
select pro.nombre, #traeme el nombre de los proveedores 
if(count(p.proveedorid)>0,'SI', 'NO') as hay #si al contar el campo provedorid de la tabla productos es mayor a cero
from proveedor as pro # creame columna HAY y unime sobre la tabla proveedor #aca recien le indico que por e proveedor
left join productos as p #la tabla productos la joineo sobre la izq de la proveedor (de izq a der)
on pro.id=p.proveedorid #si coinciden estos campos
group by pro.nombre; #ordenalo alfabeticamente segun nombre

#CASE
select pro.nombre, # seleccioname el campo nombre de la tabla proveedor
case count(p.proveedorid) when 0 then 'NO' #si cuento cero, NO
else 'SI' end as 'Hay' #caso contrario SI, crea,e tabla HAY
from proveedor as pro #alias
left join productos as p #alias 
on pro.id=p.proveedorid #campo de comparacion
group by pro.nombre; #orden

#VARIABLES DE USUARIOS
#deifinir variable en MYsql @nombrevariable:    

select @preciomayor:= max(precio) from productos; #Guardo en la variable @preciomayor el maximo precio
select * from productos where precio = @preciomayor; #ejemplo util de xa que se puede usar

select p.nombre, p.descripcion, pro.nombre
from productos as p
join proveedor as pro
on p.proveedorid=pro.id
where p.precio=@preciomayor;

#crear tabla a partir de otra con join 1/2

drop table productos; 
drop table proveedor;

#Vuelvo a crear productos
create table if not exists productos(
id int unsigned not null auto_increment,
nombre varchar (50) not null,
descripcion text,
proveedorId varchar (50), 
precio decimal (5,2),
cantidad smallint unsigned default 0,

primary key (id),
unique index (nombre)
#proveedorid ya no es foreign key xq voy a crear la tabla productos a partir de ella
#foreign key (proveedorid) references proveedor (id) #referencia a la tabla proveeddor (id)
#   "  campo a referenciar   "  nombre de la tabla (campo)
);

#agrego los resgistros de nuevo

insert into productos(nombre, descripcion, proveedorId, precio, cantidad) 
values('Lenovo 310', 'La mejor laptop', '1', 100, 50);
insert into productos(nombre, descripcion, proveedorId, precio, cantidad) 
values('Mouse', 'mouse inalambrico','2' , 15.96, 5);
insert into productos(nombre, descripcion, proveedorId, precio, cantidad) 
values('Office 360', 'Paquete de Ofice', '3', 150.69, 30);
insert into productos(nombre, descripcion, proveedorId, precio, cantidad) 
values('HP Y700', 'La mejor laptop del mercado', '4', 10, 15);

#agrego resgistros a la tabla proveedor
insert into proveedor (nombre) values('Lenovo');
insert into proveedor (nombre) values('Logitech');
insert into proveedor (nombre) values('Microsoft'); 
insert into proveedor (nombre) values('HP');

select * from productos;

drop table if exists proveedores;

create table proveedores #solo tiene una columna: nombre_proveedor
select distinct nombre as nombre_proveedor #creo el campo nombre_proveedor con los datos de proveedores q sean distintos, no repite
from proveedor;

describe proveedores;
select * from proveedores;


#insertar datos buscando el valor en otra tabla
#supongo q quiero agregar un nuevo producto pero no se el Id del proveedor
#entonces busco en la tabla proveedores el coidgo del nombre del proveedor que quiero
#y finalmente ingreso el prodcuto xq ya se el nombre del proveedor
show tables;
select * from productos;
select * from proveedor;
select * from proveedores;

insert into productos(nombre, descripcion, precio, proveedorId, cantidad)
select 'prueba 3', 'El mejor teclado', 100, id, 50 #mientras hago el insert, hago el select para buscar lo q me falta (el id en este caso)
#pongo id porque no lo se pero es el nombre de nuestro campo en la tabla proveedor
from proveedor where nombre = 'Logitech';  #y digo de q tabla estoy haciendo el select y xa q condicion
#si no existe el nombre en proveedor nos dice q no afecto ninguna fila 

#actualizar registros con valores de otra tabla (UPDATE)

alter table productos add proveedor_nuevo varchar(50);

select * from productos;
select * from proveedor;

update productos
join proveedor
on productos.proveedorId = proveedor.id #segun el campo proveedorId de la tabla productos y el campo id de la tabla proveedor
set productos.proveedor_nuevo = proveedor.nombre; #modifico el campo proveedor de la tabla productos dandole el nombre que haya en la tabla proveedor


#ahora podriamos eliminar el campo proveedorId de la tabla productos con alter table y borrar la tabla proveedores con drop table
alter table productos drop proveedorId; #chau campo proveedorId
drop table proveedor; #chau tabla proveedor

#Actualizacion en cascada (UPDATE-JOIN)
#voy a actualizar simultaneamente el id de los productos logitech en la tabla productos y en la tabla proveedores

select * from productos;
select * from proveedor;

update productos as p
join proveedor as pro
on p.proveedor_nuevo = pro.id
set p.proveedor_nuevo = "10",
pro.id = 10
where p.proveedor_nuevo = 'Microsoft';

#Borrar un registro consultando otra tabla
#supongamos q quiero eliminar todos los registros de hp pero no sabemos el codigo id del proveedor
#borro los registros de HP consulatando su id en  la tabla proveedor

delete productos
from productos
join proveedor
on productos.proveedor_nuevo = proveedor.nombre
where proveedor.nombre = 'HP';

#Ahora supongo q quiero eliminar todos los de Logitech pero solo tengo su id, no su nombre
#(se que id del proveedor es 2 pero no se a que corresponde a Logitech)
#(el mouse inalambrico de 15 mangos)
#update productos set proveedor_nuevo = 'Logitech' where id = 8;
select * from productos;
select * from proveedor;

delete productos
from productos
join proveedor
on productos.proveedor_nuevo = proveedor.nombre
where proveedor.id = 2;


#vemos q se eliminaron todos los registros de HP

#Borrar resgistros en cascada
#es decir, eliminar un resgitro al mismo tiempo en 2 tablas
#supongo q quiero eliminar todo lo del proveedor Lenovo

select * from productos;
select * from proveedor;

delete productos, proveedor
from productos
join proveedor
on productos.proveedor_nuevo = proveedor.id
where proveedor.nombre = "lenovo";

#chequear y reparar tablas (CHECK-REPAIR) xa ver si esta dañada
check table productos;

#Table: nombre de la tabla
#Op: operacion, tipo de chequeo
#Msg_type: status, error, info, warning
#Msj_text: OK

#tipos de chequeo de tabla

#quick:
#fast:
#changed:
#medium (por defecto):
#extended: 

check table productos fast;

#reparar tabla:
repair table productos;

#encriptar datos con aes encrypt y aes decrypt
#xa almacenar un dato o valor q no quiero q se pueda ver
#sintaxis basica:
#encriptar: aes_encrypt ('dato_a_encriptar', 'clave de encriptacion') #OJO Argumentos son strings
#desencriptar: select cast(aes_decrypt (columna_a_desencriptar, 'clave de encriptacion') ) #OJO la columna no es string				
drop table if exists clientes;

create table clientes(
	nombre varchar(50),
    mail varchar (70),
    numero_tarjeta_credito blob,

	primary key (nombre)
);

#inserto datos encriptandolos

insert into clientes
	values('Marcos Luis', 'marcosluis@gmail.com', aes_encrypt('5390700823285988','xyz123') );
insert into clientes 
  values ('Ganzalez Ana','gonzalesa@gmail.com',aes_encrypt('4567230823285445','xyz123') );
insert into clientes 
  values ('Lopez German','lopezg@yahoo.com',aes_encrypt('7840704453285443','xyq123') );

#pruebo ver el dato encriptado y veo q no puedo  
select numero_tarjeta_credito from clientes;
select * from clientes;
#desencripto los datos xa verlos => necesito la key, clave

select cast(aes_decrypt(numero_tarjeta_credito,'xyq123') as char ) from clientes;
#si tengo datos encriptados con distintas claves en una misma columna, me trae solo los q tienen la clave q le di de esa columna
select cast(aes_decrypt(numero_tarjeta_credito,'xyz123') as char ) from clientes;



