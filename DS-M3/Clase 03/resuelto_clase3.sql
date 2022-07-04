use henry_m3;

select avg(Precio), STDDEV(Precio)
from venta; -- el resultado no visibiliza el estado

select idProducto, avg(Precio) as promedio, avg(Precio)+ (3*STDDEV(Precio)) as maximo -- , avg(Precio)- (3*STDDEV(Precio)) as minimo
-- el minimo no es necesario, ya que no hay ventas negativas
from venta
GROUP BY idProducto;

SELECT v.*, o.promedio, o.maximo
from venta v
JOIN (select 	idProducto, 
				avg(Precio) as promedio, 
                avg(Precio)+ (3*STDDEV(Precio)) as maximo
				FROM venta
                GROUP BY idProducto) o
	on (v.idProducto = o.IdProducto)
where v.Precio > o.maximo;

SELECT * 
FROM venta
where idProducto = 42890;

SELECT v.*, o.promedio, o.maximo
from venta v
JOIN (select 	idProducto, 
				avg(Cantidad) as promedio, 
                avg(Cantidad)+ (3*STDDEV(Cantidad)) as maximo
				FROM venta
                GROUP BY idProducto) o
	on (v.idProducto = o.IdProducto)
where v.Cantidad > o.maximo;

SELECT * 
FROM venta
where idProducto = 42992;

INSERT into aux_venta
SELECT v.IdVenta, v.Fecha, v.Fecha_Entrega, v.IdCliente, v.IdSucursal, v.IdEmpleado, v.IdProducto, v.Precio, v.Cantidad,2
FROM venta v
JOIN (select 	idProducto, 
				avg(Cantidad) as promedio, 
                avg(Cantidad)+ (3*STDDEV(Cantidad)) as maximo
				FROM venta
                GROUP BY idProducto) v2
	on (v.idProducto = v2.IdProducto)
where v.Cantidad > v2.maximo or v.Cantidad < 0;

INSERT into aux_venta
SELECT v.IdVenta, v.Fecha, v.Fecha_Entrega, v.IdCliente, v.IdSucursal, v.IdEmpleado, v.IdProducto, v.Precio, v.Cantidad,3
FROM venta v
JOIN (select 	idProducto, 
				avg(Precio) as promedio, 
                avg(Precio)+ (3*STDDEV(Precio)) as maximo
				FROM venta
                GROUP BY idProducto) v2
	on (v.idProducto = v2.IdProducto)
where v.Precio > v2.maximo or v.Precio < 0;

alter table venta add Outlier tinyint not null default 1 after Cantidad;
UPDATE venta v
join aux_venta a
on (v.IdVenta = a.IdVenta AND a.Motivo in (2,3))
set v.Outlier = 0;


-- KPI: Margen de Ganancia por producto superior a 20%
SELECT 	venta.Producto, 
		venta.SumaVentas, 
        venta.CantidadVentas, 
        venta.SumaVentasOutliers,
        compra.SumaCompras, 
        compra.CantidadCompras,
        ((venta.SumaVentas / compra.SumaCompras - 1) * 100) as margen
FROM
	(SELECT 	p.Producto,
			SUM(v.Precio * v.Cantidad * v.Outlier) 	as 	SumaVentas,
			SUM(v.Outlier) 							as	CantidadVentas,
			SUM(v.Precio * v.Cantidad) 				as 	SumaVentasOutliers,
			COUNT(*) 								as	CantidadVentasOutliers
	FROM venta v JOIN producto p
		ON (v.IdProducto = p.IdProducto
			AND YEAR(v.Fecha) = 2019)
	GROUP BY p.Producto) AS venta
JOIN
	(SELECT 	p.Producto,
			SUM(c.Precio * c.Cantidad) 				as SumaCompras,
			COUNT(*)								as CantidadCompras
	FROM compra c JOIN producto p
		ON (c.IdProducto = p.IdProducto
			AND YEAR(c.Fecha) = 2019)
	GROUP BY p.Producto) as compra
ON (venta.Producto = compra.Producto)
WHERE ((venta.SumaVentas / compra.SumaCompras - 1) * 100) > 20;


