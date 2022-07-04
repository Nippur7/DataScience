use marketing_t;
update `sucursales` set `Provincia` = replace(`Provincia`, 'Ã³', 'ó')
where Provincia Like '%Ã³%';
update `sucursales` set `Provincia` = replace(`Provincia`, 'Ã­', 'í');
update `sucursales` set `Provincia` = replace(`Provincia`, 'Ã¡', 'á');
