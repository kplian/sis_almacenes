--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.f_actualizar_saldos_inventario (
  p_id_inventario integer
)
RETURNS boolean AS
$body$
DECLARE
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_id_almacen 			integer;
    
BEGIN
	v_nombre_funcion = 'f_actualizar_saldos_inventario';
    select id_almacen into v_id_almacen
    from alm.tinventario inv 
    where inv.id_inventario = p_id_inventario;
    
    update alm.tinventario_det invdet set
        cantidad_sistema = alm.f_get_saldo_fisico_item(invdet.id_item, v_id_almacen)
    where invdet.id_inventario = p_id_inventario;
            
    update alm.tinventario_det invdet set
        diferencia = invdet.cantidad_sistma - invdet.cantidad_real
    where invdet.id_inventario = p_id_inventario;
  	
    return true;
EXCEPTION
WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;
				        
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;