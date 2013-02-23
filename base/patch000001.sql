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