/***********************************I-DEP-RCM-ALM-0-11/01/2013*****************************************/
ALTER TABLE ONLY alm.tclasificacion
    ADD CONSTRAINT fk_tclasificacion__id_clasificacion_fk
    FOREIGN KEY (id_clasificacion_fk) REFERENCES alm.tclasificacion(id_clasificacion);
    
ALTER TABLE ONLY alm.titem
    ADD CONSTRAINT fk_titem__id_clasificacion
    FOREIGN KEY (id_clasificacion) REFERENCES alm.tclasificacion(id_clasificacion);
    
ALTER TABLE ONLY alm.talmacen_stock
    ADD CONSTRAINT fk_talmacen_stock__id_almacen
    FOREIGN KEY (id_almacen) REFERENCES alm.talmacen(id_almacen);
    
ALTER TABLE ONLY alm.talmacen_stock
    ADD CONSTRAINT fk_talmacen_stock__id_item
    FOREIGN KEY (id_item) REFERENCES alm.titem(id_item);
    
ALTER TABLE ONLY alm.tmovimiento
    ADD CONSTRAINT fk_tmovimiento__id_movimiento_tipo
    FOREIGN KEY (id_movimiento_tipo) REFERENCES alm.tmovimiento_tipo(id_movimiento_tipo);
    
ALTER TABLE ONLY alm.tmovimiento
    ADD CONSTRAINT fk_tmovimiento__id_almacen
    FOREIGN KEY (id_almacen) REFERENCES alm.talmacen(id_almacen);
    
ALTER TABLE ONLY alm.tmovimiento
    ADD CONSTRAINT fk_tmovimiento__id_funcionario
    FOREIGN KEY (id_funcionario) REFERENCES orga.tfuncionario(id_funcionario);
    
ALTER TABLE ONLY alm.tmovimiento
    ADD CONSTRAINT fk_tmovimiento__id_proveedor
    FOREIGN KEY (id_proveedor) REFERENCES param.tproveedor(id_proveedor);
    
ALTER TABLE ONLY alm.tmovimiento
    ADD CONSTRAINT fk_tmovimiento__id_almacen_dest
    FOREIGN KEY (id_almacen_dest) REFERENCES alm.talmacen(id_almacen);
    
    
ALTER TABLE ONLY alm.tmovimiento_det
    ADD CONSTRAINT fk_tmovimiento_det__id_item
    FOREIGN KEY (id_item) REFERENCES alm.titem(id_item);    
    
alter table alm.talmacen_usuario
add CONSTRAINT fk_talmacen_usuario__id_usuario FOREIGN KEY (id_usuario)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/*    
ALTER TABLE alm.talmacen
ADD CONSTRAINT fk_talmacen__id_almacen_usuario FOREIGN KEY (id_almacen_usuario)
    REFERENCES alm.talmacen_usuario(id_almacen_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;*/
    
ALTER TABLE alm.talmacen
add CONSTRAINT fk_talmacen__id_almacen FOREIGN KEY (id_almacen)
    REFERENCES alm.talmacen(id_almacen)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE; 
  

/***********************************F-DEP-RCM-ALM-0-11/01/2013*****************************************/


/***********************************I-DEP-AAO-ALM-12-06/02/2013*****************************************/
ALTER TABLE alm.talmacen_usuario
  ADD CONSTRAINT fk_talmacen_usuario__id_almacen FOREIGN KEY (id_almacen)
    REFERENCES alm.talmacen(id_almacen)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-AAO-ALM-12-06/02/2013*****************************************/

/***********************************I-DEP-AAO-ALM-14-06/02/2013*****************************************/
ALTER TABLE alm.titem_reemplazo
  ADD CONSTRAINT fk_titem_reemplazo__id_item FOREIGN KEY (id_item)
    REFERENCES alm.titem(id_item)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

--------------- SQL ---------------
ALTER TABLE alm.titem_reemplazo
  ADD CONSTRAINT fk_titem_reemplazo__id_item_r FOREIGN KEY (id_item_r)
    REFERENCES alm.titem(id_item)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-AAO-ALM-14-06/02/2013*****************************************/

/***********************************I-DEP-AAO-ALM-15-06/02/2013*****************************************/
ALTER TABLE alm.titem_archivo
  ADD CONSTRAINT fk_titem_archivo__id_item FOREIGN KEY (id_item)
    REFERENCES alm.titem(id_item)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-AAO-ALM-15-06/02/2013*****************************************/

/***********************************I-DEP-AAO-ALM-24-14/02/2013*****************************************/
ALTER TABLE alm.talmacen_stock
  ADD CONSTRAINT fk_talmacen_stock__id_metodo_val FOREIGN KEY (id_metodo_val)
    REFERENCES alm.tmetodo_val(id_metodo_val)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-AAO-ALM-24-14/02/2013*****************************************/


