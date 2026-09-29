
--SERIE 3:
USE base_consorcio;

--EJERCICIO 1:
--Mostrar los datos de los consorcios (provincia, localidad, nombres, dirección y zona) que
--pertenezcan a las dos zonas con mayor cantidad de consorcios.SELECT c.idprovincia, c.idlocalidad, c.nombre, c.direccion, c.idzona FROM consorcio cWHERE c.idzona IN (	SELECT TOP 2 c.idzona 	FROM consorcio c 	GROUP BY c.idzona ORDER BY COUNT(*) DESC);--EJERCICIO 2:--Seleccionar los consorcios que pertenezcan a la provincia con mayor número de habitantes, y
--mostrar los datos de los conserjes mayores a 50 años (ordenados de mayor a menor por edad)
--que no estén asignados a estos consorcios.SELECT *, DATEDIFF(yy, c.fechnac, getdate())  FROM conserje cWHERE c.idconserje NOT IN (	SELECT cons.idconserje FROM consorcio cons 	WHERE cons.idprovincia = (		SELECT TOP 1 p.idprovincia 		FROM provincia p 		ORDER BY p.poblacion desc	) ) AND DATEDIFF(yy, c.fechnac, getdate()) > 50;--EJERCICIO 3:--Mostrar todos los tipos de gastos, y sus respectivas descripciones, que no fueron registrados en
--toda la provincia de Buenos Aires para el mes de febrero del año 2015.

SELECT * from tipogasto tg
WHERE tg.idtipogasto NOT IN(
	SELECT g.idtipogasto 
	FROM gasto g 
	WHERE g.idprovincia = 2 AND MONTH(g.fechapago)=2 AND YEAR(g.fechapago)=2015
);


--EJERCICIO 5:
--Mostrar los nombres, en el caso que existan, de las provincias que no tengan localidades
--cargadas. Verificar el resultado por medio de otras consultas.

SELECT p.descripcion FROM provincia p
WHERE p.idprovincia NOT IN(
	 SELECT l.idprovincia
	 FROM localidad l
 );

--EJERCICIO 6:
--Variante del ejercicio 26 (serie 2). Agregar un nuevo tipo de gasto, y mostrar en el
--listado final los tipos de gastos que no se registraron en la tabla gastos.

INSERT INTO tipogasto (idtipogasto, descripcion) VALUES (50, 'Nuevo tipo gasto'); 

SELECT * from tipogasto tg
WHERE tg.idtipogasto NOT IN(
	SELECT g.idtipogasto
	FROM gasto g
);

--EJERCICIO 7:
--Mostrar en un solo registro, la cantidad de consorcios que realizaron al menos un
--gasto (variante con combinaciones y con subconsulta)--Combinaciones:Select Count(Distinct CONCAT(c.idconsorcio, '-', c.idlocalidad, '-', c.idprovincia)) AS 'Total de consorcios con gastos'
From consorcio c
Inner Join gasto g on c.idconsorcio = g.idconsorcio and c.idlocalidad = g.idlocalidad and c.idprovincia = g.idprovincia;--Subconsulta:SELECT COUNT(distinct (CONCAT (c.idconsorcio, c.idlocalidad, c.idprovincia))) AS 'Total de consorcios con gastos' from consorcio cWHERE CONCAT (c.idconsorcio, c.idlocalidad, c.idprovincia) IN(		SELECT CONCAT (g.idconsorcio, g.idlocalidad, g.idprovincia)		FROM gasto g);--EJERCICIO 8:--Mostrar los administradores que no están asignados a ningún consorcio (variante con
--combinaciones y con subconsulta)--Combinaciones:SELECT a.idadmin, a.apeynom, a.fechnac, a.sexo, a.tel FROM administrador aLEFT JOIN consorcio c ON a.idadmin = c.idadminWHERE c.idadmin IS NULL;--Subconsulta:SELECT a.idadmin, a.apeynom, a.fechnac, a.sexo, a.tel FROM administrador aWHERE a.idadmin NOT IN (	SELECT c.idadmin	FROM consorcio c 	WHERE c.idadmin IS NOT NULL);--EJERCICIO 9:--Mostrar los administradores con consorcios que estén por debajo del promedio de
--edad solo de los administradores asignados a estos consorcios.SELECT *, DATEDIFF(yy, a.fechnac, getdate()) AS 'Edad' FROM administrador awhere a.idadmin IN (	SELECT c.idadmin	FROM consorcio c	WHERE c.idadmin IS NOT NULL) AND DATEDIFF(yy, a.fechnac, getdate()) < (	SELECT AVG (DATEDIFF (yy, a1.fechnac, getdate())) 	FROM administrador a1	WHERE a1.idadmin IN (		SELECT c1.idadmin		FROM consorcio c1		WHERE c1.idadmin IS NOT NULL	));--EJERCICIO 10:--Mostrar los datos del administrador correspondiente al consorcio que tenga menor
--gasto acumulado en el año (2015) en concepto de 'servicios'SELECT * from administrador aWHERE a.idadmin = (	SELECT c.idadmin FROM consorcio c	WHERE CONCAT (c.idconsorcio, c.idprovincia, c.idlocalidad) = (		SELECT TOP 1 CONCAT(g.idconsorcio, g.idprovincia, g.idlocalidad) 		FROM gasto g 		WHERE YEAR(g.fechapago) = 2015 AND g.idtipogasto = 1		GROUP BY g.idconsorcio, g.idprovincia, g.idlocalidad  		ORDER BY SUM(g.importe) ASC	))--EJERCICIO 11:--Calcular el promedio de gasto anual (año 2015) por consorcio en concepto de
--'sueldos', y mostrar los consorcios que superen ese monto en este ítem de gasto en el
--mismo añoSELECT
	(SELECT c.nombre 
	FROM consorcio c 
	WHERE concat(c.idlocalidad, c.idprovincia, c.idconsorcio) = concat(g.idlocalidad, g.idprovincia, g.idconsorcio)) as 'Consorcio',
	SUM(g.importe) as 'Gasto en sueldos 2015'
FROM gasto g 
WHERE YEAR(g.fechapago) = 2015 
GROUP BY concat(g.idlocalidad, g.idprovincia, g.idconsorcio), g.idtipogasto 
HAVING  g.idtipogasto = 3 AND 
		SUM(g.importe) >
						(SELECT
							AVG(g1.importe) 
						FROM gasto g1 
						WHERE YEAR(g1.fechapago) = 2015 
						GROUP BY g1.idtipogasto 
						HAVING  g1.idtipogasto = 3)
ORDER BY SUM(g.importe) DESC
;