
--SERIE 2 -- BD

USE base_consorcio;

--EJERCICIO 1:
--Escribir una consulta que muestre todos los datos de todos los conserjes.
--Registros devueltos: 220
SELECT * FROM conserje;

--EJERCICIO 2:
--Mostrar solamente el nro. de conserje (idconserje) y el nombre (apeynom).
--Registros devueltos: 220
SELECT idconserje, apeynom FROM conserje;

--EJERCICIO 3:
--Precedencias de operadores aritméticos. Verificar los siguientes cálculos con la sentencias
--4+5*3/2-1
--(4 + 5)*3/2-1
--Salida Esperada: 10 y 12 

SELECT 4+5*3/2-1;
SELECT (4 + 5)*3/2-1;

--EJERCICIO 4:
--Escribir una consulta que muestre el gasto de los edificios, y un incremento del 20% en 3
--formatos diferentes, con las siguientes cabeceras “Sin formato”, “Redondeado a 1 digito
--decimal”, “Truncado a 1 digito”. Usar función ROUND.

SELECT *, importe*1.20 AS 'Incremento Sin Formato', ROUND(importe*1.20, 1) AS 'Redondeado a 1 digito decimal', ROUND(importe*1.20, 1, 1) AS 'Truncado a 1 digito'  FROM gasto;

--EJERCICIO 5:
--Listar el nombre (descripcion) y la población (poblacion) de cada Provincia.
--Salida Esperada:
--Registros devueltos: 24
SELECT descripcion, poblacion FROM provincia;

--EJERCICIO 6:
--Listar sin repetir, todos los códigos de provincia de la tabla “consorcio”. Usar Clausula DISTINCT

SELECT DISTINCT idprovincia FROM consorcio;

--EJERCICIO 7:
--Listar los 15 primeros conserjes de la respectiva tabla. Usar cláusula TOP

SELECT TOP 15 * FROM conserje;

--EJERCICIO 8:
--Crear una consulta que muestre el Nombre y la dirección de los consorcios de la provincia de
--“Buenos Aires”. Tabla a utilizar: consorcio y idprovincia = 2
SELECT nombre, direccion FROM consorcio WHERE idprovincia = 2; 

--EJERCICIO 9:
--Escribir y ejecutar una sentencia SELECT que devuelva los consorcios cuyo nombre comience
--con EDIFICIO-3. Tabla a utilizar: consorcio, columna: nombre

SELECT nombre, direccion FROM consorcio WHERE nombre like 'EDIFICIO-3%';

--EJERCICIO 10:
--Crear una consulta que muestre el nombre y apellido, teléfono y fecha de nacimiento en una
--sola columna, separados por un guión para todos los administradores mujeres (Sexo =F). Poner
--alias “Datos personales” en la primera columna:

SELECT apeynom + ' - ' + tel + ' - ' + FORMAT(CONVERT (DATE, fechnac), 'MMM d yyyy') AS 'Datos Personales' FROM administrador where sexo = 'F';

--EJERCICIO 11:
--Crear una consulta que muestre los gastos cuyos importes estén entre 10,00 y 100,00. 

SELECT * from gasto WHERE importe >= 10 and importe <= 100;

--EJERCICIO 12:
--Crear una consulta que muestre los administradores que hayan nacido en la década del 60,
--ordenar el resultado por dicha fecha en forma descendente: 

SELECT idadmin, apeynom, viveahi, tel, sexo, CONVERT(DATETIME,fechnac) FROM administrador WHERE YEAR(CONVERT (DATE, fechnac)) >= 1960 AND YEAR(CONVERT (DATE, fechnac)) < 1970 ORDER BY CONVERT (DATE, fechnac) DESC;

--EJERCICIO 13:
--Crear una consulta que muestre las localidades de las provincias de capital federal y buenos
--aires (1 y 2), ordenado alfabéticamente dentro de cada provincia. 

SELECT * FROM localidad WHERE idprovincia in (1, 2) ORDER BY idprovincia, descripcion;

