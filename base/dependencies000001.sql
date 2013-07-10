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
    ADD CONSTRAINT fk_tmovimiento_det__id_movimiento
    FOREIGN KEY (id_movimiento) REFERENCES alm.tmovimiento(id_movimiento);
    
ALTER TABLE ONLY alm.tmovimiento_det
    ADD CONSTRAINT fk_tmovimiento_det__id_item
    FOREIGN KEY (id_item) REFERENCES alm.titem(id_item);    
    
alter table alm.talmacen_usuario
add CONSTRAINT fk_talmacen_usuario__id_usuario FOREIGN KEY (id_usuario)
    REFERENCES segu.tusuario(id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.talmacen
ADD CONSTRAINT fk_talmacen__id_almacen_usuario FOREIGN KEY (id_almacen_usuario)
    REFERENCES alm.talmacen_usuario(id_almacen_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.talmacen
add CONSTRAINT fk_talmacen__id_almacen FOREIGN KEY (id_almacen)
    REFERENCES alm.talmacen(id_almacen)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE; 
  

ALTER TABLE alm.talmacen_correlativo
add CONSTRAINT fk_tmovimiento_tipo__id_movimiento_tipo FOREIGN KEY (id_movimiento_tipo)
    REFERENCES alm.tmovimiento_tipo(id_movimiento_tipo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
/***********************************F-DEP-RCM-ALM-0-11/01/2013*****************************************/

/***********************************I-DEP-AAO-ALM-6-04/02/2013*****************************************/
ALTER TABLE alm.talmacen_correlativo
  DROP CONSTRAINT fk_tmovimiento_tipo__id_movimiento_tipo RESTRICT;
  
ALTER TABLE alm.talmacen
  DROP COLUMN id_almacen_usuario;
/***********************************F-DEP-AAO-ALM-6-04/02/2013*****************************************/

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

/***********************************I-DEP-AAO-ALM-25-21/02/2013*****************************************/
ALTER TABLE alm.tmovimiento_det_valorado
  ADD CONSTRAINT fk_tmovimiento_det_valorado__id_movimiento_det FOREIGN KEY (id_movimiento_det)
    REFERENCES alm.tmovimiento_det(id_movimiento_det)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-AAO-ALM-25-21/02/2013*****************************************/

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

select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALCRAL.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALCRAL.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALCRAL.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALREMA.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALREMA.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALREMA.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_CLADD_MOD', 'ALCLMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALCLMA.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALCLMA.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALCLMA.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'MOV.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'MOV.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'MOV.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'CATLOG', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'INVMAIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMUSR_SEL', 'INVMAIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_INS', 'INVMAIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_MOD', 'INVMAIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_ELI', 'INVMAIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_SEL', 'INVMAIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'INVMAIN.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_INS', 'INVMAIN.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_MOD', 'INVMAIN.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_ELI', 'INVMAIN.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_SEL', 'INVMAIN.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'INVMAIN.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'INVMAIN.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'INVMAIN.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVFINREG_MOD', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVREVDIF_MOD', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVFINREV_MOD', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVCORRREV_MOD', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVINIEJE_MOD', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVFINEJE_MOD', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVPENPER_SEL', 'PERI', 'no');


------------------------
select pxp.f_insert_testructura_gui ('ALCRAL.2.3', 'ALCRAL.2');
select pxp.f_insert_testructura_gui ('ALREMA.1.3', 'ALREMA.1');
select pxp.f_insert_testructura_gui ('ALCLMA.1.1.3', 'ALCLMA.1.1');
select pxp.f_insert_testructura_gui ('MOV.1.3', 'MOV.1');
select pxp.f_insert_testructura_gui ('INVMAIN.2', 'INVMAIN');
select pxp.f_insert_testructura_gui ('INVMAIN.2.1', 'INVMAIN.2');

select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALCRAL.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALCRAL.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALCRAL.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALREMA.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALREMA.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALREMA.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALCLMA.1.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALCLMA.1.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALCLMA.1.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'MOV.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'MOV.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'MOV.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'INVMAIN.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_INS', 'INVMAIN.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_MOD', 'INVMAIN.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_ELI', 'INVMAIN.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_SEL', 'INVMAIN.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'INVMAIN.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'INVMAIN.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'INVMAIN.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_SEL', 'PERI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESUGEN_INS', 'PERI', 'si');
select pxp.f_insert_tprocedimiento_gui ('PM_SWESTPE_MOD', 'PERI', 'si');


select pxp.f_insert_tgui_rol ('PERI', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ORDINV', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('EJEINV', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ORDINV', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('EJEINV', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('INVMAIN', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('INVMAIN.2', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('INVMAIN.2.1', 'Administrador Almacenes');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVPENPER_SEL', 'PERI');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_PESU_SEL', 'PERI');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_PESUGEN_INS', 'PERI');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_SWESTPE_MOD', 'PERI');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_INVFINREG_MOD', 'ORDINV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_INVREVDIF_MOD', 'ORDINV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_INVFINREV_MOD', 'ORDINV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_INVCORRREV_MOD', 'ORDINV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_INVINIEJE_MOD', 'EJEINV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_INVFINEJE_MOD', 'EJEINV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALM_SEL', 'INVMAIN');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALMUSR_SEL', 'INVMAIN');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_INV_INS', 'INVMAIN');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_INV_MOD', 'INVMAIN');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_INV_ELI', 'INVMAIN');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_INV_SEL', 'INVMAIN');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'INVMAIN.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_DINV_INS', 'INVMAIN.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_DINV_MOD', 'INVMAIN.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_DINV_ELI', 'INVMAIN.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_DINV_SEL', 'INVMAIN.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'ALM_CLA_ARB_SEL', 'INVMAIN.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ARB_SEL', 'INVMAIN.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMSRCHARB_SEL', 'INVMAIN.2.1');
/***********************************F-DEP-AAO-ALM-72-23/04/2013*****************************************/

/***********************************I-DEP-AAO-ALM-76-23/04/2013*****************************************/

select pxp.f_insert_testructura_gui ('ALCRAL.2.2', 'ALCRAL.2');
select pxp.f_insert_testructura_gui ('ALREMA.1.2', 'ALREMA.1');
select pxp.f_insert_testructura_gui ('ALCLMA.1.1.2', 'ALCLMA.1.1');
select pxp.f_insert_testructura_gui ('MOV.1.2', 'MOV.1');
select pxp.f_insert_testructura_gui ('ORDINV.1', 'ORDINV');
select pxp.f_insert_testructura_gui ('ORDINV.1.1', 'ORDINV.1');
select pxp.f_insert_testructura_gui ('EJEINV.1', 'EJEINV');
select pxp.f_insert_testructura_gui ('EJEINV.1.1', 'EJEINV.1');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALCRAL.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALCRAL.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALCRAL.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALREMA.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALREMA.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALREMA.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_CLADD_MOD', 'ALCLMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALCLMA.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALCLMA.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALCLMA.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVREPORT_SEL', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'MOV.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'MOV.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'MOV.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'CATLOG', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVFINREG_MOD', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVREVDIF_MOD', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVFINREV_MOD', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVCORRREV_MOD', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVINIEJE_MOD', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVFINEJE_MOD', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVPENPER_SEL', 'PERI', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVPENPER_SEL', 'MOV', 'si');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMUSR_SEL', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_INS', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_MOD', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_ELI', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_SEL', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ORDINV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_INS', 'ORDINV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_MOD', 'ORDINV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_ELI', 'ORDINV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_SEL', 'ORDINV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ORDINV.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ORDINV.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ORDINV.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMUSR_SEL', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_INS', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_MOD', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_ELI', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_SEL', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'EJEINV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_INS', 'EJEINV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_MOD', 'EJEINV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_ELI', 'EJEINV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_SEL', 'EJEINV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'EJEINV.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'EJEINV.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'EJEINV.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_INS', 'PERI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_MOD', 'PERI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_ELI', 'PERI', 'no');
select pxp.f_insert_tgui_rol ('PERI', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOV', 'Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALMOVI', 'Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALM', 'Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.1', 'Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.1.1', 'Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.1.2', 'Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.1.3', 'Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.2', 'Asistente de Almacenes');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVREPORT_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVPENPER_SEL', 'PERI');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_MOVTIP_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_ALM_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_MOV_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'RH_FUNCIO_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'RH_FUNCIOCAR_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'PM_PROVEEV_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_MOV_INS', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_MOV_MOD', 'MOV');
select pxp.f_delete_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_MOV_ELI', 'MOV');
select pxp.f_delete_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_MOVFIN_MOD', 'MOV');
select pxp.f_delete_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_MOVCNL_MOD', 'MOV');
select pxp.f_delete_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_MOVREV_MOD', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_MOVREPORT_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_MOVPENPER_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_ITEMNOTBASE_SEL', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_MOVDET_INS', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_MOVDET_MOD', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_MOVDET_ELI', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_MOVDET_SEL', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_DETVAL_SEL', 'MOV.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'ALM_CLA_ARB_SEL', 'MOV.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_ARB_SEL', 'MOV.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_ITMSRCHARB_SEL', 'MOV.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'ALM_CLA_ARB_SEL', 'MOV.1.3');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_ARB_SEL', 'MOV.1.3');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_ITMSRCHARB_SEL', 'MOV.1.3');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'PM_ALARM_INS', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'PM_ALARM_MOD', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'PM_ALARM_ELI', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'PM_ALARMCOR_SEL', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'PM_ALARM_SEL', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('Asistente de Almacenes', 'SAL_MOV_ELI', 'MOV');
/***********************************F-DEP-AAO-ALM-76-23/04/2013*****************************************/

