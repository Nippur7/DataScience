use henry_m3;
-- Instrucción SQL N° 1

INSERT INTO fact_inicial (IdFecha, Fecha, IdSucursal, IdProducto, IdProductoFecha, IdSucursalFecha, IdProductoSucursalFecha)
SELECT	c.IdFecha, 
		g.Fecha,
		g.IdSucursal, 
        NULL AS IdProducto, 
        NULL AS IdProductoFecha, 
        g.IdSucursal * 100000000 + c.IdFecha IdSucursalFecha,
        NULL AS IdProductoSucursalFecha
FROM 	gasto g JOIN calendario c
	ON (g.Fecha = c.fecha)
WHERE g.IdSucursal * 100000000 + c.IdFecha NOT IN (	SELECT	v.IdSucursal * 100000000 + c.IdFecha 
													FROM venta v JOIN calendario c ON (v.Fecha = c.fecha)
													WHERE v.Outlier = 1);
-- Instrucción SQL N° 2

INSERT INTO fact_inicial (IdFecha, Fecha, IdSucursal, IdProducto, IdProductoFecha, IdSucursalFecha, IdProductoSucursalFecha)
SELECT	c.IdFecha, 
		co.Fecha,
		NULL AS IdSucursal, 
        co.IdProducto, 
        co.IdProducto * 100000000 + c.IdFecha AS  IdProductoFecha, 
        NULL IdSucursalFecha,
        NULL AS IdProductoSucursalFecha
FROM 	compra co JOIN calendario c
	ON (co.Fecha = c.fecha)
WHERE co.IdProducto * 100000000 + c.IdFecha NOT IN (SELECT	v.IdProducto * 100000000 + c.IdFecha 
													FROM venta v JOIN calendario c ON (v.Fecha = c.fecha)
													WHERE v.Outlier = 1);

-- Instrucción SQL N° 3
CREATE VIEW prom_ventas_outliers as 
SELECT 	co.TipoProducto,
		co.PromedioVentaConOutliers,
        so.PromedioVentaSinOutliers
FROM
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaConOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) co
JOIN
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaSinOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto and v.Outlier = 1)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) so
ON co.TipoProducto = so.TipoProducto;

-- PUNTO 4
SELECT Fecha, SUM(Precio * Cantidad) as Ventas_T
from venta
where Fecha = (SELECT MIN(Fecha)
					from venta)
GROUP BY Fecha
union
SELECT Fecha, SUM(Precio * Cantidad) as Ventas_T
from venta
where Fecha = (SELECT MAX(Fecha)
					from venta);
SELECT MIN(v.Fecha)
from venta v;
                    

-- PUNTO 5

SELECT v.Fecha, v.IdProducto, p.Producto, (v.Precio * v.Cantidad) AS Total_Ventas
from venta v
LEFT JOIN producto p ON (p.IdProducto = p.IdProducto)
where Fecha IN (SELECT MIN(v.Fecha)	from venta v
				union
                SELECT MAX(v.Fecha)	from venta v)
GROUP BY v.Fecha, v.IdProducto, p.Producto;

-- PUNTO 6
SELECT Fecha, SUM(Precio *Cantidad) AS Total_Ventas
from venta
GROUP BY Fecha
ORDER BY Total_Ventas DESC
limit 1;

