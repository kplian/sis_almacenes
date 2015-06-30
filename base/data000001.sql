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
select pxp.f_insert_testructura_gui ('ALM', 'SISTEMA');
select pxp.f_insert_testructura_gui ('ALDAGE', 'ALM');
select pxp.f_insert_testructura_gui ('ALMAIN', 'ALM');
select pxp.f_insert_testructura_gui ('ALMOVI', 'ALM');
select pxp.f_insert_testructura_gui ('ALCRAL', 'ALDAGE');
select pxp.f_insert_testructura_gui ('ALREMA', 'ALMAIN');
select pxp.f_insert_testructura_gui ('ALCLMA', 'ALMAIN');




----------------------------------------------
--  DEF DE FUNCIONES
--------------------------------------------------



select pxp.f_insert_tfuncion ('alm.ft_movimiento_det_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_det_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_stock_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_stock_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_saldo_fisico_item', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_saldo_valorado_item', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_correlativo', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_clasificacion_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_clasificacion_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_item_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_num_mov', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_usuario_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_valorado_item', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_item_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_usuario_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_verificar_registro', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_sel', 'Funcion para tabla     ', 'ALM');



---------------------------------
--DEF DE PROCEDIMIETOS
---------------------------------




select pxp.f_insert_tprocedimiento ('SAL_MOV_DET_ELI', 'Eliminacion de registros
', 'si', '', '', 'alm.ft_movimiento_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_DET_MOD', 'Modificacion de registros
', 'si', '', '', 'alm.ft_movimiento_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_DET_INS', 'Insercion de registros
', 'si', '', '', 'alm.ft_movimiento_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_DET_CONT', 'Conteo de registros
', 'si', '', '', 'alm.ft_movimiento_det_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOV_DET_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_movimiento_det_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_CONT', 'Conteo de registros
', 'si', '', '', 'alm.ft_almacen_stock_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_almacen_stock_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_ELI', 'Eliminacion de registros
', 'si', '', '', 'alm.ft_almacen_stock_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_MOD', 'Modificacion de registros
', 'si', '', '', 'alm.ft_almacen_stock_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_INS', 'Insercion de registros
', 'si', '', '', 'alm.ft_almacen_stock_ime');
select pxp.f_insert_tprocedimiento ('ALM_CLA_CONT', 'Conteo de registros
', 'si', '', '', 'alm.ft_clasificacion_sel');
select pxp.f_insert_tprocedimiento ('ALM_CLA_ARB_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_clasificacion_sel');
select pxp.f_insert_tprocedimiento ('ALM_CLA_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_clasificacion_sel');
select pxp.f_insert_tprocedimiento ('SAL_CLA_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'alm.ft_clasificacion_ime');
select pxp.f_insert_tprocedimiento ('SAL_CLA_MOD', '	Modificacion de registros
 	', 'si', '', '', 'alm.ft_clasificacion_ime');
select pxp.f_insert_tprocedimiento ('SAL_CLA_INS', '	Insercion de registros
 	', 'si', '', '', 'alm.ft_clasificacion_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_ELI', 'Eliminacion de registros
', 'si', '', '', 'alm.ft_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_MOD', 'Modificacion de registros
', 'si', '', '', 'alm.ft_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_INS', 'Insercion de registros
', 'si', '', '', 'alm.ft_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALM_ELI', 'Eliminacion de registros
', 'si', '', '', 'alm.ft_almacen_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALM_MOD', 'Modificacion de registros
', 'si', '', '', 'alm.ft_almacen_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALM_INS', 'Insercion de registros
', 'si', '', '', 'alm.ft_almacen_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_ELI', '	Eliminacion de registros
 	', 'si', '', '', 'alm.ft_almacen_usuario_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_MOD', '	Modificacion de registros
 	', 'si', '', '', 'alm.ft_almacen_usuario_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_INS', '	Insercion de registros
 	', 'si', '', '', 'alm.ft_almacen_usuario_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_FIN', 'CODIGO NO DOCUMENTADO', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_ELI', 'Eliminacion de datos
', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_MOD', 'Modificacion de datos
', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_INS', 'Insercion de datos
', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_CONT', 'Conteo de registros
', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOV_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_CONT', 'Conteo de registros
', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEMNOTBASE_CONT', 'Conteo de registros
', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEMNOTBASE_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ARB_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_CONT', '	Conteo de registros
 	', 'si', '', '', 'alm.ft_almacen_usuario_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_SEL', '	Consulta de datos
 	', 'si', '', '', 'alm.ft_almacen_usuario_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALM_CONT', 'Conteo de registros
', 'si', '', '', 'alm.ft_almacen_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALM_SEL', 'Consulta de datos
', 'si', '', '', 'alm.ft_almacen_sel');



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
select pxp.f_insert_tfuncion ('alm.ft_metodo_val_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_det_valorado_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_update_estado_clasificacion_recursivo', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_metodo_val_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_codigo_clasificaciones_recursivo', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_tipo_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_item_reemplazo_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_item_archivo_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_det_valorado_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_item_archivo_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_tipo_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_item_reemplazo_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_almacen_stock_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_almacen_stock_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_almacen_stock_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_almacen_stock_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_almacen_stock_ime');
select pxp.f_insert_tprocedimiento ('ALM_CLA_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_clasificacion_sel');
select pxp.f_insert_tprocedimiento ('ALM_CLA_ARB_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_clasificacion_sel');
select pxp.f_insert_tprocedimiento ('ALM_CLA_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_clasificacion_sel');
select pxp.f_insert_tprocedimiento ('SAL_CLA_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_clasificacion_ime');
select pxp.f_insert_tprocedimiento ('SAL_CLA_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_clasificacion_ime');
select pxp.f_insert_tprocedimiento ('SAL_CLA_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_clasificacion_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALM_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_almacen_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALM_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_almacen_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALM_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_almacen_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_almacen_usuario_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_almacen_usuario_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_almacen_usuario_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_ELI', 'Eliminacion de datos', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_MOD', 'Modificacion de datos', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_INS', 'Insercion de datos', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOV_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEMNOTBASE_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEMNOTBASE_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ARB_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_almacen_usuario_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_almacen_usuario_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALM_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_almacen_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALM_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_almacen_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOVDET_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_movimiento_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVDET_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_movimiento_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVDET_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_movimiento_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVDET_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_movimiento_det_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOVDET_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_det_sel');
select pxp.f_insert_tprocedimiento ('SAL_MEVAL_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_metodo_val_sel');
select pxp.f_insert_tprocedimiento ('SAL_MEVAL_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_metodo_val_sel');
select pxp.f_insert_tprocedimiento ('SAL_DETVAL_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_movimiento_det_valorado_ime');
select pxp.f_insert_tprocedimiento ('SAL_DETVAL_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_movimiento_det_valorado_ime');
select pxp.f_insert_tprocedimiento ('SAL_DETVAL_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_movimiento_det_valorado_ime');
select pxp.f_insert_tprocedimiento ('SAL_ESTCLA_MOD', 'Bloqueo y desbloqueo de clasificacion', 'si', '', '', 'alm.ft_clasificacion_ime');
select pxp.f_insert_tprocedimiento ('SAL_GENCODE_MOD', 'Modificacion del codigo de un item', 'si', '', '', 'alm.ft_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_SWEST_MOD', 'Actualización de estado', 'si', '', '', 'alm.ft_almacen_ime');
select pxp.f_insert_tprocedimiento ('SAL_MEVAL_INS', 'Insercion de datos', 'si', '', '', 'alm.ft_metodo_val_ime');
select pxp.f_insert_tprocedimiento ('SAL_MEVAL_MOD', 'Modificacion de datos', 'si', '', '', 'alm.ft_metodo_val_ime');
select pxp.f_insert_tprocedimiento ('SAL_MEVAL_ELI', 'Eliminacion de datos', 'si', '', '', 'alm.ft_metodo_val_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVTIP_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_movimiento_tipo_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOVTIP_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_tipo_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITMREE_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_item_reemplazo_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITMREE_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_item_reemplazo_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITMREE_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_item_reemplazo_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITMARCH_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_item_archivo_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITMARCH_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_item_archivo_sel');
select pxp.f_insert_tprocedimiento ('SAL_DETVAL_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_movimiento_det_valorado_sel');
select pxp.f_insert_tprocedimiento ('SAL_DETVAL_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_det_valorado_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOVFIN_MOD', 'Finalizacion de un movimiento', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVCNL_MOD', 'Cancelacion de un movimiento', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVREV_MOD', 'Reversion de un movimiento', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVREPORT_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOVREPORT_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITMARCH_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_item_archivo_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITMARCH_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_item_archivo_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITMARCH_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_item_archivo_ime');
select pxp.f_insert_tprocedimiento ('SAL_UPARCH_MOD', 'Upload de archivo', 'si', '', '', 'alm.ft_item_archivo_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVTIP_INS', 'Insercion de datos', 'si', '', '', 'alm.ft_movimiento_tipo_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVTIP_MOD', 'Modificacion de datos', 'si', '', '', 'alm.ft_movimiento_tipo_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVTIP_ELI', 'Eliminacion de datos', 'si', '', '', 'alm.ft_movimiento_tipo_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITMREE_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_item_reemplazo_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITMREE_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_item_reemplazo_sel');
select pxp.f_insert_trol ('Administrador Almacenes', 'Administrador Almacenes', 'ALM');
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
select pxp.f_insert_tprocedimiento_gui ('SAL_SWEST_MOD', 'ALCRAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPPTO_SEL', 'ALCRAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_INS', 'ALCRAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_MOD', 'ALCRAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_ELI', 'ALCRAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'ALCRAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_USUARI_SEL', 'ALCRAL.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMUSR_INS', 'ALCRAL.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMUSR_MOD', 'ALCRAL.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMUSR_ELI', 'ALCRAL.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMUSR_SEL', 'ALCRAL.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ALCRAL.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MEVAL_SEL', 'ALCRAL.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMITEM_INS', 'ALCRAL.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMITEM_MOD', 'ALCRAL.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMITEM_ELI', 'ALCRAL.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMITEM_SEL', 'ALCRAL.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_INS', 'ALCRAL.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_MOD', 'ALCRAL.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_ELI', 'ALCRAL.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_SEL', 'ALCRAL.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ALCRAL.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_GENCODE_MOD', 'ALCRAL.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ALCRAL.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMREE_INS', 'ALCRAL.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMREE_MOD', 'ALCRAL.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMREE_ELI', 'ALCRAL.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMREE_SEL', 'ALCRAL.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_INS', 'ALCRAL.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_MOD', 'ALCRAL.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_ELI', 'ALCRAL.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_SEL', 'ALCRAL.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ALCRAL.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_GENCODE_MOD', 'ALCRAL.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMARCH_INS', 'ALCRAL.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMARCH_MOD', 'ALCRAL.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMARCH_ELI', 'ALCRAL.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMARCH_SEL', 'ALCRAL.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_UPARCH_MOD', 'ALCRAL.2.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_INS', 'ALREMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_MOD', 'ALREMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_ELI', 'ALREMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_SEL', 'ALREMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ALREMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_GENCODE_MOD', 'ALREMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ALREMA.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMREE_INS', 'ALREMA.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMREE_MOD', 'ALREMA.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMREE_ELI', 'ALREMA.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMREE_SEL', 'ALREMA.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_INS', 'ALREMA.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_MOD', 'ALREMA.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_ELI', 'ALREMA.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_SEL', 'ALREMA.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ALREMA.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_GENCODE_MOD', 'ALREMA.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMARCH_INS', 'ALREMA.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMARCH_MOD', 'ALREMA.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMARCH_ELI', 'ALREMA.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMARCH_SEL', 'ALREMA.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_UPARCH_MOD', 'ALREMA.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_CLA_INS', 'ALCLMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_CLA_MOD', 'ALCLMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_CLA_ELI', 'ALCLMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALCLMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALCLMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ESTCLA_MOD', 'ALCLMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_INS', 'ALCLMA.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_MOD', 'ALCLMA.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_ELI', 'ALCLMA.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_SEL', 'ALCLMA.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ALCLMA.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_GENCODE_MOD', 'ALCLMA.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ALCLMA.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMREE_INS', 'ALCLMA.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMREE_MOD', 'ALCLMA.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMREE_ELI', 'ALCLMA.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMREE_SEL', 'ALCLMA.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_INS', 'ALCLMA.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_MOD', 'ALCLMA.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_ELI', 'ALCLMA.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEM_SEL', 'ALCLMA.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ALCLMA.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_GENCODE_MOD', 'ALCLMA.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMARCH_INS', 'ALCLMA.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMARCH_MOD', 'ALCLMA.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMARCH_ELI', 'ALCLMA.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMARCH_SEL', 'ALCLMA.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_UPARCH_MOD', 'ALCLMA.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVFIN_MOD', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVTIP_INS', 'MOVTIP', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVTIP_MOD', 'MOVTIP', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVTIP_ELI', 'MOVTIP', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVTIP_SEL', 'MOVTIP', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MEVAL_INS', 'MEVAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MEVAL_MOD', 'MEVAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MEVAL_ELI', 'MEVAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MEVAL_SEL', 'MEVAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVTIP_SEL', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOV_SEL', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROVEEV_SEL', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOV_INS', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOV_MOD', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOV_ELI', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVFIN_MOD', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVCNL_MOD', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVREV_MOD', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'MOV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVDET_INS', 'MOV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVDET_MOD', 'MOV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVDET_ELI', 'MOV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVDET_SEL', 'MOV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DETVAL_SEL', 'MOV.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_INS', 'MOV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_MOD', 'MOV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_ELI', 'MOV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARMCOR_SEL', 'MOV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_SEL', 'MOV.2', 'no');
select pxp.f_insert_tgui_rol ('MOV', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALMOVI', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALM', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOV.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOV.1.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOV.2', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALCRAL', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALDAGE', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALCRAL.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALCRAL.2', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALCRAL.2.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALCRAL.2.1.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALCRAL.2.1.1.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALCRAL.2.1.2', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALCRAL.2.1.2.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALCLMA', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALMAIN', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALCLMA.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALCLMA.1.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALCLMA.1.1.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALCLMA.1.2', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALCLMA.1.2.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVTIP', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MEVAL', 'Administrador Almacenes');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVTIP_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALM_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOV_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIOCAR_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_PROVEEV_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOV_INS', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOV_MOD', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOV_ELI', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVFIN_MOD', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVCNL_MOD', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVREV_MOD', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_INS', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_MOD', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_ELI', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_SEL', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_DETVAL_SEL', 'MOV.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_ALARM_INS', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_ALARM_MOD', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_ALARM_ELI', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_ALARMCOR_SEL', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_ALARM_SEL', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_SWEST_MOD', 'ALCRAL');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_DEPPTO_SEL', 'ALCRAL');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALM_INS', 'ALCRAL');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALM_MOD', 'ALCRAL');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALM_ELI', 'ALCRAL');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALM_SEL', 'ALCRAL');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_USUARI_SEL', 'ALCRAL.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALMUSR_INS', 'ALCRAL.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALMUSR_MOD', 'ALCRAL.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALMUSR_ELI', 'ALCRAL.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALMUSR_SEL', 'ALCRAL.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'ALCRAL.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MEVAL_SEL', 'ALCRAL.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALMITEM_INS', 'ALCRAL.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALMITEM_MOD', 'ALCRAL.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALMITEM_ELI', 'ALCRAL.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALMITEM_SEL', 'ALCRAL.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_INS', 'ALCRAL.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_MOD', 'ALCRAL.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_ELI', 'ALCRAL.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_SEL', 'ALCRAL.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'ALCRAL.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_GENCODE_MOD', 'ALCRAL.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'ALCRAL.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMREE_INS', 'ALCRAL.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMREE_MOD', 'ALCRAL.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMREE_ELI', 'ALCRAL.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMREE_SEL', 'ALCRAL.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_INS', 'ALCRAL.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_MOD', 'ALCRAL.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_ELI', 'ALCRAL.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_SEL', 'ALCRAL.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'ALCRAL.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_GENCODE_MOD', 'ALCRAL.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMARCH_INS', 'ALCRAL.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMARCH_MOD', 'ALCRAL.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMARCH_ELI', 'ALCRAL.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMARCH_SEL', 'ALCRAL.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_UPARCH_MOD', 'ALCRAL.2.1.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_CLA_INS', 'ALCLMA');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_CLA_MOD', 'ALCLMA');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_CLA_ELI', 'ALCLMA');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'ALM_CLA_ARB_SEL', 'ALCLMA');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ARB_SEL', 'ALCLMA');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ESTCLA_MOD', 'ALCLMA');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_INS', 'ALCLMA.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_MOD', 'ALCLMA.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_ELI', 'ALCLMA.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_SEL', 'ALCLMA.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'ALCLMA.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_GENCODE_MOD', 'ALCLMA.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'ALCLMA.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMREE_INS', 'ALCLMA.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMREE_MOD', 'ALCLMA.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMREE_ELI', 'ALCLMA.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMREE_SEL', 'ALCLMA.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_INS', 'ALCLMA.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_MOD', 'ALCLMA.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_ELI', 'ALCLMA.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEM_SEL', 'ALCLMA.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'ALCLMA.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_GENCODE_MOD', 'ALCLMA.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMARCH_INS', 'ALCLMA.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMARCH_MOD', 'ALCLMA.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMARCH_ELI', 'ALCLMA.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMARCH_SEL', 'ALCLMA.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_UPARCH_MOD', 'ALCLMA.1.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVTIP_INS', 'MOVTIP');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVTIP_MOD', 'MOVTIP');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVTIP_ELI', 'MOVTIP');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVTIP_SEL', 'MOVTIP');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MEVAL_INS', 'MEVAL');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MEVAL_MOD', 'MEVAL');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MEVAL_ELI', 'MEVAL');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MEVAL_SEL', 'MEVAL');



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

