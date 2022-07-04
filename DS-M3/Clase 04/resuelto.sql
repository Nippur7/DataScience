use henry_m3;
CREATE TABLE `fact_venta` (
  `IdFecha` int(11) NOT NULL AUTO_INCREMENT,
  `Fecha` date NOT NULL,
  `IdSucursal` int(11) NOT NULL,
  `IdProducto` int(11) NOT NULL,
  `IdCliente` int(11) NOT NULL,
  `Precio` decimal(10,2) NOT NULL,
  `Cantidad` decimal(10,2) NOT NULL,
  PRIMARY KEY (`IdFecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

insert into fact_venta (Fecha, IdSucursal, IdProducto, IdCliente, Precio, Cantidad)
SELECT v.Fecha, v.IdSucursal, v.IdProducto, v.IdCliente, v.Precio, v.Cantidad
FROM venta v
order by v.Fecha;

explain SELECT ca.trimestre, c.Rango_Etario,
		SUM(v.Precio * v.Cantidad) as Venta
FROM venta v
JOIN cliente c on (v.IdCliente = c.IdCliente
					AND year(v.Fecha) = 2020)
JOIN calendario ca on (ca.Fecha = v.Fecha)
GROUP BY ca.trimestre, c.Rango_Etario
ORDER BY ca.anio, ca.trimestre, c.Rango_Etario; -- 3.688 segundos - al optimizar pasamos a 0.016

explain SELECT ca.trimestre, c.Rango_Etario,
		SUM(v.Precio * v.Cantidad) as Venta
FROM venta v
JOIN cliente c on (v.IdCliente = c.IdCliente)
JOIN calendario ca on (ca.Fecha = v.Fecha)
where year(v.Fecha) = 2020
GROUP BY ca.trimestre, c.Rango_Etario
ORDER BY ca.anio, ca.trimestre, c.Rango_Etario; -- 0.015

SELECT ca.anio, ca.trimestre, tp.TipoProducto,
		SUM(v.Precio * v.Cantidad) as Venta
FROM venta v
JOIN producto p on (v.IdProducto = p.IdProducto)
join tipo_producto tp on (tp.IdTipoProducto = p.IdTipoProducto)
JOIN calendario ca on (ca.Fecha = v.Fecha)
GROUP BY ca.anio, ca.trimestre, tp.TipoProducto
ORDER BY ca.anio, ca.trimestre, tp.TipoProducto; -- 16.609 seg

/* Indices*/
alter table `venta` add index(`IdProducto`);



