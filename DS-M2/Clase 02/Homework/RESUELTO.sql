USE henry;
-- PUNTO 2
DELETE FROM henry.cohorte WHERE idCohorte = 1245 OR idCohorte = 1246;
-- PUNTO 3


UPDATE cohorte
SET fechaInicio = '2022-05-16'
WHERE idCohorte = 1243

-- punto 4
update alumno
set apellido = 'Ramirez'
where idAlumno = 165;
-- punto 5

SELECT alumno.nombre, apellido, fechaNacimiento, alumno.fechaIngreso, cohorte.fechaInicio
FROM alumno
INNER JOIN cohorte
ON cohorte.idCohorte=alumno.idCohorte
WHERE cohorte.idCohorte = 1243;

-- punto 6
SELECT DISTINCT i.nombre, i.apellido
from instructor i
left join cohorte c on i.idInstructor = c.idInstructor
WHERE c.idCarrera = 1;
-- punto 7
SELECT alumno.nombre, apellido, fechaNacimiento, alumno.fechaIngreso, cohorte.fechaInicio
FROM alumno
INNER JOIN cohorte
ON cohorte.idCohorte=alumno.idCohorte
WHERE cohorte.idCohorte = 1235;
-- punto 8 
SELECT * 
FROM alumno
WHERE idCohorte = 1235
AND fechaIngreso BETWEEN '2019-01-01' and '2019-12-31';
-- punto 9
SELECT a.nombre, a.apellido, a.fechaNacimiento, ca.nombre
FROM alumno a
INNER JOIN cohorte c
ON c.idCohorte = a.idCohorte
INNER JOIN carrera ca
ON c.idCarrera = ca.idCarrera;
--  práctica en clase 
SELECT * 
FROM alumno
WHERE idCohorte = 1235
AND fechaIngreso BETWEEN '2019-01-01' and '2019-12-31'
ORDER BY apellido ASC, fechaIngreso DESC;

SELECT count(*) 
FROM alumno
WHERE idCohorte = 1235
AND fechaIngreso BETWEEN '2019-01-01' and '2019-12-31';

SELECT avg(round(datediff(curdate(),a.fechaNacimiento )/365)) as edad
FROM alumno a;

select avg(year(curdate())-year(a.fechaNacimiento)) as edad
from alumno a;
