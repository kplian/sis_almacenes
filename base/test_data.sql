-- USUARIOS
INSERT INTO segu.tusuario ("id_clasificador", "cuenta", "contrasena", "fecha_caducidad", "fecha_reg", "estilo", "contrasena_anterior", "id_persona", "estado_reg", "autentificacion")
VALUES (1, E'spanza', E'533cd2ec574f9a6ded5801efbfee21ba', E'2014-02-28', E'2013-02-28', E'xtheme-blue.css', NULL, 3, E'activo', E'local');

-- USUARIO ROL
INSERT INTO segu.tusuario_rol ("id_usuario_rol", "id_rol", "id_usuario", "fecha_reg", "estado_reg")
VALUES (2, 2, 2, NULL, E'activo');

-- Clasificacion
INSERT INTO alm.tclasificacion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_clasificacion, id_clasificacion_fk, codigo, nombre, descripcion, codigo_largo)
VALUES (1, NULL, '2012-11-13 10:36:14', '2012-11-13 10:36:14', 'activo', 1, NULL, 'EQUIP', 'Equipos', NULL, 'EQUIPOS');

INSERT INTO alm.tclasificacion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_clasificacion, id_clasificacion_fk, codigo, nombre, descripcion, codigo_largo)
VALUES (1, NULL, '2012-11-13 11:29:46', '2012-11-13 11:29:46', 'activo', 3, 1, 'ECOM', 'Equipos de computación', NULL, 'EQUIPOCOMP');

INSERT INTO alm.tclasificacion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_clasificacion, id_clasificacion_fk, codigo, nombre, descripcion, codigo_largo)
VALUES (1, NULL, '2012-11-13 10:37:30', '2012-11-13 10:37:30', 'activo', 2, 1, 'EQMED', 'Equipos Medicos', NULL, 'EQMEDICOS');


-- Depto para almacenes

INSERT INTO param.tdepto ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_depto", "id_subsistema", "codigo", "nombre", "nombre_corto")
VALUES (1, 1, E'2013-02-24 00:00:00', E'2013-02-24 08:07:38.213', E'activo', 1, 6, E'ALM01', E'Almacen Cercado', E'ALMA');

INSERT INTO param.tdepto ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_depto", "id_subsistema", "codigo", "nombre", "nombre_corto")
VALUES (1, NULL, E'2013-02-24 00:00:00', E'2013-02-24 08:08:27.507', E'activo', 2, 6, E'ALM02', E'Almacen Aduana Zofraco', E'ALM02');

-- UNIDAD MEDIDA
INSERT INTO param.tunidad_medida ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_unidad_medida", "codigo", "descripcion", "tipo")
VALUES (1, NULL, E'2013-03-01 01:00:57.324', NULL, E'activo', 100, E'Pza.', E'Pieza', E'Masa');

-- Almacen

INSERT INTO alm.talmacen ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_almacen", "codigo", "nombre", "localizacion", "estado", "id_departamento")
VALUES (1, 1, E'2012-11-13 09:16:48', E'2013-02-20 20:18:50.233', E'activo', 1, E'ALM01', E'Almacen Cercado', NULL, E'activo', 1);

INSERT INTO alm.talmacen ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_almacen", "codigo", "nombre", "localizacion", "estado", "id_departamento")
VALUES (1, 1, E'2012-11-13 10:20:06', E'2013-02-20 20:19:12.300', E'activo', 2, E'ALM02', E'Almacen Aduana Zofraco', NULL, E'inactivo', 2);

-- Almacen Stock

INSERT INTO alm.talmacen_stock ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_almacen_stock", "id_almacen", "id_item", "cantidad_min", "cantidad_alerta_amarilla", "cantidad_alerta_roja", "id_metodo_val")
VALUES (1, NULL, E'2013-02-23 22:59:37.385', NULL, E'activo', 1, 1, 7, '10', '30', '20', 4);

INSERT INTO alm.talmacen_stock ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_almacen_stock", "id_almacen", "id_item", "cantidad_min", "cantidad_alerta_amarilla", "cantidad_alerta_roja", "id_metodo_val")
VALUES (1, NULL, E'2013-02-23 22:59:46.396', NULL, E'activo', 2, 1, 1, '10', '30', '20', 1);

INSERT INTO alm.talmacen_stock ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_almacen_stock", "id_almacen", "id_item", "cantidad_min", "cantidad_alerta_amarilla", "cantidad_alerta_roja", "id_metodo_val")
VALUES (1, NULL, E'2013-02-23 22:59:55.473', NULL, E'activo', 3, 1, 4, '10', '30', '20', 2);

