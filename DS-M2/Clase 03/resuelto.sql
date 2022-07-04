use henry;
-- punto 1
SELECT COUNT(*)
from carrera;
-- EN CLASE
SELECT COUNT(idCarrera) as Cantidad_Carreras
from carrera;

-- punto 2
select count(*)
from alumno;
-- en clase
select count(idAlumno) as cantidad_alumnos
from alumno;
-- punto 3
SELECT count(*)
from alumno
GROUP BY idCohorte;
-- en clase
SELECT idCohorte, count(*) as cantidad_alumnos
from alumno
GROUP BY idCohorte;

-- punto 4
SELECT a.fechaIngreso, CONCAT(a.nombre, ' ', a.apellido) As NombreyApellido, a.cedulaIdentidad
FROM alumno a
ORDER BY a.fechaIngreso DESC;
-- en clase
SELECT concat(a.nombre,' ',a.apellido) as nombre_apellido, fechaIngreso
FROM alumno a
ORDER BY fechaIngreso DESC;
-- punto 5
SELECT a.fechaIngreso, a.nombre, a.apellido, a.idAlumno
FROM alumno a
WHERE fechaIngreso = (select Min(b.fechaIngreso) from alumno b);
-- en clase
SELECT concat(a.nombre,' ',a.apellido) as nombre_apellido, fechaIngreso
FROM alumno a
ORDER BY fechaIngreso ASC
LIMIT 1;

-- punto 6
SELECT a.fechaIngreso, a.nombre, a.apellido, a.idAlumno
FROM alumno a
WHERE fechaIngreso = (select MAX(b.fechaIngreso) from alumno b);
-- en clase
SELECT date_format(a.fechaIngreso, '%d/%m/%y') as fecha_ingreso
FROM alumno a
ORDER BY fechaIngreso ASC
LIMIT 1;
-- punto 7 en clase
SELECT a.nombre, a.apellido, a.idAlumno
FROM alumno a
ORDER BY fechaIngreso ASC
LIMIT 1;
-- punto 8
select count(*), year(a.fechaIngreso) as anio
from alumno a 
GROUP BY anio;
-- en clase
select year(fechaIngreso) as Año_ingreso, count(*) as cantidad
from alumno
GROUP BY year(fechaIngreso);
-- punto 9 en clase
select year(fechaIngreso) as Año_ingreso, weekofyear(fechaIngreso) as semana, count(*) as cantidad
from alumno
GROUP BY year(fechaIngreso),weekofyear(fechaIngreso)
ORDER BY 1;


-- punto 10
select count(*), year(a.fechaIngreso) as anio
from alumno a 
GROUP BY anio
HAVING count(*) > 20;
-- en clase
SELECT year(fechaIngreso) as 'Año Ingreso', COUNT(*) as cantidad
from alumno
GROUP BY year(fechaIngreso)
having count(*) > 20
order by 1;

-- punto 11 en clase
SELECT concat(nombre, ' ', apellido ) as 'Nombre y Apellido',
timestampdiff(year, fechaNacimiento, curdate()) as Edad,
date_add(fechaNacimiento, interval(timestampdiff(year, fechaNacimiento, curdate()))year) as verificador
FROM instructor;

-- punto 12 en clase
SELECT concat(nombre, ' ', apellido ) as 'Nombre y Apellido',
timestampdiff(year, fechaNacimiento, curdate()) as Edad
from alumno
ORDER BY 2 DESC;

select avg(timestampdiff(year, fechaNacimiento, curdate())) as promedio
from alumno;

select idCohorte, avg(timestampdiff(year, fechaNacimiento, curdate())) as promedio
from alumno
GROUP BY idCohorte;

-- punto 13 en clase
SELECT concat(nombre, ' ', apellido ) as 'Nombre y Apellido',
timestampdiff(year, fechaNacimiento, curdate()) as Edad
from alumno
where timestampdiff(year, fechaNacimiento, curdate()) > (
	select avg(timestampdiff(year, fechaNacimiento, curdate()))
	from alumno)
ORDER BY 2 DESC;
 
#Corregir alumno con fecha de nacimiento errónea
SELECT *
from alumno
WHERE fechaNacimiento < '1900-01-01';

UPDATE alumno
set fechaNacimiento = '2002-01-02'
WHERE idAlumno = 127;







