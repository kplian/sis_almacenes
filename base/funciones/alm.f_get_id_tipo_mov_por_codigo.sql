CREATE OR REPLACE FUNCTION alm.f_get_id_tipo_mov_por_codigo(p_codigo_tipo_mov character varying)
  RETURNS integer AS
$BODY$
/**************************************************************************
 SISTEMA:		SISTEMA DE ALMACENES
 FUNCION: 		alm.f_get_id_tipo_mov_por_codigo
 DESCRIPCION:   	Función que devuelve el id_movimiento_tipo en función al código del tipo mov
 AUTOR: 		Ariel Ayaviri Omonte
 FECHA:	        	06/05/2013
 COMENTARIOS:	 revision
***************************************************************************/

DECLARE

    v_nombre_funcion		text;
    v_resp			varchar;
    v_id_mov_tip		integer;

BEGIN
    v_nombre_funcion = 'alm.f_get_id_tipo_mov_por_codigo';

	select movtip.id_movimiento_tipo into v_id_mov_tip
	from alm.tmovimiento_tipo movtip 
	where movtip.codigo = p_codigo_tipo_mov
	and estado_reg = 'activo'
	limit 1;

	if (v_id_mov_tip is null) then
		raise exception '%', 'No existe el id_movimiento_tipo para el código: '|| p_codigo_tipo_mov;
	end if;
    
    return v_id_mov_tip;
EXCEPTION					
	WHEN OTHERS THEN
			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION alm.f_get_id_tipo_mov_por_codigo(character varying)
  OWNER TO postgres;
