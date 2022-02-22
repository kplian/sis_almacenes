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
    estado VARCHAR(20),
    CONSTRAINT pk_tclasificacion__id_clasificacion
    PRIMARY KEY (id_clasificacion)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table talmacen (OID = 688562) :
--
CREATE TABLE alm.talmacen (
    id_almacen serial NOT NULL,
    codigo varchar(20),
    nombre varchar(100),
    localizacion varchar(100),
    estado VARCHAR(15),
    id_departamento INTEGER,
    id_metodo_val INTEGER,
    CONSTRAINT pk_talmacen__id_almacen PRIMARY KEY (id_almacen)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

--
-- Structure for table titem (OID = 688573) :
--
CREATE TABLE alm.titem (
    id_item serial NOT NULL,
    id_clasificacion integer,
    codigo varchar(30),
    nombre varchar(100),
    descripcion varchar(1000),
    palabras_clave varchar(1000),
    codigo_fabrica varchar(100),
    observaciones varchar(1000),
    numero_serie varchar(100),
    num_por_clasificacion INTEGER,
    id_unidad_medida INTEGER,
    precio_ref numeric(18,2),
    id_moneda integer,
    cantidad_max_sol INTEGER,
    CONSTRAINT pk_titem__id_item PRIMARY KEY (id_item)
)
INHERITS (pxp.tbase) WITHOUT OIDS;

COMMENT ON COLUMN alm.titem.cantidad_max_sol
IS 'cantidad maxima por solicitud';

--
-- Structure for table talmacen_stock (OID = 688592) :
--
CREATE TABLE alm.talmacen_stock (
    id_almacen_stock serial NOT NULL,
    id_almacen integer NOT NULL,
    id_item integer NOT NULL,
    cantidad_min numeric(18,2),
    cantidad_alerta_amarilla numeric(18,2),
    cantidad_alerta_roja numeric(18,2),
    id_metodo_val INTEGER,
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
    tipo VARCHAR(25),
    read_only BOOLEAN DEFAULT FALSE,
    id_proceso_macro INTEGER,
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
    codigo varchar(30),
    descripcion varchar(1000),
    observaciones varchar(1000),
    estado_mov varchar(20),
    id_movimiento_origen INTEGER,
    id_proceso_macro INTEGER,
    id_estado_wf INTEGER,
    id_proceso_wf INTEGER,
    id_preingreso INTEGER,
    id_salida_grupo integer,
    id_int_comprobante integer,
    id_depto_conta integer,
    id_almacen_gestion_log INTEGER,
    comail INTEGER,
    fecha_salida DATE,
    CONSTRAINT pk_tmovimiento__id_movimiento PRIMARY KEY (id_movimiento)
)
INHERITS (pxp.tbase) WITHOUT OIDS;


ALTER TABLE alm.tmovimiento
  ALTER COLUMN fecha_mod DROP DEFAULT;
--
-- Structure for table tmovimiento_det (OID = 785635) :
--
CREATE TABLE alm.tmovimiento_det (
    id_movimiento_det serial NOT NULL,
    id_movimiento integer,
    id_item integer not null,
    cantidad numeric(18,6),
    fecha_caducidad date,
    costo_unitario NUMERIC(18,6),
    cantidad_solicitada numeric(18,6),
    observaciones VARCHAR(1000),
    id_concepto_ingas integer,
    id_movimiento_det_ingreso INTEGER,

    CONSTRAINT pk_tmovimiento_det__id_movimiento_det PRIMARY KEY (id_movimiento_det)
)
INHERITS (pxp.tbase) WITHOUT OIDS;


CREATE TABLE alm.talmacen_usuario (
  id_almacen_usuario SERIAL,
  id_usuario INTEGER,
  tipo VARCHAR(20),
  id_almacen INTEGER,
  CONSTRAINT pk_talmacen_usuario__id_almacen_usuario PRIMARY KEY(id_almacen_usuario)
) INHERITS (pxp.tbase)
WITHOUT OIDS;



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



/***********************************I-SCP-AAO-ALM-14-06/02/2013****************************************/
CREATE TABLE alm.titem_reemplazo (
  id_item_reemplazo SERIAL NOT NULL,
  id_item INTEGER not null,
  id_item_r INTEGER not null,
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
  descripcion VARCHAR(1000),
  extension VARCHAR(10),
  archivo BYTEA,
  id_item INTEGER,
  PRIMARY KEY(id_item_archivo)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE alm.titem_archivo
  OWNER TO postgres;
/***********************************F-SCP-AAO-ALM-15-06/02/2013****************************************/


/***********************************I-SCP-AAO-ALM-24-14/02/2013****************************************/

CREATE TABLE alm.tmetodo_val (
  id_metodo_val SERIAL NOT NULL,
  codigo VARCHAR(20),
  nombre VARCHAR(50),
  descripcion VARCHAR(1000),
  read_only BOOLEAN DEFAULT FALSE,
  PRIMARY KEY(id_metodo_val)
) INHERITS (pxp.tbase)
WITHOUT OIDS;


/***********************************F-SCP-AAO-ALM-24-14/02/2013****************************************/


/***********************************I-SCP-AAO-ALM-25-21/02/2013****************************************/


CREATE TABLE alm.tmovimiento_det_valorado (
  id_movimiento_det_valorado SERIAL NOT NULL,
  id_movimiento_det INTEGER,
  cantidad NUMERIC(18,6),
  costo_unitario NUMERIC(18,6),
  aux_saldo_fisico NUMERIC(18,6),
  id_mov_det_val_origen INTEGER,
  PRIMARY KEY(id_movimiento_det_valorado)
) INHERITS (pxp.tbase)
WITHOUT OIDS;

ALTER TABLE alm.tmovimiento_det_valorado
  OWNER TO postgres;
/***********************************F-SCP-AAO-ALM-25-21/02/2013****************************************/



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
  id_usuario_asis INTEGER,
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


/***********************************I-SCP-RCM-ALM-82-18/07/2013*****************************************/
CREATE TABLE alm.tpreingreso(
	id_preingreso serial not null,
	id_cotizacion integer not null,
	id_almacen integer,
  id_depto INTEGER,
  id_estado_wf INTEGER,
  id_proceso_wf INTEGER,
  estado varchar(50),
  id_moneda INTEGER,
  tipo VARCHAR(15) NOT NULL,
  descripcion VARCHAR(1000),
  id_depto_conta integer,
  c31 VARCHAR(50),
	CONSTRAINT tpreingreso__id_preingreso PRIMARY KEY(id_preingreso),
  CONSTRAINT chk_tpreingreso__tipo CHECK (tipo in ('almacen','activo_fijo'))
) INHERITS (pxp.tbase)
WITHOUT OIDS;

CREATE TABLE alm.tpreingreso_det(
	id_preingreso_det serial not null,
	id_preingreso integer not null,
	id_cotizacion_det integer,
	id_item integer,
	id_almacen integer,
	cantidad_det numeric(18,2),
	precio_compra numeric(18,2),
  id_depto INTEGER,
  id_clasificacion INTEGER,
  sw_generar VARCHAR(2) DEFAULT 'no',
  observaciones VARCHAR(1000),
  estado VARCHAR(10),
  nombre VARCHAR(255),
  descripcion TEXT,
  precio_compra_87 NUMERIC(18,2),
  id_lugar INTEGER,
  ubicacion VARCHAR(255),
  c31 VARCHAR(50),
  fecha_conformidad DATE,
  fecha_compra DATE,
  id_centro_costo INTEGER,
  id_ubicacion INTEGER,
  id_grupo INTEGER,
  id_grupo_clasif INTEGER,
  nro_serie VARCHAR(50),
  marca VARCHAR(200),
  generado VARCHAR(2) DEFAULT 'no' NOT NULL,
  tipo_reg VARCHAR(10) DEFAULT 'normal' NOT NULL,
  id_preingreso_det_padre INTEGER,
  vida_util INTEGER,
	CONSTRAINT tpreingreso_det__id_preingreso_det PRIMARY KEY(id_preingreso_det)
) INHERITS (pxp.tbase)
WITHOUT OIDS;
COMMENT ON COLUMN alm.tpreingreso_det.estado
IS 'Indica si el registro es creado desde adquisiciones al generar el preingreso (''orig''), si es modificado desde preingreso (''mod'')';

COMMENT ON COLUMN alm.tpreingreso_det.id_centro_costo
IS 'Centro de costo, caso activos fijos: usado para la depreciación';

COMMENT ON COLUMN alm.tpreingreso_det.id_ubicacion
IS 'Ubicación Activos Fijos';

COMMENT ON COLUMN alm.tpreingreso_det.id_grupo
IS 'Agrupador AE para caso activos fijos';

COMMENT ON COLUMN alm.tpreingreso_det.id_grupo_clasif
IS 'Clasificador AE para caso activos fijos';

COMMENT ON COLUMN alm.tpreingreso_det.nro_serie
IS 'Número de serie del activo fijo';

COMMENT ON COLUMN alm.tpreingreso_det.marca
IS 'Marca del activo fijo';

COMMENT ON COLUMN alm.tpreingreso_det.generado
IS 'Bandera que define si el registro fue generado por el sistema o fue registrado manualmente';

COMMENT ON COLUMN alm.tpreingreso_det.tipo_reg
IS 'Define el tipo del registro, Normal (normal) o si fue Desglosado (desglose)';

COMMENT ON COLUMN alm.tpreingreso_det.id_preingreso_det_padre
IS 'Id del pasdre del registro cuando se haga un desglose';

COMMENT ON COLUMN alm.tpreingreso_det.vida_util
IS 'Vida util en meses';


UPDATE alm.tpreingreso_det pd SET
generado = 'no'
FROM alm.tpreingreso p
WHERE p.id_preingreso = pd.id_preingreso 
AND p.estado = 'borrador'
AND pd.sw_generar = 'no'
AND pd.generado = 'si'
AND pd.estado = 'orig';

/***********************************F-SCP-RCM-ALM-82-18/07/2013*****************************************/

/***********************************I-SCP-GSS-ALM-87-26/07/2013*****************************************/

CREATE TABLE alm.tmovimiento_tipo_item (
  id_movimiento_tipo_item SERIAL,
  id_movimiento_tipo INTEGER,
  id_item INTEGER,
  id_clasificacion integer,
  CONSTRAINT pk_tmovimiento_tipo_item__id_movimiento_tipo_item PRIMARY KEY(id_movimiento_tipo_item)
) INHERITS(pxp.tbase)
WITHOUT OIDS;

/***********************************F-SCP-GSS-ALM-87-26/07/2013*****************************************/


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



CREATE TABLE alm.titem_clasif_ingas (
  id_item_clasif_ingas SERIAL,
  id_concepto_ingas INTEGER,
  id_item INTEGER,
  id_clasificacion INTEGER,
  contador integer,
  CONSTRAINT pk_titem_clasif_ingas__id_item_clasif_ingas PRIMARY KEY(id_item_clasif_ingas)
) INHERITS(pxp.tbase)
WITHOUT OIDS;



/***********************************F-SCP-RCM-ALM-82-01/10/2013*****************************************/


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




/***********************************F-SCP-RCM-ALM-0-17/10/2013*****************************************/


/***********************************I-SCP-RCM-ALM-0-30/12/2013*****************************************/
CREATE TABLE alm.talmacen_gestion (
  id_almacen_gestion SERIAL,
  id_almacen INTEGER,
  id_gestion INTEGER,
  estado VARCHAR,
  PRIMARY KEY(id_almacen_gestion),
  constraint uq_talmacen_gestion__id_almacen__id_gestion unique (id_almacen,id_gestion)
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


/***********************************F-SCP-RCM-ALM-0-31/12/2013*****************************************/



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

