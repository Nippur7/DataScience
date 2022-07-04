use henry_m3;
SELECT 	v.Fecha,
		v.idProducto,
        p.Producto,
		SUM(v.Precio * v.Cantidad) as Total_ventas,
        SUM(c.Precio * c.Cantidad) as Total_compras,
        SUM((v.Precio * v.Cantidad) - (c.Precio * c.Cantidad)) as Diferencia
from venta v
INNER JOIN compra c on (c.IdProducto = v.IdProducto)
INNER JOIN producto p on (p.IdProducto = c.IdProducto)
GROUP BY v.Fecha, v.IdProducto, p.Producto;

SELECT p.IdProducto, p.Producto, round(avg(v.Precio - c.Precio),2) as Diferencia
from venta v
join producto p on (v.IdProducto = p.IdProducto)
join compra c on (v.IdProducto = c.IdProducto)
group by p.IdProducto, p.Producto;