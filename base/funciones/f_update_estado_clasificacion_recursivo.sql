--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.f_update_estado_clasificacion_recursivo (
  v_id_clasificacion integer,
  v_estado_nuevo varchar,
  p_id_usuario integer
)
RETURNS boolean AS
$body$
DECLARE
  g_registros	record;
  v_result		boolean;
  v_cont 		integer;
BEGIN
	v_cont = 0;
    FOR g_registros in (
        select 
        	id_clasificacion 
        from alm.tclasificacion 
        where id_clasificacion_fk = v_id_clasificacion 
        	and estado_reg = 'activo'
	) LOOP
		v_result = alm.f_update_estado_clasificacion_recursivo(g_registros.id_clasificacion, v_estado_nuevo, p_id_usuario);
        v_cont = v_cont + 1;
    END LOOP;
    
    IF (v_estado_nuevo = 'restringido' and v_cont = 0) THEN
    	select count(id_item) into v_cont from alm.titem
        where id_clasificacion = v_id_clasificacion;
        IF(v_cont = 0) THEN
        	v_estado_nuevo = null;
        END IF;
    END IF;
    
    update alm.tclasificacion set
        fecha_mod = now(),
        id_usuario_mod = p_id_usuario,
        estado = v_estado_nuevo
    where id_clasificacion=v_id_clasificacion;
	return true;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;