use henry_m3;

DELIMITER $$

CREATE PROCEDURE ListarProductos (IN InFecha DATE)
BEGIN
		SELECT v.Fecha, p.Producto, sum(v.Cantidad) as Cant
        FROM venta v
        INNER JOIN producto p
        on v.IdProducto = p.IdProducto
        where v.Fecha = InFecha
        GROUP BY p.Producto;
        
END$$
DELIMITER ;

CALL ListarProductos ('2020-02-01');

SELECT v.IdProducto, p.Producto
        FROM venta v
        INNER JOIN producto p
        on v.IdProducto = p.IdProducto
        where v.Fecha = '2020-01-01';

-- RESUELTO EN CLASES

DROP PROCEDURE ListaProductos;
DELIMITER $$
CREATE PROCEDURE ListaProductos(IN fechaventa DATE)
BEGIN
	SELECT DISTINCT tp.TipoProducto, p.Producto
    FROM fact_venta v
    JOIN dim_producto p 	ON (v.IdProducto = p.IdProducto)
    JOIN tipo_producto tp 	ON (p.TipoProducto = tp.TipoProducto)
    WHERE v.Fecha = fechaventa
    ORDER BY tp.TipoProdcuto, p.Producto;

END $$

DELIMITER ;

CALL ListaProductos('2018-03-09');

SELECT DISTINCT tp.TipoProducto, p.Producto
    FROM fact_venta v
    JOIN dim_producto p 	ON (v.IdProducto = p.IdProducto)
    JOIN tipo_producto tp 	ON (p.Producto = tp.TipoProducto)
    WHERE v.Fecha = '2020-01-01'
    ORDER BY tp.TipoProducto, p.Producto;
    
DROP FUNCTION margenBruto;
DELIMITER $$
CREATE FUNCTION margenBruto(precio DECIMAL(15,3), margen DECIMAL(9,2)) RETURNS DECIMAL (15,3)
/* DETERMINISTIC
READS SQL DATA */
BEGIN
	DECLARE margenBruto DECIMAL (15,3);
    SET margenBruto = precio * margen;
    RETURN margenBruto;
END $$

DELIMITER ;

select margenBruto(5.0,5.0);

SELECT c.Fecha,
		pr.Nombre as Proveedor,
		p.Producto,
        c.Precio as PrecioCompra,
        margenBruto(c.Precio, 1.2) as Margen
FROM compra c
JOIN producto p ON (c.IdProducto = p.IdProducto)
JOIN proveedor pr ON (c.IdProveedor = pr.IdProveedor);

SELECT 	p.IdProducto,
		p.Producto,
        p.Precio,
        margenBruto(p.Precio, 0.2) as Margen
from producto p
JOIN tipo_producto tp ON (p.IdTipoProducto = tp.IdTipoProducto AND TipoProducto = 'Impresión');

DROP PROCEDURE listaCategoria;
DELIMITER $$
CREATE PROCEDURE listaCategoria(IN categoria VARCHAR(30))
BEGIN
	SELECT	v.Fecha,
			v.Fecha_Entrega,
            v.IdCliente,
			v.IdSucursal,
            p.Producto,
            v.Precio,
            v.Cantidad
	from venta v
    JOIN producto p ON (v.IdProducto = p.IdProducto AND v.Outlier = 1)
    JOIN tipo_producto tp ON (p.IdTipoProducto = tp.IdTipoProducto 
    AND TipoProducto = categoria);

END $$
DELIMITER ;

CALL listaCategoria('sin dato');

SELECT DISTINCT Rango_Etario FROM cliente;
SET @grupo_etario = '4_De 51 a 60 años';
SELECT * 
FROM cliente
WHERE Rango_Etario = @grupo_etario;