/***********************************I-DEP-AAO-ALM-56-03/05/2013*****************************************/
select pxp.f_insert_testructura_gui ('REPOR', 'ALM');
select pxp.f_insert_testructura_gui ('REPEXIST', 'REPOR');
select pxp.f_insert_testructura_gui ('ALREMA.3', 'ALREMA');
select pxp.f_insert_testructura_gui ('ALREMA.3.1', 'ALREMA.3');
select pxp.f_insert_testructura_gui ('ALCLMA.1.3', 'ALCLMA.1');
select pxp.f_insert_testructura_gui ('ALCLMA.1.3.1', 'ALCLMA.1.3');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_SEL', 'ALREMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_INS', 'ALREMA.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_MOD', 'ALREMA.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_ELI', 'ALREMA.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_SEL', 'ALREMA.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALREMA.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'ALREMA.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'ALREMA.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'ALREMA.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'ALREMA.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'ALREMA.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'ALREMA.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALREMA.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_INS', 'ALCLMA.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_MOD', 'ALCLMA.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_ELI', 'ALCLMA.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_SEL', 'ALCLMA.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALCLMA.1.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'ALCLMA.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'ALCLMA.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'ALCLMA.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'ALCLMA.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'ALCLMA.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'ALCLMA.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALCLMA.1.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'REPEXIST', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'REPEXIST', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_REPEXIST_SEL', 'REPEXIST', 'no');
select pxp.f_insert_tgui_rol ('REPOR', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('REPEXIST', 'Administrador Almacenes');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALM_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_REPEXIST_SEL', 'REPEXIST');
/***********************************F-DEP-AAO-ALM-56-03/05/2013*****************************************/

/***********************************I-DEP-GSS-ALM-69-05/07/2013*****************************************/

ALTER TABLE alm.tmovimiento_tipo
  ALTER COLUMN id_proceso_macro SET NOT NULL;

ALTER TABLE alm.tmovimiento_tipo
  ADD CONSTRAINT fk_tmovimiento_tipo__id_proceso_macro FOREIGN KEY (id_proceso_macro)
    REFERENCES wf.tproceso_macro(id_proceso_macro)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
  
/***********************************F-DEP-GSS-ALM-69-05/07/2013*****************************************/