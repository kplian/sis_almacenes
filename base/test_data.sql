-- Clasificacion
INSERT INTO alm.tclasificacion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_clasificacion, id_clasificacion_fk, codigo, nombre, descripcion, codigo_largo)
VALUES (1, NULL, '2012-11-13 10:36:14', '2012-11-13 10:36:14', 'activo', 1, NULL, 'EQUIP', 'Equipos', NULL, 'EQUIPOS');

INSERT INTO alm.tclasificacion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_clasificacion, id_clasificacion_fk, codigo, nombre, descripcion, codigo_largo)
VALUES (1, NULL, '2012-11-13 11:29:46', '2012-11-13 11:29:46', 'activo', 3, 1, 'ECOM', 'Equipos de computación', NULL, 'EQUIPOCOMP');

INSERT INTO alm.tclasificacion (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_clasificacion, id_clasificacion_fk, codigo, nombre, descripcion, codigo_largo)
VALUES (1, NULL, '2012-11-13 10:37:30', '2012-11-13 10:37:30', 'activo', 2, 1, 'EQMED', 'Equipos Medicos', NULL, 'EQMEDICOS');


-- Almacen
INSERT INTO alm.talmacen ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_almacen", "codigo", "nombre", "localizacion", "estado")
VALUES (1, 1, E'2012-11-13 09:16:48', E'2013-02-20 20:18:50.233', E'activo', 1, E'ALM01', E'Almacen Cercado', NULL, E'activo');

INSERT INTO alm.talmacen ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_almacen", "codigo", "nombre", "localizacion", "estado")
VALUES (1, 1, E'2012-11-13 10:20:06', E'2013-02-20 20:19:12.300', E'activo', 2, E'ALM02', E'Almacen Aduana Zofraco', NULL, E'inactivo');

-- Almacen Stock

INSERT INTO alm.talmacen_stock ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_almacen_stock", "id_almacen", "id_item", "cantidad_min", "cantidad_alerta_amarilla", "cantidad_alerta_roja", "id_metodo_val")
VALUES (1, NULL, E'2013-02-23 22:59:37.385', NULL, E'activo', 1, 1, 7, '10', '30', '20', 4);

INSERT INTO alm.talmacen_stock ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_almacen_stock", "id_almacen", "id_item", "cantidad_min", "cantidad_alerta_amarilla", "cantidad_alerta_roja", "id_metodo_val")
VALUES (1, NULL, E'2013-02-23 22:59:46.396', NULL, E'activo', 2, 1, 1, '10', '30', '20', 1);

INSERT INTO alm.talmacen_stock ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_almacen_stock", "id_almacen", "id_item", "cantidad_min", "cantidad_alerta_amarilla", "cantidad_alerta_roja", "id_metodo_val")
VALUES (1, NULL, E'2013-02-23 22:59:55.473', NULL, E'activo', 3, 1, 4, '10', '30', '20', 2);


-- Item
INSERT INTO alm.titem (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_item, id_clasificacion, codigo, nombre, descripcion, palabras_clave, codigo_fabrica, observaciones, numero_serie)
VALUES (1, NULL, '2012-11-13 11:31:31', '2012-11-13 11:31:31', 'activo', 1, 2, 'HUM01', 'Humidificador Personal', NULL, NULL, NULL, NULL, NULL);

INSERT INTO alm.titem (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_item, id_clasificacion, codigo, nombre, descripcion, palabras_clave, codigo_fabrica, observaciones, numero_serie)
VALUES (1, NULL, '2012-11-13 11:32:06', '2012-11-13 11:32:06', 'activo', 2, 2, 'ECAR', 'Electrocardiógrafo avanzado pantalla táctil ', NULL, NULL, NULL, NULL, NULL);

INSERT INTO alm.titem (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_item, id_clasificacion, codigo, nombre, descripcion, palabras_clave, codigo_fabrica, observaciones, numero_serie)
VALUES (1, NULL, '2012-11-13 11:36:30', '2012-11-13 11:36:30', 'activo', 3, 3, 'LP001', 'Laptop Dell Latitude i7', 'RAM 8 GB, i7, HDD 750 GB', NULL, NULL, NULL, NULL);

INSERT INTO alm.titem (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_item, id_clasificacion, codigo, nombre, descripcion, palabras_clave, codigo_fabrica, observaciones, numero_serie)
VALUES (1, NULL, '2012-11-13 11:37:38', '2012-11-13 11:37:38', 'activo', 4, 3, 'IP001', 'Ipad 3ra Gen', NULL, NULL, NULL, NULL, NULL);

INSERT INTO alm.titem (id_usuario_reg, id_usuario_mod, fecha_reg, fecha_mod, estado_reg, id_item, id_clasificacion, codigo, nombre, descripcion, palabras_clave, codigo_fabrica, observaciones, numero_serie)
VALUES (1, NULL, '2012-11-13 11:38:14', '2012-11-13 11:38:14', 'activo', 5, 3, 'SW001', 'Switch Juniper SRX A1', NULL, NULL, NULL, NULL, NULL);