--almacen usuario

INSERT INTO alm.talmacen_usuario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_almacen_usuario", "id_usuario", "tipo", "id_almacen")
VALUES (1, NULL, E'2013-02-26 02:52:19.588', NULL, E'activo', 1, 1, E'responsable', 1);

INSERT INTO alm.talmacen_usuario ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_almacen_usuario", "id_usuario", "tipo", "id_almacen")
VALUES (1, NULL, E'2013-02-26 02:52:29.050', NULL, E'activo', 2, 2, E'asistente', 1);


-- Item
INSERT INTO alm.titem (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_item, id_clasificacion, codigo, nombre, descripcion, palabras_clave, codigo_fabrica, observaciones, numero_serie, id_unidad_medida)
VALUES (1, NULL, '2012-11-13 11:31:31', '2012-11-13 11:31:31', 'activo', 1, 2, 'HUM01', 'Humidificador Personal', NULL, NULL, NULL, NULL, NULL, 100);

INSERT INTO alm.titem (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_item, id_clasificacion, codigo, nombre, descripcion, palabras_clave, codigo_fabrica, observaciones, numero_serie, id_unidad_medida)
VALUES (1, NULL, '2012-11-13 11:32:06', '2012-11-13 11:32:06', 'activo', 2, 2, 'ECAR', 'Electrocardiógrafo avanzado pantalla táctil ', NULL, NULL, NULL, NULL, NULL, 100);

INSERT INTO alm.titem (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_item, id_clasificacion, codigo, nombre, descripcion, palabras_clave, codigo_fabrica, observaciones, numero_serie, id_unidad_medida)
VALUES (1, NULL, '2012-11-13 11:36:30', '2012-11-13 11:36:30', 'activo', 3, 3, 'LP001', 'Laptop Dell Latitude i7', 'RAM 8 GB, i7, HDD 750 GB', NULL, NULL, NULL, NULL, 100);

INSERT INTO alm.titem (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_item, id_clasificacion, codigo, nombre, descripcion, palabras_clave, codigo_fabrica, observaciones, numero_serie, id_unidad_medida)
VALUES (1, NULL, '2012-11-13 11:37:38', '2012-11-13 11:37:38', 'activo', 4, 3, 'IP001', 'Ipad 3ra Gen', NULL, NULL, NULL, NULL, NULL, 100);

INSERT INTO alm.titem (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_item, id_clasificacion, codigo, nombre, descripcion, palabras_clave, codigo_fabrica, observaciones, numero_serie, id_unidad_medida)
VALUES (1, NULL, '2012-11-13 11:38:14', '2012-11-13 11:38:14', 'activo', 5, 3, 'SW001', 'Switch Juniper SRX A1', NULL, NULL, NULL, NULL, NULL, 100);

INSERT INTO alm.titem ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_item", "id_clasificacion", "codigo", "nombre", "descripcion", "palabras_clave", "codigo_fabrica", "observaciones", "numero_serie", id_unidad_medida)
VALUES (1, NULL, E'2012-12-29 05:30:30.025', E'2012-12-29 05:30:30.025', E'activo', 7, 3, E'', E'Canon Ip1900', E'Impresora multicolor Canon IP 1900', E'IP1900', E'IP1900_s', E'color negro', E'asd579', 100);


-- Movimiento_tipo
INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_tipo", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2013-02-19 19:13:12.927', E'2013-02-19 19:13:12.927', E'activo', 5, E'INCOMP', E'Ingreso por Compra', E'ingreso');

INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_tipo", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2013-02-19 19:13:26.057', E'2013-02-19 19:13:26.057', E'activo', 6, E'SALVENT', E'Salida por Venta', E'salida');

