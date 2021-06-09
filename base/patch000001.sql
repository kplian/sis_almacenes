/***********************************I-SCP-JRR-ALM-1-19/11/2012****************************************/
/*
*	Author: JRR
*	Date: 11/2012
*	Description: Build the menu definition and composition
*/
--
-- Structure for table tclasificacion (OID = 688286) :
--

CREATE TABLE alm.tclasificacion (
    id_clasificacion serial NOT NULL,
    id_clasificacion_fk integer,
    codigo varchar(20),
    nombre varchar(200),
    descripcion varchar(1000),
    codigo_largo varchar(20),
    CONSTRAINT pk_tclasificacion__id_clasificacion
    PRIMARY KEY (id_clasificacion)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table talmacen (OID = 688562) :
--
CREATE TABLE alm.talmacen (
    id_almacen serial NOT NULL,
    codigo varchar(10),
    nombre varchar(100),
    localizacion varchar(100),
    CONSTRAINT pk_talmacen__id_almacen PRIMARY KEY (id_almacen)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table titem (OID = 688573) :
--
CREATE TABLE alm.titem (
    id_item serial NOT NULL,
    id_clasificacion integer,
    codigo varchar(20),
    nombre varchar(100),
    descripcion varchar(1000),
    palabras_clave varchar(1000),
    codigo_fabrica varchar(100),
    observaciones varchar(1000),
    numero_serie varchar(100),
    CONSTRAINT pk_titem__id_item PRIMARY KEY (id_item)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table talmacen_stock (OID = 688592) :
--
CREATE TABLE alm.talmacen_stock (
    id_almacen_stock serial NOT NULL,
    id_almacen integer NOT NULL,
    id_item integer,
    cantidad_min numeric(18,2),
    cantidad_alerta_amarilla numeric(18,2),
    cantidad_alerta_roja numeric(18,2),
    CONSTRAINT pk_talmacen_stock__id_almacen_stock PRIMARY KEY (id_almacen_stock)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table tmovimiento_tipo (OID = 688613) :
--
CREATE TABLE alm.tmovimiento_tipo (
    id_movimiento_tipo serial NOT NULL,
    codigo varchar(20),
    nombre varchar(100),
    CONSTRAINT pk_tmovimiento_tipo__id_movimiento_tipo
    PRIMARY KEY (id_movimiento_tipo)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table tmovimiento (OID = 688624) :
--
CREATE TABLE alm.tmovimiento (
    id_movimiento serial NOT NULL,
    id_movimiento_tipo integer,
    id_almacen integer,
    id_funcionario integer,
    id_proveedor integer,
    id_almacen_dest integer,
    fecha_mov timestamp without time zone,
    numero_mov varchar(30),
    descripcion varchar(1000),
    observaciones varchar(1000),
    estado_mov varchar(10),
    CONSTRAINT pk_tmovimiento__id_movimiento PRIMARY KEY (id_movimiento)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table tmovimiento_det (OID = 785635) :
--
CREATE TABLE alm.tmovimiento_det (
    id_movimiento_det serial NOT NULL,
    id_movimiento integer,
    id_item integer,
    cantidad numeric(18,6),
    costo_unitario numeric(18,6),
    fecha_caducidad date,
    CONSTRAINT pk_tmovimiento_det__id_movimiento_det PRIMARY KEY (id_movimiento_det)
)
INHERITS (pxp.tbase) WITHOUT OIDS;


CREATE TABLE alm.talmacen_usuario (
  id_almacen_usuario SERIAL,
  id_usuario INTEGER,
  CONSTRAINT pk_talmacen_usuario__id_almacen_usuario PRIMARY KEY(id_almacen_usuario)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE alm.talmacen
  ADD COLUMN id_almacen_usuario INTEGER;


CREATE TABLE alm.talmacen_correlativo (
  id_almacen_correl SERIAL,
  id_almacen INTEGER,
  id_movimiento_tipo INTEGER,
  periodo VARCHAR,
  correl_act INTEGER DEFAULT 0,
  correl_sig INTEGER DEFAULT 1,
  CONSTRAINT pk_talmacen_correlativo__id_almacen_correl PRIMARY KEY(id_almacen_correl)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

/***********************************F-SCP-JRR-ALM-1-19/11/2012****************************************/

/***********************************I-SCP-AAO-ALM-16-05/02/2013****************************************/
ALTER TABLE alm.titem
  ADD COLUMN num_por_clasificacion INTEGER;
/***********************************F-SCP-AAO-ALM-16-05/02/2013****************************************/

/***********************************I-SCP-AAO-ALM-16_2-05/02/2013****************************************/
ALTER TABLE alm.tclasificacion
  ADD COLUMN estado VARCHAR(20);
/***********************************F-SCP-AAO-ALM-16_2-05/02/2013****************************************/

/***********************************I-SCP-AAO-ALM-12-06/02/2013****************************************/
ALTER TABLE alm.talmacen_usuario
  ADD COLUMN tipo VARCHAR(20);

ALTER TABLE alm.talmacen_usuario
  ADD COLUMN id_almacen INTEGER;
/***********************************F-SCP-AAO-ALM-12-06/02/2013****************************************/

/***********************************I-SCP-AAO-ALM-14-06/02/2013****************************************/
CREATE TABLE alm.titem_reemplazo (
  id_item_reemplazo SERIAL NOT NULL,
  id_item INTEGER,
  id_item_r INTEGER,
  PRIMARY KEY(id_item_reemplazo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE alm.titem_reemplazo
  OWNER TO postgres;
/***********************************F-SCP-AAO-ALM-14-06/02/2013****************************************/

/***********************************I-SCP-AAO-ALM-15-06/02/2013****************************************/
CREATE TABLE alm.titem_archivo (
  id_item_archivo SERIAL NOT NULL,
  nombre VARCHAR(50),
  descripcion VARCHAR(150),
  extension VARCHAR(10),
  archivo BYTEA,
  id_item INTEGER,
  PRIMARY KEY(id_item_archivo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE alm.titem_archivo
  OWNER TO postgres;
/***********************************F-SCP-AAO-ALM-15-06/02/2013****************************************/

/***********************************I-SCP-AAO-ALM-23-13/02/2013****************************************/

ALTER TABLE alm.talmacen
  ADD COLUMN estado VARCHAR(15);
/***********************************F-SCP-AAO-ALM-23-13/02/2013****************************************/

/***********************************I-SCP-AAO-ALM-19-13/02/2013****************************************/

ALTER TABLE alm.tmovimiento_tipo
  ADD COLUMN tipo VARCHAR(25);
/***********************************F-SCP-AAO-ALM-19-13/02/2013****************************************/

/***********************************I-SCP-AAO-ALM-24-14/02/2013****************************************/

CREATE TABLE alm.tmetodo_val (
  id_metodo_val SERIAL NOT NULL,
  codigo VARCHAR(20),
  nombre VARCHAR(50),
  descripcion VARCHAR(150),
  PRIMARY KEY(id_metodo_val)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE alm.talmacen_stock
  ADD COLUMN id_metodo_val INTEGER;
/***********************************F-SCP-AAO-ALM-24-14/02/2013****************************************/

/***********************************I-SCP-AAO-ALM-20-15/02/2013****************************************/
ALTER TABLE alm.tmovimiento
  RENAME COLUMN numero_mov TO codigo;
/***********************************F-SCP-AAO-ALM-20-15/02/2013****************************************/

/***********************************I-SCP-AAO-ALM-25-21/02/2013****************************************/
ALTER TABLE alm.tmovimiento_det
  DROP COLUMN costo_unitario;

CREATE TABLE alm.tmovimiento_det_valorado (
  id_movimiento_det_valorado SERIAL NOT NULL,
  id_movimiento_det INTEGER,
  cantidad NUMERIC(18,6),
  costo_unitario NUMERIC(18,6),
  aux_saldo_fisico NUMERIC(18,6),
  PRIMARY KEY(id_movimiento_det_valorado)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE alm.tmovimiento_det_valorado
  OWNER TO postgres;
/***********************************F-SCP-AAO-ALM-25-21/02/2013****************************************/

/***********************************I-SCP-AAO-ALM-33-21/02/2013****************************************/
ALTER TABLE alm.tmovimiento_det
  ADD COLUMN costo_unitario NUMERIC(18,6);
/***********************************F-SCP-AAO-ALM-33-21/02/2013****************************************/

/***********************************I-SCP-AAO-ALM-31-23/02/2013****************************************/
ALTER TABLE alm.tmovimiento
  ADD COLUMN id_movimiento_dest INTEGER;
/***********************************F-SCP-AAO-ALM-31-23/02/2013****************************************/

/***********************************I-SCP-AAO-ALM-26-25/02/2013****************************************/
ALTER TABLE alm.talmacen
  ADD COLUMN id_departamento INTEGER;
/***********************************F-SCP-AAO-ALM-26-25/02/2013****************************************/

/***********************************I-SCP-AAO-ALM-29-25/02/2013****************************************/
ALTER TABLE alm.tmovimiento
  RENAME COLUMN id_movimiento_dest TO id_movimiento_origen;
/***********************************F-SCP-AAO-ALM-29-25/02/2013****************************************/

/***********************************I-SCP-AAO-ALM-28-26/02/2013****************************************/
ALTER TABLE alm.tmovimiento_det_valorado
  ADD COLUMN id_mov_det_val_origen INTEGER;
/***********************************F-SCP-AAO-ALM-28-26/02/2013****************************************/

/***********************************I-SCP-AAO-ALM-34-01/03/2013****************************************/
ALTER TABLE alm.titem
  ADD COLUMN id_unidad_medida INTEGER;
/***********************************F-SCP-AAO-ALM-34-01/03/2013****************************************/

/***********************************I-SCP-AAO-ALM-35-04/03/2013****************************************/
ALTER TABLE alm.talmacen
  ALTER COLUMN codigo TYPE VARCHAR(20);

ALTER TABLE alm.titem
  ALTER COLUMN codigo TYPE VARCHAR(30);
/***********************************F-SCP-AAO-ALM-35-04/03/2013****************************************/

/***********************************I-SCP-AAO-ALM-41-05/03/2013*****************************************/
ALTER TABLE alm.titem_archivo
  ALTER COLUMN descripcion TYPE VARCHAR(1000);

ALTER TABLE alm.tmetodo_val
  ALTER COLUMN descripcion TYPE VARCHAR(1000);
/***********************************F-SCP-AAO-ALM-41-05/03/2013*****************************************/

/***********************************I-SCP-AAO-ALM-60-14/03/2013*****************************************/
ALTER TABLE alm.tmovimiento_tipo
  ADD COLUMN read_only BOOLEAN;

ALTER TABLE alm.tmovimiento_tipo
  ALTER COLUMN read_only SET DEFAULT FALSE;

ALTER TABLE alm.tmetodo_val
  ADD COLUMN read_only BOOLEAN;

ALTER TABLE alm.tmetodo_val
  ALTER COLUMN read_only SET DEFAULT FALSE;
/***********************************F-SCP-AAO-ALM-60-14/03/2013*****************************************/

/***********************************I-SCP-AAO-ALM-45-14/03/2013*****************************************/
CREATE TABLE alm.tinventario (
  id_inventario SERIAL,
  id_almacen INTEGER NOT NULL,
  id_usuario_resp INTEGER NOT NULL,
  fecha_inv_planif TIMESTAMP WITHOUT TIME ZONE,
  fecha_inv_ejec TIMESTAMP WITHOUT TIME ZONE,
  observaciones VARCHAR(1000),
  completo VARCHAR(2) NOT NULL,
  estado VARCHAR(20),
  CONSTRAINT tinventario_pkey PRIMARY KEY(id_inventario)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE alm.tinventario
  OWNER TO postgres;
/***********************************F-SCP-AAO-ALM-45-14/03/2013*****************************************/

/***********************************I-SCP-AAO-ALM-45-15/03/2013*****************************************/

CREATE TABLE alm.tinventario_det (
  id_inventario_det SERIAL NOT NULL,
  id_inventario INTEGER,
  id_item INTEGER,
  cantidad_sistema NUMERIC(18,2),
  cantidad_real NUMERIC(18,2),
  diferencia NUMERIC(18,2),
  observaciones VARCHAR(1000),
  PRIMARY KEY(id_inventario_det)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE alm.tinventario_det
  OWNER TO postgres;

/***********************************F-SCP-AAO-ALM-45-15/03/2013*****************************************/

/***********************************I-SCP-AAO-ALM-9-18/03/2013*****************************************/

ALTER TABLE alm.talmacen_stock
  ALTER COLUMN id_item SET NOT NULL;

ALTER TABLE alm.titem_reemplazo
  ALTER COLUMN id_item SET NOT NULL;

ALTER TABLE alm.titem_reemplazo
  ALTER COLUMN id_item_r SET NOT NULL;

ALTER TABLE alm.tmovimiento_det
  ALTER COLUMN id_item SET NOT NULL;
/***********************************F-SCP-AAO-ALM-9-18/03/2013*****************************************/

/***********************************I-SCP-AAO-ALM-70-21/03/2013*****************************************/
ALTER TABLE alm.tmovimiento_det
  ADD COLUMN cantidad_solicitada numeric(18,6);
/***********************************F-SCP-AAO-ALM-70-21/03/2013*****************************************/

/***********************************I-SCP-RCM-ALM-79-19/06/2013*****************************************/
CREATE TABLE alm.tperiodo(
	id_periodo serial not null,
	periodo date,
	fecha_ini date,
	fecha_fin date,
	CONSTRAINT tperiodo__id_periodo PRIMARY KEY(id_periodo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE alm.tperiodo_log(
	id_periodo_log serial not null,
	id_periodo integer not null,
	estado_reg_ant varchar(15),
	CONSTRAINT tperiodo_log__id_periodo_log PRIMARY KEY(id_periodo_log)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
/***********************************F-SCP-RCM-ALM-79-19/06/2013*****************************************/

/***********************************I-SCP-GSS-ALM-69-05/07/2013*****************************************/

ALTER TABLE alm.tmovimiento
  ADD COLUMN id_proceso_macro INTEGER;

ALTER TABLE alm.tmovimiento
  ADD COLUMN id_estado_wf INTEGER;

ALTER TABLE alm.tmovimiento
  ADD COLUMN id_proceso_wf INTEGER;

ALTER TABLE alm.tmovimiento_tipo
  ADD COLUMN id_proceso_macro INTEGER;

/***********************************F-SCP-GSS-ALM-69-05/07/2013*****************************************/

/***********************************I-SCP-RCM-ALM-82-18/07/2013*****************************************/
CREATE TABLE alm.tpreingreso(
	id_preingreso serial not null,
	id_cotizacion integer not null,
	id_almacen integer,
	CONSTRAINT tpreingreso__id_preingreso PRIMARY KEY(id_preingreso)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE alm.tpreingreso_det(
	id_preingreso_det serial not null,
	id_preingreso integer not null,
	id_cotizacion_det integer,
	id_item integer,
	id_almacen integer,
	cantidad numeric(18,2),
	precio_compra numeric(18,2),
	CONSTRAINT tpreingreso_det__id_preingreso_det PRIMARY KEY(id_preingreso_det)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE alm.titem_concepto(
	id_item_concepto serial not null,
	id_item integer not null,
	id_concepto_ingas integer not null,
	CONSTRAINT titem_concepto__id_item_concepto PRIMARY KEY(id_item_concepto)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
/***********************************F-SCP-RCM-ALM-82-18/07/2013*****************************************/

/***********************************I-SCP-GSS-ALM-90-25/07/2013*****************************************/

ALTER TABLE alm.tmovimiento_det
  ADD COLUMN observaciones VARCHAR(1000);

/***********************************F-SCP-GSS-ALM-90-25/07/2013*****************************************/

/***********************************I-SCP-GSS-ALM-86-26/07/2013*****************************************/

ALTER TABLE alm.tinventario
  ADD COLUMN id_usuario_asis INTEGER;

/***********************************F-SCP-GSS-ALM-86-26/07/2013*****************************************/


/***********************************I-SCP-GSS-ALM-87-26/07/2013*****************************************/

CREATE TABLE alm.tmovimiento_tipo_item (
  id_movimiento_tipo_item SERIAL,
  id_movimiento_tipo INTEGER,
  id_item INTEGER,
  CONSTRAINT pk_tmovimiento_tipo_item__id_movimiento_tipo_item PRIMARY KEY(id_movimiento_tipo_item)
) INHERITS(pxp.tbase)
WITHOUT OIDS;

/***********************************F-SCP-GSS-ALM-87-26/07/2013*****************************************/

/***********************************I-SCP-RCM-ALM-87-21/08/2013*****************************************/
alter table alm.tmovimiento_tipo_item
add column id_clasificacion integer;
/***********************************F-SCP-RCM-ALM-87-21/08/2013*****************************************/

/***********************************I-SCP-RCM-ALM-95-22/08/2013*****************************************/
CREATE TABLE alm.tmovimiento_tipo_uo (
  id_movimiento_tipo_uo SERIAL,
  id_movimiento_tipo INTEGER,
  id_uo INTEGER,
  CONSTRAINT pk_tmovimiento_tipo_uo__id_movimiento_tipo_uo PRIMARY KEY(id_movimiento_tipo_uo)
) INHERITS(pxp.tbase)
WITHOUT OIDS;
/***********************************F-SCP-RCM-ALM-95-22/08/2013*****************************************/

/***********************************I-SCP-RCM-ALM-82-01/10/2013*****************************************/
ALTER TABLE alm.tpreingreso
  ADD COLUMN id_depto INTEGER;
ALTER TABLE alm.tpreingreso
  ADD COLUMN id_estado_wf INTEGER;
ALTER TABLE alm.tpreingreso
  ADD COLUMN id_proceso_wf INTEGER;
ALTER TABLE alm.tpreingreso
  ADD COLUMN estado varchar(50);
ALTER TABLE alm.tpreingreso
  ADD COLUMN id_moneda INTEGER;

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN id_depto INTEGER;

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN id_clasificacion INTEGER;

CREATE TABLE alm.titem_clasif_ingas (
  id_item_clasif_ingas SERIAL,
  id_concepto_ingas INTEGER,
  id_item INTEGER,
  id_clasificacion INTEGER,
  contador integer,
  CONSTRAINT pk_titem_clasif_ingas__id_item_clasif_ingas PRIMARY KEY(id_item_clasif_ingas)
) INHERITS(pxp.tbase)
WITHOUT OIDS;

drop table alm.titem_concepto;

ALTER TABLE alm.tpreingreso
  ADD COLUMN tipo VARCHAR(15) NOT NULL;

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN sw_generar VARCHAR(2);

ALTER TABLE alm.tpreingreso_det
  ALTER COLUMN sw_generar SET DEFAULT 'no';

ALTER TABLE alm.tpreingreso
  ADD COLUMN descripcion VARCHAR(1000);

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN observaciones VARCHAR(1000);

ALTER TABLE alm.tmovimiento
  ADD COLUMN id_preingreso INTEGER;

  ALTER TABLE alm.tpreingreso_det
  RENAME COLUMN cantidad TO cantidad_det;
/***********************************F-SCP-RCM-ALM-82-01/10/2013*****************************************/

/***********************************I-SCP-RCM-ALM-0-10/10/2013*****************************************/
alter table alm.titem
add column precio_ref numeric(18,2);

alter table alm.titem
add column id_moneda integer;

/***********************************F-SCP-RCM-ALM-0-10/10/2013*****************************************/

/***********************************I-SCP-RCM-ALM-0-17/10/2013*****************************************/
CREATE TABLE alm.tsalida_grupo (
  id_salida_grupo SERIAL,
  id_almacen integer,
  id_movimiento_tipo integer,
  descripcion varchar(1000),
  observaciones varchar(1000),
  estado varchar(15),
  fecha date,
  CONSTRAINT pk_tsalida_grupo__id_salida_grupo PRIMARY KEY(id_salida_grupo)
) INHERITS(pxp.tbase)
WITHOUT OIDS;

CREATE TABLE alm.tsalida_grupo_item (
  id_salida_grupo_item SERIAL,
  id_salida_grupo integer,
  id_item integer,
  cantidad_sol numeric(18,2),
  observaciones varchar(1000),
  CONSTRAINT pk_tsalida_grupo_item__id_salida_grupo_item PRIMARY KEY(id_salida_grupo_item)
) INHERITS(pxp.tbase)
WITHOUT OIDS;

CREATE TABLE alm.tsalida_grupo_fun (
  id_salida_grupo_fun SERIAL,
  id_salida_grupo_item integer,
  id_funcionario integer,
  cantidad_sol numeric(18,2),
  observaciones varchar(1000),
  CONSTRAINT pk_tsalida_grupo_fun__id_salida_grupo_fun PRIMARY KEY(id_salida_grupo_fun),
  CONSTRAINT uq_tsalida_grupo_fun__id_funcionario UNIQUE (id_salida_grupo_item,id_funcionario)
) INHERITS(pxp.tbase)
WITHOUT OIDS;

alter table alm.tmovimiento
add column id_salida_grupo integer;

alter table alm.tmovimiento
add column id_int_comprobante integer;

CREATE TABLE alm.tmovimiento_grupo (
  id_movimiento_grupo SERIAL,
  id_almacen integer,
  id_int_comprobante integer,
  id_depto_conta INTEGER,
  descripcion varchar(1000),
  estado varchar(15),
  fecha_ini date,
  fecha_fin date,
  CONSTRAINT pk_tmovimiento_grupo__id_movimiento_grupo PRIMARY KEY(id_movimiento_grupo)
) INHERITS(pxp.tbase)
WITHOUT OIDS;

CREATE TABLE alm.tmovimiento_grupo_det (
  id_movimiento_grupo_det SERIAL,
  id_movimiento_grupo integer,
  id_movimiento integer,
  CONSTRAINT pk_tmovimiento_grupo_det__id_movimiento_grupo_det PRIMARY KEY(id_movimiento_grupo_det)
) INHERITS(pxp.tbase)
WITHOUT OIDS;

alter table alm.tpreingreso
add column id_depto_conta integer;

ALTER TABLE alm.tmovimiento
  ALTER COLUMN estado_mov TYPE VARCHAR(20);
/***********************************F-SCP-RCM-ALM-0-17/10/2013*****************************************/

/***********************************I-SCP-RCM-ALM-0-31/10/2013*****************************************/
ALTER TABLE alm.tmovimiento
  ADD COLUMN id_depto_conta integer;
ALTER TABLE alm.tmovimiento_det
  ADD COLUMN id_concepto_ingas integer;

/***********************************F-SCP-RCM-ALM-0-31/10/2013*****************************************/

/***********************************I-SCP-RCM-ALM-0-20/11/2013*****************************************/
ALTER TABLE alm.tmovimiento
  ALTER COLUMN fecha_mod DROP DEFAULT;
/***********************************F-SCP-RCM-ALM-0-20/11/2013*****************************************/

/***********************************I-SCP-RCM-ALM-0-30/12/2013*****************************************/
CREATE TABLE alm.talmacen_gestion (
  id_almacen_gestion SERIAL,
  id_almacen INTEGER,
  id_gestion INTEGER,
  estado VARCHAR,
  PRIMARY KEY(id_almacen_gestion)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
/***********************************F-SCP-RCM-ALM-0-30/12/2013*****************************************/

/***********************************I-SCP-RCM-ALM-0-31/12/2013*****************************************/
CREATE TABLE alm.talmacen_gestion_log (
  id_almacen_gestion_log SERIAL,
  id_almacen_gestion INTEGER,
  estado VARCHAR,
  PRIMARY KEY(id_almacen_gestion_log)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

alter table alm.talmacen_gestion
add constraint uq_talmacen_gestion__id_almacen__id_gestion unique (id_almacen,id_gestion);

ALTER TABLE alm.tmovimiento
  ADD COLUMN id_almacen_gestion_log INTEGER;
/***********************************F-SCP-RCM-ALM-0-31/12/2013*****************************************/

/***********************************I-SCP-JRR-ALM-0-21/03/2015*****************************************/

ALTER TABLE alm.tmovimiento_det
  ADD COLUMN id_movimiento_det_ingreso INTEGER;

/***********************************F-SCP-JRR-ALM-0-21/03/2015*****************************************/

/***********************************I-SCP-RCM-ALM-0-03/05/2015*****************************************/
ALTER TABLE alm.tpreingreso_det
  ADD COLUMN estado VARCHAR(10);
COMMENT ON COLUMN alm.tpreingreso_det.estado
IS 'Indica si el registro es creado desde adquisiciones al generar el preingreso (''orig''), si es modificado desde preingreso (''mod'')';
/***********************************F-SCP-RCM-ALM-0-03/05/2015*****************************************/

/***********************************I-SCP-JRR-ALM-0-04/08/2015*****************************************/
ALTER TABLE alm.tpreingreso_det
  ADD COLUMN nombre VARCHAR(255);

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN descripcion TEXT;

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN precio_compra_87 NUMERIC(18,2);

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN id_lugar INTEGER;

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN ubicacion VARCHAR(255);

/***********************************F-SCP-JRR-ALM-0-04/08/2015*****************************************/

/***********************************I-SCP-JRR-ALM-0-11/08/2015*****************************************/

ALTER TABLE alm.tpreingreso
  ADD COLUMN c31 VARCHAR(50);

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN c31 VARCHAR(50);

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN fecha_conformidad DATE;


/***********************************F-SCP-JRR-ALM-0-11/08/2015*****************************************/


/***********************************I-SCP-JRR-ALM-0-16/09/2015*****************************************/

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN fecha_compra DATE;

/***********************************F-SCP-JRR-ALM-0-16/09/2015*****************************************/


/***********************************I-SCP-JRR-ALM-0-08/10/2015*****************************************/

ALTER TABLE alm.talmacen
  ADD COLUMN id_metodo_val INTEGER;

/***********************************F-SCP-JRR-ALM-0-08/10/2015*****************************************/

/***********************************I-SCP-JRR-ALM-0-23/06/2016*****************************************/

CREATE TYPE alm.detalle_movimiento AS (
  codigo_item VARCHAR(50),
  cantidad NUMERIC(18,6)
);

/***********************************F-SCP-JRR-ALM-0-23/06/2016*****************************************/

/***********************************I-SCP-GSS-ALM-1-13/07/2016*****************************************/

CREATE TABLE alm.tmovimiento_tipo_almacen (
  id_movimiento_tipo_almacen SERIAL,
  id_movimiento_tipo INTEGER NOT NULL,
  id_almacen INTEGER NOT NULL,
  PRIMARY KEY(id_movimiento_tipo_almacen)
) INHERITS (pxp.tbase) WITHOUT OIDS;

/***********************************F-SCP-GSS-ALM-1-13/07/2016*****************************************/


/***********************************I-SCP-GSS-ALM-1-14/11/2016*****************************************/

ALTER TABLE alm.titem
  ADD COLUMN cantidad_max_sol INTEGER;

COMMENT ON COLUMN alm.titem.cantidad_max_sol
IS 'cantidad maxima por solicitud';

/***********************************F-SCP-GSS-ALM-1-14/11/2016*****************************************/




/***********************************I-SCP-RAC-ALM-1-14/04/2017*****************************************/


--------------- SQL --------------- se olvidaron agregar esta columna

--------------- SQL ---------------

ALTER TABLE alm.tmovimiento
  ADD COLUMN comail INTEGER;

  --------------- SQL ---------------

ALTER TABLE alm.tmovimiento
  ADD COLUMN fecha_salida DATE;


/***********************************F-SCP-RAC-ALM-1-14/04/2017*****************************************/

/***********************************I-SCP-RCM-ALM-1-17/07/2018*****************************************/
ALTER TABLE alm.tpreingreso_det
  ADD COLUMN id_centro_costo INTEGER;

COMMENT ON COLUMN alm.tpreingreso_det.id_centro_costo
IS 'Centro de costo, caso activos fijos: usado para la depreciación';

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN id_ubicacion INTEGER;

COMMENT ON COLUMN alm.tpreingreso_det.id_ubicacion
IS 'Ubicación Activos Fijos';

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN id_grupo INTEGER;

COMMENT ON COLUMN alm.tpreingreso_det.id_grupo
IS 'Agrupador AE para caso activos fijos';

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN id_grupo_clasif INTEGER;

COMMENT ON COLUMN alm.tpreingreso_det.id_grupo_clasif
IS 'Clasificador AE para caso activos fijos';

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN nro_serie VARCHAR(50);

COMMENT ON COLUMN alm.tpreingreso_det.nro_serie
IS 'Número de serie del activo fijo';

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN marca VARCHAR(200);

COMMENT ON COLUMN alm.tpreingreso_det.marca
IS 'Marca del activo fijo';

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN generado VARCHAR(2) DEFAULT 'si' NOT NULL;

COMMENT ON COLUMN alm.tpreingreso_det.generado
IS 'Bandera que define si el registro fue generado por el sistema o fue registrado manualmente';

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN tipo_reg VARCHAR(10) DEFAULT 'normal' NOT NULL;

COMMENT ON COLUMN alm.tpreingreso_det.tipo_reg
IS 'Define el tipo del registro, Normal (normal) o si fue Desglosado (desglose)';

ALTER TABLE alm.tpreingreso_det
  ADD COLUMN id_preingreso_det_padre INTEGER;

COMMENT ON COLUMN alm.tpreingreso_det.id_preingreso_det_padre
IS 'Id del pasdre del registro cuando se haga un desglose';
/***********************************F-SCP-RCM-ALM-1-17/07/2018*****************************************/

/***********************************I-SCP-RCM-ALM-1-05/09/2018*****************************************/
ALTER TABLE alm.tpreingreso_det
  ADD COLUMN vida_util INTEGER;

COMMENT ON COLUMN alm.tpreingreso_det.vida_util
IS 'Vida util en meses';
/***********************************F-SCP-RCM-ALM-1-05/09/2018*****************************************/
 
/***********************************I-DAT-RCM-ALM-ETR-4195-09/06/2021****************************************/
 ALTER TABLE alm.tpreingreso_det ALTER COLUMN generado SET DEFAULT 'no'::character varying;
/***********************************F-DAT-RCM-ALM-ETR-4195-09/06/2021****************************************/