select pxp.f_insert_tprocedimiento_gui ('PM_UME_SEL', 'ALCLMA.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_SEL', 'UMED', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_INS', 'UMED', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_MOD', 'UMED', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_ELI', 'UMED', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'UMED', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'MOVTIP', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'CATLOG', 'si');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'CATLOG', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'CATLOG', 'si');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'CATLOG', 'si');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'CATLOG', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'CATLOG', 'no');

select pxp.f_insert_tgui_rol ('UMED', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('CATLOG', 'Administrador Almacenes');

select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_UME_SEL', 'ALCLMA.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_UME_SEL', 'UMED');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_UME_INS', 'UMED');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_UME_MOD', 'UMED');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_UME_ELI', 'UMED');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CATCMB_SEL', 'UMED');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CATCMB_SEL', 'MOVTIP');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CAT_SEL', 'CATLOG');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_SUBSIS_SEL', 'CATLOG');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_PACATI_SEL', 'CATLOG');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CAT_INS', 'CATLOG');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CAT_MOD', 'CATLOG');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CAT_ELI', 'CATLOG');



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

/***********************************I-DAT-AAO-ALM-72-18/04/2013*****************************************/


select pxp.f_insert_tprocedimiento_gui ('SAL_MOVREPORT_SEL', 'MOV', 'no');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVREPORT_SEL', 'MOV');



