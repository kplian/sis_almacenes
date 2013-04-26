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
select pxp.f_insert_tgui ('Ingresos', 'Ingresos', 'ALINGR', 'si', 2, 'sis_almacenes/vista/movimiento/Ingreso.php
', 3, '', 'Ingreso', 'ALM');
select pxp.f_insert_tgui ('Salidas', 'Salidas', 'ALSAGR', 'si', 2, 'sis_almacenes/vista/movimiento/Salida.php
', 3, '', 'Salida', 'ALM');
select pxp.f_insert_tgui ('Transferencias', 'Transferencias', 'ALTRGR', 'si', 3, 'sis_almacenes/vista/movimiento/Transferencia.php', 3, '', 'Transferencia', 'ALM');
select pxp.f_insert_testructura_gui ('ALM', 'SISTEMA');
select pxp.f_insert_testructura_gui ('ALDAGE', 'ALM');
select pxp.f_insert_testructura_gui ('ALMAIN', 'ALM');
select pxp.f_insert_testructura_gui ('ALMOVI', 'ALM');
select pxp.f_insert_testructura_gui ('ALCRAL', 'ALDAGE');
select pxp.f_insert_testructura_gui ('ALREMA', 'ALMAIN');
select pxp.f_insert_testructura_gui ('ALCLMA', 'ALMAIN');
select pxp.f_insert_testructura_gui ('ALINGR', 'ALMOVI');
select pxp.f_insert_testructura_gui ('ALSAGR', 'ALMOVI');
select pxp.f_insert_testructura_gui ('ALTRGR', 'ALMOVI');



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
INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_tipo", "codigo", "nombre", "tipo")
VALUES (1, 1, E'2013-02-19 19:01:02.292', E'2013-02-19 19:03:21.553', E'activo', 1, E'SALTRNSF', E'Salida por Transferencia', E'salida');

INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_tipo", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2013-02-19 19:03:55.823', E'2013-02-19 19:03:55.823', E'activo', 2, E'INTRNSF', E'Ingreso por transferencia', E'ingreso');
/***********************************F-DAT-AAO-ALM-31-20/02/2013*****************************************/

/***********************************I-DAT-AAO-ALM-29-23/02/2013*****************************************/
INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_tipo", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2013-02-23 18:49:21.853', E'2013-02-23 18:49:21.853', E'activo', 3, E'DEV', E'Ingreso por Devolucion', E'ingreso');
/***********************************F-DAT-AAO-ALM-29-23/02/2013*****************************************/

/***********************************I-DAT-AAO-ALM-26-25/02/2013*****************************************/
INSERT INTO param.tdocumento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_subsistema", "codigo", "descripcion", "periodo_gestion", "tipo", "tipo_numeracion", "formato")
VALUES (1, 1, E'2013-02-24 00:00:00', E'2013-02-24 08:22:48.436', E'activo', 6, E'MOVIN', E'Movimiento tipo Ingreso al Almacen', E'periodo', E'', E'depto', E'depto-I-periodo-correlativo/gestion');

INSERT INTO param.tdocumento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_subsistema", "codigo", "descripcion", "periodo_gestion", "tipo", "tipo_numeracion", "formato")
VALUES (1, 1, E'2013-02-24 00:00:00', E'2013-02-24 08:23:00.205', E'activo', 6, E'MOVSAL', E'Moviento tipo Salida de Almacen', E'periodo', E'', E'depto', E'depto-S-periodo-correlativo/gestion');
/***********************************F-DAT-AAO-ALM-26-25/02/2013*****************************************/

/***********************************I-DAT-AAO-ALM-39-06/03/2013*****************************************/
INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_tipo", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2013-02-23 18:49:21.853', E'2013-02-23 18:49:21.853', E'activo', 4, E'INVINI', E'Inventario Inicial', E'ingreso');
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
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVFIN_MOD', 'ALTRGR', 'no');
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