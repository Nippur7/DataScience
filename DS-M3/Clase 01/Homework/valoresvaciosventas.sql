use henry_m3;
select * , (v.Precio/p.Precio) as cantidad1
from productos p
inner join venta v
on p.IdProducto = v.IdProducto
where v.Cantidad = ' ';



update venta v
join productos p
on p.IdProducto = v.IdProducto 
set v.cantidad = (v.Precio/p.Precio)
where v.Cantidad = ' ';                                                                                               updated