-- Movimiento

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov", "id_movimiento_origen")
VALUES (1, NULL, E'2013-02-26 20:15:28.267', E'2013-02-26 20:15:28.267', E'activo', 1, 4, 1, NULL, NULL, NULL, E'2013-02-17 00:01:00', E'ALM01-I-2-2/2013', E'', E'', E'finalizado', NULL);

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov", "id_movimiento_origen")
VALUES (1, NULL, E'2013-02-26 21:51:13.431', E'2013-02-26 21:51:13.431', E'activo', 2, 4, 1, NULL, NULL, NULL, E'2013-02-18 00:01:00', E'ALM01-I-2-3/2013', E'', E'', E'finalizado', NULL);

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov", "id_movimiento_origen")
VALUES (1, NULL, E'2013-02-26 21:58:48.791', E'2013-02-26 21:58:48.791', E'activo', 3, 5, 1, NULL, 1, NULL, E'2013-02-19 00:01:00', E'ALM01-S-2-2/2013', E'', E'', E'finalizado', NULL);

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov", "id_movimiento_origen")
VALUES (1, NULL, E'2013-02-26 22:04:05.055', E'2013-02-26 22:04:05.055', E'activo', 4, 5, 1, NULL, 2, NULL, E'2013-02-20 00:01:00', E'ALM01-S-2-5/2013', E'', E'', E'finalizado', NULL);

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov", "id_movimiento_origen")
VALUES (1, NULL, E'2013-02-26 22:15:08.220', E'2013-02-26 22:15:08.220', E'activo', 5, 4, 1, NULL, NULL, NULL, E'2013-02-21 00:01:00', E'ALM01-I-2-4/2013', E'', E'', E'finalizado', NULL);

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov", "id_movimiento_origen")
VALUES (1, NULL, E'2013-02-26 22:16:10.313', E'2013-02-26 22:16:10.313', E'activo', 6, 4, 1, NULL, NULL, NULL, E'2013-02-22 00:01:00', E'ALM01-I-2-5/2013', E'', E'', E'finalizado', NULL);

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov", "id_movimiento_origen")
VALUES (1, NULL, E'2013-02-26 22:17:16.003', E'2013-02-26 22:17:16.003', E'activo', 7, 5, 1, NULL, 2, NULL, E'2013-02-23 00:01:00', E'ALM01-S-2-6/2013', E'', E'', E'finalizado', NULL);

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov", "id_movimiento_origen")
VALUES (1, NULL, E'2013-02-26 22:18:41.026', E'2013-02-26 22:18:41.026', E'activo', 8, 5, 1, NULL, 2, NULL, E'2013-02-24 00:01:00', E'ALM01-S-2-9/2013', E'', E'', E'finalizado', NULL);

-- Movimiento_det

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 20:15:47.272', E'2013-02-26 20:15:47.272', E'activo', 1, 1, 7, '100', NULL, '80');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 20:15:57.269', E'2013-02-26 20:15:57.269', E'activo', 2, 1, 1, '100', NULL, '80');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 20:16:01.945', E'2013-02-26 20:16:01.945', E'activo', 3, 1, 4, '100', NULL, '80');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 21:51:27.796', E'2013-02-26 21:51:27.796', E'activo', 4, 2, 7, '50', NULL, '70');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 21:51:34.428', E'2013-02-26 21:51:34.428', E'activo', 5, 2, 1, '50', NULL, '70');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 21:51:39.616', E'2013-02-26 21:51:39.616', E'activo', 6, 2, 4, '50', NULL, '70');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 21:59:46.449', E'2013-02-26 21:59:46.449', E'activo', 7, 3, 7, '80', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 21:59:52.916', E'2013-02-26 21:59:52.916', E'activo', 8, 3, 1, '80', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 21:59:57.411', E'2013-02-26 21:59:57.411', E'activo', 9, 3, 4, '80', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 22:08:01.564', E'2013-02-26 22:08:01.564', E'activo', 10, 4, 7, '50', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 22:08:08.187', E'2013-02-26 22:08:08.187', E'activo', 11, 4, 1, '50', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 22:08:27.618', E'2013-02-26 22:08:27.618', E'activo', 12, 4, 4, '50', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 22:15:39.949', E'2013-02-26 22:15:39.949', E'activo', 13, 5, 7, '90', NULL, '90');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 22:15:46.139', E'2013-02-26 22:15:46.139', E'activo', 14, 5, 1, '90', NULL, '90');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 22:15:51.071', E'2013-02-26 22:15:51.071', E'activo', 15, 5, 4, '90', NULL, '90');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 22:16:26.458', E'2013-02-26 22:16:26.458', E'activo', 16, 6, 7, '50', NULL, '70');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 22:16:37.336', E'2013-02-26 22:16:37.336', E'activo', 17, 6, 1, '50', NULL, '70');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 22:16:43.390', E'2013-02-26 22:16:43.390', E'activo', 18, 6, 4, '50', NULL, '70');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 22:17:32.473', E'2013-02-26 22:17:32.473', E'activo', 19, 7, 7, '50', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 22:17:39.554', E'2013-02-26 22:17:39.554', E'activo', 20, 7, 1, '50', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 22:17:46.175', E'2013-02-26 22:17:46.175', E'activo', 21, 7, 4, '50', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 22:19:03.949', E'2013-02-26 22:19:03.949', E'activo', 22, 8, 7, '20', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 22:19:11.339', E'2013-02-26 22:19:11.339', E'activo', 23, 8, 1, '20', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-26 22:19:17.051', E'2013-02-26 22:19:17.051', E'activo', 24, 8, 4, '20', NULL, NULL);