--EJERCICIO 14:
--Crear una consulta que muestre los datos de los consorcios cuya dirección contenga la letra ‘N’
--en la Posición 5.

SELECT * FROM consorcio WHERE direccion like '____N%';

--EJERCICIO 15:
--Crear una consulta para mostrar los 697 gastos más costosos.

SELECT TOP 697 * FROM gasto ORDER BY importe DESC;

--EJERCICIO 16:
--Sobre la consulta anterior mostrar los importes repetidos.

SELECT TOP 697 * FROM gasto ORDER BY importe DESC;

--EJERCICIO 17:
--Crear una consulta que permita calcular un incremento de 15% para los gastos menores a
--10000, 10% para los que están entre 10000 y 20000 y un 5 % para el resto. Muestre la salida
--ordenada en forma decreciente por el importe.

SELECT *, 
CASE 
WHEN importe < 10000 THEN importe*1.15  
WHEN importe >= 10000 AND importe <= 20000 THEN importe*1.10
WHEN importe > 20000  THEN importe*1.5
END
AS 'Importe actualizado' FROM gasto ORDER BY importe DESC;

--EJERCICIO 18:
--Informar la cantidad de administradores masculinos y femeninos (sexo = ‘M’ y sexo = ‘F’)

SELECT 
COUNT(CASE WHEN sexo = 'M' THEN 1 END) AS Masculino,
COUNT(CASE WHEN sexo = 'F' THEN 1 END) AS Femenino
FROM administrador;

--EJERCICIO 19:
--Informar la suma total de gastos, la cantidad de gastos y el promedio del mismo. Utilizar Sum,
--Count y Avg

SELECT SUM(importe) AS 'Sumatoria', Count(importe) AS 'Cantidad', Avg(importe) AS 'Promedio' FROM gasto;

--EJERCICIO 20:
--a) Mostrar el importe total acumulado de gasto por tipo de gasto

SELECT idtipogasto, SUM(Importe) AS 'Importe Acumulado' FROM gasto GROUP BY idtipogasto;

--b)  Sobre la consulta anterior, listar solo aquellos gastos cuyos importes sean superior a 2.000.000.

SELECT idtipogasto, SUM(Importe) AS 'Importe Acumulado' FROM gasto GROUP BY idtipogasto HAVING SUM(importe) > 2000000 ;

--c) Listar solamente los dos (2) tipos de gastos con menor importe acumulado.SELECT TOP 2 idtipogasto, SUM(Importe) AS 'Importe Acumulado' FROM gasto GROUP BY idtipogasto ORDER BY SUM(importe) ASC;

--EJERCICIO 21:
--Mostrar por cada tipo de gasto, el importe del mayor gasto realizado.

SELECT idtipogasto, MAX(importe) AS 'Gasto mayor importe' FROM gasto GROUP BY idtipogasto;

--EJERCICIO 22:
--Mostrar el promedio de gasto por tipo de gasto, solo para aquellos pertenecientes al 1er
--semestre (períod del 1 al 6).

SELECT idtipogasto, AVG(CASE WHEN periodo BETWEEN 1 AND 6 THEN importe END) AS 'Promedio de gasto - 1er Semestre -' FROM gasto GROUP BY idtipogasto;

--EJERCICIO 23:
--Mostrar la cantidad de consorcios concentrados por zonas. Solo para las zonas 2 (NORTE), 3
--(SUR) y 4 (ESTE).

SELECT idzona, COUNT(*) AS 'Cantidad consorcios por zona' FROM consorcio GROUP BY idzona HAVING idzona IN (2, 3, 4);

--EJERCICIO 24:
--Mostrar la cantidad de consorcios existentes por localidad. Visualizar la lista en forma
--descendente por cantidad. SELECT idprovincia, idlocalidad, COUNT (*) AS 'Cantidad de consorcios por localidad' FROM consorcio GROUP BY idprovincia, idlocalidad ORDER BY COUNT(*) DESC;--EJERCICIO 25:--Mostrar la cantidad de conserjes agrupados por estado civil y edad. Mostrar un listado
--ordenado

