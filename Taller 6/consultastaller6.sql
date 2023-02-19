update academico.persona 
set fechanacimiento = now()-'60 year'::interval * random();

update academico.persona 
set fevarcharegistro = now() - '2 year'::interval * random();


--1. Un reporte donde salga la siguiente información del ejemplo "Adam";"Díaz";"101010293";"CC ";"Masculino";1994-01-23";"2018-06-30";"RESTREPO ";"Meta ";"COLOMBIA "

select distinct on (p.id) p.nombre, p.apellido, p.documento, td.nombre, s.nombre, p.fechanacimiento, p.fevarcharegistro, c.nombre, d.nombre, ps.nombre 
from persona p, tipodocumento td, sexo s, ciudad c, pais ps, departamento d 
where p.id=6 ;

--2. Se desea conocer cuantos registro contiene.

select count(p.id) as registros from persona p;

--3. Se desea filtrar un archivo con solo los de sexo masculino y otro con los de sexo femenino. Y cuantos hombre y mujeres hay.

--Hombres
select p.id, p.nombre, s.nombre from persona p, sexo s where p.idsexo=1 and p.idsexo =s.id order by p.id asc;
select count(p.idsexo) as Cant_Hombres from persona p where p.idsexo=1

--Mujeres
select p.id, p.nombre, s.nombre from persona p, sexo s where p.idsexo=2 and p.idsexo =s.id order by p.id asc;
select count(p.idsexo) as Cant_Hombres from persona p where p.idsexo=2

--4. Se desea conocer cuantos hombres menores de 30 hay

select count(p.idsexo) as Hombres_men30 from persona p where p.idsexo=1 and (2023-extract(year from p.fechanacimiento))<30;

--5. Si hay menores de edad y si los hay cuantos son.

select distinct on (p.id) p.id, p.nombre, date_part('year', age(p.fechanacimiento)) as edad from persona p 
where (2023-extract(year from p.fechanacimiento))<18;

select count(p.id) as Menores_edad from persona p 
where (2023-extract(year from p.fechanacimiento))<18;

--6. Si hay menores de edad que sean del departamento de Antioquia

select distinct on (p.id) p.id, p.nombre, date_part('year', age(p.fechanacimiento)) as edad, d.nombre from persona p, departamento d, ciudad c  
where p.idciudad=c.id and c.iddepartamento=d.id and d.id=1 and (2023-extract(year from p.fechanacimiento))<18;

select count(p.id) as Menores_edad_Antioquia from persona p, departamento d, ciudad c  
where p.idciudad=c.id and c.iddepartamento=d.id and d.id=1 and (2023-extract(year from p.fechanacimiento))<18;

--7. Si hay personas menores de edad en santander,  que tenga el ultimo numero de la cedula 7 o 3.

select distinct on (p.id) p.id, p.nombre, date_part('year', age(p.fechanacimiento)) as edad, p.documento, d.nombre from persona p, departamento d, ciudad c  
where p.idciudad=c.id and c.iddepartamento=d.id and d.id=21 and (2023-extract(year from p.fechanacimiento))<18 and (p.documento like '%7' or p.documento like '%3');

select count(p.id) as Menores_edad_Santander from persona p, departamento d, ciudad c  
where p.idciudad=c.id and c.iddepartamento=d.id and d.id=21 and (2023-extract(year from p.fechanacimiento))<18 and (p.documento like '%7' or p.documento like '%3');

--8. Un reporte con las columnas del primero, donde estén las mujeres de los departamento que empiecen por C y la fecha de registro este entre  "2018-09-10" y  "2019-04-01"

select distinct on (p.fevarcharegistro) p.id, p.nombre, p.fevarcharegistro, p.documento, d.nombre from persona p, departamento d, ciudad c  
where p.idsexo=2 and p.idciudad=c.id and c.iddepartamento=d.id and d.nombre like 'C%' and p.fevarcharegistro>='2018-09-10' and p.fevarcharegistro<='2019-04-01';

--9. Los mujeres y hombre de los departamentos códigos 11 12 13 15 20 47 50 19 66 y los nombre de "Norte de Santander" "Nariño" "Choco" que nacieron un martes 13 o un viernes 13.

select distinct on (p.id) p.id, p.nombre, p.documento, d.id, d.nombre, p.fechanacimiento, to_char(p.fechanacimiento, 'Day') as dia_semana from persona p, departamento d, ciudad c
where p.idciudad=c.id and c.iddepartamento=d.id and (d.id= 11 or d.id=12 or d.id=13 or d.id=15 or d.id=20 or d.id=47 or d.id=50 or d.id=19 or d.id=66 or d.nombre like 'Norte de Santander' or d.nombre like 'Nariño' or d.nombre like 'Choco')
and (extract(dow from p.fechanacimiento) = 2 and date_part('day', fechanacimiento) = 13 or extract(dow from p.fechanacimiento) = 5 and date_part('day', fechanacimiento) = 13);

--10.Cuantos hombres menores de 30 y mayores de 21 de los departamentos anteriores que nacieron en diciembre o enero pero no los días festivos.

select count(p.id) as Hombres_ma21_men30 from persona p, departamento d, ciudad c  
where p.idciudad=c.id and c.iddepartamento=d.id and (d.id= 11 or d.id=12 or d.id=13 or d.id=15 or d.id=20 or d.id=47 or d.id=50 or d.id=19 or d.id=66 or d.nombre like 'Norte de Santander' or d.nombre like 'Nariño' or d.nombre like 'Choco') 
and (2023-extract(year from p.fechanacimiento))<30 and (2023-extract(year from p.fechanacimiento))>21 and 
((extract(day from p.fechanacimiento) not in (1, 6) and extract(month from p.fechanacimiento) = 1) or (extract(day from p.fechanacimiento) not in (8, 25) and extract(month from p.fechanacimiento) = 12) or (extract(month from p.fechanacimiento) != 12 ) and extract(month from p.fechanacimiento) != 1)
and p.idsexo=1;

select distinct on (p.id) p.id, p.nombre, date_part('year', age(p.fechanacimiento)) as edad, p.documento, d.nombre, d.id, d.nombre, p.fechanacimiento from persona p, departamento d, ciudad c  
where p.idciudad=c.id and c.iddepartamento=d.id and (d.id= 11 or d.id=12 or d.id=13 or d.id=15 or d.id=20 or d.id=47 or d.id=50 or d.id=19 or d.id=66 or d.nombre like 'Norte de Santander' or d.nombre like 'Nariño' or d.nombre like 'Choco') 
and (2023-extract(year from p.fechanacimiento))<30 and (2023-extract(year from p.fechanacimiento))>21 and 
((extract(day from p.fechanacimiento) not in (1, 6) and extract(month from p.fechanacimiento) = 1) or (extract(day from p.fechanacimiento) not in (8, 25) and extract(month from p.fechanacimiento) = 12) or (extract(month from p.fechanacimiento) != 12 ) and extract(month from p.fechanacimiento) != 1)
and p.idsexo=1;



