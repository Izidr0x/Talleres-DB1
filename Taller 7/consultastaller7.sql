--1. Un reporte donde salga la siguiente información del ejemplo "Adam";"Díaz";"101010293";"CC ";"Masculino";"1994-01-23";"2018-06-30";"RESTREPO ";"Meta ";"COLOMBIA ".se desea saber cuantas personas aparecen en la tabla persona por departamento.

select distinct on (p.id) p.nombre, p.apellido, p.documento, td.nombre, s.nombre, p.fechanacimiento, p.fevarcharegistro, c.nombre, d.nombre, ps.nombre 
from persona p, tipodocumento td, sexo s, ciudad c, pais ps, departamento d 
where p.id=6 ;

select d.id, d.nombre, count(p.id) as Personas from persona p, ciudad c, departamento d 
where p.idciudad =c.id and c.iddepartamento =d.id group by d.id order by d.id asc;

--2. Se desea saber cuántas personas por sexo masculino aparecen en la tabla persona por departamento ordenadas por los departamentos con mayor cantidad de personas.

select d.id, d.nombre, count(p.id) as Personas from persona p, ciudad c, departamento d 
where p.idciudad =c.id and c.iddepartamento=d.id and p.idsexo=1 group by d.id order by count(p.id) desc;

--3. Se desea saber cuántas personas por sexo femenino aparecen en la tabla persona por departamento ordenadas por los departamentos con mayor cantidad de personas.

select d.id, d.nombre, count(p.id) as Personas from persona p, ciudad c, departamento d 
where p.idciudad =c.id and c.iddepartamento=d.id and p.idsexo=2 group by d.id order by count(p.id) desc;

--4. Se desea saber cuántas personas por sexo femenino menores(0,18), mayores(19,50) viejas (50,100)  aparecen en la tabla persona por departamento ordenadas por los departamentos con mayor cantidad de personas en un solo reporte (consulta).

select d.id, d.nombre, 
    sum(case when (2023-extract(year from p.fechanacimiento))<18 then 1 else 0 end) as menores,
    sum(case when (2023-extract(year from p.fechanacimiento))>18 and (2023-extract(year from p.fechanacimiento))<50 then 1 else 0 end) as mayores,
    sum(case when (2023-extract(year from p.fechanacimiento))>50 and (2023-extract(year from p.fechanacimiento))<100 then 1 else 0 end) as viejas
from persona p, ciudad c, departamento d 
where p.idciudad =c.id and c.iddepartamento=d.id and p.idsexo=2
group by d.id
order by count(*) desc;

--5. Los mujeres y hombre de los departamentos códigos 11 12 13 15 20 47 50 19 66 y los nombre de "Norte de Santander" "Nariño" "Choco" que nacieron un martes 13 o un viernes 13 con la cláusula EXISTS.

select distinct on (p.id) p.id, p.nombre, p.documento, d.id, d.nombre, p.fechanacimiento, to_char(p.fechanacimiento, 'Day') as dia_semana from persona p, departamento d, ciudad c
where p.idciudad=c.id and c.iddepartamento=d.id and (d.id= 11 or d.id=12 or d.id=13 or d.id=15 or d.id=20 or d.id=47 or d.id=50 or d.id=19 or d.id=66 or d.nombre like 'Norte de Santander' or d.nombre like 'Nariño' or d.nombre like 'Choco')
and exists (select 1 from (select 2 as dow, 13 as day union all select 5 as dow, 13 as day) as valid_dates
where extract(dow from p.fechanacimiento) = valid_dates.dow and date_part('day', p.fechanacimiento) = valid_dates.day);



--6. interceptar las consultas de con los nombre, apellido, documento con los documentos que tengas tipodocumento cc con la consulta de los que son menores de edad.