INSERT INTO alm.titem ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_item", "id_clasificacion", "codigo", "nombre", "descripcion", "palabras_clave", "codigo_fabrica", "observaciones", "numero_serie")
VALUES (1, NULL, E'2012-12-29 05:30:30.025', E'2012-12-29 05:30:30.025', E'activo', 7, 3, E'', E'Canon Ip1900', E'Impresora multicolor Canon IP 1900', E'IP1900', E'IP1900_s', E'color negro', E'asd579');


-- Movimiento_tipo
INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_tipo", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2013-02-19 19:13:12.927', E'2013-02-19 19:13:12.927', E'activo', 4, E'INCOMP', E'Ingreso por Compra', E'ingreso');

INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_tipo", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2013-02-19 19:13:26.057', E'2013-02-19 19:13:26.057', E'activo', 5, E'SALVENT', E'Salida por Venta', E'salida');

-- Movimiento
INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov")
VALUES (1, NULL, E'2013-02-23 15:37:40.362', E'2013-02-23 15:37:40.362', E'activo', 1, 4, 1, 4, NULL, NULL, E'2013-02-10 00:00:00', NULL, E'', E'', E'finalizado');

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov")
VALUES (1, NULL, E'2013-02-23 16:27:00.379', E'2013-02-23 16:27:00.379', E'activo', 2, 4, 1, 4, NULL, NULL, E'2013-02-11 00:00:00', NULL, E'', E'', E'finalizado');

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov")
VALUES (1, NULL, E'2013-02-23 16:28:18.682', E'2013-02-23 16:28:18.682', E'activo', 3, 5, 1, 4, NULL, NULL, E'2013-02-12 00:00:00', NULL, E'', E'', E'finalizado');

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov")
VALUES (1, NULL, E'2013-02-23 16:38:47.818', E'2013-02-23 16:38:47.818', E'activo', 4, 5, 1, 4, NULL, NULL, E'2013-02-13 00:00:00', NULL, E'', E'', E'finalizado');

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov")
VALUES (1, NULL, E'2013-02-23 16:41:35.130', E'2013-02-23 16:41:35.130', E'activo', 5, 4, 1, 4, NULL, NULL, E'2013-02-14 00:00:00', NULL, E'', E'', E'finalizado');

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov")
VALUES (1, NULL, E'2013-02-23 16:42:42.927', E'2013-02-23 16:42:42.927', E'activo', 6, 4, 1, 4, NULL, NULL, E'2013-02-15 00:00:00', NULL, E'', E'', E'finalizado');

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov")
VALUES (1, NULL, E'2013-02-23 16:44:09.925', E'2013-02-23 16:44:09.925', E'activo', 7, 5, 1, 4, NULL, NULL, E'2013-02-16 00:00:00', NULL, E'', E'', E'finalizado');

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov")
VALUES (1, NULL, E'2013-02-23 16:46:11.740', E'2013-02-23 16:46:11.740', E'activo', 8, 5, 1, 3, NULL, NULL, E'2013-02-17 00:00:00', NULL, E'', E'', E'finalizado');

-- Movimiento_det


INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:10:11.310', E'2013-02-23 16:10:11.310', E'activo', 1, 1, 7, '100', NULL, '80');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:18:24.487', E'2013-02-23 16:18:24.487', E'activo', 2, 1, 1, '100', NULL, '80');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:18:31.546', E'2013-02-23 16:18:31.546', E'activo', 3, 1, 4, '100', NULL, '80');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:27:14.908', E'2013-02-23 16:27:14.908', E'activo', 4, 2, 7, '50', NULL, '70');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:27:20.539', E'2013-02-23 16:27:20.539', E'activo', 5, 2, 1, '50', NULL, '70');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:27:31.803', E'2013-02-23 16:27:31.803', E'activo', 6, 2, 4, '50', NULL, '70');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:28:30.930', E'2013-02-23 16:28:30.930', E'activo', 7, 3, 7, '80', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:28:36.722', E'2013-02-23 16:28:36.722', E'activo', 8, 3, 1, '80', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:28:41.199', E'2013-02-23 16:28:41.199', E'activo', 9, 3, 4, '80', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:39:07.595', E'2013-02-23 16:39:07.595', E'activo', 10, 4, 7, '50', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:39:14.063', E'2013-02-23 16:39:14.063', E'activo', 11, 4, 1, '50', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:39:18.589', E'2013-02-23 16:39:18.589', E'activo', 12, 4, 4, '50', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:41:56.246', E'2013-02-23 16:41:56.246', E'activo', 13, 5, 7, '90', NULL, '90');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:42:03.490', E'2013-02-23 16:42:03.490', E'activo', 14, 5, 1, '90', NULL, '90');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:42:08.539', E'2013-02-23 16:42:08.539', E'activo', 15, 5, 4, '90', NULL, '90');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:43:08.160', E'2013-02-23 16:43:08.160', E'activo', 16, 6, 7, '50', NULL, '70');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:43:28.618', E'2013-02-23 16:43:28.618', E'activo', 17, 6, 1, '50', NULL, '70');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:43:33.886', E'2013-02-23 16:43:33.886', E'activo', 18, 6, 4, '50', NULL, '70');

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:44:46.046', E'2013-02-23 16:44:46.046', E'activo', 19, 7, 7, '50', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:44:52.762', E'2013-02-23 16:44:52.762', E'activo', 20, 7, 1, '50', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:44:58.513', E'2013-02-23 16:44:58.513', E'activo', 21, 7, 4, '50', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:47:08.253', E'2013-02-23 16:47:08.253', E'activo', 23, 8, 1, '20', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, NULL, E'2013-02-23 16:47:13.223', E'2013-02-23 16:47:13.223', E'activo', 24, 8, 4, '20', NULL, NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad", "costo_unitario")
VALUES (1, 1, E'2013-02-23 16:46:56.606', E'2013-02-23 16:47:32.988', E'activo', 22, 8, 7, '20', NULL, NULL);

