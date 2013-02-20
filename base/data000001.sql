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
select pxp.f_insert_tfuncion ('alm.f_get_existencias_item', 'Funcion para tabla     ', 'ALM');
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