/***********************************F-DAT-AAO-ALM-72-18/04/2013*****************************************/

                                 

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

select pxp.f_insert_tfuncion ('alm.f_actualizar_saldos_inventario', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_inventario_det_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_inventario_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_inventario_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_ruta_clasificacion', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_inventario_det_ime', 'Funcion para tabla     ', 'ALM');

select pxp.f_insert_tprocedimiento ('SAL_CLADD_MOD', 'Inserta interfaces en el arbol', 'si', '', '', 'alm.ft_clasificacion_ime');
select pxp.f_insert_tprocedimiento ('SAL_DINV_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_inventario_det_sel');
select pxp.f_insert_tprocedimiento ('SAL_DINV_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_inventario_det_sel');
select pxp.f_insert_tprocedimiento ('SAL_INV_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_inventario_ime');
select pxp.f_insert_tprocedimiento ('SAL_INV_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_inventario_ime');
select pxp.f_insert_tprocedimiento ('SAL_INV_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_inventario_ime');
select pxp.f_insert_tprocedimiento ('SAL_INVFINREG_MOD', 'Finalizacion de registro Orden Inventario', 'si', '', '', 'alm.ft_inventario_ime');
select pxp.f_insert_tprocedimiento ('SAL_INVINIEJE_MOD', 'Finalizacion de registro Orden Inventario', 'si', '', '', 'alm.ft_inventario_ime');
select pxp.f_insert_tprocedimiento ('SAL_INVFINEJE_MOD', 'Finalizacion de registro Orden Inventario', 'si', '', '', 'alm.ft_inventario_ime');
select pxp.f_insert_tprocedimiento ('SAL_INVFINREV_MOD', 'Finalizacion de registro Orden Inventario', 'si', '', '', 'alm.ft_inventario_ime');
select pxp.f_insert_tprocedimiento ('SAL_INVCORRREV_MOD', 'Devuelve el inventario para correccion', 'si', '', '', 'alm.ft_inventario_ime');
select pxp.f_insert_tprocedimiento ('SAL_INVREVDIF_MOD', 'Revision de diferencias en el inventario detalle', 'si', '', '', 'alm.ft_inventario_ime');
select pxp.f_insert_tprocedimiento ('SAL_INVNIVMOV_MOD', 'Realiza la insercion de los movimientos necesarios para la nivelacion de saldos.', 'si', '', '', 'alm.ft_inventario_ime');
select pxp.f_insert_tprocedimiento ('SAL_INVACTSALD_MOD', 'Actualiza los saldos del inventario', 'si', '', '', 'alm.ft_inventario_ime');
select pxp.f_insert_tprocedimiento ('SAL_INV_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_inventario_sel');
select pxp.f_insert_tprocedimiento ('SAL_INV_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_inventario_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOVPENPER_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOVPENPER_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_DINV_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_inventario_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_DINV_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_inventario_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_DINV_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_inventario_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITMSRCHARB_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITMSRCHARB_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_item_sel');



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
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_almacen_stock_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_almacen_stock_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_almacen_stock_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_almacen_stock_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMITEM_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_almacen_stock_ime');
select pxp.f_insert_tprocedimiento ('ALM_CLA_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_clasificacion_sel');
select pxp.f_insert_tprocedimiento ('ALM_CLA_ARB_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_clasificacion_sel');
select pxp.f_insert_tprocedimiento ('ALM_CLA_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_clasificacion_sel');
select pxp.f_insert_tprocedimiento ('SAL_CLA_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_clasificacion_ime');
select pxp.f_insert_tprocedimiento ('SAL_CLA_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_clasificacion_ime');
select pxp.f_insert_tprocedimiento ('SAL_CLA_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_clasificacion_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALM_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_almacen_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALM_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_almacen_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALM_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_almacen_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_almacen_usuario_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_almacen_usuario_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_almacen_usuario_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_ELI', 'Eliminacion de datos', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_MOD', 'Modificacion de datos', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_INS', 'Insercion de datos', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOV_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOV_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEMNOTBASE_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEMNOTBASE_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ARB_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITEM_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_almacen_usuario_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMUSR_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_almacen_usuario_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALM_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_almacen_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALM_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_almacen_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOVDET_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_movimiento_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVDET_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_movimiento_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVDET_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_movimiento_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVDET_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_movimiento_det_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOVDET_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_det_sel');
select pxp.f_insert_tprocedimiento ('SAL_MEVAL_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_metodo_val_sel');
select pxp.f_insert_tprocedimiento ('SAL_MEVAL_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_metodo_val_sel');
select pxp.f_insert_tprocedimiento ('SAL_DETVAL_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_movimiento_det_valorado_ime');
select pxp.f_insert_tprocedimiento ('SAL_DETVAL_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_movimiento_det_valorado_ime');
select pxp.f_insert_tprocedimiento ('SAL_DETVAL_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_movimiento_det_valorado_ime');
select pxp.f_insert_tprocedimiento ('SAL_ESTCLA_MOD', 'Bloqueo y desbloqueo de clasificacion', 'si', '', '', 'alm.ft_clasificacion_ime');
select pxp.f_insert_tprocedimiento ('SAL_GENCODE_MOD', 'Modificacion del codigo de un item', 'si', '', '', 'alm.ft_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_SWEST_MOD', 'Actualización de estado', 'si', '', '', 'alm.ft_almacen_ime');
select pxp.f_insert_tprocedimiento ('SAL_MEVAL_INS', 'Insercion de datos', 'si', '', '', 'alm.ft_metodo_val_ime');
select pxp.f_insert_tprocedimiento ('SAL_MEVAL_MOD', 'Modificacion de datos', 'si', '', '', 'alm.ft_metodo_val_ime');
select pxp.f_insert_tprocedimiento ('SAL_MEVAL_ELI', 'Eliminacion de datos', 'si', '', '', 'alm.ft_metodo_val_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVTIP_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_movimiento_tipo_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOVTIP_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_tipo_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITMREE_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_item_reemplazo_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITMREE_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_item_reemplazo_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITMREE_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_item_reemplazo_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITMARCH_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_item_archivo_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITMARCH_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_item_archivo_sel');
select pxp.f_insert_tprocedimiento ('SAL_DETVAL_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_movimiento_det_valorado_sel');
select pxp.f_insert_tprocedimiento ('SAL_DETVAL_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_det_valorado_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOVFIN_MOD', 'Finalizacion de un movimiento', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVCNL_MOD', 'Cancelacion de un movimiento', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVREV_MOD', 'Reversion de un movimiento', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVREPORT_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOVREPORT_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITMARCH_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_item_archivo_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITMARCH_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_item_archivo_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITMARCH_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_item_archivo_ime');
select pxp.f_insert_tprocedimiento ('SAL_UPARCH_MOD', 'Upload de archivo', 'si', '', '', 'alm.ft_item_archivo_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVTIP_INS', 'Insercion de datos', 'si', '', '', 'alm.ft_movimiento_tipo_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVTIP_MOD', 'Modificacion de datos', 'si', '', '', 'alm.ft_movimiento_tipo_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVTIP_ELI', 'Eliminacion de datos', 'si', '', '', 'alm.ft_movimiento_tipo_ime');
select pxp.f_insert_tprocedimiento ('SAL_ITMREE_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_item_reemplazo_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITMREE_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_item_reemplazo_sel');
select pxp.f_insert_trol ('', 'Asistente de Almacenes', 'ALM');



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
select pxp.f_insert_tfuncion ('alm.ft_reporte_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tprocedimiento ('SAL_REPEXIST_SEL', 'Retorna las existencias de n items de un almacen.', 'si', '', '', 'alm.ft_reporte_sel');
select pxp.f_insert_tprocedimiento ('SAL_REPEXIST_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_reporte_sel');

select pxp.f_insert_tgui ('Kardex x Item', 'Reporte de Kardex por Item', 'KARITE', 'si', 1, 'sis_almacenes/vista/vista_reportes/KardexItem.php', 3, '', 'KardexItem', 'ALM');
select pxp.f_insert_tgui ('Items Entregados/Ingresados', 'Items Entregados/Ingresados', 'ALREPIEI', 'si', 1, 'sis_almacenes/vista/vista_reportes/ItemEntRec.php', 3, '', 'ItemEntRec', 'ALM');

select pxp.f_insert_testructura_gui ('REPOR', 'ALM');
select pxp.f_insert_testructura_gui ('REPEXIST', 'REPOR');
select pxp.f_insert_testructura_gui ('KARITE', 'REPOR');
select pxp.f_insert_testructura_gui ('ALREPIEI', 'REPOR');

/***********************************F-DAT-AAO-ALM-56-03/05/2013*****************************************/

/***********************************I-DAT-AAO-ALM-52-06/05/2013*****************************************/



select pxp.f_update_table_sequence('alm', 'tmovimiento_tipo');

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

select pxp.f_insert_tfuncion ('alm.ft_periodo_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_preingreso_det_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_preingreso_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_rep_kardex_item_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_id_tipo_mov_por_codigo', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_saldo_item', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_preingreso_det_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_periodo_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_preingreso_sel', 'Funcion para tabla     ', 'ALM');

select pxp.f_insert_tprocedimiento ('SAL_ALMPER_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_periodo_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMPER_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_periodo_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMPER_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_periodo_ime');
select pxp.f_insert_tprocedimiento ('SAL_PEABCE_MOD', 'Abrir/Cerrar/Reabrir periodo', 'si', '', '', 'alm.ft_periodo_ime');
select pxp.f_insert_tprocedimiento ('SAL_PREDET_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_preingreso_det_sel');
select pxp.f_insert_tprocedimiento ('SAL_PREDET_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_preingreso_det_sel');
select pxp.f_insert_tprocedimiento ('SAL_ANTEMOV_IME', 'Transaccion utilizada  pasar a  estados anterior del movimiento
                    segun la operacion definida', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_SIGEMOV_IME', 'funcion que controla el cambio al Siguiente estado del movimiento, integrado con el WF', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_PREINGR_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_preingreso_ime');
select pxp.f_insert_tprocedimiento ('SAL_PREINGR_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_preingreso_ime');
select pxp.f_insert_tprocedimiento ('SAL_PREINGR_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_preingreso_ime');
select pxp.f_insert_tprocedimiento ('SAL_RKARIT_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_rep_kardex_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_PREDET_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_preingreso_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_PREDET_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_preingreso_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_PREDET_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_preingreso_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMPER_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_periodo_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMPER_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_periodo_sel');
select pxp.f_insert_tprocedimiento ('SAL_PREINGR_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_preingreso_sel');
select pxp.f_insert_tprocedimiento ('SAL_PREINGR_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_preingreso_sel');

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
select pxp.f_insert_tfuncion ('alm.f_cbte_validado_ingreso', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_grupo_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_generar_mov_gestion', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_grupo_det_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_generar_salida_func', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_item_existencia_almacen_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_generar_alertas_mov', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_gestion_log_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_salida_grupo_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_tipo_uo_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_valoracion_mov', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_gestion_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_grupo_det_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_gestion_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_salida_grupo_item_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_tipo_uo_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_movimiento_workflow_principal', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_id_clasificaciones', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_tipo_item_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_salida_grupo_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_salida_grupo_fun_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_registrar_almacen_gestion_log', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_tri_talmacen_gestion', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_insercion_movimiento', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_id_clasificaciones_varios', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_grupo_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_almacen_gestion_log_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_saldo_item_val', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_salida_grupo_item_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_get_codigo_clasificacion_rec', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_movimiento_tipo_item_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.ft_salida_grupo_fun_ime', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_verificar_existencias_item', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_generar_cbtes', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_generar_ingreso', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_existencias_almacen_sel', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tfuncion ('alm.f_insercion_movimiento_externo', 'Funcion para tabla     ', 'ALM');
select pxp.f_insert_tprocedimiento ('SAL_MOVGRU_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_movimiento_grupo_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVGRU_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_movimiento_grupo_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVGRU_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_movimiento_grupo_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVGRU_GEN', 'Generación de comprobante', 'si', '', '', 'alm.ft_movimiento_grupo_ime');
select pxp.f_insert_tprocedimiento ('SAL_PREING_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_preingreso_sel');
select pxp.f_insert_tprocedimiento ('SAL_PREING_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_preingreso_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOGRDE_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_movimiento_grupo_det_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOGRDE_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_grupo_det_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITMALM_SEL', 'Consulta de datos', 'si', '', '', 'alm.f_item_existencia_almacen_sel');
select pxp.f_insert_tprocedimiento ('SAL_ITMALM_CONT', 'Conteo de registros', 'si', '', '', 'alm.f_item_existencia_almacen_sel');
select pxp.f_insert_tprocedimiento ('SAL_AGLOG_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_almacen_gestion_log_sel');
select pxp.f_insert_tprocedimiento ('SAL_AGLOG_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_almacen_gestion_log_sel');
select pxp.f_insert_tprocedimiento ('SAL_SALGRU_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_salida_grupo_sel');
select pxp.f_insert_tprocedimiento ('SAL_SALGRU_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_salida_grupo_sel');
select pxp.f_insert_tprocedimiento ('SAL_TIMVUO_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_movimiento_tipo_uo_sel');
select pxp.f_insert_tprocedimiento ('SAL_TIMVUO_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_tipo_uo_sel');
select pxp.f_insert_tprocedimiento ('SAL_PREING_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_preingreso_ime');
select pxp.f_insert_tprocedimiento ('SAL_PREING_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_preingreso_ime');
select pxp.f_insert_tprocedimiento ('SAL_PREING_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_preingreso_ime');
select pxp.f_insert_tprocedimiento ('SAL_INGRES_GEN', 'GEneración de ingreso a Almacenes o Activos Fijos', 'si', '', '', 'alm.ft_preingreso_ime');
select pxp.f_insert_tprocedimiento ('SAL_PREING_REV', 'Reversión del Preingreso', 'si', '', '', 'alm.ft_preingreso_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMGES_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_almacen_gestion_sel');
select pxp.f_insert_tprocedimiento ('SAL_ALMGES_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_almacen_gestion_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOGRDE_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_movimiento_grupo_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOGRDE_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_movimiento_grupo_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOGRDE_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_movimiento_grupo_det_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMGES_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_almacen_gestion_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMGES_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_almacen_gestion_ime');
select pxp.f_insert_tprocedimiento ('SAL_ALMGES_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_almacen_gestion_ime');
select pxp.f_insert_tprocedimiento ('SAL_ACCGES_INS', 'Acciones para realizar sobre la gestión', 'si', '', '', 'alm.ft_almacen_gestion_ime');
select pxp.f_insert_tprocedimiento ('SAL_SAGRIT_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_salida_grupo_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_SAGRIT_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_salida_grupo_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_TIMVUO_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_movimiento_tipo_uo_ime');
select pxp.f_insert_tprocedimiento ('SAL_TIMVUO_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_movimiento_tipo_uo_ime');
select pxp.f_insert_tprocedimiento ('SAL_REITEN_SEL', 'Retorna listado de los materiales entregados/recibidos', 'si', '', '', 'alm.ft_reporte_sel');
select pxp.f_insert_tprocedimiento ('SAL_REITEN_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_reporte_sel');
select pxp.f_insert_tprocedimiento ('SAL_TIMITE_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_movimiento_tipo_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_TIMITE_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_tipo_item_sel');
select pxp.f_insert_tprocedimiento ('SAL_SALGRU_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_salida_grupo_ime');
select pxp.f_insert_tprocedimiento ('SAL_SALGRU_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_salida_grupo_ime');
select pxp.f_insert_tprocedimiento ('SAL_SALGRU_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_salida_grupo_ime');
select pxp.f_insert_tprocedimiento ('SAL_SALGRU_FIN', 'Finalización de la solicitud grupal', 'si', '', '', 'alm.ft_salida_grupo_ime');
select pxp.f_insert_tprocedimiento ('SAL_SALGRU_RET', 'Retrocede una solicitud la solicitud grupal si es que ninguna de las solicitudes generadas han sido ya aprobadas', 'si', '', '', 'alm.ft_salida_grupo_ime');
select pxp.f_insert_tprocedimiento ('SAL_GRITFU_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_salida_grupo_fun_sel');
select pxp.f_insert_tprocedimiento ('SAL_GRITFU_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_salida_grupo_fun_sel');
select pxp.f_insert_tprocedimiento ('SAL_FUNCIOCAR_SEL', 'Listado de los funcionarios para el registro del movimiento', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_FUNCIOCAR_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOVGRU_SEL', 'Consulta de datos', 'si', '', '', 'alm.ft_movimiento_grupo_sel');
select pxp.f_insert_tprocedimiento ('SAL_MOVGRU_CONT', 'Conteo de registros', 'si', '', '', 'alm.ft_movimiento_grupo_sel');
select pxp.f_insert_tprocedimiento ('SAL_AGLOG_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_almacen_gestion_log_ime');
select pxp.f_insert_tprocedimiento ('SAL_AGLOG_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_almacen_gestion_log_ime');
select pxp.f_insert_tprocedimiento ('SAL_AGLOG_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_almacen_gestion_log_ime');
select pxp.f_insert_tprocedimiento ('SAL_SAGRIT_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_salida_grupo_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_SAGRIT_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_salida_grupo_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_SAGRIT_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_salida_grupo_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_TIMITE_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_movimiento_tipo_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_TIMITE_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_movimiento_tipo_item_ime');
select pxp.f_insert_tprocedimiento ('SAL_GRITFU_INS', 'Insercion de registros', 'si', '', '', 'alm.ft_salida_grupo_fun_ime');
select pxp.f_insert_tprocedimiento ('SAL_GRITFU_MOD', 'Modificacion de registros', 'si', '', '', 'alm.ft_salida_grupo_fun_ime');
select pxp.f_insert_tprocedimiento ('SAL_GRITFU_ELI', 'Eliminacion de registros', 'si', '', '', 'alm.ft_salida_grupo_fun_ime');
select pxp.f_insert_tprocedimiento ('SAL_MOVPRE_REV', 'REvierte un ingreso hasta el preingreso. Cancela el movimiento y retrocede el estado del preingreso', 'si', '', '', 'alm.ft_movimiento_ime');
select pxp.f_insert_tprocedimiento ('SAL_AGMOV_GET', 'Almacen gestion obtener Movimiento', 'si', '', '', 'alm.ft_almacen_gestion_ime');
select pxp.f_insert_trol ('Registra salidas de almacenes', 'ALM - Asistente de Almacenes', 'ALM');
select pxp.f_insert_trol ('ingreso a Reportes', 'ALM - Consulta', 'ALM');

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