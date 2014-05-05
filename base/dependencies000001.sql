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
/*
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

*/


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
    
ALTER TABLE alm.tpreingreso
  ADD CONSTRAINT chk_tpreingreso__tipo CHECK (tipo in ('almacen','activo_fijo'));
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

/***********************************I-DEP-RCM-ALM-0-31/12/2013*****************************************/
ALTER TABLE alm.talmacen_gestion_log
  ADD CONSTRAINT fk_talmacen_gestion_log__id_almacen_gestion FOREIGN KEY (id_almacen_gestion)
    REFERENCES alm.talmacen_gestion(id_almacen_gestion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
/***********************************F-DEP-RCM-ALM-0-31/12/2013*****************************************/

/***********************************I-DEP-RCM-ALM-0-02/01/2014*****************************************/

CREATE TRIGGER tr_talmacen_gestion BEFORE DELETE 
ON alm.talmacen_gestion FOR EACH ROW 
EXECUTE PROCEDURE alm.f_tri_talmacen_gestion();

ALTER TABLE alm.talmacen_gestion_log
  DROP CONSTRAINT fk_talmacen_gestion_log__id_almacen_gestion RESTRICT;

ALTER TABLE alm.talmacen_gestion_log
  ADD CONSTRAINT fk_talmacen_gestion_log__id_almacen_gestion FOREIGN KEY (id_almacen_gestion)
    REFERENCES alm.talmacen_gestion(id_almacen_gestion)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

/***********************************F-DEP-RCM-ALM-0-02/01/2014*****************************************/

/***********************************I-DEP-RCM-ALM-0-15/01/2014*****************************************/
ALTER TABLE alm.tmovimiento_det_valorado
  DROP CONSTRAINT fk_tmovimiento_det_valorado__id_movimiento_det RESTRICT;

ALTER TABLE alm.tmovimiento_det_valorado
  ADD CONSTRAINT fk_tmovimiento_det_valorado__id_movimiento_det FOREIGN KEY (id_movimiento_det)
    REFERENCES alm.tmovimiento_det(id_movimiento_det)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
    NOT DEFERRABLE;
    
ALTER TABLE alm.tmovimiento_det
  DROP CONSTRAINT fk_tmovimiento_det__id_movimiento RESTRICT;

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
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILUSU_SEL', 'ALCRAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILEPUO_SEL', 'ALCRAL', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALCRAL.2.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALCRAL.2.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALCRAL.2.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'ALCRAL.2.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMGES_INS', 'ALCRAL.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMGES_MOD', 'ALCRAL.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMGES_ELI', 'ALCRAL.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMGES_SEL', 'ALCRAL.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ACCGES_INS', 'ALCRAL.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_SEL', 'ALCRAL.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_AGLOG_INS', 'ALCRAL.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_AGLOG_MOD', 'ALCRAL.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_AGLOG_ELI', 'ALCRAL.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_AGLOG_SEL', 'ALCRAL.5.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GETGES_ELI', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVREPORT_SEL', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVTIP_SEL', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_FUNCIOCAR_SEL', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROVEEV_SEL', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOV_SEL', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPPTO_SEL', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUSUCOMB_SEL', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILUSU_SEL', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILEPUO_SEL', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOV_INS', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOV_MOD', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOV_ELI', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVCNL_MOD', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVREV_MOD', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVFIN_MOD', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SIGEST_SEL', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVPRE_REV', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ALCRAL.5.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIG_SEL', 'ALCRAL.5.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIGPP_SEL', 'ALCRAL.5.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVDET_INS', 'ALCRAL.5.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVDET_MOD', 'ALCRAL.5.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVDET_ELI', 'ALCRAL.5.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVDET_SEL', 'ALCRAL.5.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALCRAL.5.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALCRAL.5.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALCRAL.5.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DETVAL_SEL', 'ALCRAL.5.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_INS', 'ALCRAL.5.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_MOD', 'ALCRAL.5.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_ELI', 'ALCRAL.5.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARMCOR_SEL', 'ALCRAL.5.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_SEL', 'ALCRAL.5.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'ALREMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_SEL', 'ALREMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALREMA.1.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALREMA.1.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALREMA.1.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'ALREMA.1.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_INS', 'ALREMA.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_MOD', 'ALREMA.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_ELI', 'ALREMA.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_SEL', 'ALREMA.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALREMA.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'ALREMA.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'ALREMA.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'ALREMA.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'ALREMA.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'ALREMA.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'ALREMA.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALREMA.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_CLADD_MOD', 'ALCLMA', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'ALCLMA.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALCLMA.1.1.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALCLMA.1.1.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALCLMA.1.1.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'ALCLMA.1.1.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_INS', 'ALCLMA.1.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_MOD', 'ALCLMA.1.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_ELI', 'ALCLMA.1.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_UME_SEL', 'ALCLMA.1.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALCLMA.1.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'ALCLMA.1.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'ALCLMA.1.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'ALCLMA.1.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'ALCLMA.1.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'ALCLMA.1.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'ALCLMA.1.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALCLMA.1.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_TIMITE_INS', 'MOVTIP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_TIMITE_ELI', 'MOVTIP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_TIMITE_SEL', 'MOVTIP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'MOVTIP.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_GUIROL_INS', 'MOVTIP.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'MOVTIP.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'MOVTIP.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_TIMVUO_INS', 'MOVTIP.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_TIMVUO_ELI', 'MOVTIP.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_TIMVUO_SEL', 'MOVTIP.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_INIUOARB_SEL', 'MOVTIP.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_ESTRUO_SEL', 'MOVTIP.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_NIVORG_SEL', 'MOVTIP.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TIPCON_SEL', 'MOVTIP.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_OFI_SEL', 'MOVTIP.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TCARGO_SEL', 'MOVTIP.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_ESCSAL_SEL', 'MOVTIP.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_INS', 'MOVTIP.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_MOD', 'MOVTIP.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_ELI', 'MOVTIP.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_SEL', 'MOVTIP.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOM_SEL', 'MOVTIP.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_INS', 'MOVTIP.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_MOD', 'MOVTIP.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_ELI', 'MOVTIP.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_SEL', 'MOVTIP.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_SEL', 'MOVTIP.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CEC_SEL', 'MOVTIP.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOMFU_SEL', 'MOVTIP.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CCFILDEP_SEL', 'MOVTIP.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOM_SEL', 'MOVTIP.2.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_INS', 'MOVTIP.2.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_MOD', 'MOVTIP.2.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_ELI', 'MOVTIP.2.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_SEL', 'MOVTIP.2.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_SEL', 'MOVTIP.2.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CEC_SEL', 'MOVTIP.2.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOMFU_SEL', 'MOVTIP.2.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CCFILDEP_SEL', 'MOVTIP.2.1.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_SEL', 'MOVTIP.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'MOVTIP.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'MOVTIP.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_INS', 'MOVTIP.2.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_MOD', 'MOVTIP.2.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_ELI', 'MOVTIP.2.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'MOVTIP.2.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'MOVTIP.2.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'MOVTIP.2.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOVTIP.2.1.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_INS', 'MOVTIP.2.1.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_MOD', 'MOVTIP.2.1.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_ELI', 'MOVTIP.2.1.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_SEL', 'MOVTIP.2.1.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'MOVTIP.2.1.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'MOVTIP.2.1.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'MOVTIP.2.1.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'MOVTIP.2.1.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'MOVTIP.2.1.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'MOVTIP.2.1.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOVTIP.2.1.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'MOVTIP.2.1.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'MOVTIP.2.1.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'MOVTIP.2.1.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOVTIP.2.1.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'MOVTIP.2.1.2.1.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'MOVTIP.2.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'MOVTIP.2.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'MOVTIP.2.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOVTIP.2.1.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'CATLOG', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_FUNCIOCAR_SEL', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPPTO_SEL', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUSUCOMB_SEL', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILUSU_SEL', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILEPUO_SEL', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SIGEST_SEL', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVPRE_REV', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'MOV', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIG_SEL', 'MOV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIGPP_SEL', 'MOV.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'MOV.1.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'MOV.1.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'MOV.1.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'MOV.1.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'INVMAIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMUSR_SEL', 'INVMAIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_INS', 'INVMAIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_MOD', 'INVMAIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_ELI', 'INVMAIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_SEL', 'INVMAIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'INVMAIN.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_SEL', 'INVMAIN.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'INVMAIN.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'INVMAIN.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_INS', 'INVMAIN.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_MOD', 'INVMAIN.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_ELI', 'INVMAIN.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_SEL', 'INVMAIN.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'INVMAIN.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'INVMAIN.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'INVMAIN.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'INVMAIN.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_GUIROL_INS', 'INVMAIN.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'INVMAIN.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'INVMAIN.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVFINREG_MOD', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVREVDIF_MOD', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVFINREV_MOD', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVCORRREV_MOD', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMUSR_SEL', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_INS', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_MOD', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_ELI', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_SEL', 'ORDINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ORDINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_SEL', 'ORDINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ORDINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ORDINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_INS', 'ORDINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_MOD', 'ORDINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_ELI', 'ORDINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_SEL', 'ORDINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ORDINV.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ORDINV.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ORDINV.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'ORDINV.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_GUIROL_INS', 'ORDINV.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ORDINV.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ORDINV.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVINIEJE_MOD', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INVFINEJE_MOD', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALMUSR_SEL', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_INS', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_MOD', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_ELI', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INV_SEL', 'EJEINV', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'EJEINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_SEL', 'EJEINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'EJEINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'EJEINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_INS', 'EJEINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_MOD', 'EJEINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_ELI', 'EJEINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DINV_SEL', 'EJEINV.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'EJEINV.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'EJEINV.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'EJEINV.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'EJEINV.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_GUIROL_INS', 'EJEINV.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'EJEINV.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'EJEINV.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_INS', 'PERI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_MOD', 'PERI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_ELI', 'PERI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PESU_SEL', 'PERI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_SWESTPE_MOD', 'PERI', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'REPEXIST', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'REPEXIST', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_REPEXIST_SEL', 'REPEXIST', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'REPEXIST', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_GUIROL_INS', 'REPEXIST.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'REPEXIST.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'REPEXIST.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'REPEXIST.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'REPEXIST.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'REPEXIST.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'REPEXIST.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'REPEXIST.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'REPEXIST.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'REPEXIST.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_FUNCIOCAR_SEL', 'MOVALM', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPPTO_SEL', 'MOVALM', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUSUCOMB_SEL', 'MOVALM', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILUSU_SEL', 'MOVALM', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILEPUO_SEL', 'MOVALM', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SIGEST_SEL', 'MOVALM', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'MOVALM', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVPRE_REV', 'MOVALM', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'MOVALM', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIG_SEL', 'MOVALM.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIGPP_SEL', 'MOVALM.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'MOVALM.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIG_SEL', 'MOVALM.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIGPP_SEL', 'MOVALM.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVFIN_MOD', 'MOVVB', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_FUNCIOCAR_SEL', 'MOVVB', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPPTO_SEL', 'MOVVB', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUSUCOMB_SEL', 'MOVVB', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILUSU_SEL', 'MOVVB', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILEPUO_SEL', 'MOVVB', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SIGEST_SEL', 'MOVVB', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVPRE_REV', 'MOVVB', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'MOVVB', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIG_SEL', 'MOVVB.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIGPP_SEL', 'MOVVB.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'MOVVB.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIG_SEL', 'MOVVB.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIGPP_SEL', 'MOVVB.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILUSU_SEL', 'PREING', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREING_INS', 'PREING', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREING_MOD', 'PREING', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREING_ELI', 'PREING', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREING_SEL', 'PREING', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INGRES_GEN', 'PREING', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREING_REV', 'PREING', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'PREING', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUSUCOMB_SEL', 'PREING', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_MONEDA_SEL', 'PREING', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'PREING.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'PREING.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILUSU_SEL', 'PREING.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREDET_INS', 'PREING.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREDET_MOD', 'PREING.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREDET_ELI', 'PREING.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREDET_SEL', 'PREING.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'PREING.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'PREING.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'PREING.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'PREING.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'PREING.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'PREING.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'PREING.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'PREING.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'PREING.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'PREING.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'PREING.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'PREING.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'PREING.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'PREING.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'PREING.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'PREING.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'PREING.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'PREING.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'PREING.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALBUSQ', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALBUSQ', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALBUSQ', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'ALBUSQ.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'ALPREIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILUSU_SEL', 'ALPREIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREING_INS', 'ALPREIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREING_MOD', 'ALPREIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREING_ELI', 'ALPREIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREING_SEL', 'ALPREIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_INGRES_GEN', 'ALPREIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREING_REV', 'ALPREIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALPREIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUSUCOMB_SEL', 'ALPREIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_MONEDA_SEL', 'ALPREIN', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ALPREIN.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'ALPREIN.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILUSU_SEL', 'ALPREIN.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREDET_INS', 'ALPREIN.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREDET_MOD', 'ALPREIN.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREDET_ELI', 'ALPREIN.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_PREDET_SEL', 'ALPREIN.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALPREIN.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALPREIN.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALPREIN.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALPREIN.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'ALPREIN.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'ALPREIN.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'ALPREIN.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'ALPREIN.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'ALPREIN.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'ALPREIN.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'ALPREIN.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALPREIN.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'ALPREIN.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'ALPREIN.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'ALPREIN.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'ALPREIN.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'ALPREIN.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'ALPREIN.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALPREIN.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'SALGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_SALGRU_INS', 'SALGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_SALGRU_MOD', 'SALGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_SALGRU_ELI', 'SALGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_SALGRU_SEL', 'SALGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_SALGRU_FIN', 'SALGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_SALGRU_RET', 'SALGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'SALGRU.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_SAGRIT_INS', 'SALGRU.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_SAGRIT_MOD', 'SALGRU.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_SAGRIT_ELI', 'SALGRU.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_SAGRIT_SEL', 'SALGRU.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'SALGRU.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'SALGRU.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'SALGRU.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'SALGRU.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_FUNCIOCAR_SEL', 'SALGRU.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_GRITFU_INS', 'SALGRU.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_GRITFU_MOD', 'SALGRU.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_GRITFU_ELI', 'SALGRU.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_GRITFU_SEL', 'SALGRU.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'SALGRU.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'MOVGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPPTO_SEL', 'MOVGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUSUCOMB_SEL', 'MOVGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILUSU_SEL', 'MOVGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILEPUO_SEL', 'MOVGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVGRU_INS', 'MOVGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVGRU_MOD', 'MOVGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVGRU_ELI', 'MOVGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVGRU_SEL', 'MOVGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVGRU_GEN', 'MOVGRU', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVREPORT_SEL', 'MOVGRU.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOGRDE_INS', 'MOVGRU.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOGRDE_MOD', 'MOVGRU.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOGRDE_ELI', 'MOVGRU.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOGRDE_SEL', 'MOVGRU.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_AGMOV_GET', 'ALCRAL.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVREPORT_SEL', 'ALCRAL.5', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'ALCRAL.5.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_INS', 'ALCRAL.5.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_MOD', 'ALCRAL.5.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_ELI', 'ALCRAL.5.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'ALCRAL.5.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'ALCRAL.5.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'ALCRAL.5.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ALCRAL.5.2.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_INS', 'ALCRAL.5.2.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_MOD', 'ALCRAL.5.2.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_ELI', 'ALCRAL.5.2.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_SEL', 'ALCRAL.5.2.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'ALCRAL.5.2.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'ALCRAL.5.2.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'ALCRAL.5.2.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'ALCRAL.5.2.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'ALCRAL.5.2.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'ALCRAL.5.2.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ALCRAL.5.2.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'ALCRAL.5.2.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'ALCRAL.5.2.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'ALCRAL.5.2.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ALCRAL.5.2.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'ALCRAL.5.2.3.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'ALCRAL.5.2.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'ALCRAL.5.2.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'ALCRAL.5.2.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ALCRAL.5.2.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_INS', 'MOV.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_MOD', 'MOV.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_ELI', 'MOV.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'MOV.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'MOV.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'MOV.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOV.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_INS', 'MOV.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_MOD', 'MOV.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_ELI', 'MOV.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_SEL', 'MOV.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'MOV.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'MOV.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'MOV.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'MOV.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'MOV.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'MOV.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOV.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'MOV.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'MOV.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'MOV.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOV.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'MOV.3.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'MOV.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'MOV.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'MOV.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOV.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ANTEMOV_IME', 'MOVALM', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_SIGEMOV_IME', 'MOVALM', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_INS', 'MOVALM.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_MOD', 'MOVALM.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_ELI', 'MOVALM.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'MOVALM.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'MOVALM.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'MOVALM.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOVALM.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_INS', 'MOVALM.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_MOD', 'MOVALM.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_ELI', 'MOVALM.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_SEL', 'MOVALM.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'MOVALM.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'MOVALM.4.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'MOVALM.4.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'MOVALM.4.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'MOVALM.4.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'MOVALM.4.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOVALM.4.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'MOVALM.4.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'MOVALM.4.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'MOVALM.4.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOVALM.4.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'MOVALM.4.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'MOVALM.4.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'MOVALM.4.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'MOVALM.4.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOVALM.4.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_INS', 'MOVVB.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_MOD', 'MOVVB.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_ELI', 'MOVVB.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'MOVVB.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'MOVVB.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'MOVVB.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOVVB.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_INS', 'MOVVB.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_MOD', 'MOVVB.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_ELI', 'MOVVB.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_SEL', 'MOVVB.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'MOVVB.4.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'MOVVB.4.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'MOVVB.4.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'MOVVB.4.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'MOVVB.4.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'MOVVB.4.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOVVB.4.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'MOVVB.4.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'MOVVB.4.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'MOVVB.4.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOVVB.4.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'MOVVB.4.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'MOVVB.4.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'MOVVB.4.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'MOVVB.4.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'MOVVB.4.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'KARITE', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'KARITE', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_RKARIT_SEL', 'KARITE', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_RKARIT_SEL', 'KARITE.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROVEEV_SEL', 'ALREPIEI', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'ALREPIEI', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'ALREPIEI', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ALREPIEI', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'ALREPIEI', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_REITEN_SEL', 'ALREPIEI', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALREPIEI', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_GUIROL_INS', 'ALREPIEI.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALREPIEI.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALREPIEI.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_INIUOARB_SEL', 'ALREPIEI.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_ESTRUO_SEL', 'ALREPIEI.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_NIVORG_SEL', 'ALREPIEI.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TIPCON_SEL', 'ALREPIEI.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_OFI_SEL', 'ALREPIEI.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_TCARGO_SEL', 'ALREPIEI.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_ESCSAL_SEL', 'ALREPIEI.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_INS', 'ALREPIEI.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_MOD', 'ALREPIEI.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_ELI', 'ALREPIEI.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_SEL', 'ALREPIEI.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOM_SEL', 'ALREPIEI.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_INS', 'ALREPIEI.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_MOD', 'ALREPIEI.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_ELI', 'ALREPIEI.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARPRE_SEL', 'ALREPIEI.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_SEL', 'ALREPIEI.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CEC_SEL', 'ALREPIEI.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOMFU_SEL', 'ALREPIEI.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CCFILDEP_SEL', 'ALREPIEI.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOM_SEL', 'ALREPIEI.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_INS', 'ALREPIEI.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_MOD', 'ALREPIEI.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_ELI', 'ALREPIEI.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARCC_SEL', 'ALREPIEI.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GES_SEL', 'ALREPIEI.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CEC_SEL', 'ALREPIEI.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CECCOMFU_SEL', 'ALREPIEI.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CCFILDEP_SEL', 'ALREPIEI.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_CARGO_SEL', 'ALREPIEI.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'ALREPIEI.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'ALREPIEI.2.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_INS', 'ALREPIEI.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_MOD', 'ALREPIEI.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_ELI', 'ALREPIEI.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'ALREPIEI.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'ALREPIEI.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'ALREPIEI.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_INS', 'ALREPIEI.2.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_MOD', 'ALREPIEI.2.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_ELI', 'ALREPIEI.2.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_SEL', 'ALREPIEI.2.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'ALREPIEI.2.2.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'ALREPIEI.2.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'ALREPIEI.2.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'ALREPIEI.2.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'ALREPIEI.2.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'ALREPIEI.2.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'ALREPIEI.2.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'ALREPIEI.2.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'ALREPIEI.2.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'ALREPIEI.2.2.1.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'ALREPIEI.2.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'ALREPIEI.2.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'ALREPIEI.2.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_REITEN_SEL', 'ALREPIEI.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_SUBSIS_SEL', 'ALREPIEI.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PACATI_SEL', 'ALREPIEI.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_INS', 'ALREPIEI.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_MOD', 'ALREPIEI.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_ELI', 'ALREPIEI.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CAT_SEL', 'ALREPIEI.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALREPIEI.4', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GETGES_ELI', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVREPORT_SEL', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVTIP_SEL', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ALM_SEL', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_PROVEEV_SEL', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOV_SEL', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPPTO_SEL', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPUSUCOMB_SEL', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILUSU_SEL', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_DEPFILEPUO_SEL', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOV_INS', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOV_MOD', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOV_ELI', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVCNL_MOD', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVREV_MOD', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVFIN_MOD', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_SIGEST_SEL', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('WF_FUNTIPES_SEL', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVPRE_REV', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CATCMB_SEL', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'ALSALID', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITEMNOTBASE_SEL', 'ALSALID.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIG_SEL', 'ALSALID.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_CONIGPP_SEL', 'ALSALID.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVDET_INS', 'ALSALID.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVDET_MOD', 'ALSALID.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVDET_ELI', 'ALSALID.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_MOVDET_SEL', 'ALSALID.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('ALM_CLA_ARB_SEL', 'ALSALID.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ARB_SEL', 'ALSALID.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMSRCHARB_SEL', 'ALSALID.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_ITMALM_SEL', 'ALSALID.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SAL_DETVAL_SEL', 'ALSALID.1.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_INS', 'ALSALID.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_MOD', 'ALSALID.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_ELI', 'ALSALID.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARMCOR_SEL', 'ALSALID.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_ALARM_SEL', 'ALSALID.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_INS', 'ALSALID.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_MOD', 'ALSALID.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_ELI', 'ALSALID.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIO_SEL', 'ALSALID.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('RH_FUNCIOCAR_SEL', 'ALSALID.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'ALSALID.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ALSALID.3', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_INS', 'ALSALID.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_MOD', 'ALSALID.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_ELI', 'ALSALID.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('OR_FUNCUE_SEL', 'ALSALID.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'ALSALID.3.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_INS', 'ALSALID.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_MOD', 'ALSALID.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_ELI', 'ALSALID.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_INSTIT_SEL', 'ALSALID.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_SEL', 'ALSALID.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ALSALID.3.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'ALSALID.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'ALSALID.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'ALSALID.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ALSALID.3.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_UPFOTOPER_MOD', 'ALSALID.3.1.1.1.1', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_INS', 'ALSALID.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_MOD', 'ALSALID.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSON_ELI', 'ALSALID.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('SEG_PERSONMIN_SEL', 'ALSALID.3.2', 'no');
select pxp.f_insert_tprocedimiento_gui ('PM_GETGES_ELI', 'MOVALM', 'no');
select pxp.f_insert_tgui_rol ('SISTEMA', 'Almacenero');
select pxp.f_insert_tgui_rol ('REPOR', 'Almacenero');
select pxp.f_insert_tgui_rol ('ALREPIEI', 'Almacenero');
select pxp.f_insert_tgui_rol ('ALREPIEI.4', 'Almacenero');
select pxp.f_insert_tgui_rol ('ALREPIEI.3', 'Almacenero');
select pxp.f_insert_tgui_rol ('ALREPIEI.2', 'Almacenero');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2', 'Almacenero');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1', 'Almacenero');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.2', 'Almacenero');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1', 'Almacenero');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1.1', 'Almacenero');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1.1.1', 'Almacenero');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1.1.1.1', 'Almacenero');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.1', 'Almacenero');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.1.2', 'Almacenero');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.1.1', 'Almacenero');
select pxp.f_insert_tgui_rol ('ALREPIEI.1', 'Almacenero');
select pxp.f_insert_tgui_rol ('KARITE', 'Almacenero');
select pxp.f_insert_tgui_rol ('KARITE.1', 'Almacenero');
select pxp.f_insert_tgui_rol ('REPEXIST', 'Almacenero');
select pxp.f_insert_tgui_rol ('REPEXIST.2', 'Almacenero');
select pxp.f_insert_tgui_rol ('REPEXIST.1', 'Almacenero');
select pxp.f_insert_tgui_rol ('REPOR', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALM', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('SISTEMA', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALREPIEI', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALREPIEI.4', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALREPIEI.3', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALREPIEI.2', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.2', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1.1.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1.1.1.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.1.2', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.1.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALREPIEI.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('KARITE', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('KARITE.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('REPEXIST', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('REPEXIST.2', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('REPEXIST.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('REPOR', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('SISTEMA', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.4', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.3', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.2', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1.1.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1.1.1.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.1.2', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.1.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('KARITE', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('KARITE.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('REPEXIST', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('REPEXIST.2', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('REPEXIST.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM.1.2', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM.1.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM.1.1.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM.2', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM.2.2', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM.2.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM.3', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM.4', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM.4.2', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM.4.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM.4.1.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM.4.1.1.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM.4.1.1.1.1', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOV', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALMOVI', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALM', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('SISTEMA', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.3', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.3.2', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.3.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.3.1.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.3.1.1.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.3.1.1.1.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.2', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.1.4', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.1.4.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOV.1.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('MOVALM', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('REPOR', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.4', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.3', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.2', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1.1.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.2.1.1.1.1.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.1.2', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.2.1.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('ALREPIEI.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('KARITE', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('KARITE.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('REPEXIST', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('REPEXIST.2', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('REPEXIST.1', 'ALM - Asistente de Almacenes');
select pxp.f_insert_tgui_rol ('PERI', 'Administrador Almacenes');
select pxp.f_insert_tgui_rol ('MOV.1.4.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('MOV.1.4', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('MOV.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('MOV', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('ALMOVI', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('MOV.1.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('MOV.3.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('MOV.3', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('MOV.3.1.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('MOV.3.1.1.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('PREING', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('PREING.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('PREING.1.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('PREING.1.1.1', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('PREING.1.2', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('PREING.2', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('MOV.3.2', 'ALM - Consulta');
select pxp.f_insert_tgui_rol ('MOV.2', 'ALM - Consulta');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_GETGES_ELI', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_PROVEEV_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'RH_FUNCIO_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'RH_FUNCIOCAR_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SAL_ITEMNOTBASE_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SAL_ALM_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SAL_REITEN_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CATCMB_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_SUBSIS_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_PACATI_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CAT_INS', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CAT_MOD', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CAT_ELI', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CAT_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CATCMB_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SAL_REITEN_SEL', 'ALREPIEI.3');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'RH_INIUOARB_SEL', 'ALREPIEI.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'RH_ESTRUO_SEL', 'ALREPIEI.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_NIVORG_SEL', 'ALREPIEI.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_CARGO_SEL', 'ALREPIEI.2.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'RH_FUNCIO_SEL', 'ALREPIEI.2.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'RH_FUNCIOCAR_SEL', 'ALREPIEI.2.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'RH_FUNCIO_INS', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'RH_FUNCIO_MOD', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'RH_FUNCIO_ELI', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'RH_FUNCIO_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'RH_FUNCIOCAR_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_PERSON_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_PERSON_INS', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_PERSON_MOD', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_PERSON_ELI', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_FUNCUE_INS', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_FUNCUE_MOD', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_FUNCUE_ELI', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_FUNCUE_SEL', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_INSTIT_SEL', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_INSTIT_INS', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_INSTIT_MOD', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_INSTIT_ELI', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_INSTIT_SEL', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_PERSON_SEL', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_PERSON_INS', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_PERSON_MOD', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_PERSON_ELI', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_UPFOTOPER_MOD', 'ALREPIEI.2.2.1.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_TIPCON_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_OFI_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_TCARGO_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_ESCSAL_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_CARGO_INS', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_CARGO_MOD', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_CARGO_ELI', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_CARGO_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CECCOM_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_CARCC_INS', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_CARCC_MOD', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_CARCC_ELI', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_CARCC_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_GES_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CEC_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CECCOMFU_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CCFILDEP_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CECCOM_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_CARPRE_INS', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_CARPRE_MOD', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_CARPRE_ELI', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'OR_CARPRE_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_GES_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CEC_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CECCOMFU_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CCFILDEP_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_GUIROL_INS', 'ALREPIEI.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'ALM_CLA_ARB_SEL', 'ALREPIEI.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SAL_ARB_SEL', 'ALREPIEI.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SAL_ITEMNOTBASE_SEL', 'KARITE');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SAL_ALM_SEL', 'KARITE');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SAL_RKARIT_SEL', 'KARITE');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SAL_RKARIT_SEL', 'KARITE.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SAL_ALM_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SAL_ITEMNOTBASE_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SAL_REPEXIST_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CATCMB_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_SUBSIS_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_PACATI_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CAT_INS', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CAT_MOD', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CAT_ELI', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CAT_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'PM_CATCMB_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SEG_GUIROL_INS', 'REPEXIST.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'ALM_CLA_ARB_SEL', 'REPEXIST.1');
select pxp.f_insert_trol_procedimiento_gui ('Almacenero', 'SAL_ARB_SEL', 'REPEXIST.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_PROVEEV_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'RH_FUNCIO_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'RH_FUNCIOCAR_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ITEMNOTBASE_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ALM_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_REITEN_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CATCMB_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_SUBSIS_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_PACATI_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CAT_INS', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CAT_MOD', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CAT_ELI', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CAT_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CATCMB_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_REITEN_SEL', 'ALREPIEI.3');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'RH_INIUOARB_SEL', 'ALREPIEI.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'RH_ESTRUO_SEL', 'ALREPIEI.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_NIVORG_SEL', 'ALREPIEI.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_CARGO_SEL', 'ALREPIEI.2.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'RH_FUNCIO_SEL', 'ALREPIEI.2.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'RH_FUNCIOCAR_SEL', 'ALREPIEI.2.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'RH_FUNCIO_INS', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'RH_FUNCIO_MOD', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'RH_FUNCIO_ELI', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'RH_FUNCIO_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'RH_FUNCIOCAR_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSON_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSON_INS', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSON_MOD', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSON_ELI', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_FUNCUE_INS', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_FUNCUE_MOD', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_FUNCUE_ELI', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_FUNCUE_SEL', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_INSTIT_SEL', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_INSTIT_INS', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_INSTIT_MOD', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_INSTIT_ELI', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_INSTIT_SEL', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSON_SEL', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSON_INS', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSON_MOD', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSON_ELI', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_UPFOTOPER_MOD', 'ALREPIEI.2.2.1.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_TIPCON_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_OFI_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_TCARGO_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_ESCSAL_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_CARGO_INS', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_CARGO_MOD', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_CARGO_ELI', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_CARGO_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CECCOM_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_CARCC_INS', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_CARCC_MOD', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_CARCC_ELI', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_CARCC_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_GES_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CEC_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CECCOMFU_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CCFILDEP_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CECCOM_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_CARPRE_INS', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_CARPRE_MOD', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_CARPRE_ELI', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_CARPRE_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_GES_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CEC_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CECCOMFU_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CCFILDEP_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_GUIROL_INS', 'ALREPIEI.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'ALM_CLA_ARB_SEL', 'ALREPIEI.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ARB_SEL', 'ALREPIEI.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ITEMNOTBASE_SEL', 'KARITE');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ALM_SEL', 'KARITE');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_RKARIT_SEL', 'KARITE');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_RKARIT_SEL', 'KARITE.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ALM_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ITEMNOTBASE_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_REPEXIST_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CATCMB_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_SUBSIS_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_PACATI_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CAT_INS', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CAT_MOD', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CAT_ELI', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CAT_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CATCMB_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_GUIROL_INS', 'REPEXIST.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'ALM_CLA_ARB_SEL', 'REPEXIST.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ARB_SEL', 'REPEXIST.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_PROVEEV_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIOCAR_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALM_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_REITEN_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CATCMB_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_SUBSIS_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_PACATI_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CAT_INS', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CAT_MOD', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CAT_ELI', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CAT_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CATCMB_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_REITEN_SEL', 'ALREPIEI.3');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_INIUOARB_SEL', 'ALREPIEI.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_ESTRUO_SEL', 'ALREPIEI.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_NIVORG_SEL', 'ALREPIEI.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_CARGO_SEL', 'ALREPIEI.2.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_SEL', 'ALREPIEI.2.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIOCAR_SEL', 'ALREPIEI.2.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_INS', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_MOD', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_ELI', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIOCAR_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_INS', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_MOD', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_ELI', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_FUNCUE_INS', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_FUNCUE_MOD', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_FUNCUE_ELI', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_FUNCUE_SEL', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_INSTIT_SEL', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_INSTIT_INS', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_INSTIT_MOD', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_INSTIT_ELI', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_INSTIT_SEL', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_SEL', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_INS', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_MOD', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_ELI', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_UPFOTOPER_MOD', 'ALREPIEI.2.2.1.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_TIPCON_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_OFI_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_TCARGO_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_ESCSAL_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_CARGO_INS', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_CARGO_MOD', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_CARGO_ELI', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_CARGO_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CECCOM_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_CARCC_INS', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_CARCC_MOD', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_CARCC_ELI', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_CARCC_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_GES_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CEC_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CECCOMFU_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CCFILDEP_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CECCOM_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_CARPRE_INS', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_CARPRE_MOD', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_CARPRE_ELI', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_CARPRE_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_GES_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CEC_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CECCOMFU_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CCFILDEP_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_GUIROL_INS', 'ALREPIEI.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'ALM_CLA_ARB_SEL', 'ALREPIEI.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ARB_SEL', 'ALREPIEI.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'KARITE');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALM_SEL', 'KARITE');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_RKARIT_SEL', 'KARITE');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_RKARIT_SEL', 'KARITE.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALM_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_REPEXIST_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CATCMB_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_SUBSIS_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_PACATI_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CAT_INS', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CAT_MOD', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CAT_ELI', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CAT_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CATCMB_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_GUIROL_INS', 'REPEXIST.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'ALM_CLA_ARB_SEL', 'REPEXIST.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ARB_SEL', 'REPEXIST.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVFIN_MOD', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVREPORT_SEL', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVTIP_SEL', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALM_SEL', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_SEL', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIOCAR_SEL', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_PROVEEV_SEL', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOV_SEL', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOV_INS', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOV_MOD', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOV_ELI', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVCNL_MOD', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVREV_MOD', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_FUNCIOCAR_SEL', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_DEPPTO_SEL', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_DEPUSUCOMB_SEL', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_DEPFILUSU_SEL', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_DEPFILEPUO_SEL', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'WF_SIGEST_SEL', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'WF_FUNTIPES_SEL', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVPRE_REV', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CATCMB_SEL', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ANTEMOV_IME', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_SIGEMOV_IME', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_GETGES_ELI', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'MOVALM.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_INS', 'MOVALM.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_MOD', 'MOVALM.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_ELI', 'MOVALM.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_SEL', 'MOVALM.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CONIG_SEL', 'MOVALM.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CONIGPP_SEL', 'MOVALM.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_DETVAL_SEL', 'MOVALM.1.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'ALM_CLA_ARB_SEL', 'MOVALM.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ARB_SEL', 'MOVALM.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMSRCHARB_SEL', 'MOVALM.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMALM_SEL', 'MOVALM.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'MOVALM.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_INS', 'MOVALM.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_MOD', 'MOVALM.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_ELI', 'MOVALM.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_SEL', 'MOVALM.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CONIG_SEL', 'MOVALM.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CONIGPP_SEL', 'MOVALM.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_DETVAL_SEL', 'MOVALM.2.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'ALM_CLA_ARB_SEL', 'MOVALM.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ARB_SEL', 'MOVALM.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMSRCHARB_SEL', 'MOVALM.2.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_ALARM_INS', 'MOVALM.3');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_ALARM_MOD', 'MOVALM.3');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_ALARM_ELI', 'MOVALM.3');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_ALARMCOR_SEL', 'MOVALM.3');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_ALARM_SEL', 'MOVALM.3');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_INS', 'MOVALM.4');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_MOD', 'MOVALM.4');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_ELI', 'MOVALM.4');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_SEL', 'MOVALM.4');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIOCAR_SEL', 'MOVALM.4');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_SEL', 'MOVALM.4');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSONMIN_SEL', 'MOVALM.4');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_INS', 'MOVALM.4.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_MOD', 'MOVALM.4.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_ELI', 'MOVALM.4.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSONMIN_SEL', 'MOVALM.4.2');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_FUNCUE_INS', 'MOVALM.4.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_FUNCUE_MOD', 'MOVALM.4.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_FUNCUE_ELI', 'MOVALM.4.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'OR_FUNCUE_SEL', 'MOVALM.4.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_INSTIT_SEL', 'MOVALM.4.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_INSTIT_INS', 'MOVALM.4.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_INSTIT_MOD', 'MOVALM.4.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_INSTIT_ELI', 'MOVALM.4.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_INSTIT_SEL', 'MOVALM.4.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_SEL', 'MOVALM.4.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSONMIN_SEL', 'MOVALM.4.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_INS', 'MOVALM.4.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_MOD', 'MOVALM.4.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_ELI', 'MOVALM.4.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSONMIN_SEL', 'MOVALM.4.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_UPFOTOPER_MOD', 'MOVALM.4.1.1.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVFIN_MOD', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVTIP_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ALM_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOV_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIOCAR_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_PROVEEV_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOV_INS', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOV_MOD', 'MOV');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOV_ELI', 'MOV');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVCNL_MOD', 'MOV');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVREV_MOD', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVREPORT_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_GETGES_ELI', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_FUNCIOCAR_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_DEPPTO_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_DEPUSUCOMB_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_DEPFILUSU_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_DEPFILEPUO_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'WF_SIGEST_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'WF_FUNTIPES_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVPRE_REV', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CATCMB_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_INS', 'MOV.3');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_MOD', 'MOV.3');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_ELI', 'MOV.3');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_SEL', 'MOV.3');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIOCAR_SEL', 'MOV.3');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_SEL', 'MOV.3');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSONMIN_SEL', 'MOV.3');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_INS', 'MOV.3.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_MOD', 'MOV.3.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_ELI', 'MOV.3.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSONMIN_SEL', 'MOV.3.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_FUNCUE_INS', 'MOV.3.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_FUNCUE_MOD', 'MOV.3.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_FUNCUE_ELI', 'MOV.3.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_FUNCUE_SEL', 'MOV.3.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_INSTIT_SEL', 'MOV.3.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_INSTIT_INS', 'MOV.3.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_INSTIT_MOD', 'MOV.3.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_INSTIT_ELI', 'MOV.3.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_INSTIT_SEL', 'MOV.3.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_SEL', 'MOV.3.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSONMIN_SEL', 'MOV.3.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_INS', 'MOV.3.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_MOD', 'MOV.3.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_ELI', 'MOV.3.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSONMIN_SEL', 'MOV.3.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_UPFOTOPER_MOD', 'MOV.3.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_ALARM_INS', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_ALARM_MOD', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_ALARM_ELI', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_ALARMCOR_SEL', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_ALARM_SEL', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ITEMNOTBASE_SEL', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVDET_INS', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVDET_MOD', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVDET_ELI', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVDET_SEL', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CONIG_SEL', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CONIGPP_SEL', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'ALM_CLA_ARB_SEL', 'MOV.1.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ARB_SEL', 'MOV.1.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ITMSRCHARB_SEL', 'MOV.1.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ITMALM_SEL', 'MOV.1.4.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_DETVAL_SEL', 'MOV.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVFIN_MOD', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVREPORT_SEL', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVTIP_SEL', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ALM_SEL', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_SEL', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIOCAR_SEL', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_PROVEEV_SEL', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOV_SEL', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOV_INS', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOV_MOD', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOV_ELI', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVCNL_MOD', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVREV_MOD', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_FUNCIOCAR_SEL', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_DEPPTO_SEL', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_DEPUSUCOMB_SEL', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_DEPFILUSU_SEL', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_DEPFILEPUO_SEL', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'WF_SIGEST_SEL', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'WF_FUNTIPES_SEL', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVPRE_REV', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CATCMB_SEL', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ANTEMOV_IME', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_SIGEMOV_IME', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_GETGES_ELI', 'MOVALM');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ITEMNOTBASE_SEL', 'MOVALM.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVDET_INS', 'MOVALM.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVDET_MOD', 'MOVALM.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVDET_ELI', 'MOVALM.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVDET_SEL', 'MOVALM.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CONIG_SEL', 'MOVALM.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CONIGPP_SEL', 'MOVALM.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_DETVAL_SEL', 'MOVALM.1.2');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'ALM_CLA_ARB_SEL', 'MOVALM.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ARB_SEL', 'MOVALM.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ITMSRCHARB_SEL', 'MOVALM.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ITMALM_SEL', 'MOVALM.1.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ITEMNOTBASE_SEL', 'MOVALM.2');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVDET_INS', 'MOVALM.2');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVDET_MOD', 'MOVALM.2');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVDET_ELI', 'MOVALM.2');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOVDET_SEL', 'MOVALM.2');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CONIG_SEL', 'MOVALM.2');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CONIGPP_SEL', 'MOVALM.2');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_DETVAL_SEL', 'MOVALM.2.2');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'ALM_CLA_ARB_SEL', 'MOVALM.2.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ARB_SEL', 'MOVALM.2.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ITMSRCHARB_SEL', 'MOVALM.2.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_ALARM_INS', 'MOVALM.3');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_ALARM_MOD', 'MOVALM.3');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_ALARM_ELI', 'MOVALM.3');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_ALARMCOR_SEL', 'MOVALM.3');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_ALARM_SEL', 'MOVALM.3');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_INS', 'MOVALM.4');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_MOD', 'MOVALM.4');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_ELI', 'MOVALM.4');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_SEL', 'MOVALM.4');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIOCAR_SEL', 'MOVALM.4');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_SEL', 'MOVALM.4');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSONMIN_SEL', 'MOVALM.4');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_INS', 'MOVALM.4.2');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_MOD', 'MOVALM.4.2');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_ELI', 'MOVALM.4.2');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSONMIN_SEL', 'MOVALM.4.2');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_FUNCUE_INS', 'MOVALM.4.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_FUNCUE_MOD', 'MOVALM.4.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_FUNCUE_ELI', 'MOVALM.4.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_FUNCUE_SEL', 'MOVALM.4.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_INSTIT_SEL', 'MOVALM.4.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_INSTIT_INS', 'MOVALM.4.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_INSTIT_MOD', 'MOVALM.4.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_INSTIT_ELI', 'MOVALM.4.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_INSTIT_SEL', 'MOVALM.4.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_SEL', 'MOVALM.4.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSONMIN_SEL', 'MOVALM.4.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_INS', 'MOVALM.4.1.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_MOD', 'MOVALM.4.1.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_ELI', 'MOVALM.4.1.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSONMIN_SEL', 'MOVALM.4.1.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_UPFOTOPER_MOD', 'MOVALM.4.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_MOV_ELI', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_GETGES_ELI', 'MOVALM');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_PROVEEV_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIOCAR_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ITEMNOTBASE_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ALM_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_REITEN_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CATCMB_SEL', 'ALREPIEI');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_SUBSIS_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_PACATI_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CAT_INS', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CAT_MOD', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CAT_ELI', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CAT_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CATCMB_SEL', 'ALREPIEI.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_REITEN_SEL', 'ALREPIEI.3');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_INIUOARB_SEL', 'ALREPIEI.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_ESTRUO_SEL', 'ALREPIEI.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_NIVORG_SEL', 'ALREPIEI.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_CARGO_SEL', 'ALREPIEI.2.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_SEL', 'ALREPIEI.2.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIOCAR_SEL', 'ALREPIEI.2.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_INS', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_MOD', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_ELI', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIO_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'RH_FUNCIOCAR_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_INS', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_MOD', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_ELI', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_FUNCUE_INS', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_FUNCUE_MOD', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_FUNCUE_ELI', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_FUNCUE_SEL', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_INSTIT_SEL', 'ALREPIEI.2.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_INSTIT_INS', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_INSTIT_MOD', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_INSTIT_ELI', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_INSTIT_SEL', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_SEL', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_INS', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_MOD', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSON_ELI', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_PERSONMIN_SEL', 'ALREPIEI.2.2.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_UPFOTOPER_MOD', 'ALREPIEI.2.2.1.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_TIPCON_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_OFI_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_TCARGO_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_ESCSAL_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_CARGO_INS', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_CARGO_MOD', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_CARGO_ELI', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_CARGO_SEL', 'ALREPIEI.2.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CECCOM_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_CARCC_INS', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_CARCC_MOD', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_CARCC_ELI', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_CARCC_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_GES_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CEC_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CECCOMFU_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CCFILDEP_SEL', 'ALREPIEI.2.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CECCOM_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_CARPRE_INS', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_CARPRE_MOD', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_CARPRE_ELI', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'OR_CARPRE_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_GES_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CEC_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CECCOMFU_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CCFILDEP_SEL', 'ALREPIEI.2.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_GUIROL_INS', 'ALREPIEI.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'ALM_CLA_ARB_SEL', 'ALREPIEI.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ARB_SEL', 'ALREPIEI.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ITEMNOTBASE_SEL', 'KARITE');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ALM_SEL', 'KARITE');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_RKARIT_SEL', 'KARITE');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_RKARIT_SEL', 'KARITE.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ALM_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ITEMNOTBASE_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_REPEXIST_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CATCMB_SEL', 'REPEXIST');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_SUBSIS_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_PACATI_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CAT_INS', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CAT_MOD', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CAT_ELI', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CAT_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'PM_CATCMB_SEL', 'REPEXIST.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SEG_GUIROL_INS', 'REPEXIST.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'ALM_CLA_ARB_SEL', 'REPEXIST.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Asistente de Almacenes', 'SAL_ARB_SEL', 'REPEXIST.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOV_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'WF_TIPES_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'WF_FUNTIPES_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_SIGEMOV_IME', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ANTEMOV_IME', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVREPORT_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVTIP_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ALM_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIOCAR_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_PROVEEV_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOV_INS', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOV_MOD', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOV_ELI', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVCNL_MOD', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVREV_MOD', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVFIN_MOD', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_FUNCIOCAR_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_DEPPTO_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_DEPUSUCOMB_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_DEPFILUSU_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_DEPFILEPUO_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'WF_SIGEST_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVPRE_REV', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CATCMB_SEL', 'MOVVB');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'MOVVB.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_INS', 'MOVVB.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_MOD', 'MOVVB.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_ELI', 'MOVVB.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_SEL', 'MOVVB.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CONIG_SEL', 'MOVVB.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CONIGPP_SEL', 'MOVVB.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_DETVAL_SEL', 'MOVVB.1.2');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'ALM_CLA_ARB_SEL', 'MOVVB.1.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ARB_SEL', 'MOVVB.1.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMSRCHARB_SEL', 'MOVVB.1.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMALM_SEL', 'MOVVB.1.1.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITEMNOTBASE_SEL', 'MOVVB.2');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_INS', 'MOVVB.2');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_MOD', 'MOVVB.2');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_ELI', 'MOVVB.2');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_MOVDET_SEL', 'MOVVB.2');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CONIG_SEL', 'MOVVB.2');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_CONIGPP_SEL', 'MOVVB.2');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_DETVAL_SEL', 'MOVVB.2.2');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'ALM_CLA_ARB_SEL', 'MOVVB.2.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ARB_SEL', 'MOVVB.2.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SAL_ITMSRCHARB_SEL', 'MOVVB.2.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_ALARM_INS', 'MOVVB.3');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_ALARM_MOD', 'MOVVB.3');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_ALARM_ELI', 'MOVVB.3');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_ALARMCOR_SEL', 'MOVVB.3');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_ALARM_SEL', 'MOVVB.3');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_INS', 'MOVVB.4');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_MOD', 'MOVVB.4');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_ELI', 'MOVVB.4');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIO_SEL', 'MOVVB.4');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'RH_FUNCIOCAR_SEL', 'MOVVB.4');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_SEL', 'MOVVB.4');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSONMIN_SEL', 'MOVVB.4');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_INS', 'MOVVB.4.2');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_MOD', 'MOVVB.4.2');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_ELI', 'MOVVB.4.2');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSONMIN_SEL', 'MOVVB.4.2');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'OR_FUNCUE_INS', 'MOVVB.4.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'OR_FUNCUE_MOD', 'MOVVB.4.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'OR_FUNCUE_ELI', 'MOVVB.4.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'OR_FUNCUE_SEL', 'MOVVB.4.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_INSTIT_SEL', 'MOVVB.4.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_INSTIT_INS', 'MOVVB.4.1.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_INSTIT_MOD', 'MOVVB.4.1.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_INSTIT_ELI', 'MOVVB.4.1.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'PM_INSTIT_SEL', 'MOVVB.4.1.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_SEL', 'MOVVB.4.1.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSONMIN_SEL', 'MOVVB.4.1.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_INS', 'MOVVB.4.1.1.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_MOD', 'MOVVB.4.1.1.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSON_ELI', 'MOVVB.4.1.1.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_PERSONMIN_SEL', 'MOVVB.4.1.1.1');
select pxp.f_delete_trol_procedimiento_gui ('Administrador Almacenes', 'SEG_UPFOTOPER_MOD', 'MOVVB.4.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_PESU_SEL', 'PERI');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_PESU_INS', 'PERI');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_PESU_MOD', 'PERI');
select pxp.f_insert_trol_procedimiento_gui ('Administrador Almacenes', 'PM_SWESTPE_MOD', 'PERI');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ITMALM_SEL', 'MOV.1.4.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'ALM_CLA_ARB_SEL', 'MOV.1.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ARB_SEL', 'MOV.1.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ITMSRCHARB_SEL', 'MOV.1.4');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CONIG_SEL', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ITEMNOTBASE_SEL', 'MOV.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Consulta', 'SAL_MOVDET_INS', 'MOV.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Consulta', 'SAL_MOVDET_MOD', 'MOV.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Consulta', 'SAL_MOVDET_ELI', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_MOVDET_SEL', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CONIGPP_SEL', 'MOV.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_DETVAL_SEL', 'MOV.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_INSTIT_SEL', 'MOV.3.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'OR_FUNCUE_SEL', 'MOV.3.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Consulta', 'OR_FUNCUE_INS', 'MOV.3.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Consulta', 'OR_FUNCUE_MOD', 'MOV.3.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Consulta', 'OR_FUNCUE_ELI', 'MOV.3.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSONMIN_SEL', 'MOV.3.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSON_SEL', 'MOV.3.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Consulta', 'PM_INSTIT_INS', 'MOV.3.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Consulta', 'PM_INSTIT_MOD', 'MOV.3.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Consulta', 'PM_INSTIT_ELI', 'MOV.3.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_INSTIT_SEL', 'MOV.3.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSONMIN_SEL', 'MOV.3.1.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSON_ELI', 'MOV.3.1.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSON_MOD', 'MOV.3.1.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSON_INS', 'MOV.3.1.1.1');
select pxp.f_delete_trol_procedimiento_gui ('ALM - Consulta', 'SEG_UPFOTOPER_MOD', 'MOV.3.1.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSONMIN_SEL', 'MOV.3');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSON_SEL', 'MOV.3');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'RH_FUNCIOCAR_SEL', 'MOV.3');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'RH_FUNCIO_SEL', 'MOV.3');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_MOVTIP_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ALM_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_MOV_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'RH_FUNCIO_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'RH_FUNCIOCAR_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_PROVEEV_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_MOVREPORT_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_FUNCIOCAR_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_DEPPTO_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_DEPUSUCOMB_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_DEPFILUSU_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_DEPFILEPUO_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'WF_SIGEST_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'WF_FUNTIPES_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CATCMB_SEL', 'MOV');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_MONEDA_SEL', 'PREING');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_DEPUSUCOMB_SEL', 'PREING');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CATCMB_SEL', 'PREING');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_PREING_SEL', 'PREING');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_DEPFILUSU_SEL', 'PREING');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_PREINGR_SEL', 'PREING');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ALM_SEL', 'PREING');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_PREDET_SEL', 'PREING.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_DEPFILUSU_SEL', 'PREING.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ALM_SEL', 'PREING.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ITEMNOTBASE_SEL', 'PREING.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CATCMB_SEL', 'PREING.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ITMSRCHARB_SEL', 'PREING.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ARB_SEL', 'PREING.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'ALM_CLA_ARB_SEL', 'PREING.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SAL_ITMALM_SEL', 'PREING.1.1.1');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CATCMB_SEL', 'PREING.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CAT_SEL', 'PREING.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_PACATI_SEL', 'PREING.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_SUBSIS_SEL', 'PREING.1.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CATCMB_SEL', 'PREING.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_CAT_SEL', 'PREING.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_PACATI_SEL', 'PREING.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_SUBSIS_SEL', 'PREING.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'SEG_PERSONMIN_SEL', 'MOV.3.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_ALARMCOR_SEL', 'MOV.2');
select pxp.f_insert_trol_procedimiento_gui ('ALM - Consulta', 'PM_ALARM_SEL', 'MOV.2');

/***********************************F-DEP-JRR-ALM-0-24/04/2014****************************************/
