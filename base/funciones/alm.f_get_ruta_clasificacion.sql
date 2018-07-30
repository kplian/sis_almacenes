--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.f_get_ruta_clasificacion (
  p_id_clasificacion integer
)
RETURNS integer [] AS
$body$
DECLARE
	v_nombre_funcion	varchar;
    v_resp		     	varchar;
    v_result			integer[];
    v_result_2			integer[];
    v_id_padre			integer;
BEGIN
	v_nombre_funcion = 'alm.ft_inventario_ime';
	
    select cla.id_clasificacion_fk into v_id_padre
    from alm.tclasificacion cla
    where cla.id_clasificacion = p_id_clasificacion;
    
    if (v_id_padre is not null) then
        v_result = array_append(alm.f_get_ruta_clasificacion(v_id_padre), p_id_clasificacion);
        return v_result;
    else
        v_result = array_append(v_result, p_id_clasificacion);
        return v_result;
    end if;
    
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