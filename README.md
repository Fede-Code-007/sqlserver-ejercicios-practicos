# Práctica SQL Server

Repositorio que contiene una serie de ejercicios prácticos realizados con **Microsoft SQL Server**, orientados al diseño, manipulación y consulta de bases de datos relacionales.

Los ejercicios fueron desarrollados sobre una base de datos de ejemplo denominada `base_consorcio`, utilizada para practicar diferentes conceptos de SQL de manera progresiva.

## 📚 Contenido

El repositorio está organizado en cuatro series de ejercicios:

| Serie       | Contenido                                                                |
| ----------- | ------------------------------------------------------------------------ |
| **Serie 1** | Creación de la base de datos, tablas, restricciones e inserción de datos |
| **Serie 2** | Consultas SQL, filtros, funciones, agrupaciones y JOINs                  |
| **Serie 3** | Subconsultas y combinaciones                                             |
| **Serie 4** | Consultas avanzadas, informes y análisis de datos                        |

---

## 🗄️ Base de datos

Los ejercicios utilizan una base de datos denominada:

```sql
base_consorcio
```

El modelo contiene información relacionada con:

* Provincias
* Localidades
* Zonas
* Consorcios
* Administradores
* Conserjes
* Tipos de gastos
* Gastos
* Inmuebles

Entre las relaciones principales se encuentran:

```text
Provincia
   │
   └── Localidad
          │
          └── Consorcio
                 ├── Administrador
                 ├── Conserje
                 ├── Zona
                 ├── Gasto
                 └── Inmueble
```

---

## 📝 Serie 1 — Creación y manipulación de la base de datos

En esta serie se trabaja principalmente con la **definición de estructuras y manipulación de datos**.

### Conceptos trabajados

* Creación de tablas mediante `CREATE TABLE`
* Claves primarias (`PRIMARY KEY`)
* Claves foráneas (`FOREIGN KEY`)
* Claves primarias compuestas
* Restricciones `CHECK`
* Valores `DEFAULT`
* Columnas `IDENTITY`
* Modificación de tablas mediante `ALTER TABLE`
* Inserción de datos con `INSERT`
* Actualización de datos con `UPDATE`
* Eliminación de datos con `DELETE`
* Eliminación de tablas
* Limpieza de tablas mediante `TRUNCATE TABLE`
* Validación de datos mediante restricciones

También se incluyen ejercicios donde se realizan operaciones que **deben producir errores debido a las restricciones definidas**, permitiendo comprobar el funcionamiento de las reglas de integridad.

### Principales tablas

```text
provincia
localidad
zona
conserje
administrador
tipogasto
consorcio
gasto
```

---

## 🔎 Serie 2 — Consultas SQL

La segunda serie está enfocada en la recuperación y análisis de información mediante consultas `SELECT`.

### Conceptos trabajados

* `SELECT`
* `WHERE`
* `DISTINCT`
* `TOP`
* `ORDER BY`
* `LIKE`
* `IN`
* Operadores aritméticos
* Concatenación de cadenas
* Conversión de tipos
* Funciones de fecha
* `ROUND`
* `FORMAT`
* `CASE`
* `COUNT`
* `SUM`
* `AVG`
* `MAX`
* `GROUP BY`
* `HAVING`
* `INNER JOIN`
* `LEFT JOIN`
* `FULL OUTER JOIN`

También se realizan consultas para generar información agrupada y reportes, como:

* Cantidad de administradores por sexo.
* Gastos totales y promedio.
* Gastos acumulados por tipo.
* Cantidad de consorcios por zona y localidad.
* Mayores gastos registrados.
* Información de consorcios, provincias y localidades.
* Relación entre conserjes y consorcios.

---

## 🔍 Serie 3 — Subconsultas y combinaciones

La tercera serie profundiza en el uso de **subconsultas y combinaciones de tablas** para resolver consultas más complejas.

### Conceptos trabajados

* Subconsultas
* `IN`
* `NOT IN`
* `EXISTS` y consultas equivalentes
* `INNER JOIN`
* `LEFT JOIN`
* Agrupaciones dentro de subconsultas
* Funciones de agregación
* Comparación contra valores promedio
* Consultas anidadas
* Identificación de registros sin relaciones asociadas