SELECT estciv, DATEDIFF(YY, fechnac, getdate()) AS EDAD, COUNT(*) AS Cantidad from conserje GROUP BY estciv, DATEDIFF(YY, fechnac, getdate()) ORDER BY  DATEDIFF(YY, fechnac, getdate()) ASC;

--EJERCICIO 26:
--Mostrar el importe total acumulado de gasto por tipo de gasto. Mostrar las descripciones de
--cada tipo de gasto de la tabla tipogasto.

SELECT (SELECT tg.descripcion FROM tipogasto tg WHERE tg.idtipogasto = g.idtipogasto) AS 'Descripcion', SUM(g.importe) AS 'Importe Acumulado' FROM gasto g group by g.idtipogasto;

--EJERCICIO 27:
--Mostrar los nombres de todos los consorcios y en que provincia y localidad esta cada uno.
--Ordenados por Provincia, localidad y consorcioSELECT 	(SELECT top 1 p.descripcion FROM provincia p WHERE p.idprovincia = c.idprovincia) AS 'Provincia',     (SELECT top 1 l.descripcion FROM localidad l WHERE l.idlocalidad = c.idlocalidad)  AS 'Localidad', 	c.nombre AS 'Consorcio' FROM consorcio c ORDER BY 	(SELECT top 1 p.descripcion FROM provincia p WHERE p.idprovincia = c.idprovincia),	(SELECT top 1 l.descripcion FROM localidad l WHERE l.idlocalidad = c.idlocalidad),	c.nombre;--EJERCICIO 28:--Mostrar los 10 (diez) consorcios donde se registraron mayores gastos y a qué provincia
--pertenecen.SELECT TOP 10	(SELECT TOP 1 c.nombre from consorcio c where c.idconsorcio = g.idconsorcio and c.idprovincia = g.idprovincia and c.idlocalidad = g.idlocalidad) AS 'Consorcio',	(SELECT TOP 1 p.descripcion from provincia p where p.idprovincia = g.idprovincia) AS 'Provincia',	SUM (g.importe) AS 'GASTO TOTAL'FROM gasto gGROUP BY g.idconsorcio, g.idprovincia, g.idlocalidadORDER BY (SUM (g.importe)) DESC;--EJERCICIO 29:--Mostrar todas las provincias registradas. Para las que tengan consorcios mostrar a qué
--localidad pertenecen. Todos con sus nombres respectivos. Ordene los resultados por Provincia,
--localidad y consorcio.SELECT 	p.descripcion AS 'Provincia',     (SELECT top 1 l.descripcion FROM localidad l WHERE c.idlocalidad = l.idlocalidad)  AS 'Localidad', 	c.nombre AS 'Consorcio' FROM provincia pLEFT JOIN consorcio c ON c.idprovincia = p.idprovinciaORDER BY 	p.descripcion,	Localidad,	c.nombre; --EJERCICIO 30:--Mostrar los nombres de todos los conserjes. Para los que están asignados a algún consorcio
--mostrar también ese nombre. Ordene por apellido y nombre.SELECT 
    c.apeynom,
    co.nombre AS 'Consorcio'
FROM conserje c
LEFT JOIN consorcio co ON co.idconserje = c.idconserje
ORDER BY c.apeynom;SELECT COUNT (*) FROM conserje;--EJERCICIO 31:--Inserte un registro en la tabla consorcio con los siguientes valores:
--Idprovincia=1
--Idlocalidad =1
--Idconsorcio =3
--Nombre ='EDIFICIO-113'
--Direccion ='PARAGUAY Nº 630'
--Idzona = 5
--Idconserje = null
--Idadmin = null
--Mostrar los consorcios registrados, tengan o no tengan conserjes asignados.INSERT INTO consorcio (idprovincia, idlocalidad, idconsorcio, nombre, direccion, idzona) VALUES (1,1,3,'EDIFICIO-113','PARAGUAY Nº 630',5);SELECT 
    c.apeynom,
    co.nombre AS 'Consorcio'
FROM conserje c
FULL OUTER JOIN consorcio co ON co.idconserje = c.idconserje
ORDER BY c.apeynom;