/***********************************I-DEP-AAO-ALM-26-25/02/2013*****************************************/
ALTER TABLE alm.talmacen
  ADD CONSTRAINT fk_talmacen__id_departamento FOREIGN KEY (id_departamento)
    REFERENCES param.tdepto(id_depto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-AAO-ALM-26-25/02/2013*****************************************/

/***********************************I-DEP-AAO-ALM-34-01/03/2013*****************************************/
ALTER TABLE alm.titem
  ADD CONSTRAINT fk_titem__id_unidad_medida FOREIGN KEY (id_unidad_medida)
    REFERENCES param.tunidad_medida(id_unidad_medida)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-AAO-ALM-34-01/03/2013*****************************************/

/***********************************I-DEP-AAO-ALM-45-14/03/2013*****************************************/
ALTER TABLE alm.tinventario
  ADD CONSTRAINT fk_tinventario__id_almacen FOREIGN KEY (id_almacen)
    REFERENCES alm.talmacen(id_almacen)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE alm.tinventario
  ADD CONSTRAINT fk_tinventario__id_usuario_resp FOREIGN KEY (id_usuario_resp)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-AAO-ALM-45-14/03/2013*****************************************/

/***********************************I-DEP-AAO-ALM-45-15/03/2013*****************************************/
ALTER TABLE alm.tinventario_det
  ADD CONSTRAINT fk_tinventario_det__id_inventario FOREIGN KEY (id_inventario)
    REFERENCES alm.tinventario(id_inventario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tinventario_det
  ADD CONSTRAINT fk_tinventario_det__id_item FOREIGN KEY (id_item)
    REFERENCES alm.titem(id_item)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-AAO-ALM-45-15/03/2013*****************************************/

/***********************************I-DEP-AAO-ALM-72-23/04/2013*****************************************/

select pxp.f_insert_testructura_gui ('ALCRAL.2.2', 'ALCRAL.2');
select pxp.f_insert_testructura_gui ('ALREMA.1.2', 'ALREMA.1');
select pxp.f_insert_testructura_gui ('ALCLMA.1.1.2', 'ALCLMA.1.1');
select pxp.f_insert_testructura_gui ('MOV.1.2', 'MOV.1');
select pxp.f_insert_testructura_gui ('INVMAIN.1', 'INVMAIN');
select pxp.f_insert_testructura_gui ('INVMAIN.1.1', 'INVMAIN.1');


------------------------
select pxp.f_insert_testructura_gui ('ALCRAL.2.3', 'ALCRAL.2');
select pxp.f_insert_testructura_gui ('ALREMA.1.3', 'ALREMA.1');
select pxp.f_insert_testructura_gui ('ALCLMA.1.1.3', 'ALCLMA.1.1');
select pxp.f_insert_testructura_gui ('MOV.1.3', 'MOV.1');
select pxp.f_insert_testructura_gui ('INVMAIN.2', 'INVMAIN');
select pxp.f_insert_testructura_gui ('INVMAIN.2.1', 'INVMAIN.2');






/***********************************F-DEP-AAO-ALM-72-23/04/2013*****************************************/

/***********************************I-DEP-AAO-ALM-76-23/04/2013*****************************************/


/*

select pxp.f_insert_testructura_gui ('ALCRAL.2.2', 'ALCRAL.2');
select pxp.f_insert_testructura_gui ('ALREMA.1.2', 'ALREMA.1');
select pxp.f_insert_testructura_gui ('ALCLMA.1.1.2', 'ALCLMA.1.1');
select pxp.f_insert_testructura_gui ('MOV.1.2', 'MOV.1');
select pxp.f_insert_testructura_gui ('ORDINV.1', 'ORDINV');
select pxp.f_insert_testructura_gui ('ORDINV.1.1', 'ORDINV.1');
select pxp.f_insert_testructura_gui ('EJEINV.1', 'EJEINV');


*/

/***********************************F-DEP-AAO-ALM-76-23/04/2013*****************************************/

/***********************************I-DEP-AAO-ALM-56-03/05/2013*****************************************/

/*


select pxp.f_insert_testructura_gui ('REPOR', 'ALM');
select pxp.f_insert_testructura_gui ('REPEXIST', 'REPOR');
select pxp.f_insert_testructura_gui ('ALREMA.3', 'ALREMA');
select pxp.f_insert_testructura_gui ('ALREMA.3.1', 'ALREMA.3');
select pxp.f_insert_testructura_gui ('ALCLMA.1.3', 'ALCLMA.1');
select pxp.f_insert_testructura_gui ('ALCLMA.1.3.1', 'ALCLMA.1.3');

select pxp.f_insert_tgui_rol ('REPOR', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('REPEXIST', 'Administrador Almacenes');

*/


/***********************************F-DEP-AAO-ALM-56-03/05/2013*****************************************/

/***********************************I-DEP-GSS-ALM-69-05/07/2013*****************************************/

/*ALTER TABLE alm.tmovimiento_tipo
  ALTER COLUMN id_proceso_macro SET NOT NULL;*/

ALTER TABLE alm.tmovimiento_tipo
  ADD CONSTRAINT fk_tmovimiento_tipo__id_proceso_macro FOREIGN KEY (id_proceso_macro)
    REFERENCES wf.tproceso_macro(id_proceso_macro)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
  
/***********************************F-DEP-GSS-ALM-69-05/07/2013*****************************************/

/***********************************I-DEP-RCM-ALM-82-18/07/2013*****************************************/
ALTER TABLE alm.tpreingreso
  ADD CONSTRAINT fk_tpreingreso__id_cotizacion FOREIGN KEY (id_cotizacion)
    REFERENCES adq.tcotizacion(id_cotizacion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tpreingreso
  ADD CONSTRAINT fk_tpreingreso__id_almacen FOREIGN KEY (id_almacen)
    REFERENCES alm.talmacen(id_almacen)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tpreingreso_det
  ADD CONSTRAINT fk_tpreingreso_det__id_preingreso FOREIGN KEY (id_preingreso)
    REFERENCES alm.tpreingreso(id_preingreso)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tpreingreso_det
  ADD CONSTRAINT fk_tpreingreso_det__id_cotizacion_det FOREIGN KEY (id_cotizacion_det)
    REFERENCES adq.tcotizacion_det(id_cotizacion_det)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tpreingreso_det
  ADD CONSTRAINT fk_tpreingreso_det__id_item FOREIGN KEY (id_item)
    REFERENCES alm.titem(id_item)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tpreingreso_det
  ADD CONSTRAINT fk_tpreingreso_det__id_almacen FOREIGN KEY (id_almacen)
    REFERENCES alm.talmacen(id_almacen)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/***********************************F-DEP-RCM-ALM-82-18/07/2013*****************************************/

/***********************************I-DEP-GSS-ALM-82-22/07/2013****************************************/
select pxp.f_insert_testructura_gui ('INVMAIN.1.2', 'INVMAIN.1');
select pxp.f_insert_testructura_gui ('ORDINV.1.2', 'ORDINV.1');
select pxp.f_insert_testructura_gui ('EJEINV.1.2', 'EJEINV.1');
select pxp.f_insert_testructura_gui ('MOVALM.1', 'MOVALM');
select pxp.f_insert_testructura_gui ('MOVALM.2', 'MOVALM');
select pxp.f_insert_testructura_gui ('MOVALM.3', 'MOVALM');
select pxp.f_insert_testructura_gui ('MOVALM.1.1', 'MOVALM.1');
select pxp.f_insert_testructura_gui ('MOVALM.1.2', 'MOVALM.1');
select pxp.f_insert_testructura_gui ('MOVALM.2.1', 'MOVALM.2');
select pxp.f_insert_testructura_gui ('MOVALM.2.2', 'MOVALM.2');
select pxp.f_insert_testructura_gui ('MOVVB.1', 'MOVVB');
select pxp.f_insert_testructura_gui ('MOVVB.2', 'MOVVB');
select pxp.f_insert_testructura_gui ('MOVVB.3', 'MOVVB');
select pxp.f_insert_testructura_gui ('MOVVB.1.1', 'MOVVB.1');
select pxp.f_insert_testructura_gui ('MOVVB.1.2', 'MOVVB.1');
select pxp.f_insert_testructura_gui ('MOVVB.2.1', 'MOVVB.2');
select pxp.f_insert_testructura_gui ('MOVVB.2.2', 'MOVVB.2');
select pxp.f_insert_testructura_gui ('PREING.1', 'PREING');



select pxp.f_insert_tgui_rol ('MOVALM.1', 'Almacenero');

/***********************************F-DEP-GSS-ALM-82-22/07/2013****************************************/



/***********************************I-DEP-GSS-ALM-86-26/07/2013*****************************************/

ALTER TABLE alm.tinventario
  ADD CONSTRAINT fk_tinventario__id_usuario_asis FOREIGN KEY (id_usuario_asis)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/***********************************F-DEP-GSS-ALM-86-26/07/2013*****************************************/

/***********************************I-DEP-GSS-ALM-87-26/07/2013*****************************************/

ALTER TABLE alm.tmovimiento_tipo_item
  ADD CONSTRAINT fk_tmovimiento_tipo_item__id_movimiento_tipo FOREIGN KEY (id_movimiento_tipo)
    REFERENCES alm.tmovimiento_tipo(id_movimiento_tipo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tmovimiento_tipo_item
  ADD CONSTRAINT fk_tmovimiento_tipo_item__id_item FOREIGN KEY (id_item)
    REFERENCES alm.titem(id_item)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
/***********************************F-DEP-GSS-ALM-87-26/07/2013*****************************************/

/***********************************I-DEP-RCM-ALM-87-21/08/2013*****************************************/
ALTER TABLE alm.tmovimiento_tipo_item
  ADD CONSTRAINT fk_tmovimiento_tipo_item__id_clasificacion FOREIGN KEY (id_clasificacion)
    REFERENCES alm.tclasificacion(id_clasificacion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-RCM-ALM-87-21/08/2013*****************************************/

/***********************************I-DEP-RCM-ALM-95-22/08/2013*****************************************/
ALTER TABLE alm.tmovimiento_tipo_uo
  ADD CONSTRAINT fk_tmovimiento_tipo_uo__id_movimiento_tipo FOREIGN KEY (id_movimiento_tipo)
    REFERENCES alm.tmovimiento_tipo(id_movimiento_tipo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tmovimiento_tipo_uo
  ADD CONSTRAINT fk_tmovimiento_tipo_uo__id_uo FOREIGN KEY (id_uo)
    REFERENCES orga.tuo(id_uo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
/***********************************F-DEP-RCM-ALM-95-22/08/2013*****************************************/

/***********************************I-DEP-RCM-ALM-82-01/10/2013*****************************************/
ALTER TABLE alm.tpreingreso
  ADD CONSTRAINT fk_tpreingreso__id_depto FOREIGN KEY (id_depto)
    REFERENCES param.tdepto(id_depto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

/***********************************F-DEP-RCM-ALM-82-01/10/2013*****************************************/


/***********************************I-DEP-RCM-ALM-0-17/10/2013*****************************************/
ALTER TABLE alm.tmovimiento
  ADD CONSTRAINT fk_tmovimiento__id_salida_grupo FOREIGN KEY (id_salida_grupo)
    REFERENCES alm.tsalida_grupo(id_salida_grupo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tsalida_grupo
  ADD CONSTRAINT fk_tsalida_grupo__id_almacen FOREIGN KEY (id_almacen)
    REFERENCES alm.talmacen(id_almacen)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tsalida_grupo
  ADD CONSTRAINT fk_tsalida_grupo__id_movimiento_tipo FOREIGN KEY (id_movimiento_tipo)
    REFERENCES alm.tmovimiento_tipo(id_movimiento_tipo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tsalida_grupo_item
  ADD CONSTRAINT fk_tsalida_grupo_item__id_salida_grupo FOREIGN KEY (id_salida_grupo)
    REFERENCES alm.tsalida_grupo(id_salida_grupo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tsalida_grupo_item
  ADD CONSTRAINT fk_tsalida_grupo_item__id_item FOREIGN KEY (id_item)
    REFERENCES alm.titem(id_item)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tsalida_grupo_fun
  ADD CONSTRAINT fk_tsalida_grupo_fun__id_salida_grupo_item FOREIGN KEY (id_salida_grupo_item)
    REFERENCES alm.tsalida_grupo_item(id_salida_grupo_item)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tsalida_grupo_fun
  ADD CONSTRAINT fk_tsalida_grupo_fun__id_funcionario FOREIGN KEY (id_funcionario)
    REFERENCES orga.tfuncionario(id_funcionario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tpreingreso
  ADD CONSTRAINT fk_tpreingreso__id_depto_conta FOREIGN KEY (id_depto_conta)
    REFERENCES param.tdepto(id_depto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

CREATE VIEW alm.vcbte_salida_cab (
    id_movimiento_grupo,
    benef,
    id_moneda,
    id_depto_conta,
    fecha_actual,
    id_gestion,
    desc_almacen,
    id_almacen)
AS
SELECT mgru.id_movimiento_grupo, (((((('Salida del Almacén: '::text ||
    alm.codigo::text) || ' - '::text) || alm.nombre::text) || ', del: '::text)
    || to_char(mgru.fecha_ini::timestamp with time zone, 'dd/mm/yyyy'::text))
    || ' al: '::text) || to_char(mgru.fecha_fin::timestamp with time zone,
    'dd/mm/yyyy'::text) AS benef, param.f_get_moneda_base() AS id_moneda,
    mgru.id_depto_conta, now() AS fecha_actual, (
    SELECT f_get_periodo_gestion.po_id_gestion
    FROM param.f_get_periodo_gestion(mgru.fecha_ini)
        f_get_periodo_gestion(po_id_periodo, po_id_gestion, po_id_periodo_subsistema)
    ) AS id_gestion, (alm.codigo::text || ' - '::text) || alm.nombre::text AS
        desc_almacen, mgru.id_almacen
FROM alm.tmovimiento_grupo mgru
   JOIN alm.talmacen alm ON alm.id_almacen = mgru.id_almacen;
  -------------------

CREATE VIEW alm.vcbte_salida_det (
    id_movimiento_grupo,
    cantidad,
    costo_total,
    id_clasificacion,
    codigo_largo,
    nombre,
    descripcion)
AS
SELECT tab.id_movimiento_grupo, sum(tab.cantidad) AS cantidad,
    sum(tab.costo_total) AS costo_total, tab.id_clasificacion,
    tab.codigo_largo, tab.nombre, tab.descripcion
FROM (
    SELECT mgrudet.id_movimiento_grupo_det, mgrudet.id_movimiento_grupo,
        mdetval.cantidad, mdetval.costo_unitario, mdetval.cantidad *
        mdetval.costo_unitario AS costo_total, cla.id_clasificacion,
        cla.codigo_largo, cla.nombre, (cla.codigo_largo::text || ' - '::text)
        || cla.nombre::text AS descripcion
    FROM alm.tmovimiento_grupo_det mgrudet
      JOIN alm.tmovimiento mov ON mov.id_movimiento = mgrudet.id_movimiento
   JOIN alm.tmovimiento_det mdet ON mdet.id_movimiento = mov.id_movimiento
   JOIN alm.tmovimiento_det_valorado mdetval ON mdetval.id_movimiento_det =
       mdet.id_movimiento_det
   JOIN alm.titem ite ON ite.id_item = mdet.id_item
   JOIN alm.tclasificacion cla ON cla.id_clasificacion = ite.id_clasificacion
    ) tab
GROUP BY tab.id_movimiento_grupo, tab.id_clasificacion, tab.codigo_largo,
    tab.nombre, tab.descripcion;
 ---------------   
CREATE VIEW alm.vcbte_salida_det_alm (
    id_movimiento_grupo,
    cantidad,
    costo_total,
    descripcion)
AS
SELECT sal.id_movimiento_grupo, sum(sal.cantidad) AS cantidad,
    sum(sal.costo_total) AS costo_total, 'Salida de Almacén' AS descripcion
FROM alm.vcbte_salida_det sal
GROUP BY sal.id_movimiento_grupo;
/***********************************F-DEP-RCM-ALM-0-17/10/2013*****************************************/


/***********************************I-DEP-RCM-ALM-31-10/10/2013*****************************************/
CREATE VIEW alm.vcbte_ingreso_cab (
    id_movimiento,
    beneficiario,
    id_moneda,
    id_depto_conta,
    codigo,
    fecha_actual,
    estado_mov,
    id_gestion,
    desc_motivo,
    tipo,
    id_preingreso,
    desc_almacen,
    id_almacen)
AS
SELECT mov.id_movimiento,
        CASE COALESCE(mov.id_funcionario, 0)
            WHEN 0 THEN pro.desc_proveedor::text
            ELSE fun.desc_funcionario1
        END AS beneficiario, param.f_get_moneda_base() AS id_moneda,
            mov.id_depto_conta, mov.codigo, now() AS fecha_actual, mov.estado_mov, (
    SELECT f_get_periodo_gestion.po_id_gestion
    FROM param.f_get_periodo_gestion(mov.fecha_mov::date)
        f_get_periodo_gestion(po_id_periodo, po_id_gestion, po_id_periodo_subsistema)
    ) AS id_gestion, mtip.nombre AS desc_motivo, mtip.tipo, mov.id_preingreso,
        (alm.codigo::text || ' - '::text) || alm.nombre::text AS desc_almacen,
        mov.id_almacen
FROM alm.tmovimiento mov
   LEFT JOIN orga.vfuncionario fun ON fun.id_funcionario = mov.id_funcionario
   LEFT JOIN param.vproveedor pro ON pro.id_proveedor = mov.id_proveedor
   JOIN alm.talmacen alm ON alm.id_almacen = mov.id_almacen
   JOIN alm.tmovimiento_tipo mtip ON mtip.id_movimiento_tipo = mov.id_movimiento_tipo
WHERE mov.id_int_comprobante IS NULL;

---------------
  
CREATE OR REPLACE VIEW alm.vcbte_ingreso_det(
    id_movimiento_det,
    id_movimiento,
    cantidad,
    costo_unitario,
    costo_total,
    id_item,
    codigo_item,
    nombre_item,
    id_preingreso,
    id_concepto_ingas,
    desc_item)
AS
  SELECT mdet.id_movimiento_det,
         mdet.id_movimiento,
         mdetva.cantidad,
         mdetva.costo_unitario,
         mdetva.cantidad * mdetva.costo_unitario AS costo_total,
         mdet.id_item,
         item.codigo AS codigo_item,
         item.nombre AS nombre_item,
         mov.id_preingreso,
         mdet.id_concepto_ingas,
         (COALESCE(item.codigo, 'S/C' ::character varying) ::text || ' - '
          ::text) || item.nombre::text AS desc_item
  FROM alm.tmovimiento mov
       JOIN alm.tmovimiento_det mdet ON mdet.id_movimiento = mov.id_movimiento
       JOIN alm.tmovimiento_det_valorado mdetva ON mdetva.id_movimiento_det =
        mdet.id_movimiento_det
       JOIN alm.titem item ON item.id_item = mdet.id_item
  WHERE mov.id_int_comprobante IS NULL;
  
  
-------------
CREATE VIEW alm.vcbte_ingreso_det_alm (
    id_movimiento,
    cantidad,
    costo_total,
    descripcion)
AS
SELECT ing.id_movimiento, sum(ing.cantidad) AS cantidad, sum(ing.costo_total)
    AS costo_total, 'Ingreso a Almacén' AS descripcion
FROM alm.vcbte_ingreso_det ing
GROUP BY ing.id_movimiento;
/***********************************F-DEP-RCM-ALM-31-10/10/2013*****************************************/

/***********************************I-DEP-RCM-ALM-0-30/12/2013*****************************************/
ALTER TABLE alm.talmacen_gestion
  ADD CONSTRAINT fk_talmacen_gestion__id_almacen FOREIGN KEY (id_almacen)
    REFERENCES alm.talmacen(id_almacen)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.talmacen_gestion
  ADD CONSTRAINT fk_talmacen_gestion__id_gestion FOREIGN KEY (id_gestion)
    REFERENCES param.tgestion(id_gestion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-RCM-ALM-0-30/12/2013*****************************************/


/***********************************I-DEP-RCM-ALM-0-02/01/2014*****************************************/

CREATE TRIGGER tr_talmacen_gestion BEFORE DELETE 
ON alm.talmacen_gestion FOR EACH ROW 
EXECUTE PROCEDURE alm.f_tri_talmacen_gestion();


ALTER TABLE alm.talmacen_gestion_log
  ADD CONSTRAINT fk_talmacen_gestion_log__id_almacen_gestion FOREIGN KEY (id_almacen_gestion)
    REFERENCES alm.talmacen_gestion(id_almacen_gestion)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/***********************************F-DEP-RCM-ALM-0-02/01/2014*****************************************/

/***********************************I-DEP-RCM-ALM-0-15/01/2014*****************************************/



ALTER TABLE alm.tmovimiento_det_valorado
  ADD CONSTRAINT fk_tmovimiento_det_valorado__id_movimiento_det FOREIGN KEY (id_movimiento_det)
    REFERENCES alm.tmovimiento_det(id_movimiento_det)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    

ALTER TABLE alm.tmovimiento_det
  ADD CONSTRAINT fk_tmovimiento_det__id_movimiento FOREIGN KEY (id_movimiento)
    REFERENCES alm.tmovimiento(id_movimiento)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-RCM-ALM-0-15/01/2014*****************************************/    

/***********************************I-DEP-RCM-ALM-0-22/01/2014*****************************************/
ALTER TABLE ONLY alm.tmovimiento_grupo_det
    ADD CONSTRAINT fk_tmovimiento_grupo_det__id_movimiento_grupo
    FOREIGN KEY (id_movimiento_grupo) REFERENCES alm.tmovimiento_grupo(id_movimiento_grupo);
/***********************************F-DEP-RCM-ALM-0-22/01/2014*****************************************/

/***********************************I-DEP-JRR-ALM-0-24/04/2014****************************************/

select pxp.f_insert_testructura_gui ('ALCRAL.3', 'ALCRAL');
select pxp.f_insert_testructura_gui ('ALCRAL.4', 'ALCRAL');
select pxp.f_insert_testructura_gui ('ALCRAL.5', 'ALCRAL');
select pxp.f_insert_testructura_gui ('ALCRAL.2.4', 'ALCRAL.2');
select pxp.f_insert_testructura_gui ('ALCRAL.2.4.1', 'ALCRAL.2.4');
select pxp.f_insert_testructura_gui ('ALCRAL.5.1', 'ALCRAL.5');
select pxp.f_insert_testructura_gui ('ALCRAL.5.2', 'ALCRAL.5');
select pxp.f_insert_testructura_gui ('ALCRAL.5.2.1', 'ALCRAL.5.2');
select pxp.f_insert_testructura_gui ('ALCRAL.5.2.2', 'ALCRAL.5.2');
select pxp.f_insert_testructura_gui ('ALCRAL.5.2.1.1', 'ALCRAL.5.2.1');
select pxp.f_insert_testructura_gui ('ALCRAL.5.2.1.2', 'ALCRAL.5.2.1');
select pxp.f_insert_testructura_gui ('ALREMA.4', 'ALREMA');
select pxp.f_insert_testructura_gui ('ALREMA.1.4', 'ALREMA.1');
select pxp.f_insert_testructura_gui ('ALREMA.1.4.1', 'ALREMA.1.4');
select pxp.f_insert_testructura_gui ('ALREMA.4.1', 'ALREMA.4');
select pxp.f_insert_testructura_gui ('ALCLMA.1.4', 'ALCLMA.1');
select pxp.f_insert_testructura_gui ('ALCLMA.1.1.4', 'ALCLMA.1.1');
select pxp.f_insert_testructura_gui ('ALCLMA.1.1.4.1', 'ALCLMA.1.1.4');
select pxp.f_insert_testructura_gui ('ALCLMA.1.4.1', 'ALCLMA.1.4');
select pxp.f_insert_testructura_gui ('MOVTIP.1', 'MOVTIP');
select pxp.f_insert_testructura_gui ('MOVTIP.2', 'MOVTIP');
select pxp.f_insert_testructura_gui ('MOVTIP.3', 'MOVTIP');
select pxp.f_insert_testructura_gui ('MOVTIP.4', 'MOVTIP');
select pxp.f_insert_testructura_gui ('MOVTIP.1.1', 'MOVTIP.1');
select pxp.f_insert_testructura_gui ('MOVTIP.2.1', 'MOVTIP.2');
select pxp.f_insert_testructura_gui ('MOVTIP.2.1.1', 'MOVTIP.2.1');
select pxp.f_insert_testructura_gui ('MOVTIP.2.1.2', 'MOVTIP.2.1');
select pxp.f_insert_testructura_gui ('MOVTIP.2.1.1.1', 'MOVTIP.2.1.1');
select pxp.f_insert_testructura_gui ('MOVTIP.2.1.1.2', 'MOVTIP.2.1.1');
select pxp.f_insert_testructura_gui ('MOVTIP.2.1.2.1', 'MOVTIP.2.1.2');
select pxp.f_insert_testructura_gui ('MOVTIP.2.1.2.1.1', 'MOVTIP.2.1.2.1');
select pxp.f_insert_testructura_gui ('MOVTIP.2.1.2.1.2', 'MOVTIP.2.1.2.1');
select pxp.f_insert_testructura_gui ('MOVTIP.2.1.2.1.1.1', 'MOVTIP.2.1.2.1.1');
select pxp.f_insert_testructura_gui ('MOVTIP.2.1.2.1.1.1.1', 'MOVTIP.2.1.2.1.1.1');
select pxp.f_insert_testructura_gui ('MOVTIP.2.1.2.1.1.1.1.1', 'MOVTIP.2.1.2.1.1.1.1');
select pxp.f_insert_testructura_gui ('MOV.1.4', 'MOV.1');
select pxp.f_insert_testructura_gui ('MOV.1.4.1', 'MOV.1.4');
select pxp.f_insert_testructura_gui ('INVMAIN.3', 'INVMAIN');
select pxp.f_insert_testructura_gui ('INVMAIN.3.1', 'INVMAIN.3');
select pxp.f_insert_testructura_gui ('INVMAIN.3.2', 'INVMAIN.3');
select pxp.f_insert_testructura_gui ('INVMAIN.3.1.1', 'INVMAIN.3.1');
select pxp.f_insert_testructura_gui ('ORDINV.2', 'ORDINV');
select pxp.f_insert_testructura_gui ('ORDINV.2.1', 'ORDINV.2');
select pxp.f_insert_testructura_gui ('ORDINV.2.2', 'ORDINV.2');
select pxp.f_insert_testructura_gui ('ORDINV.2.1.1', 'ORDINV.2.1');
select pxp.f_insert_testructura_gui ('EJEINV.2', 'EJEINV');
select pxp.f_insert_testructura_gui ('EJEINV.2.1', 'EJEINV.2');
select pxp.f_insert_testructura_gui ('EJEINV.2.2', 'EJEINV.2');
select pxp.f_insert_testructura_gui ('EJEINV.2.1.1', 'EJEINV.2.1');
select pxp.f_insert_testructura_gui ('REPEXIST.1', 'REPEXIST');
select pxp.f_insert_testructura_gui ('REPEXIST.2', 'REPEXIST');
select pxp.f_insert_testructura_gui ('MOVALM.1.1.1', 'MOVALM.1.1');
select pxp.f_insert_testructura_gui ('MOVVB.1.1.1', 'MOVVB.1.1');
select pxp.f_insert_testructura_gui ('PREING.2', 'PREING');
select pxp.f_insert_testructura_gui ('PREING.1.1', 'PREING.1');
select pxp.f_insert_testructura_gui ('PREING.1.2', 'PREING.1');
select pxp.f_insert_testructura_gui ('PREING.1.1.1', 'PREING.1.1');
select pxp.f_insert_testructura_gui ('ALBUSQ.1', 'ALBUSQ');
select pxp.f_insert_testructura_gui ('ALPREIN.1', 'ALPREIN');
select pxp.f_insert_testructura_gui ('ALPREIN.2', 'ALPREIN');
select pxp.f_insert_testructura_gui ('ALPREIN.1.1', 'ALPREIN.1');
select pxp.f_insert_testructura_gui ('ALPREIN.1.2', 'ALPREIN.1');
select pxp.f_insert_testructura_gui ('ALPREIN.1.1.1', 'ALPREIN.1.1');
select pxp.f_insert_testructura_gui ('SALGRU.1', 'SALGRU');
select pxp.f_insert_testructura_gui ('SALGRU.1.1', 'SALGRU.1');
select pxp.f_insert_testructura_gui ('SALGRU.1.2', 'SALGRU.1');
select pxp.f_insert_testructura_gui ('SALGRU.1.1.1', 'SALGRU.1.1');
select pxp.f_insert_testructura_gui ('MOVGRU.1', 'MOVGRU');
select pxp.f_insert_testructura_gui ('ALCRAL.5.2.3', 'ALCRAL.5.2');
select pxp.f_insert_testructura_gui ('ALCRAL.5.2.3.1', 'ALCRAL.5.2.3');
select pxp.f_insert_testructura_gui ('ALCRAL.5.2.3.2', 'ALCRAL.5.2.3');
select pxp.f_insert_testructura_gui ('ALCRAL.5.2.3.1.1', 'ALCRAL.5.2.3.1');
select pxp.f_insert_testructura_gui ('ALCRAL.5.2.3.1.1.1', 'ALCRAL.5.2.3.1.1');
select pxp.f_insert_testructura_gui ('ALCRAL.5.2.3.1.1.1.1', 'ALCRAL.5.2.3.1.1.1');
select pxp.f_insert_testructura_gui ('MOV.3', 'MOV');
select pxp.f_insert_testructura_gui ('MOV.3.1', 'MOV.3');
select pxp.f_insert_testructura_gui ('MOV.3.2', 'MOV.3');
select pxp.f_insert_testructura_gui ('MOV.3.1.1', 'MOV.3.1');
select pxp.f_insert_testructura_gui ('MOV.3.1.1.1', 'MOV.3.1.1');
select pxp.f_insert_testructura_gui ('MOV.3.1.1.1.1', 'MOV.3.1.1.1');
select pxp.f_insert_testructura_gui ('MOVALM.4', 'MOVALM');
select pxp.f_insert_testructura_gui ('MOVALM.4.1', 'MOVALM.4');
select pxp.f_insert_testructura_gui ('MOVALM.4.2', 'MOVALM.4');
select pxp.f_insert_testructura_gui ('MOVALM.4.1.1', 'MOVALM.4.1');
select pxp.f_insert_testructura_gui ('MOVALM.4.1.1.1', 'MOVALM.4.1.1');
select pxp.f_insert_testructura_gui ('MOVALM.4.1.1.1.1', 'MOVALM.4.1.1.1');
select pxp.f_insert_testructura_gui ('MOVVB.4', 'MOVVB');
select pxp.f_insert_testructura_gui ('MOVVB.4.1', 'MOVVB.4');
select pxp.f_insert_testructura_gui ('MOVVB.4.2', 'MOVVB.4');
select pxp.f_insert_testructura_gui ('MOVVB.4.1.1', 'MOVVB.4.1');
select pxp.f_insert_testructura_gui ('MOVVB.4.1.1.1', 'MOVVB.4.1.1');
select pxp.f_insert_testructura_gui ('MOVVB.4.1.1.1.1', 'MOVVB.4.1.1.1');
select pxp.f_insert_testructura_gui ('KARITE.1', 'KARITE');
select pxp.f_insert_testructura_gui ('ALREPIEI.1', 'ALREPIEI');
select pxp.f_insert_testructura_gui ('ALREPIEI.2', 'ALREPIEI');
select pxp.f_insert_testructura_gui ('ALREPIEI.3', 'ALREPIEI');
select pxp.f_insert_testructura_gui ('ALREPIEI.4', 'ALREPIEI');
select pxp.f_insert_testructura_gui ('ALREPIEI.2.1', 'ALREPIEI.2');
select pxp.f_insert_testructura_gui ('ALREPIEI.2.2', 'ALREPIEI.2');
select pxp.f_insert_testructura_gui ('ALREPIEI.2.1.1', 'ALREPIEI.2.1');
select pxp.f_insert_testructura_gui ('ALREPIEI.2.1.2', 'ALREPIEI.2.1');
select pxp.f_insert_testructura_gui ('ALREPIEI.2.2.1', 'ALREPIEI.2.2');
select pxp.f_insert_testructura_gui ('ALREPIEI.2.2.1.1', 'ALREPIEI.2.2.1');
select pxp.f_insert_testructura_gui ('ALREPIEI.2.2.1.2', 'ALREPIEI.2.2.1');
select pxp.f_insert_testructura_gui ('ALREPIEI.2.2.1.1.1', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_testructura_gui ('ALREPIEI.2.2.1.1.1.1', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_testructura_gui ('ALREPIEI.2.2.1.1.1.1.1', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_testructura_gui ('ALSALID.1', 'ALSALID');
select pxp.f_insert_testructura_gui ('ALSALID.2', 'ALSALID');
select pxp.f_insert_testructura_gui ('ALSALID.3', 'ALSALID');
select pxp.f_insert_testructura_gui ('ALSALID.1.1', 'ALSALID.1');
select pxp.f_insert_testructura_gui ('ALSALID.1.2', 'ALSALID.1');
select pxp.f_insert_testructura_gui ('ALSALID.1.1.1', 'ALSALID.1.1');
select pxp.f_insert_testructura_gui ('ALSALID.3.1', 'ALSALID.3');
select pxp.f_insert_testructura_gui ('ALSALID.3.2', 'ALSALID.3');
select pxp.f_insert_testructura_gui ('ALSALID.3.1.1', 'ALSALID.3.1');
select pxp.f_insert_testructura_gui ('ALSALID.3.1.1.1', 'ALSALID.3.1.1');
select pxp.f_insert_testructura_gui ('ALSALID.3.1.1.1.1', 'ALSALID.3.1.1.1');

/***********************************F-DEP-JRR-ALM-0-24/04/2014****************************************/

/***********************************I-DEP-JRR-ALM-0-22/03/2014****************************************/

CREATE VIEW alm.vmovimiento(
    codigo_movimiento_tipo,
    id_usuario_reg,
    id_usuario_mod,
    fecha_reg,
    fecha_mod,
    estado_reg,
    id_usuario_ai,
    usuario_ai,
    id_movimiento,
    id_movimiento_tipo,
    id_almacen,
    id_funcionario,
    id_proveedor,
    id_almacen_dest,
    fecha_mov,
    codigo,
    descripcion,
    observaciones,
    estado_mov,
    id_movimiento_origen,
    id_proceso_macro,
    id_estado_wf,
    id_proceso_wf,
    id_preingreso,
    id_salida_grupo,
    id_int_comprobante,
    id_depto_conta,
    id_almacen_gestion_log,
    desc_funcionario1,
    detalle_solicitud)
AS
  SELECT mt.codigo AS codigo_movimiento_tipo,
         mov.id_usuario_reg,
         mov.id_usuario_mod,
         mov.fecha_reg,
         mov.fecha_mod,
         mov.estado_reg,
         mov.id_usuario_ai,
         mov.usuario_ai,
         mov.id_movimiento,
         mov.id_movimiento_tipo,
         mov.id_almacen,
         mov.id_funcionario,
         mov.id_proveedor,
         mov.id_almacen_dest,
         mov.fecha_mov,
         mov.codigo,
         mov.descripcion,
         mov.observaciones,
         mov.estado_mov,
         mov.id_movimiento_origen,
         mov.id_proceso_macro,
         mov.id_estado_wf,
         mov.id_proceso_wf,
         mov.id_preingreso,
         mov.id_salida_grupo,
         mov.id_int_comprobante,
         mov.id_depto_conta,
         mov.id_almacen_gestion_log,
         fun.desc_funcionario1,
         ('<table border="1"><TR> 
   <TH>Item</TH> 
   <TH>Cantidad Solicitada</TH>   
   ' || pxp.html_rows('<td>'::text || it.nombre::text || '</td> <td>'::text || md.cantidad_solicitada::text|| '</td>'::text) ||
   '</table>')::text as detalle_solicitud
  FROM alm.tmovimiento mov
       JOIN alm.tmovimiento_tipo mt ON mt.id_movimiento_tipo =
         mov.id_movimiento_tipo
       JOIN orga.vfuncionario fun on fun.id_funcionario = mov.id_funcionario
       LEFT JOIN alm.tmovimiento_det md on md.id_movimiento = mov.id_movimiento
         LEFT JOIN alm.titem it on it.id_item = md.id_item
 group by  mt.codigo,
         mov.id_usuario_reg,
         mov.id_usuario_mod,
         mov.fecha_reg,
         mov.fecha_mod,
         mov.estado_reg,
         mov.id_usuario_ai,
         mov.usuario_ai,
         mov.id_movimiento,
         mov.id_movimiento_tipo,
         mov.id_almacen,
         mov.id_funcionario,
         mov.id_proveedor,
         mov.id_almacen_dest,
         mov.fecha_mov,
         mov.codigo,
         mov.descripcion,
         mov.observaciones,
         mov.estado_mov,
         mov.id_movimiento_origen,
         mov.id_proceso_macro,
         mov.id_estado_wf,
         mov.id_proceso_wf,
         mov.id_preingreso,
         mov.id_salida_grupo,
         mov.id_int_comprobante,
         mov.id_depto_conta,
         mov.id_almacen_gestion_log,
         fun.desc_funcionario1;

ALTER TABLE alm.vmovimiento
  OWNER TO postgres;
        
/***********************************F-DEP-JRR-ALM-0-22/03/2014****************************************/


/***********************************I-DEP-JRR-ALM-0-04/08/2015*****************************************/
ALTER TABLE alm.tpreingreso_det
  ADD CONSTRAINT fk_tpreingreso_det__id_lugar FOREIGN KEY (id_lugar)
    REFERENCES param.tlugar(id_lugar)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/***********************************F-DEP-JRR-ALM-0-04/08/2015*****************************************/


/***********************************I-DEP-JRR-ALM-0-08/10/2015*****************************************/

ALTER TABLE alm.talmacen
  ADD CONSTRAINT fk_talmacen__id_metodo_val FOREIGN KEY (id_metodo_val)
    REFERENCES alm.tmetodo_val(id_metodo_val)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;    


/***********************************F-DEP-JRR-ALM-0-08/10/2015*****************************************/

/***********************************I-DEP-JRR-ALM-0-12/01/2016*****************************************/

CREATE UNIQUE INDEX talmacen_stock_idx ON alm.talmacen_stock
  USING btree (id_almacen, id_item);
  
/***********************************F-DEP-JRR-ALM-0-12/01/2016*****************************************/

/***********************************I-DEP-GSS-ALM-1-13/07/2016*****************************************/

ALTER TABLE alm.tmovimiento_tipo_almacen
  ADD CONSTRAINT fk_tmovimiento_tipo_almacen__id_movimiento_tipo FOREIGN KEY (id_movimiento_tipo)
    REFERENCES alm.tmovimiento_tipo(id_movimiento_tipo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE alm.tmovimiento_tipo_almacen
  ADD CONSTRAINT fk_tmovimiento_tipo_almacen__id_almacen FOREIGN KEY (id_almacen)
    REFERENCES alm.talmacen(id_almacen)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/***********************************F-DEP-GSS-ALM-1-13/07/2016*****************************************/