-- Movimiento_det_valorado

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 22:15:46.139', E'2013-02-26 22:24:08.205', E'activo', 28, 14, '90', '90', '40', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, NULL, E'2013-02-26 20:15:47.272', E'2013-02-26 20:15:47.272', E'activo', 1, 1, '100', '80', '100', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, NULL, E'2013-02-26 21:51:27.796', E'2013-02-26 21:51:27.796', E'activo', 4, 4, '50', '70', '50', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 22:15:51.071', E'2013-02-26 22:24:08.205', E'activo', 29, 15, '90', '90', '70', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 20:15:57.269', E'2013-02-26 22:14:37.486', E'activo', 2, 2, '100', '80', '0', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 22:23:59.557', E'2013-02-26 22:24:08.205', E'activo', 43, 22, '20', '82.083334', '20', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 20:16:01.945', E'2013-02-26 22:14:37.486', E'activo', 3, 3, '100', '80', '20', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 22:23:59.557', E'2013-02-26 22:24:08.205', E'activo', 44, 23, '20', '90', '20', 28);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 22:11:28.579', E'2013-02-26 22:14:37.486', E'activo', 23, 10, '50', '76.666666', '50', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 22:11:28.579', E'2013-02-26 22:14:37.486', E'activo', 24, 11, '20', '80', '20', 2);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, NULL, E'2013-02-26 22:14:37.486', E'2013-02-26 22:14:37.486', E'activo', 26, 11, '30', '70', '30', 5);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 22:11:28.579', E'2013-02-26 22:14:37.486', E'activo', 25, 12, '50', '80', '50', 3);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, NULL, E'2013-02-26 22:15:39.949', E'2013-02-26 22:15:39.949', E'activo', 27, 13, '90', '90', '90', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 22:23:59.557', E'2013-02-26 22:24:08.205', E'activo', 45, 24, '20', '90', '20', 29);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, NULL, E'2013-02-26 22:16:26.458', E'2013-02-26 22:16:26.458', E'activo', 30, 16, '50', '70', '50', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 21:51:39.616', E'2013-02-26 22:01:32.489', E'activo', 6, 6, '50', '70', '0', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, NULL, E'2013-02-26 22:16:37.336', E'2013-02-26 22:16:37.336', E'activo', 31, 17, '50', '70', '50', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 22:01:06.047', E'2013-02-26 22:01:32.489', E'activo', 11, 7, '80', '76.666667', '80', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 22:01:06.047', E'2013-02-26 22:01:32.489', E'activo', 12, 8, '80', '80', '80', 2);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 22:01:06.047', E'2013-02-26 22:01:32.489', E'activo', 13, 9, '50', '70', '50', 6);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, NULL, E'2013-02-26 22:01:32.489', E'2013-02-26 22:01:32.489', E'activo', 14, 9, '30', '80', '30', 3);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 21:51:34.428', E'2013-02-26 22:17:55.463', E'activo', 5, 5, '50', '70', '0', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 22:16:43.390', E'2013-02-26 22:17:55.463', E'activo', 32, 18, '50', '70', '0', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 22:17:32.473', E'2013-02-26 22:17:55.463', E'activo', 33, 19, '50', '82.083333', '50', NULL);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 22:17:39.554', E'2013-02-26 22:17:55.463', E'activo', 34, 20, '20', '70', '20', 5);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, NULL, E'2013-02-26 22:17:55.463', E'2013-02-26 22:17:55.463', E'activo', 36, 20, '30', '90', '30', 28);

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico", "id_mov_det_val_origen")
VALUES (1, 1, E'2013-02-26 22:17:46.175', E'2013-02-26 22:17:55.463', E'activo', 35, 21, '50', '70', '50', 32);

-- Actalizacion de Secuencias

