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
VALUES (1, NULL, E'2013-02-19 19:13:12.927', E'2013-02-19 19:13:12.927', E'activo', 3, E'INCOMP', E'Ingreso por Compra', E'ingreso');

INSERT INTO alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_tipo", "codigo", "nombre", "tipo")
VALUES (1, NULL, E'2013-02-19 19:13:26.057', E'2013-02-19 19:13:26.057', E'activo', 4, E'SALVENT', E'Salida por Venta', E'salida');

-- Movimiento

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov")
VALUES (1, NULL, E'2013-02-22 10:22:13.178', E'2013-02-22 10:22:13.178', E'activo', 1, 3, 1, 3, 1, NULL, E'2013-02-17 00:00:00', NULL, E'1er mov', E'', E'finalizado');

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov")
VALUES (1, NULL, E'2013-02-22 10:22:30.699', E'2013-02-22 10:22:30.699', E'activo', 2, 3, 1, 3, NULL, NULL, E'2013-02-18 00:00:00', NULL, E'2do mov', E'', E'finalizado');

INSERT INTO alm.tmovimiento ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento", "id_movimiento_tipo", "id_almacen", "id_funcionario", "id_proveedor", "id_almacen_dest", "fecha_mov", "codigo", "descripcion", "observaciones", "estado_mov")
VALUES (1, NULL, E'2013-02-22 10:22:49.990', E'2013-02-22 10:22:49.990', E'activo', 3, 3, 1, 1, NULL, NULL, E'2013-02-19 00:00:00', NULL, E'3er mov.', E'', E'finalizado');

-- Movimiento_det

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad")
VALUES (1, NULL, E'2013-02-22 10:23:09.359', E'2013-02-22 10:23:09.359', E'activo', 1, 1, 7, '100', NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad")
VALUES (1, NULL, E'2013-02-22 10:24:14.151', E'2013-02-22 10:24:14.151', E'activo', 2, 2, 7, '50', NULL);

INSERT INTO alm.tmovimiento_det ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det", "id_movimiento", "id_item", "cantidad", "fecha_caducidad")
VALUES (1, NULL, E'2013-02-22 10:24:55.165', E'2013-02-22 10:24:55.165', E'activo', 3, 3, 7, '40', NULL);

-- Movimiento_det_valorado

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo")
VALUES (1, NULL, E'2013-02-22 10:23:09.359', E'2013-02-22 10:23:09.359', E'activo', 1, 1, 100, '10', '100');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo")
VALUES (1, NULL, E'2013-02-22 10:24:14.151', E'2013-02-22 10:24:14.151', E'activo', 2, 2, 50, '15', '50');

INSERT INTO alm.tmovimiento_det_valorado ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "id_movimiento_det_valorado", "id_movimiento_det", "cantidad", "costo_unitario", "aux_saldo")
VALUES (1, NULL, E'2013-02-22 10:24:55.165', E'2013-02-22 10:24:55.165', E'activo', 3, 3, 40, '12', '40');

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