-- Movimiento_det_valorado


INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, NULL, E'2013-02-23 16:10:11.310', E'2013-02-23 16:10:11.310', E'activo', 1, 1, '100', '80', '100');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, NULL, E'2013-02-23 16:27:14.908', E'2013-02-23 16:27:14.908', E'activo', 4, 4, '50', '70', '50');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:27:31.803', E'2013-02-23 16:36:51.483', E'activo', 6, 6, '50', '70', '0');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:28:30.930', E'2013-02-23 16:36:51.483', E'activo', 7, 7, '80', '76.666667', '80');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:28:36.722', E'2013-02-23 16:36:51.483', E'activo', 8, 8, '80', '80', '80');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:28:41.199', E'2013-02-23 16:36:51.483', E'activo', 9, 9, '50', '70', '50');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, NULL, E'2013-02-23 16:36:51.483', E'2013-02-23 16:36:51.483', E'activo', 10, 9, '30', '80', '30');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:18:24.487', E'2013-02-23 16:39:31.996', E'activo', 2, 2, '100', '80', '0');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:18:31.546', E'2013-02-23 16:39:31.996', E'activo', 3, 3, '100', '80', '20');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:39:07.595', E'2013-02-23 16:39:31.996', E'activo', 11, 10, '50', '76.666666', '50');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:39:14.063', E'2013-02-23 16:39:31.996', E'activo', 12, 11, '20', '80', '20');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, NULL, E'2013-02-23 16:39:31.996', E'2013-02-23 16:39:31.996', E'activo', 14, 11, '30', '70', '30');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:39:18.589', E'2013-02-23 16:39:31.996', E'activo', 13, 12, '50', '80', '50');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, NULL, E'2013-02-23 16:41:56.246', E'2013-02-23 16:41:56.246', E'activo', 15, 13, '90', '90', '90');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, NULL, E'2013-02-23 16:43:08.160', E'2013-02-23 16:43:08.160', E'activo', 18, 16, '50', '70', '50');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, NULL, E'2013-02-23 16:43:28.618', E'2013-02-23 16:43:28.618', E'activo', 19, 17, '50', '70', '50');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:27:20.539', E'2013-02-23 16:45:12.548', E'activo', 5, 5, '50', '70', '0');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:43:33.886', E'2013-02-23 16:45:12.548', E'activo', 20, 18, '50', '70', '0');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:44:46.046', E'2013-02-23 16:45:12.548', E'activo', 21, 19, '50', '82.083333', '50');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:44:52.762', E'2013-02-23 16:45:12.548', E'activo', 22, 20, '20', '70', '20');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, NULL, E'2013-02-23 16:45:12.548', E'2013-02-23 16:45:12.548', E'activo', 24, 20, '30', '90', '30');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:44:58.513', E'2013-02-23 16:45:12.548', E'activo', 23, 21, '50', '70', '50');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:42:03.490', E'2013-02-23 16:47:41.089', E'activo', 16, 14, '90', '90', '40');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:42:08.539', E'2013-02-23 16:47:41.089', E'activo', 17, 15, '90', '90', '70');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:47:08.253', E'2013-02-23 16:47:41.089', E'activo', 26, 23, '20', '90', '20');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:47:13.223', E'2013-02-23 16:47:41.089', E'activo', 27, 24, '20', '90', '20');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo_fisico")
VALUES (1, 1, E'2013-02-23 16:46:56.606', E'2013-02-23 16:47:41.089', E'activo', 25, 22, '20', '82.083334', '20');

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

