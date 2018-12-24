/***********************************I-DAT-RCM-ALM-0-15/01/2013*****************************************/

/*
*	Author: RAC
*	Date: 21/12/2012
*	Description: Build the menu definition and the composition
*/


/*

Para  definir la la metadata, menus, roles, etc

1) sincronize ls funciones y procedimientos del sistema
2)  verifique que la primera linea de los datos sea la insercion del sistema correspondiente
3)  exporte los datos a archivo SQL (desde la interface de sistema en sis_seguridad), 
    verifique que la codificacion  se mantenga en UTF8 para no distorcionar los caracteres especiales
4)  remplaze los sectores correspondientes en este archivo en su totalidad:  (el orden es importante)  
                             menu, 
                             funciones, 
                             procedimietnos
*/


INSERT INTO segu.tsubsistema ("codigo", "nombre", "fecha_reg", "prefijo", "estado_reg", "nombre_carpeta", "id_subsis_orig")
VALUES (E'ALM', E'Sistema de Almacenes', E'2012-09-20', E'SAL', E'activo', E'ALMACENES', NULL);
  

-------------------------------------
--DEFINICION DE INTERFACES
-----------------------------------
  

select pxp.f_insert_tgui ('SISTEMA DE ALMACENES', '', 'ALM', 'si',1 , '', 1, '../../../lib/imagenes/alma32x32.png', '', 'ALM');
select pxp.f_insert_tgui ('Datos Generales', 'Datos Generales', 'ALDAGE', 'si', 1, '', 2, '', '', 'ALM');
select pxp.f_insert_tgui ('Catálogos', 'Catálogos', 'ALMAIN', 'si', 2, '', 2, '', '', 'ALM');
select pxp.f_insert_tgui ('Movimientos', 'Movimientos', 'ALMOVI', 'si', 3, '', 2, '', '', 'ALM');
select pxp.f_insert_tgui ('Almacenes', 'Almacenes', 'ALCRAL', 'si', 1, 'sis_almacenes/vista/almacen/Almacen.php', 3, '', 'Almacen', 'ALM');
select pxp.f_insert_tgui ('Materiales', 'Registro de Materiales', 'ALREMA', 'si', 1, 'sis_almacenes/vista/item/Item.php', 3, '', 'Item', 'ALM');
select pxp.f_insert_tgui ('Clasificación de materiales', 'Clasificación de materiales', 'ALCLMA', 'si', 1, 'sis_almacenes/vista/clasificacion/Clasificacion.php', 3, '', 'Clasificacion', 'ALM');



/***********************************F-DAT-RCM-ALM-0-15/01/2013*****************************************/

/***********************************I-DAT-AAO-ALM-19-13/02/2013*****************************************/



select pxp.f_insert_tgui ('Tipos de Movimientos', 'Tipos de Movimientos', 'MOVTIP', 'si', 1, 'sis_almacenes/vista/movimientoTipo/MovimientoTipo.php', 3, '', 'MovimientoTipo', 'ALM');
select pxp.f_insert_testructura_gui ('MOVTIP', 'ALMAIN');

select pxp.f_add_catalog('ALM','tmovimiento_tipo_tipo','ingreso');
select pxp.f_add_catalog('ALM','tmovimiento_tipo_tipo','salida');



/***********************************F-DAT-AAO-ALM-19-13/02/2013*****************************************/

/***********************************I-DAT-AAO-ALM-24-13/02/2013*****************************************/



select pxp.f_insert_tgui ('Métodos de Valoracion', 'Métodos de Valoracion', 'MEVAL', 'si', 1, 'sis_almacenes/vista/metodoVal/MetodoVal.php', 3, '', 'MetodoVal', 'ALM');
select pxp.f_insert_testructura_gui ('MEVAL', 'ALMAIN');

INSERT INTO alm.tmetodo_val ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_metodo_val", "codigo", "nombre", "descripcion")
VALUES (1, 1, E'2013-02-14 09:30:07.254', E'2013-02-14 09:32:41.473', E'activo', 2, E'UEPS', E'Ultimo en Entrar Primero en Salir', E'');

INSERT INTO alm.tmetodo_val ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_metodo_val", "codigo", "nombre", "descripcion")
VALUES (1, 1, E'2013-02-14 09:28:58.325', E'2013-02-14 09:32:45.920', E'activo', 1, E'PEPS', E'Primero en Entrar Primero en Salir', E'');

INSERT INTO alm.tmetodo_val ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_metodo_val", "codigo", "nombre", "descripcion")
VALUES (1, NULL, E'2013-02-14 10:21:20.660', E'2013-02-14 10:21:20.660', E'activo', 4, E'PP', E'Promedio Ponderado', E'');



/***********************************F-DAT-AAO-ALM-24-13/02/2013*****************************************/

/***********************************I-DAT-AAO-ALM-20-13/02/2013*****************************************/



select pxp.f_insert_tgui ('Movimientos', 'Movimientos', 'MOV', 'si', 1, 'sis_almacenes/vista/movimiento/Movimiento.php', 3, '', 'Movimiento', 'ALM');
select pxp.f_insert_testructura_gui ('MOV', 'ALMOVI');



/***********************************F-DAT-AAO-ALM-20-13/02/2013*****************************************/

/***********************************I-DAT-AAO-ALM-31-20/02/2013*****************************************/



INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg",  "codigo", "nombre", "tipo")
VALUES (1, null, now(), null, E'activo', E'SALTRNSF', E'Salida por Transferencia', E'salida');

INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg",  "codigo", "nombre", "tipo")
VALUES (1, NULL, now(), null, E'activo', E'INTRNSF', E'Ingreso por transferencia', E'ingreso');


/***********************************F-DAT-AAO-ALM-31-20/02/2013*****************************************/

/***********************************I-DAT-AAO-ALM-29-23/02/2013*****************************************/


INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2013-02-23 18:49:21.853', E'2013-02-23 18:49:21.853', E'activo', E'DEV', E'Ingreso por Devolucion', E'ingreso');


/***********************************F-DAT-AAO-ALM-29-23/02/2013*****************************************/

/***********************************I-DAT-AAO-ALM-26-25/02/2013*****************************************/


INSERT INTO param.tdocumento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_subsistema", "codigo", "descripcion", "periodo_gestion", "tipo", "tipo_numeracion", "formato")
VALUES (1, 1, E'2013-02-24 00:00:00', E'2013-02-24 08:22:48.436', E'activo', 6, E'MOVIN', E'Movimiento tipo Ingreso al Almacen', E'periodo', E'', E'depto', E'depto-I-periodo-correlativo/gestion');

INSERT INTO param.tdocumento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_subsistema", "codigo", "descripcion", "periodo_gestion", "tipo", "tipo_numeracion", "formato")
VALUES (1, 1, E'2013-02-24 00:00:00', E'2013-02-24 08:23:00.205', E'activo', 6, E'MOVSAL', E'Moviento tipo Salida de Almacen', E'periodo', E'', E'depto', E'depto-S-periodo-correlativo/gestion');


/***********************************F-DAT-AAO-ALM-26-25/02/2013*****************************************/

/***********************************I-DAT-AAO-ALM-39-06/03/2013*****************************************/


INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2013-02-23 18:49:21.853', E'2013-02-23 18:49:21.853', E'activo', E'INVINI', E'Inventario Inicial', E'ingreso');
/***********************************F-DAT-AAO-ALM-39-06/03/2013*****************************************/


