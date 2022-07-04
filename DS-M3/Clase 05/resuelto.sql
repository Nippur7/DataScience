use henry_m3;
CREATE TABLE `henry_m3`.`fac_inicial` (
  `IdFecha` INT NOT NULL,
  `Fecha` DATE NULL,
  `IdSucursal` INT NULL,
  `IdProducto` INT NULL,
  `IdProductoFecha` INT NULL,
  `IdSucursalFecha` INT NULL,
  `IdProductoSucursalFecha` INT NULL,
  PRIMARY KEY (`IdFecha`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish2_ci;

CREATE TABLE `henry_m3`.`fac_inicial_audit` (
  `Id_auditoria` INT NOT NULL,
  `Fecha` DATE NULL,
  `Usuario` VARCHAR(20) NULL,
  `FechaCarga` DATE NULL,
  PRIMARY KEY (`Id_auditoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;

create trigger fac_audit after insert on fac_inicial
for each ROW
insert INTO fac_inicial_audit (IdFecha, Fecha, Usuario, FechaCarga)
values (NEW.IdFecha, NEW.Fecha, current_user,now());

INSERT INTO fac_inicial (Fecha, IdSucursal, IdProducto, IdProductoFecha, IdSucursalFecha, IdProductoSucursalFecha)
SELECT v.Fecha, v.IdSucursal, v.IdProducto, v.IdProducto, CONCAT(v.IdProducto,v.Fecha), CONCAT(v.IdProducto,v.IdSucursal,v.Fecha)
FROM venta v 
JOIN calendario c
	ON (v.Fecha = c.fecha)
	WHERE v.Fecha > (SELECT IF(fi.Fecha IS NULL,'1800-01-01',max(fi.Fecha)) from fac_inicial fi);
/* PRUEBA DE FUNCIONAMIENTO DE LA FUNCION 
-- select if (max(fi.Fecha) not null from fac_inicial fi , select max(fi.Fecha) from fac_inicial fi, '1800-01-01' )
SELECT IF(fi.Fecha IS NULL,'1800-01-01',max(fi.Fecha)) as prueba
from fac_inicial fi;

SELECT v.Fecha, v.IdSucursal, v.IdProducto, v.IdProducto, CONCAT(v.IdProducto, v.Fecha), CONCAT(v.IdProducto, v.IdSucursal, v.Fecha)
FROM venta v
JOIN calendario c
	ON (v.Fecha = c.fecha)
    WHERE v.Fecha > (SELECT IF(fi.Fecha IS NULL,'1800-01-01',max(fi.Fecha)) from fac_inicial fi);
*/
-- RESOLUCION EN CLASE
CREATE TABLE IF NOT EXISTS `fact_venta_auditoria` (
	`Fecha`				DATE,
    `Fecha_Entrega`		DATE,
    `IdCanal`			INTEGER,
    `IdCliente`			INTEGER,
    `IdEmpleado`		INTEGER,
    `IdProducto`		INTEGER,
    `usuario`			VARCHAR(20),
    `FechaMod`			DATETIME
    );
    
    CREATE TRIGGER fact_venta_auditoria AFTER INSERT ON fact_venta
    FOR EACH ROW
    INSERT INTO fact_venta_auditoria (Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, usuario, FechaMod)
    VALUES (NEW.fecha, NEW.Fecha_Entrega, NEW.IdCanal, NEW.IdCliente, NEW.IdEmpleado, NEW.IdProducto, CURRENT_USER, now());
    -- TRUNCATE TABLE fact_venta; -- solo usar en casos excepcionales
    INSERT INTO fact_venta
    SELECT idVenta, Fecha,Fecha_Entrega,IdCanal,IdCliente,IdEmpleado,IdProducto, Precio, Cantidad
    FROM venta;
    
    -- Creamos la tabla que cuenta los registros
    
    DROP TABLE IF EXISTS `fact_venta_registros`;
    CREATE TABLE IF NOT EXISTS `fact_venta_registros`(
		Id INT NOT NULL AUTO_INCREMENT,
        CantRegistros INT,
        Usuario	VARCHAR(20),
        Fecha DATETIME,
        PRIMARY KEY (Id)
        );
DROP TRIGGER fact_venta_registros;        
CREATE TRIGGER fact_venta_registros AFTER INSERT ON fact_venta
FOR EACH ROW
INSERT INTO fact_venta_registros (CantRegistros, Usuario, Fecha)
VALUES ((SELECT COUNT(*) FROM fact_venta), CURRENT_USER, NOW());

DROP TABLE IF EXISTS registros_tablas;
CREATE TABLE IF NOT EXISTS registros_tablas (
id INT NOT NULL AUTO_INCREMENT,
tabla VARCHAR(30),
fecha DATETIME,
CantRegistros INT,
PRIMARY KEY (id)
);

INSERT INTO registros_tablas (tabla, fecha, cantRegistros)
SELECT 'venta', NOW() , COUNT(*)
FROM venta;
DROP TABLE IF EXISTS `fact_venta_cambios`;
CREATE TABLE IF NOT EXISTS `fact_venta_cambios`(
`fecha`			DATE,
`IdCliente`		INTEGER,
`idProducto`		INTEGER,
`Precio`		DECIMAL(15,3),
`Cantidad`		INTEGER
);

CREATE TRIGGER control_actualizacion AFTER UPDATE ON fact_venta
FOR EACH ROW
INSERT INTO fact_venta_cambios
VALUES (OLD.Fecha, OLD.IdCliente,OLD.IdProducto, OLD.Precio, OLD.Cantidad);

UPDATE fact_venta
SET Precio = 2930
where IdVenta = 7;