Algunos ejercicios resuelven el mismo problema mediante diferentes estrategias, por ejemplo:

* Utilizando `JOIN`.
* Utilizando subconsultas.

Esto permite comparar diferentes formas de plantear una consulta SQL.

---

## 📊 Serie 4 — Consultas avanzadas e informes

La cuarta serie está orientada a la generación de **informes y consultas de mayor complejidad**.

Se incorporan datos relacionados con los inmuebles y se plantean consultas que requieren combinar varias tablas y aplicar diferentes operaciones simultáneamente.

### Conceptos trabajados

* Consultas con múltiples tablas
* Subconsultas correlacionadas y no correlacionadas
* `FULL OUTER JOIN`
* `LEFT JOIN`
* `GROUP BY`
* `HAVING`
* `CASE`
* `COALESCE`
* `COUNT`
* `SUM`
* `AVG`
* `DISTINCT`
* Agrupaciones por múltiples columnas
* Ordenamiento mediante expresiones
* Identificación de registros sin correspondencia
* Generación de informes mediante consultas SQL

### Ejemplos de problemas resueltos

* Cantidad de departamentos por piso y consorcio.
* Inmuebles pertenecientes a determinadas zonas.
* Cantidad de pisos y departamentos asignados a cada consorcio.
* Consorcios sin departamentos asignados.
* Inmuebles sin consorcio asignado.
* Total, promedio y cantidad de gastos por consorcio.
* Consorcios sin inmuebles mediante subconsultas.
* Clasificación de inmuebles según cantidad de pisos.

---

## 🛠️ Tecnologías utilizadas

* **Microsoft SQL Server**
* **T-SQL**
* SQL Server Management Studio (SSMS)

---

## ▶️ Cómo ejecutar

### 1. Requisitos

Para ejecutar los ejercicios se necesita:

* Microsoft SQL Server.
* SQL Server Management Studio (SSMS) u otro cliente compatible con SQL Server.
* Una instancia de SQL Server en ejecución.

### 2. Clonar el repositorio

Clonar el repositorio utilizando Git:

```bash
git clone https://github.com/Fede-Code-007/Practica-SQL-Server.git
```

Ingresar al directorio del proyecto:

```bash
cd Practica-SQL-Server
```

### 3. Crear la base de datos

Abrir **SQL Server Management Studio** y conectarse a la instancia de SQL Server.

Abrir el archivo correspondiente a la **Serie 1** y ejecutar primero la creación de la base de datos:

```sql
CREATE DATABASE base_consorcio;
GO

USE base_consorcio;
GO
```

Luego ejecutar los ejercicios de la Serie 1 en el orden establecido.

> La Serie 1 contiene la creación de las tablas, restricciones y carga inicial de datos necesarias para trabajar con las siguientes series.

### 4. Ejecutar las series restantes

Una vez creada y cargada la base de datos, seleccionar la base:

```sql
USE base_consorcio;
GO
```

A continuación, ejecutar los archivos en orden:

```text
Serie 1
   ↓
Serie 2
   ↓
Serie 3
   ↓
Serie 4
```

Cada serie contiene los ejercicios correspondientes y sus respectivas consultas SQL.

### ⚠️ Consideraciones

* Se recomienda ejecutar los ejercicios de cada serie **en el orden en que aparecen**.
* Algunos ejercicios modifican, eliminan o agregan datos.
* La **Serie 1** crea la estructura necesaria para las consultas posteriores.
* Algunos ejercicios están diseñados intencionalmente para generar errores al intentar violar restricciones `CHECK`, `PRIMARY KEY` o `FOREIGN KEY`.
* La Serie 4 utiliza la tabla `inmueble`, por lo que requiere que dicha tabla y sus datos estén disponibles en la base de datos.

---

## 🎯 Objetivos de aprendizaje

Esta práctica tuvo como objetivo fortalecer conocimientos en:

* Diseño de bases de datos relacionales.
* Definición de estructuras y relaciones.
* Integridad referencial.
* Manipulación de datos.
* Consultas SQL.
* Funciones de agregación.
* Agrupación y filtrado de información.
* Subconsultas.
* Combinación de tablas mediante `JOIN`.
* Resolución de problemas mediante consultas SQL.
* Generación de informes a partir de datos relacionales.

