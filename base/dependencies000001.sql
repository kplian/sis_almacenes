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