USE henry_m3;
SELECT c.Nombre_y_Apellido, v.IdProducto, p.Producto, v.Precio
FROM venta v
INNER JOIN cliente c
ON v.IdCliente = c.IdCliente
INNER JOIN producto p
ON v.IdProducto = p.IdProducto;
-- group by c.Nombre_y_Apellido;

SELECT c.Nombre_y_Apellido, p.Producto, v.Cantidad
FROM cliente c
LEFT JOIN venta v
ON c.IdCliente = v.IdCliente
LEFT JOIN producto p
ON v.IdProducto = p.IdProducto;

-- RESUELTO EN CLASES

SELECT 	c.IdCliente,
		c.Nombre_y_Apellido,
        SUM(ifnull(v.Cantidad,0)) as cant_prod,
        SUM(v.Cantidad) as cant_null
FROM cliente c
LEFT JOIN venta v ON (v.IdCliente = c.IdCliente)
GROUP BY c.IdCliente, c.Nombre_y_Apellido
ORDER BY SUM(ifnull(v.Cantidad,0));

SELECT 	c.IdCliente,
		c.Nombre_y_Apellido,
        YEAR(v.Fecha),
        COUNT(v.IdVenta) as Total_Compras
FROM venta v
INNER JOIN cliente c ON (c.IdCliente = v.IdCliente)
GROUP BY c.IdCliente, c.Nombre_y_Apellido, YEAR(v.Fecha);


SELECT 	c.IdCliente,
		c.Nombre_y_Apellido,
		p.Producto,
        p.IdProducto,
        SUM(v.Cantidad) as Cant_Prod,
        round(avg(v.Precio),2) as Prom_Precio
FROM venta v
inner join producto p on (v.IdProducto = p.IdProducto)
inner join cliente c on (v.IdCliente = c.IdCliente)
GROUP BY c.IdCliente, c.Nombre_y_Apellido, p.IdProducto, p.Producto
ORDER BY c.IdCliente;

-- SELECT Localidad from localidad group by localidad having count(*) > 1; busqueda de duplicados

SELECT 	p.Provincia,
		l.Localidad,
        SUM(v.Cantidad) as Cant_Prod,
        SUM(v.Precio * v.Cantidad) as Total_Venta,
        COUNT(v.IdVenta) as Volumen_venta
FROM venta v
LEFT JOIN cliente c ON (v.IdCliente = c.IdCliente)
LEFT JOIN localidad l ON (l.IdLocalidad = c.IdLocalidad)
left join provincia p on (l.IdProvincia=p.IdProvincia) 
where v.Outlier = 1
group by p.IdProvincia, p.Provincia, l.IdLocalidad, l.Localidad
order by p.Provincia, l.Localidad;

-- punto 6
SELECT 	p.Provincia,
		-- l.Localidad,
        SUM(v.Cantidad) as Cant_Prod,
        SUM(v.Precio * v.Cantidad) as Total_Venta,
        COUNT(v.IdVenta) as Volumen_venta
FROM venta v
LEFT JOIN cliente c ON (v.IdCliente = c.IdCliente)
LEFT JOIN localidad l ON (l.IdLocalidad = c.IdLocalidad)
left join provincia p on (l.IdProvincia=p.IdProvincia) 
where v.Outlier = 1
group by p.IdProvincia, p.Provincia -- l.IdLocalidad, l.Localidad
HAVING  SUM(v.Precio * v.Cantidad) > 100000
order by p.Provincia; -- l.Localidad;

-- punto 7
SELECT 	c.Rango_Etario,
		SUM(v.Cantidad) as Cant_Prod,
        SUM(v.Precio * v.Cantidad) as Total_Venta
FROM venta v
INNER JOIN	cliente c ON (v.IdCliente = c.IdCliente)
where v.Outlier = 1
GROUP BY c.Rango_Etario;

-- punto 8

SELECT p.IdProvincia,
	p.Provincia,
    COUNT(c.IdCliente) as cant_clientes
FROM provincia p
left join localidad l on (p.IdProvincia = l.IdProvincia)
left JOIN cliente c on (c.IdLocalidad = l.IdLocalidad)
GROUP BY p.IdProvincia, p.Provincia;
 
        
        
        