/***********************************I-DAT-AAO-ALM-42-08/03/2013*****************************************/

   

----------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select pxp.f_insert_tgui ('Personal del Almacén', 'Personal del Almacén', 'ALCRAL.1', 'no', 0, 'sis_almacenes/vista/almacenUsuario/AlmacenUsuario.php', 4, '', 'AlmacenUsuario', 'ALM');
select pxp.f_insert_tgui ('Stock Minimo de almacenes', 'Stock Minimo de almacenes', 'ALCRAL.2', 'no', 0, 'sis_almacenes/vista/almacenStock/AlmacenStock.php', 4, '', 'AlmacenStock', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ALCRAL.2.1', 'no', 0, 'sis_almacenes/vista/item/Item.php', 5, '', 'item', 'ALM');
select pxp.f_insert_tgui ('Items de Reemplazo', 'Items de Reemplazo', 'ALCRAL.2.1.1', 'no', 0, 'sis_almacenes/vista/itemReemplazo/ItemReemplazo.php', 6, '', 'ItemReemplazo', 'ALM');
select pxp.f_insert_tgui ('Archivos del Item', 'Archivos del Item', 'ALCRAL.2.1.2', 'no', 0, 'sis_almacenes/vista/itemArchivo/ItemArchivo.php', 6, '', 'ItemArchivo', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ALCRAL.2.1.1.1', 'no', 0, 'sis_almacenes/vista/item/Item.php', 7, '', 'item', 'ALM');
select pxp.f_insert_tgui ('Subir Archivo', 'Subir Archivo', 'ALCRAL.2.1.2.1', 'no', 0, 'sis_almacenes/vista/itemArchivo/SubirArchivo.php', 7, '', 'SubirArchivo', 'ALM');
select pxp.f_insert_tgui ('Items de Reemplazo', 'Items de Reemplazo', 'ALREMA.1', 'no', 0, 'sis_almacenes/vista/itemReemplazo/ItemReemplazo.php', 4, '', 'ItemReemplazo', 'ALM');
select pxp.f_insert_tgui ('Archivos del Item', 'Archivos del Item', 'ALREMA.2', 'no', 0, 'sis_almacenes/vista/itemArchivo/ItemArchivo.php', 4, '', 'ItemArchivo', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ALREMA.1.1', 'no', 0, 'sis_almacenes/vista/item/Item.php', 5, '', 'item', 'ALM');
select pxp.f_insert_tgui ('Subir Archivo', 'Subir Archivo', 'ALREMA.2.1', 'no', 0, 'sis_almacenes/vista/itemArchivo/SubirArchivo.php', 5, '', 'SubirArchivo', 'ALM');
select pxp.f_insert_tgui ('Materiales', 'Materiales', 'ALCLMA.1', 'no', 0, 'sis_almacenes/vista/item/Item.php', 4, '', 'Item', 'ALM');
select pxp.f_insert_tgui ('Items de Reemplazo', 'Items de Reemplazo', 'ALCLMA.1.1', 'no', 0, 'sis_almacenes/vista/itemReemplazo/ItemReemplazo.php', 5, '', 'ItemReemplazo', 'ALM');
select pxp.f_insert_tgui ('Archivos del Item', 'Archivos del Item', 'ALCLMA.1.2', 'no', 0, 'sis_almacenes/vista/itemArchivo/ItemArchivo.php', 5, '', 'ItemArchivo', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ALCLMA.1.1.1', 'no', 0, 'sis_almacenes/vista/item/Item.php', 6, '', 'item', 'ALM');
select pxp.f_insert_tgui ('Subir Archivo', 'Subir Archivo', 'ALCLMA.1.2.1', 'no', 0, 'sis_almacenes/vista/itemArchivo/SubirArchivo.php', 6, '', 'SubirArchivo', 'ALM');
select pxp.f_insert_tgui ('Detalle de Movimiento', 'Detalle de Movimiento', 'MOV.1', 'no', 0, 'sis_almacenes/vista/movimientoDetalle/MovimientoDetalle.php', 4, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Alarmas', 'Alarmas', 'MOV.2', 'no', 0, 'sis_parametros/vista/alarma/AlarmaFuncionario.php', 4, '', 'AlarmaFuncionario', 'ALM');
select pxp.f_insert_tgui ('Valoracion del Detalle', 'Valoracion del Detalle', 'MOV.1.1', 'no', 0, 'sis_almacenes/vista/movimientoDetValorado/MovimientoDetValorado.php', 5, '', '20%', 'ALM');

----------------------------------
--COPY LINES TO dependencies.sql FILE 
---------------------------------

select pxp.f_insert_testructura_gui ('ALCRAL.1', 'ALCRAL');
select pxp.f_insert_testructura_gui ('ALCRAL.2', 'ALCRAL');
select pxp.f_insert_testructura_gui ('ALCRAL.2.1', 'ALCRAL.2');
select pxp.f_insert_testructura_gui ('ALCRAL.2.1.1', 'ALCRAL.2.1');
select pxp.f_insert_testructura_gui ('ALCRAL.2.1.2', 'ALCRAL.2.1');
select pxp.f_insert_testructura_gui ('ALCRAL.2.1.1.1', 'ALCRAL.2.1.1');
select pxp.f_insert_testructura_gui ('ALCRAL.2.1.2.1', 'ALCRAL.2.1.2');
select pxp.f_insert_testructura_gui ('ALREMA.1', 'ALREMA');
select pxp.f_insert_testructura_gui ('ALREMA.2', 'ALREMA');
select pxp.f_insert_testructura_gui ('ALREMA.1.1', 'ALREMA.1');
select pxp.f_insert_testructura_gui ('ALREMA.2.1', 'ALREMA.2');
select pxp.f_insert_testructura_gui ('ALCLMA.1', 'ALCLMA');
select pxp.f_insert_testructura_gui ('ALCLMA.1.1', 'ALCLMA.1');
select pxp.f_insert_testructura_gui ('ALCLMA.1.2', 'ALCLMA.1');
select pxp.f_insert_testructura_gui ('ALCLMA.1.1.1', 'ALCLMA.1.1');
select pxp.f_insert_testructura_gui ('ALCLMA.1.2.1', 'ALCLMA.1.2');
select pxp.f_insert_testructura_gui ('MOV.1', 'MOV');
select pxp.f_insert_testructura_gui ('MOV.2', 'MOV');
select pxp.f_insert_testructura_gui ('MOV.1.1', 'MOV.1');





/***********************************F-DAT-AAO-ALM-42-08/03/2013*****************************************/

/***********************************I-DAT-AAO-ALM-42-11/03/2013*****************************************/



---------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------

select pxp.f_insert_tgui ('Unidad Medida', 'Unidad Medida', 'UMED', 'si', 3, 'sis_parametros/vista/item/Item.php', 5, '', 'UnidadMedida', 'ALM');
select pxp.f_insert_tgui ('Catalogo', 'Catalogo', 'CATLOG', 'si', 1, 'sis_parametros/vista/catalogo/Catalogo.php', 4, '', 'Catalogo', 'ALM');

---------------------------------
--COPY LINES TO dependencies.sql FILE 
---------------------------------

select pxp.f_insert_testructura_gui ('UMED', 'ALCLMA.1');
select pxp.f_insert_testructura_gui ('CATLOG', 'MOVTIP');




/***********************************F-DAT-AAO-ALM-42-11/03/2013*****************************************/

/***********************************I-DAT-AAO-ALM-60-14/03/2013*****************************************/


update alm.tmovimiento_tipo set
	read_only = TRUE;

update alm.tmetodo_val set
	read_only = TRUE;
	

/***********************************F-DAT-AAO-ALM-60-14/03/2013*****************************************/

/***********************************I-DAT-AAO-ALM-45-15/03/2013*****************************************/

update segu.tsubsistema set
	nombre_carpeta = 'almacenes'
where codigo = 'ALM';
/***********************************F-DAT-AAO-ALM-45-15/03/2013*****************************************/

                                 

/***********************************I-DAT-AAO-ALM-72-23/04/2013*****************************************/

select pxp.f_insert_tgui ('Items', 'Items', 'ALCRAL.2.2', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ALREMA.1.2', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ALCLMA.1.1.2', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 6, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'MOV.1.2', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Detalle Inventario', 'Detalle Inventario', 'INVMAIN.1', 'no', 0, 'sis_almacenes/vista/inventario_det/InventarioDet.php', 6, '', 'InventarioDet', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'INVMAIN.1.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 7, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ALCRAL.2.3', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ALREMA.1.3', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ALCLMA.1.1.3', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 6, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'MOV.1.3', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Detalle Inventario', 'Detalle Inventario', 'INVMAIN.2', 'no', 0, 'sis_almacenes/vista/inventario_det/InventarioDet.php', 6, '', 'InventarioDet', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'INVMAIN.2.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 7, '', 'BuscarItem', 'ALM');


/***********************************F-DAT-AAO-ALM-72-23/04/2013*****************************************/



/***********************************I-DAT-AAO-ALM-72-25/04/2013*****************************************/



select pxp.f_insert_tgui ('Inventario', 'Inventario', 'INVMAIN', 'si', 1, 'sis_almacenes/vista/inventario/InventarioBase.php', 5, '', 'InventarioBase', 'ALM');
select pxp.f_insert_testructura_gui ('INVMAIN', 'ALMAIN');
select pxp.f_insert_tgui ('Orden Inventario', 'Orden Inventario', 'ORDINV', 'si', 1, 'sis_almacenes/vista/inventario/OrdenInventario.php', 5, '', 'OrdenInventario', 'ALM');
select pxp.f_insert_testructura_gui ('ORDINV', 'ALMAIN');
select pxp.f_insert_tgui ('Ejecucion Inventario', 'Ejecucion Inventario', 'EJEINV', 'si', 1, 'sis_almacenes/vista/inventario/EjecucionInventario.php', 5, '', 'EjecucionInventario', 'ALM');
select pxp.f_insert_testructura_gui ('EJEINV', 'ALMAIN');
select pxp.f_insert_tgui ('Periodo', 'Periodo', 'PERI', 'si', 2, 'sis_almacenes/vista/periodo_almacenes/PeriodoAlmacenes.php', 2, '', 'PeriodoAlmacenes', 'ALM');
select pxp.f_insert_testructura_gui ('PERI', 'ALDAGE');



/***********************************F-DAT-AAO-ALM-72-25/04/2013*****************************************/

/***********************************I-DAT-AAO-ALM-76-25/04/2013*****************************************/



select pxp.f_insert_tgui ('Detalle Inventario', 'Detalle Inventario', 'ORDINV.1', 'no', 0, 'sis_almacenes/vista/inventario_det/InventarioDet.php', 6, '', 'InventarioDet', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ORDINV.1.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 7, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Detalle Inventario', 'Detalle Inventario', 'EJEINV.1', 'no', 0, 'sis_almacenes/vista/inventario_det/InventarioDet.php', 6, '', 'InventarioDet', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'EJEINV.1.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 7, '', 'BuscarItem', 'ALM');


/***********************************F-DAT-AAO-ALM-76-25/04/2013*****************************************/

/***********************************I-DAT-AAO-ALM-78-26/04/2013*****************************************/



update param.tdocumento set
  formato = 'depto-I-correlativo-periodo/gestion'
where codigo = 'MOVIN';

update param.tdocumento set
  formato = 'depto-S-correlativo-periodo/gestion'
where codigo = 'MOVSAL';



/***********************************F-DAT-AAO-ALM-78-26/04/2013*****************************************/

/***********************************I-DAT-AAO-ALM-56-03/05/2013*****************************************/



select pxp.f_insert_tgui ('Reportes', 'Reportes', 'REPOR', 'si', 3, '', 2, '', '', 'ALM');
select pxp.f_insert_tgui ('Reporte de Existencias', 'Reporte de Existencias', 'REPEXIST', 'si', 1, 'sis_almacenes/vista/vista_reportes/GenerarReporteExistencias.php', 3, '', 'GenerarReporteExistencias', 'ALM');
select pxp.f_insert_tgui ('Unidades de Medida', 'Unidades de Medida', 'ALREMA.3', 'no', 0, 'sis_parametros/vista/unidad_medida/UnidadMedida.php', 4, '', 'UnidadMedida', 'ALM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'ALREMA.3.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 5, '', 'Catalogo', 'ALM');
select pxp.f_insert_tgui ('Unidades de Medida', 'Unidades de Medida', 'ALCLMA.1.3', 'no', 0, 'sis_parametros/vista/unidad_medida/UnidadMedida.php', 5, '', 'UnidadMedida', 'ALM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'ALCLMA.1.3.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 6, '', 'Catalogo', 'ALM');

select pxp.f_insert_tgui ('Kardex x Item', 'Reporte de Kardex por Item', 'KARITE', 'si', 1, 'sis_almacenes/vista/vista_reportes/KardexItem.php', 3, '', 'KardexItem', 'ALM');
select pxp.f_insert_tgui ('Items Entregados/Ingresados', 'Items Entregados/Ingresados', 'ALREPIEI', 'si', 1, 'sis_almacenes/vista/vista_reportes/ItemEntRec.php', 3, '', 'ItemEntRec', 'ALM');

select pxp.f_insert_testructura_gui ('REPOR', 'ALM');
select pxp.f_insert_testructura_gui ('REPEXIST', 'REPOR');
select pxp.f_insert_testructura_gui ('KARITE', 'REPOR');
select pxp.f_insert_testructura_gui ('ALREPIEI', 'REPOR');

/***********************************F-DAT-AAO-ALM-56-03/05/2013*****************************************/

/***********************************I-DAT-AAO-ALM-52-06/05/2013*****************************************/


INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "fecha_reg", "estado_reg", "codigo", "nombre", "tipo", "read_only")
VALUES (1, E'2013-02-19 19:01:02.292', E'activo', E'INAJUST', E'Ingreso por Ajuste de Inventario', E'ingreso', TRUE);

INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "fecha_reg", "estado_reg", "codigo", "nombre", "tipo", "read_only")
VALUES (1, E'2013-02-19 19:01:02.292', E'activo', E'SALAJUST', E'Salida por Ajuste de Inventario', E'salida', TRUE);



/***********************************F-DAT-AAO-ALM-52-06/05/2013*****************************************/

/***********************************I-DAT-GSS-ALM-79-08/07/2013*****************************************/

select pxp.f_insert_tgui ('Periodo', 'Periodo', 'PERI', 'si', 2, 'sis_almacenes/vista/periodo_subsistema/PeriodoAlm.php', 2, '', 'PeriodoAlm', 'ALM');
select pxp.f_insert_tgui ('Movimientos', 'Movimientos', 'MOV', 'si', 1, 'sis_almacenes/vista/movimiento/MovimientoReq.php', 3, '', 'MovimientoReq', 'ALM');

---------------------------------
--   (WF)  PROCESO MACRO, TIPOS DE PROCESO
-----------------------------------------
---------------------------------
--COPY LINES TO data.sql FILE  
---------------------------------
select wf.f_insert_tproceso_macro ('ALM-MOV', 'Movimiento', 'si', 'activo', 'Sistema de Almacenes');
select wf.f_insert_ttipo_proceso ('', 'Movimiento Almacenes', 'MOV', 'alm.tmovimiento', 'id_movimiento', 'activo', 'si', 'ALM-MOV');
select wf.f_insert_ttipo_estado ('borrador', 'Borrador', 'si', 'no', 'no', 'ninguno', '', 'ninguno', '', '', 'activo', 'MOV', '');
select wf.f_insert_ttipo_estado ('pendiente', 'Pendiente', 'no', 'no', 'no', 'ninguno', '', 'ninguno', '', '', 'activo', 'MOV', '');
select wf.f_insert_ttipo_estado ('finalizado', 'Finalizado', 'no', 'no', 'si', 'ninguno', '', 'ninguno', '', '', 'activo', 'MOV', '');
select wf.f_insert_ttipo_estado ('vbrpm', 'Visto Bueno Responsable Movimiento', 'no', 'no', 'no', 'listado', '', 'ninguno', '', '', 'activo', 'MOV', '');
select wf.f_insert_ttipo_estado ('vbarea', 'Visto Bueno Area', 'no', 'no', 'no', 'listado', '', 'ninguno', '', '', 'activo', 'MOV', '');
select wf.f_insert_testructura_estado ('borrador', 'MOV', 'pendiente', 'MOV', '1', '', 'activo');
select wf.f_insert_testructura_estado ('pendiente', 'MOV', 'vbrpm', 'MOV', '1', '', 'activo');
select wf.f_insert_testructura_estado ('vbrpm', 'MOV', 'vbarea', 'MOV', '1', '', 'activo');
select wf.f_insert_testructura_estado ('vbarea', 'MOV', 'finalizado', 'MOV', '1', '', 'activo');

-- Movimiento_tipo
INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2013-02-19 19:13:12.927', E'2013-02-19 19:13:12.927', E'activo', E'INCOMP', E'Ingreso por Compra', E'ingreso');

INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2013-02-19 19:13:26.057', E'2013-02-19 19:13:26.057', E'activo', E'SALVENT', E'Salida por Venta', E'salida');

update alm.tmovimiento_tipo
set id_proceso_macro = (select id_proceso_macro 
						from wf.tproceso_macro
						where codigo = 'ALM-MOV');					

  
/***********************************F-DAT-GSS-ALM-79-08/07/2013****************************************/

/***********************************I-DAT-GSS-ALM-79-10/07/2013****************************************/

select pxp.f_insert_tgui ('MovimientoAlm', 'movimiento almacenero', 'MOVALM', 'si', 1, 'sis_almacenes/vista/movimiento/MovimientoAlm.php', 3, '', 'MovimientoAlm', 'ALM');
select pxp.f_insert_testructura_gui ('MOVALM', 'ALMOVI');



/***********************************F-DAT-GSS-ALM-79-10/07/2013****************************************/

/***********************************I-DAT-GSS-ALM-79-15/07/2013****************************************/




select pxp.f_insert_tgui ('Ingresos', 'Ingresos', 'ALINGR', 'si', 4, 'sis_almacenes/vista/movimiento/Ingreso.php
', 3, '', 'Ingreso', 'ALM');
select pxp.f_insert_tgui ('Salidas', 'Salidas', 'ALSAGR', 'si', 5, 'sis_almacenes/vista/movimiento/Salida.php
', 3, '', 'Salida', 'ALM');
select pxp.f_insert_tgui ('Transferencias', 'Transferencias', 'ALTRGR', 'si', 6, 'sis_almacenes/vista/movimiento/Transferencia.php', 3, '', 'Transferencia', 'ALM');
select pxp.f_insert_tgui ('MovimientoAlm', 'movimiento almacenero', 'MOVALM', 'si', 3, 'sis_almacenes/vista/movimiento/MovimientoAlm.php', 3, '', 'MovimientoAlm', 'ALM');
select pxp.f_insert_tgui ('MovimientoVb', 'movimiento vb', 'MOVVB', 'si', 2, 'sis_almacenes/vista/movimiento/MovimientoVb.php', 3, '', 'MovimientoVb', 'ALM');
select pxp.f_insert_testructura_gui ('MOVVB', 'ALMOVI');



/***********************************F-DAT-GSS-ALM-79-15/07/2013****************************************/

/***********************************I-DAT-RCM-ALM-85-18/07/2013****************************************/


 
select pxp.f_add_catalog('ALM','titem__opciones','Todos los Items');
select pxp.f_add_catalog('ALM','titem__opciones','Seleccionar Items');
select pxp.f_add_catalog('ALM','titem__opciones','Por Clasificacion');



/***********************************F-DAT-RCM-ALM-85-18/07/2013****************************************/

/***********************************I-DAT-GSS-ALM-82-22/07/2013****************************************/

select pxp.f_insert_tgui ('PreIngreso', 'preingreso', 'PREING', 'si', 1, 'sis_almacenes/vista/preingreso/Preingreso.php', 3, '', 'Preingreso', 'ALM');
select pxp.f_insert_testructura_gui ('PREING', 'ALMOVI');

select pxp.f_insert_tgui ('Clasificacion', 'Clasificacion', 'INVMAIN.1.2', 'no', 0, 'sis_almacenes/vista/clasificacion/BuscarClasificacion.php', 7, '', 'BuscarClasificacion', 'ALM');
select pxp.f_insert_tgui ('Clasificacion', 'Clasificacion', 'ORDINV.1.2', 'no', 0, 'sis_almacenes/vista/clasificacion/BuscarClasificacion.php', 7, '', 'BuscarClasificacion', 'ALM');
select pxp.f_insert_tgui ('Clasificacion', 'Clasificacion', 'EJEINV.1.2', 'no', 0, 'sis_almacenes/vista/clasificacion/BuscarClasificacion.php', 7, '', 'BuscarClasificacion', 'ALM');
select pxp.f_insert_tgui ('Detalle', 'Detalle', 'MOVALM.1', 'no', 0, 'sis_almacenes/vista/movimientoDetalle/MovimientoDetalleAlm.php', 4, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Detalle de Movimiento', 'Detalle de Movimiento', 'MOVALM.2', 'no', 0, 'sis_almacenes/vista/movimientoDetalle/MovimientoDetalle.php', 4, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Alarmas', 'Alarmas', 'MOVALM.3', 'no', 0, 'sis_parametros/vista/alarma/AlarmaFuncionario.php', 4, '', 'AlarmaFuncionario', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'MOVALM.1.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Valoracion del Detalle', 'Valoracion del Detalle', 'MOVALM.1.2', 'no', 0, 'sis_almacenes/vista/movimientoDetValorado/MovimientoDetValorado.php', 5, '', '20%', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'MOVALM.2.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Valoracion del Detalle', 'Valoracion del Detalle', 'MOVALM.2.2', 'no', 0, 'sis_almacenes/vista/movimientoDetValorado/MovimientoDetValorado.php', 5, '', '20%', 'ALM');
select pxp.f_insert_tgui ('Detalle', 'Detalle', 'MOVVB.1', 'no', 0, 'sis_almacenes/vista/movimientoDetalle/MovimientoDetalleVb.php', 4, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Detalle de Movimiento', 'Detalle de Movimiento', 'MOVVB.2', 'no', 0, 'sis_almacenes/vista/movimientoDetalle/MovimientoDetalle.php', 4, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Alarmas', 'Alarmas', 'MOVVB.3', 'no', 0, 'sis_parametros/vista/alarma/AlarmaFuncionario.php', 4, '', 'AlarmaFuncionario', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'MOVVB.1.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Valoracion del Detalle', 'Valoracion del Detalle', 'MOVVB.1.2', 'no', 0, 'sis_almacenes/vista/movimientoDetValorado/MovimientoDetValorado.php', 5, '', '20%', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'MOVVB.2.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Valoracion del Detalle', 'Valoracion del Detalle', 'MOVVB.2.2', 'no', 0, 'sis_almacenes/vista/movimientoDetValorado/MovimientoDetValorado.php', 5, '', '20%', 'ALM');
select pxp.f_insert_tgui ('Detalle', 'Detalle', 'PREING.1', 'no', 0, 'sis_almacenes/vista/preingreso_det/PreingresoDet.php', 4, '', 'PreingresoDet', 'ALM');

select pxp.f_insert_trol ('solicita items de almacenes', 'Solicitante de Almacenes', 'ALM');
select pxp.f_insert_trol ('visto bueno solicitud de almacen', 'Visto Bueno Solicitud Almacen', 'ALM');
select pxp.f_insert_trol ('almacenero se ocupa de registrar los items que ingresan', 'Almacenero', 'ALM');





/***********************************F-DAT-GSS-ALM-82-22/07/2013****************************************/

/***********************************I-DAT-GSS-ALM-89-26/07/2013****************************************/

select wf.f_insert_tproceso_macro ('MV-IN-TIP1', 'Movimiento Ingresos Tipo 1', 'si', 'activo', 'Sistema de Almacenes');
select wf.f_insert_ttipo_proceso ('', 'Ingreso Tipo 1', 'INGT1', 'alm.tmovimiento', 'id_movimiento', 'activo', 'si', 'MV-IN-TIP1');
select wf.f_insert_ttipo_estado ('borrador', 'Borrador', 'si', 'no', 'no', 'anterior', '', 'ninguno', '', '', 'activo', 'INGT1', '');
select wf.f_insert_ttipo_estado ('vbarea', 'Visto Bueno Area', 'no', 'no', 'no', 'anterior', '', 'ninguno', '', '', 'activo', 'INGT1', '');
select wf.f_insert_ttipo_estado ('finalizado', 'Finalizado', 'no', 'no', 'si', 'ninguno', '', 'ninguno', '', '', 'activo', 'INGT1', '');
select wf.f_insert_testructura_estado ('borrador', 'INGT1', 'vbarea', 'INGT1', '1', '', 'activo');
select wf.f_insert_testructura_estado ('vbarea', 'INGT1', 'finalizado', 'INGT1', '1', '', 'activo');



/***********************************F-DAT-GSS-ALM-89-26/07/2013****************************************/

/***********************************I-DAT-RCM-ALM-92-01/08/2013****************************************/


 
select pxp.f_insert_tgui ('Buscador de Materiales', 'Buscador de Materiales', 'ALBUSQ', 'si', 2, 'sis_almacenes/vista/item/BuscarItem.php', 3, '', 'BuscarItem', 'ALM');
select pxp.f_insert_testructura_gui ('ALBUSQ', 'ALMOVI');



/***********************************F-DAT-RCM-ALM-92-01/08/2013****************************************/

/***********************************I-DAT-RCM-ALM-93-12/08/2013****************************************/


select pxp.f_add_catalog('ALM','tmovimiento_tipo_tipo1','ingresos y salidas');
select pxp.f_add_catalog('ALM','tmovimiento_tipo_tipo1','ingreso');
select pxp.f_add_catalog('ALM','tmovimiento_tipo_tipo1','salida');


/***********************************F-DAT-RCM-ALM-93-12/08/2013****************************************/

/***********************************I-DAT-RCM-ALM-87-22/08/2013****************************************/


INSERT INTO pxp.variable_global ("variable", "valor", "descripcion")
VALUES (E'alm_filtrar_item_tipomov', E'si', E'Bandera para verificar si se debe filtrar los Items por Tipo de movimiento al registrar cualquier movimiento');
INSERT INTO pxp.variable_global ("variable", "valor", "descripcion")
VALUES (E'alm_filtrar_funcionario_tipomov_asistente', E'si', E'Bandera para verificar si al registrar un movimiento, filtre los funcionarios en base al tipo de movimiento y a la asistente que realiza el registro');

/***********************************F-DAT-RCM-ALM-87-22/08/2013****************************************/

/***********************************I-DAT-RCM-ALM-82-01/10/2013****************************************/
select pxp.f_insert_tgui ('Preingreso', 'Preingreso', 'ALPREIN', 'si', 1, 'sis_almacenes/vista/preingreso/PreingresoAlm.php', 3, '', 'PreingresoAlm', 'ALM');
select pxp.f_insert_testructura_gui ('ALPREIN', 'ALMOVI');

select pxp.f_add_catalog('ALM','tpreingreso__tipo','almacen');
select pxp.f_add_catalog('ALM','tpreingreso__tipo','activo_fijo');

/***********************************F-DAT-RCM-ALM-82-01/10/2013****************************************/

/***********************************I-DAT-RCM-ALM-0-17/10/2013****************************************/
INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg","codigo", "nombre", "tipo")
VALUES (1, null, now(), null, E'activo', E'SALGRU', E'Salida Grupal', E'salida');

select pxp.f_insert_tgui ('Salida Múltiple', 'Salida múltiple', 'SALGRU', 'si', 1, 'sis_almacenes/vista/salida_grupo/SalidaGrupo.php', 3, '', 'SalidaGrupo', 'ALM');
select pxp.f_insert_testructura_gui ('SALGRU', 'ALMOVI');

INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg","codigo", "nombre", "tipo")
VALUES (1, null, now(), null, E'activo', E'INADQ', E'Ingreso desde Adquisiciones', E'ingreso');

select pxp.f_insert_tgui ('Comprobante Salidas', 'Comprobante Salidas', 'MOVGRU', 'si', 8, 'sis_almacenes/vista/movimiento_grupo/MovimientoGrupo.php', 3, '', 'MovimientoGrupo', 'ALM');
select pxp.f_insert_testructura_gui ('MOVGRU', 'ALMOVI');
/***********************************F-DAT-RCM-ALM-0-17/10/2013****************************************/

/***********************************I-DAT-RCM-ALM-0-29/11/2013****************************************/
select pxp.f_add_catalog('ALM','tmovimiento__all_tipo_mov','ingreso');
select pxp.f_add_catalog('ALM','tmovimiento__all_tipo_mov','salida');
select pxp.f_add_catalog('ALM','tmovimiento__all_tipo_mov','ingreso_salida');
/***********************************F-DAT-RCM-ALM-0-29/11/2013****************************************/

/***********************************I-DAT-RCM-ALM-0-02/01/2014****************************************/
INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "codigo", "nombre", "tipo","read_only")
VALUES (1, NULL, now(), NULL, E'activo', E'INVFIN', E'Inventario Final', E'salida',true);

INSERT INTO pxp.variable_global ("variable", "valor", "descripcion")
VALUES (E'alm_migrar_af_endesis', E'si', E'Bandera para migrar activos fijos a Endesis');
/***********************************F-DAT-RCM-ALM-0-02/01/2014****************************************/

/***********************************I-DAT-RCM-ALM-0-17/02/2014****************************************/

select pxp.f_insert_tgui ('Salidas', 'Salidas', 'ALSALID', 'si', 5, 'sis_almacenes/vista/movimiento/MovimientoReqSalida.php', 3, '', 'MovimientoReqSalida', 'ALM');
select pxp.f_insert_testructura_gui ('ALSALID', 'ALMOVI');

/***********************************F-DAT-RCM-ALM-0-17/02/2014****************************************/

/***********************************I-DAT-JRR-ALM-0-24/04/2014****************************************/

select pxp.f_insert_tgui ('Upload archivos', 'Upload archivos', 'ALCRAL.3', 'no', 0, 'sis_parametros/vista/tabla_upload/TablaUpload.php', 4, '', '50%', 'ALM');
select pxp.f_insert_tgui ('btnSwitchEstado', 'btnSwitchEstado', 'ALCRAL.4', 'no', 0, 'btnAlmacenUsuario', 4, '', 'inactivo', 'ALM');
select pxp.f_insert_tgui ('Gestión Almacenes', 'Gestión Almacenes', 'ALCRAL.5', 'no', 0, 'sis_almacenes/vista/almacen_gestion/AlmacenGestion.php', 4, '', '70%', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ALCRAL.2.4', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Existencia de Materiales por Almacén', 'Existencia de Materiales por Almacén', 'ALCRAL.2.4.1', 'no', 0, 'sis_almacenes/vista/item/ItemExistenciaAlmacen.php', 6, '', '30%', 'ALM');
select pxp.f_insert_tgui ('Histórico Gestión', 'Histórico Gestión', 'ALCRAL.5.1', 'no', 0, 'sis_almacenes/vista/almacen_gestion_log/AlmacenGestionLog.php', 5, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Movimientos Pendientes', 'Movimientos Pendientes', 'ALCRAL.5.2', 'no', 0, 'sis_almacenes/vista/movimiento/MovimientoReq.php', 5, '', '70%', 'ALM');
select pxp.f_insert_tgui ('Detalle de Movimiento', 'Detalle de Movimiento', 'ALCRAL.5.2.1', 'no', 0, 'sis_almacenes/vista/movimientoDetalle/MovimientoDetalle.php', 6, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Alarmas', 'Alarmas', 'ALCRAL.5.2.2', 'no', 0, 'sis_parametros/vista/alarma/AlarmaFuncionario.php', 6, '', 'AlarmaFuncionario', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ALCRAL.5.2.1.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 7, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Valoracion del Detalle', 'Valoracion del Detalle', 'ALCRAL.5.2.1.2', 'no', 0, 'sis_almacenes/vista/movimientoDetValorado/MovimientoDetValorado.php', 7, '', '20%', 'ALM');
select pxp.f_insert_tgui ('Unidades de Medida', 'Unidades de Medida', 'ALREMA.4', 'no', 0, 'sis_parametros/vista/unidad_medida/UnidadMedida.php', 4, '', 'UnidadMedida', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ALREMA.1.4', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Existencia de Materiales por Almacén', 'Existencia de Materiales por Almacén', 'ALREMA.1.4.1', 'no', 0, 'sis_almacenes/vista/item/ItemExistenciaAlmacen.php', 6, '', '30%', 'ALM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'ALREMA.4.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 5, '', 'Catalogo', 'ALM');
select pxp.f_insert_tgui ('Unidades de Medida', 'Unidades de Medida', 'ALCLMA.1.4', 'no', 0, 'sis_parametros/vista/unidad_medida/UnidadMedida.php', 5, '', 'UnidadMedida', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ALCLMA.1.1.4', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 6, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Existencia de Materiales por Almacén', 'Existencia de Materiales por Almacén', 'ALCLMA.1.1.4.1', 'no', 0, 'sis_almacenes/vista/item/ItemExistenciaAlmacen.php', 7, '', '30%', 'ALM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'ALCLMA.1.4.1', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 6, '', 'Catalogo', 'ALM');
select pxp.f_insert_tgui ('Items/Clasificación', 'Items/Clasificación', 'MOVTIP.1', 'no', 0, 'sis_almacenes/vista/movimiento_tipo_item/MovimientoTipoItem.php', 4, '', '40%', 'ALM');
select pxp.f_insert_tgui ('Cargos permitidos', 'Cargos permitidos', 'MOVTIP.2', 'no', 0, 'sis_almacenes/vista/movimiento_tipo_uo/MovimientoTipoUo.php', 4, '', '40%', 'ALM');
select pxp.f_insert_tgui ('catalogo', 'catalogo', 'MOVTIP.3', 'no', 0, 'CATALOGO', 4, '', 'Catálogo', 'ALM');
select pxp.f_insert_tgui ('Seleccione un catálogo...', 'Seleccione un catálogo...', 'MOVTIP.4', 'no', 0, 'Catalogo', 4, '', '../../sis_parametros/control/Catalogo/listarCatalogoCombo', 'ALM');
select pxp.f_insert_tgui ('Clasificación', 'Clasificación', 'MOVTIP.1.1', 'no', 0, 'sis_almacenes/vista/clasificacion/BuscarClasificacion.php', 5, '', '60%', 'ALM');
select pxp.f_insert_tgui ('Organigrama', 'Organigrama', 'MOVTIP.2.1', 'no', 0, 'sis_organigrama/vista/estructura_uo/EstructuraUoCheck.php', 5, '', '60%', 'ALM');
select pxp.f_insert_tgui ('Cargos por Unidad', 'Cargos por Unidad', 'MOVTIP.2.1.1', 'no', 0, 'sis_organigrama/vista/cargo/Cargo.php', 6, '', 'Cargo', 'ALM');
select pxp.f_insert_tgui ('Asignacion de Funcionarios a Unidad', 'Asignacion de Funcionarios a Unidad', 'MOVTIP.2.1.2', 'no', 0, 'sis_organigrama/vista/uo_funcionario/UOFuncionario.php', 6, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Asignación de Presupuesto por Cargo', 'Asignación de Presupuesto por Cargo', 'MOVTIP.2.1.1.1', 'no', 0, 'sis_organigrama/vista/cargo_presupuesto/CargoPresupuesto.php', 7, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Centros de Costo Asignados por Cargo', 'Centros de Costo Asignados por Cargo', 'MOVTIP.2.1.1.2', 'no', 0, 'sis_organigrama/vista/cargo_centro_costo/CargoCentroCosto.php', 7, '', 'CargoCentroCosto', 'ALM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'MOVTIP.2.1.2.1', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 7, '', 'funcionario', 'ALM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'MOVTIP.2.1.2.1.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 8, '', 'FuncionarioCuentaBancaria', 'ALM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'MOVTIP.2.1.2.1.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 8, '', 'persona', 'ALM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'MOVTIP.2.1.2.1.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 9, '', 'Institucion', 'ALM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'MOVTIP.2.1.2.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 10, '', 'persona', 'ALM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'MOVTIP.2.1.2.1.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 11, '', 'subirFotoPersona', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'MOV.1.4', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Existencia de Materiales por Almacén', 'Existencia de Materiales por Almacén', 'MOV.1.4.1', 'no', 0, 'sis_almacenes/vista/item/ItemExistenciaAlmacen.php', 6, '', '30%', 'ALM');
select pxp.f_insert_tgui ('Detalle Inventario', 'Detalle Inventario', 'INVMAIN.3', 'no', 0, 'sis_almacenes/vista/inventario_det/InventarioDet.php', 6, '', 'InventarioDet', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'INVMAIN.3.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 7, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Clasificacion', 'Clasificacion', 'INVMAIN.3.2', 'no', 0, 'sis_almacenes/vista/clasificacion/BuscarClasificacion.php', 7, '', 'BuscarClasificacion', 'ALM');
select pxp.f_insert_tgui ('Existencia de Materiales por Almacén', 'Existencia de Materiales por Almacén', 'INVMAIN.3.1.1', 'no', 0, 'sis_almacenes/vista/item/ItemExistenciaAlmacen.php', 8, '', '30%', 'ALM');
select pxp.f_insert_tgui ('Detalle Inventario', 'Detalle Inventario', 'ORDINV.2', 'no', 0, 'sis_almacenes/vista/inventario_det/InventarioDet.php', 6, '', 'InventarioDet', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ORDINV.2.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 7, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Clasificacion', 'Clasificacion', 'ORDINV.2.2', 'no', 0, 'sis_almacenes/vista/clasificacion/BuscarClasificacion.php', 7, '', 'BuscarClasificacion', 'ALM');
select pxp.f_insert_tgui ('Existencia de Materiales por Almacén', 'Existencia de Materiales por Almacén', 'ORDINV.2.1.1', 'no', 0, 'sis_almacenes/vista/item/ItemExistenciaAlmacen.php', 8, '', '30%', 'ALM');
select pxp.f_insert_tgui ('Detalle Inventario', 'Detalle Inventario', 'EJEINV.2', 'no', 0, 'sis_almacenes/vista/inventario_det/InventarioDet.php', 6, '', 'InventarioDet', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'EJEINV.2.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 7, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Clasificacion', 'Clasificacion', 'EJEINV.2.2', 'no', 0, 'sis_almacenes/vista/clasificacion/BuscarClasificacion.php', 7, '', 'BuscarClasificacion', 'ALM');
select pxp.f_insert_tgui ('Existencia de Materiales por Almacén', 'Existencia de Materiales por Almacén', 'EJEINV.2.1.1', 'no', 0, 'sis_almacenes/vista/item/ItemExistenciaAlmacen.php', 8, '', '30%', 'ALM');
select pxp.f_insert_tgui ('Clasificación', 'Clasificación', 'REPEXIST.1', 'no', 0, 'sis_almacenes/vista/clasificacion/BuscarClasificacion.php', 4, '', '60%', 'ALM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'REPEXIST.2', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 4, '', 'Catalogo', 'ALM');
select pxp.f_insert_tgui ('Existencia de Materiales por Almacén', 'Existencia de Materiales por Almacén', 'MOVALM.1.1.1', 'no', 0, 'sis_almacenes/vista/item/ItemExistenciaAlmacen.php', 6, '', '30%', 'ALM');
select pxp.f_insert_tgui ('Existencia de Materiales por Almacén', 'Existencia de Materiales por Almacén', 'MOVVB.1.1.1', 'no', 0, 'sis_almacenes/vista/item/ItemExistenciaAlmacen.php', 6, '', '30%', 'ALM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'PREING.2', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 4, '', 'Catalogo', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'PREING.1.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'PREING.1.2', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 5, '', 'Catalogo', 'ALM');
select pxp.f_insert_tgui ('Existencia de Materiales por Almacén', 'Existencia de Materiales por Almacén', 'PREING.1.1.1', 'no', 0, 'sis_almacenes/vista/item/ItemExistenciaAlmacen.php', 6, '', '30%', 'ALM');
select pxp.f_insert_tgui ('Existencia de Materiales por Almacén', 'Existencia de Materiales por Almacén', 'ALBUSQ.1', 'no', 0, 'sis_almacenes/vista/item/ItemExistenciaAlmacen.php', 4, '', '30%', 'ALM');
select pxp.f_insert_tgui ('Detalle Preingreso', 'Detalle Preingreso', 'ALPREIN.1', 'no', 0, 'sis_almacenes/vista/preingreso_det/PreingresoDet.php', 4, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'ALPREIN.2', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 4, '', 'Catalogo', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ALPREIN.1.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'ALPREIN.1.2', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 5, '', 'Catalogo', 'ALM');
select pxp.f_insert_tgui ('Existencia de Materiales por Almacén', 'Existencia de Materiales por Almacén', 'ALPREIN.1.1.1', 'no', 0, 'sis_almacenes/vista/item/ItemExistenciaAlmacen.php', 6, '', '30%', 'ALM');
select pxp.f_insert_tgui ('Detalle de Items', 'Detalle de Items', 'SALGRU.1', 'no', 0, 'sis_almacenes/vista/salida_grupo_item/SalidaGrupoItem.php', 4, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'SALGRU.1.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Funcionario', 'Funcionario', 'SALGRU.1.2', 'no', 0, 'sis_almacenes/vista/salida_grupo_fun/SalidaGrupoFun.php', 5, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Existencia de Materiales por Almacén', 'Existencia de Materiales por Almacén', 'SALGRU.1.1.1', 'no', 0, 'sis_almacenes/vista/item/ItemExistenciaAlmacen.php', 6, '', '30%', 'ALM');
select pxp.f_insert_tgui ('Detalle de Items', 'Detalle de Items', 'MOVGRU.1', 'no', 0, 'sis_almacenes/vista/movimiento_grupo_det/MovimientoGrupoDet.php', 4, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'ALCRAL.5.2.3', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 6, '', 'funcionario', 'ALM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'ALCRAL.5.2.3.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 7, '', 'FuncionarioCuentaBancaria', 'ALM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ALCRAL.5.2.3.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 7, '', 'persona', 'ALM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'ALCRAL.5.2.3.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 8, '', 'Institucion', 'ALM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ALCRAL.5.2.3.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 9, '', 'persona', 'ALM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'ALCRAL.5.2.3.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 10, '', 'subirFotoPersona', 'ALM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'MOV.3', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 4, '', 'funcionario', 'ALM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'MOV.3.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 5, '', 'FuncionarioCuentaBancaria', 'ALM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'MOV.3.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 5, '', 'persona', 'ALM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'MOV.3.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 6, '', 'Institucion', 'ALM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'MOV.3.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 7, '', 'persona', 'ALM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'MOV.3.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 8, '', 'subirFotoPersona', 'ALM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'MOVALM.4', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 4, '', 'funcionario', 'ALM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'MOVALM.4.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 5, '', 'FuncionarioCuentaBancaria', 'ALM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'MOVALM.4.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 5, '', 'persona', 'ALM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'MOVALM.4.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 6, '', 'Institucion', 'ALM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'MOVALM.4.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 7, '', 'persona', 'ALM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'MOVALM.4.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 8, '', 'subirFotoPersona', 'ALM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'MOVVB.4', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 4, '', 'funcionario', 'ALM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'MOVVB.4.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 5, '', 'FuncionarioCuentaBancaria', 'ALM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'MOVVB.4.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 5, '', 'persona', 'ALM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'MOVVB.4.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 6, '', 'Institucion', 'ALM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'MOVVB.4.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 7, '', 'persona', 'ALM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'MOVVB.4.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 8, '', 'subirFotoPersona', 'ALM');
select pxp.f_insert_tgui ('Kardex por Item: ', 'Kardex por Item: ', 'KARITE.1', 'no', 0, 'sis_almacenes/vista/vista_reportes/repKardexItem.php', 4, '', '90%', 'ALM');
select pxp.f_insert_tgui ('Clasificación', 'Clasificación', 'ALREPIEI.1', 'no', 0, 'sis_almacenes/vista/clasificacion/BuscarClasificacion.php', 4, '', '60%', 'ALM');
select pxp.f_insert_tgui ('Organigrama', 'Organigrama', 'ALREPIEI.2', 'no', 0, 'sis_organigrama/vista/estructura_uo/EstructuraUoCheck.php', 4, '', '60%', 'ALM');
select pxp.f_insert_tgui ('Items Entregados/Recibidos', 'Items Entregados/Recibidos', 'ALREPIEI.3', 'no', 0, 'sis_almacenes/vista/vista_reportes/repItemEntRec.php', 4, '', '90%', 'ALM');
select pxp.f_insert_tgui ('Catálogo', 'Catálogo', 'ALREPIEI.4', 'no', 0, 'sis_parametros/vista/catalogo/Catalogo.php', 4, '', 'Catalogo', 'ALM');
select pxp.f_insert_tgui ('Cargos por Unidad', 'Cargos por Unidad', 'ALREPIEI.2.1', 'no', 0, 'sis_organigrama/vista/cargo/Cargo.php', 5, '', 'Cargo', 'ALM');
select pxp.f_insert_tgui ('Asignacion de Funcionarios a Unidad', 'Asignacion de Funcionarios a Unidad', 'ALREPIEI.2.2', 'no', 0, 'sis_organigrama/vista/uo_funcionario/UOFuncionario.php', 5, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Asignación de Presupuesto por Cargo', 'Asignación de Presupuesto por Cargo', 'ALREPIEI.2.1.1', 'no', 0, 'sis_organigrama/vista/cargo_presupuesto/CargoPresupuesto.php', 6, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Centros de Costo Asignados por Cargo', 'Centros de Costo Asignados por Cargo', 'ALREPIEI.2.1.2', 'no', 0, 'sis_organigrama/vista/cargo_centro_costo/CargoCentroCosto.php', 6, '', 'CargoCentroCosto', 'ALM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'ALREPIEI.2.2.1', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 6, '', 'funcionario', 'ALM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'ALREPIEI.2.2.1.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 7, '', 'FuncionarioCuentaBancaria', 'ALM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ALREPIEI.2.2.1.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 7, '', 'persona', 'ALM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'ALREPIEI.2.2.1.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 8, '', 'Institucion', 'ALM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ALREPIEI.2.2.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 9, '', 'persona', 'ALM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'ALREPIEI.2.2.1.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 10, '', 'subirFotoPersona', 'ALM');
select pxp.f_insert_tgui ('Detalle de Movimiento', 'Detalle de Movimiento', 'ALSALID.1', 'no', 0, 'sis_almacenes/vista/movimientoDetalle/MovimientoDetalle.php', 4, '', '50%', 'ALM');
select pxp.f_insert_tgui ('Alarmas', 'Alarmas', 'ALSALID.2', 'no', 0, 'sis_parametros/vista/alarma/AlarmaFuncionario.php', 4, '', 'AlarmaFuncionario', 'ALM');
select pxp.f_insert_tgui ('Funcionarios', 'Funcionarios', 'ALSALID.3', 'no', 0, 'sis_organigrama/vista/funcionario/Funcionario.php', 4, '', 'funcionario', 'ALM');
select pxp.f_insert_tgui ('Items', 'Items', 'ALSALID.1.1', 'no', 0, 'sis_almacenes/vista/item/BuscarItem.php', 5, '', 'BuscarItem', 'ALM');
select pxp.f_insert_tgui ('Valoracion del Detalle', 'Valoracion del Detalle', 'ALSALID.1.2', 'no', 0, 'sis_almacenes/vista/movimientoDetValorado/MovimientoDetValorado.php', 5, '', '20%', 'ALM');
select pxp.f_insert_tgui ('Existencia de Materiales por Almacén', 'Existencia de Materiales por Almacén', 'ALSALID.1.1.1', 'no', 0, 'sis_almacenes/vista/item/ItemExistenciaAlmacen.php', 6, '', '30%', 'ALM');
select pxp.f_insert_tgui ('Cuenta Bancaria del Empleado', 'Cuenta Bancaria del Empleado', 'ALSALID.3.1', 'no', 0, 'sis_organigrama/vista/funcionario_cuenta_bancaria/FuncionarioCuentaBancaria.php', 5, '', 'FuncionarioCuentaBancaria', 'ALM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ALSALID.3.2', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 5, '', 'persona', 'ALM');
select pxp.f_insert_tgui ('Instituciones', 'Instituciones', 'ALSALID.3.1.1', 'no', 0, 'sis_parametros/vista/institucion/Institucion.php', 6, '', 'Institucion', 'ALM');
select pxp.f_insert_tgui ('Personas', 'Personas', 'ALSALID.3.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/Persona.php', 7, '', 'persona', 'ALM');
select pxp.f_insert_tgui ('Subir foto', 'Subir foto', 'ALSALID.3.1.1.1.1', 'no', 0, 'sis_seguridad/vista/persona/subirFotoPersona.php', 8, '', 'subirFotoPersona', 'ALM');

/***********************************F-DAT-JRR-ALM-0-24/04/2014****************************************/




/***********************************I-DAT-RAC-ALM-0-24/06/2014****************************************/
select pxp.f_insert_tgui ('PreIngreso', 'preingreso', 'PREING', 'si', 1, 'sis_almacenes/vista/preingreso/PreingresoAlm.php', 3, '', 'PreingresoAlm', 'ALM');


/***********************************F-DAT-RAC-ALM-0-24/06/2014****************************************/


/***********************************I-DAT-RCM-ALM-0-05/05/2015****************************************/
update alm.tpreingreso_det set
estado = 'orig'
from alm.tpreingreso pre
where alm.tpreingreso_det.id_preingreso = pre.id_preingreso
and pre.estado = 'borrador';
/***********************************F-DAT-RCM-ALM-0-05/05/2015****************************************/

/***********************************I-DAT-GSS-ALM-0-14/12/2016****************************************/

INSERT INTO pxp.variable_global ("variable", "valor", "descripcion")
VALUES (E'alm_habilitar_fecha_tope', E'no', E'bandera para indicar si estara activo o no la fecha tope de solcitudes de salidas de almacen');
INSERT INTO pxp.variable_global ("variable", "valor", "descripcion")
VALUES (E'alm_fecha_tope_solicitudes', E'13-12-2016', E'fecha tope de solicitudes de salida de almacenes');

/***********************************F-DAT-GSS-ALM-0-14/12/2016****************************************/