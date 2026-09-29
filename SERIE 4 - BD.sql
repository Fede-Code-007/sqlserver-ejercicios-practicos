USE base_consorcio 
--SERIE 4 BD
---------------------
--EJERCICIO 1 ------
--------------------
/*
1) Se requiere acceder a un informe que muestre la cantidad de departamentos por piso y consorcio. 

Formato de la salida:
provincia|localidad|consorcio|piso|cantidad de departamentos|
---------+---------+---------+----+-------------------------+
*/

SELECT 
	(	SELECT TOP 1  p.descripcion
		FROM provincia p
		WHERE p.idprovincia = i.idprovincia
	) as 'provincia',
	(	SELECT TOP 1 l.descripcion
		FROM localidad l
		WHERE l.idlocalidad = i.idlocalidad
	) as 'localidad',
	(
		SELECT TOP 1  c.nombre
		FROM consorcio c
		WHERE c.idconsorcio = i.idconsorcio AND c.idlocalidad = i.idlocalidad AND c.idprovincia = i.idprovincia
	) as 'consorcio',
	i.nro_piso as 'piso', 
	count(i.dpto) as 'cantidad de departamentos' 
From inmueble i
group by i.nro_piso, i.idconsorcio, i.idlocalidad, i.idprovincia
having i.idprovincia IS NOT NULL and i.idlocalidad IS NOT NULL and i.idconsorcio IS NOT NULL;


--------------------
--EJERCICIO 2 ------
--------------------
/*
2) Mostrar los datos de los departamentos (Nro_piso, Dpto, Sup_cubierta, Frente, balcon), el nombre del consorcio,  y la zona a la que pertenecen. Exceptos los que estan en la zona con menor cantidad de inmuebles.

Formato de salida:
nombre   |nro_piso |dpto |sup_Cubierta |frente |balcon |idprovincia |idlocalidad |idconsorcio |idzona|
*/


--PRIMERO OBTENEMOS LA ZONA CON MENOS INMBUEBLES
SELECT TOP 1 c.idzona, count (c.idzona) FROM inmueble i
LEFT JOIN consorcio c ON c.idlocalidad = i.idlocalidad and c.idprovincia = i.idprovincia and c.idconsorcio = i.idconsorcio
GROUP BY c.idzona
HAVING c.idzona IS NOT NULL
ORDER BY count (c.idzona) ASC;

/*AHORA HACEMOS LA SUBCONSULTA, la misma debe dar 534 registros debido a que la tabla inmueble tiene 582, 
de los cuales 5 no tienen consorcios asociados y 43 pertenecen a la zona con menos consorcios
582 - 5 - 43 = 534*/

SELECT 
	c.nombre, i.*, c.idzona
FROM inmueble i
LEFT JOIN consorcio c ON c.idconsorcio = i.idconsorcio and c.idlocalidad = i.idlocalidad and c.idprovincia = i.idprovincia
WHERE idzona != (
	SELECT TOP 1 c.idzona FROM inmueble i
	LEFT JOIN consorcio c ON c.idlocalidad = i.idlocalidad and c.idprovincia = i.idprovincia and c.idconsorcio = i.idconsorcio
	GROUP BY c.idzona
	HAVING c.idzona IS NOT NULL
	ORDER BY count (c.idzona) ASC
);
--------------------
--EJERCICIO 3 ------
--------------------
/*
3) Se solicita un informe, 
para conocer por cada conserje que trabaja en un consorcio, la cantidad de departamentos asignados que tiene, y la cantidad de pisos correspondientes.

Formato de salida:
apeynom     |nombre        |cantidad de pisos|Cantidad de departamentos|
------------+--------------+-----------------+-------------------------+
*/


SELECT COUNT (DISTINCT idconserje) FROM consorcio;

SELECT 
	(SELECT conser.apeynom FROM conserje conser WHERE conser.idconserje = consor.idconserje),
	consor.nombre,
	(SELECT count(distinct(i.nro_piso)) FROM inmueble i where i.idconsorcio=consor.idconsorcio AND i.idlocalidad=consor.idlocalidad AND consor.idprovincia=i.idprovincia) AS 'cantidad de pisos',
	(SELECT count(distinct(i.dpto)) FROM inmueble i where i.idconsorcio=consor.idconsorcio AND i.idlocalidad=consor.idlocalidad AND consor.idprovincia=i.idprovincia) AS 'Cantidad de departamentos'
FROM consorcio consor 
order by consor.idconserje;

--------------------
--EJERCICIO 4 ------
--------------------
/*
4) Para un informe, se necesita mostrar un listado con dos columnas (nombre consorcio, id inmueble), que indiquen lo siguiente:
- el nombre de los consorcios sin departamentos asignados, con la leyenda 'sin dptos'
-  los departamentos que están sin consorcios asignados, con la leyenda 'sin consorcio'

Modelo de salida esperada:

nombre        |id inmueble|
--------------+-----------+
EDIFICIO-3161 |sin dptos  |
EDIFICIO-8172 |sin dptos  |
. . . . . . . . . . . . . .
sin consorcios|578        |
sin consorcios|582        |
*/

