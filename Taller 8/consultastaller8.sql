--1.Inserte un escritor anónimo en la base de datos.

INSERT INTO libreria.escritor
(id, nombre, apellido, idpersona, seudonimo, idgeneroliterario, fecharegistro, email, perfil)
VALUES(1, '', '', null, '', 0, now(), '', null);



--2.Inserte en escritor  a Pepito perez con correo pepito@pepe.com y no lo referencie a ninguna persona.


INSERT INTO libreria.escritor
(id, nombre, apellido, idpersona, seudonimo, idgeneroliterario, fecharegistro, email, perfil)
VALUES(2, 'Pepito', 'Perez', null, '', 0, now(), 'pepito@pepe.com', null);

--3.Inserte a  a Roberto perez con correo Roberto@robert.com y  a  Claudia perez con correo Claudia@clau.com y no los referencia a ninguna persona y a

INSERT INTO libreria.escritor
(id, nombre, apellido, idpersona, seudonimo, idgeneroliterario, fecharegistro, email, perfil)
VALUES(3, 'Roberto', 'Perez', null, '', 0, now(), 'Roberto@robert.com', null), (4, 'Claudia', 'Perez', null, '', 0, now(), 'Claudia@clau.com', null);

--4.Inserte los escritores de los departamentos que tengan menos de 5 personas en la tabla personas, complete los datos de escritor.


insert into libreria.escritor (id, nombre, apellido, idpersona, seudonimo, idgeneroliterario, fecharegistro, email, perfil)
select p.id ,p.nombre, p.apellido , null, '', 0, p.fevarcharegistro , p.email , null from academico.persona p, academico.departamento d, academico.ciudad c
where d.nombre in (select d2.nombre from academico.departamento d2, academico.ciudad c2, academico.persona p2
where c2.iddepartamento=d2.id and p.idciudad = c2.id group by d2.id having (count(1)<5)) and c.id = d.id and p.idciudad = c.id;

--5.Inserte los escritores del valle del Cauca;

insert into libreria.escritor (id, nombre, apellido, idpersona, seudonimo, idgeneroliterario, fecharegistro, email, perfil)
select p.id ,p.nombre, p.apellido , null, '', 0, p.fevarcharegistro , p.email , null from academico.departamento d, academico.ciudad c, academico.persona p 
where c.iddepartamento=d.id and p.idciudad = c.id and d.id=24;

select * from libreria.tema t

--7.Inserte los libros y asignale un escritor aleatorio libro


update libreria.escritor set id = subquery.numero_secuencia
from (select e.id as id2, (row_number() over()-1) as numero_secuencia from libreria.escritor e) as subquery
where id = subquery.id2 and id != 0;

select max(id) from libreria.escritor 
update libreria.libro  set idautor = subquery.random_num
from (select l.id as id2, floor( (random()*60) ) as random_num from libreria.libro l) as subquery
where id = subquery.id2;

select * from libreria.libro l


--8.Actualice de forma aleatoria los idpersona en escritor;

update libreria.escritor set idpersona = subquery.id_persona from (select id as id_persona, row_number() over() as rownum
from academico.persona order by random() 
) as subquery where subquery.rownum = libreria.escritor.id; 

select * from libreria.escritor e;

--9.Asigne los idpersona que corresponda a cada escritor;

update libreria.escritor set idpersona = subquery.id_persona
from(select e.id as id_escritor, p.id as id_persona from libreria.escritor e ,academico.persona p
where e.id = p.id) as subquery where id = subquery.id_persona select * from libreria.escritor e;

--10.Borre los registros que no tengan una persona asignada menos anonimo.
	
delete from libreria.escritor where idpersona is null and id <> 0;

SELECT * FROM libreria.escritor e