/* SET search_path = segu, pg_catalog;
SELECT pg_catalog.setval('tpersona_id_persona_seq', 2, true);
--
-- Data for sequence param.tinstitucion_id_institucion_seq (OID = 1407919)
--
SET search_path = param, pg_catalog;
SELECT pg_catalog.setval('tinstitucion_id_institucion_seq', 3, true);
--
-- Data for sequence param.tproveedor_id_proveedor_seq (OID = 1408012)
--
SELECT pg_catalog.setval('tproveedor_id_proveedor_seq', 2, true);
--
-- Data for sequence orga.tfuncionario_id_funcionario_seq (OID = 1408268)
--
SET search_path = orga, pg_catalog;
SELECT pg_catalog.setval('tfuncionario_id_funcionario_seq', 1, true);
--
-- Data for sequence alm.tclasificacion_id_clasificacion_seq (OID = 1409018)
--
SET search_path = alm, pg_catalog;
SELECT pg_catalog.setval('tclasificacion_id_clasificacion_seq', 3, true);
--
-- Data for sequence alm.talmacen_id_almacen_seq (OID = 1409030)
--
SELECT pg_catalog.setval('talmacen_id_almacen_seq', 2, true);
--
-- Data for sequence alm.titem_id_item_seq (OID = 1409039)
--
SELECT pg_catalog.setval('titem_id_item_seq', 5, true);
--
-- Data for sequence alm.tmovimiento_tipo_id_movimiento_tipo_seq (OID = 1409060)
--
SELECT pg_catalog.setval('tmovimiento_tipo_id_movimiento_tipo_seq', 2, true);
--
-- Data for sequence alm.tmovimiento_id_movimiento_seq (OID = 1409069)
--
SELECT pg_catalog.setval('tmovimiento_id_movimiento_seq', 7, true);
--
-- Data for sequence alm.tmovimiento_det_id_movimiento_det_seq (OID = 1409081)
--
SELECT pg_catalog.setval('tmovimiento_det_id_movimiento_det_seq', 11, true);*/

-- Gestion
INSERT INTO param.tgestion ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_gestion", "gestion", "estado", "id_moneda_base", "id_empresa")
VALUES (1, NULL, E'2013-02-24 04:11:51.076', NULL, E'activo', 105, 2013, E'', 1, 1);

-- Periodo
INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_periodo", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-02-24 04:11:51.076', NULL, E'activo', 1, 1, 105, E'2013-01-01', E'2013-01-31');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_periodo", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-02-24 04:11:51.076', NULL, E'activo', 2, 2, 105, E'2013-02-01', E'2013-02-28');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_periodo", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-02-24 04:11:51.076', NULL, E'activo', 3, 3, 105, E'2013-03-01', E'2013-03-31');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_periodo", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-02-24 04:11:51.076', NULL, E'activo', 4, 4, 105, E'2013-04-01', E'2013-04-30');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_periodo", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-02-24 04:11:51.076', NULL, E'activo', 5, 5, 105, E'2013-05-01', E'2013-05-31');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_periodo", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-02-24 04:11:51.076', NULL, E'activo', 6, 6, 105, E'2013-06-01', E'2013-06-30');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_periodo", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-02-24 04:11:51.076', NULL, E'activo', 7, 7, 105, E'2013-07-01', E'2013-07-31');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_periodo", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-02-24 04:11:51.076', NULL, E'activo', 8, 8, 105, E'2013-08-01', E'2013-08-31');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_periodo", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-02-24 04:11:51.076', NULL, E'activo', 9, 9, 105, E'2013-09-01', E'2013-09-30');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_periodo", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-02-24 04:11:51.076', NULL, E'activo', 10, 10, 105, E'2013-10-01', E'2013-10-31');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_periodo", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-02-24 04:11:51.076', NULL, E'activo', 11, 11, 105, E'2013-11-01', E'2013-11-30');

INSERT INTO param.tperiodo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_periodo", "periodo", "id_gestion", "fecha_ini", "fecha_fin")
VALUES (1, NULL, E'2013-02-24 04:11:51.076', NULL, E'activo', 12, 12, 105, E'2013-12-01', E'2013-12-31');

---Temporal

select pxp.f_insert_tgui ('Inventario', 'Inventario', 'INVMAIN', 'si', 1, 'sis_almacenes/vista/inventario/InventarioBase.php', 5, '', 'InventarioBase', 'ALM');
select pxp.f_insert_testructura_gui ('INVMAIN', 'ALMAIN');

select pxp.f_insert_tgui ('Orden Inventario', 'Orden Inventario', 'ORDINV', 'si', 1, 'sis_almacenes/vista/inventario/OrdenInventario.php', 5, '', 'OrdenInventario', 'ALM');
select pxp.f_insert_testructura_gui ('ORDINV', 'ALMAIN');

select pxp.f_insert_tgui ('Ejecucion Inventario', 'Ejecucion Inventario', 'EJEINV', 'si', 1, 'sis_almacenes/vista/inventario/EjecucionInventario.php', 5, '', 'EjecucionInventario', 'ALM');
select pxp.f_insert_testructura_gui ('EJEINV', 'ALMAIN');