SELECT	
CASE WHEN c.nombre IS NULL THEN 'sin consorcios'
ELSE c.nombre
END AS nombre,
CASE WHEN i.idinmueble IS NULL THEN 'sin dptos'
ELSE CONVERT(VARCHAR, i.idinmueble)
END AS 'id inmueble'
FROM consorcio c
FULL OUTER JOIN inmueble i 
ON c.idconsorcio = i.idconsorcio AND c.idlocalidad = i.idlocalidad AND c.idprovincia = i.idprovincia
WHERE c.nombre IS NULL or i.idinmueble IS NULL
ORDER BY i.idinmueble;

SELECT * from inmueble;
SELECT * from consorcio;
--------------------
--EJERCICIO 5 ------
--------------------

/*
5) Generar un informe donde se muestre por cada consorcio, el total de gasto generado, el promedio de gasto, y la cantidad de gastos realizados. 
Visualizar solamente los consorcios con más de 42 gastos realizados.

nombre    |total de gasto generado|promedio de gasto|Cantidad de Gastos|
----------+-----------------------+-----------------+------------------+
*/

SELECT c.nombre, SUM(g.importe) AS 'total de gasto generado', AVG(g.importe) AS 'promedio de gasto' , COUNT(g.importe) AS 'Cantidad de Gastos'
FROM consorcio c
LEFT JOIN gasto g ON c.idconsorcio = g.idconsorcio AND c.idlocalidad = g.idlocalidad AND c.idprovincia = g.idprovincia
GROUP BY c.nombre, g.idconsorcio, g.idlocalidad, g.idprovincia
HAVING g.idconsorcio IS NOT NULL AND COUNT(g.idgasto)>42;

--Verificamos viendo si todos los consorcios tienen 80 gastos como salio en la consulta
SELECT COUNT (*) FROM GASTO
GROUP BY idconsorcio, idlocalidad, idprovincia;

--------------------
--EJERCICIO 6 ------
--------------------
--Mostrar todos los consorcios (solo sus nombres) y todos los inmuebles (solo su ID).
--Organizando primero los consorcios sin inmuebles asignados, luego los inmuebles sin 
--consorcios y después el resto.

SELECT	
COALESCE(c.nombre, 'sin consorcios') AS nombre,
COALESCE(CAST(i.idinmueble AS VARCHAR), 'sin dptos') AS 'id inmueble'
FROM consorcio c
FULL OUTER JOIN inmueble i 
ON c.idconsorcio = i.idconsorcio AND c.idlocalidad = i.idlocalidad AND c.idprovincia = i.idprovincia
ORDER BY 
CASE WHEN i.idinmueble IS NULL THEN 0 ELSE 1 END ASC,
CASE WHEN c.nombre IS NULL THEN 0 ELSE 1 END ASC,
c.nombre DESC;

--------------------
--EJERCICIO 7 ------
--------------------
--Usando subconsulta, mostrar todos los consorcios que no tienen inmuebles asignados.

SELECT c.* FROM consorcio c
WHERE CONCAT(c.idconsorcio,c.idlocalidad,c.idprovincia) NOT IN (
	SELECT CONCAT(i.idconsorcio,i.idlocalidad,i.idprovincia)
	FROM inmueble i
);
				  
--------------------
--EJERCICIO 8 ------
--------------------
--Mostrar en una sola línea la cantidad de Departamentos/inmuebles con 1, 2, 3 y 4 o más
--pisos que estén asignados a algún consorcio. 
-- Respetando  el siguiente formato:
--Cantidad						UnPiso	DosPisos	TresPisos	Masdetrespisos
--Cantidad inmuebles por piso  	0			0			0			0

SELECT COUNT(*) from inmueble; -- VERIFICAMOS LA CANTIDAD DE INMUEBLES REGISTRADOS

/*CALCULAMOS LA CANTIDAD DE INMUEBLES POR PISO (la sumatoria de los valores debe ser igual a la cantidad
calculada anteriormente.*/
SELECT 
    'Cantidad inmuebles por piso' AS Cantidad, 
    (SELECT COUNT(*) FROM inmueble WHERE nro_piso = 0 AND idconsorcio IS NOT NULL AND idlocalidad IS NOT NULL AND idprovincia IS NOT NULL) AS UnPiso,
	(SELECT COUNT(*) FROM inmueble WHERE nro_piso = 1 AND idconsorcio IS NOT NULL AND idlocalidad IS NOT NULL AND idprovincia IS NOT NULL) AS DosPisos,
	(SELECT COUNT(*) FROM inmueble WHERE nro_piso = 2 AND idconsorcio IS NOT NULL AND idlocalidad IS NOT NULL AND idprovincia IS NOT NULL) AS TresPisos,
	(SELECT COUNT(*) FROM inmueble WHERE nro_piso > 2 AND idconsorcio IS NOT NULL AND idlocalidad IS NOT NULL AND idprovincia IS NOT NULL) AS Masdetrespisos;

/* 230 + 231 + 116 + 0 = 577 y sabemos que son 582 departamentos de los
 cuales 5 no tienen asignados consorcios, 582-5 = 577 por lo tanto podemos concluir que la consulta
 esta bien hecha.
