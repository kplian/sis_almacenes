CREATE OR REPLACE FUNCTION alm.ft_movimiento_det_sel(p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
  RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_movimiento_det_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdepto_usuario'
 AUTOR:          Ariel Ayaviri Omonte
 FECHA:          02-10-2012
 COMENTARIOS:    
***************************************************************************/

DECLARE
  v_nombre_funcion	text;
  v_parametros 		record;
  v_consulta 		varchar;
  v_respuesta 		varchar;
BEGIN
  v_nombre_funcion = 'alm.ft_movimiento_det_sel';
  v_parametros = pxp.f_get_record(p_tabla);
  
  /*********************************    
     #TRANSACCION:  'SAL_MOVDET_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        19-02-2013
    ***********************************/ 
    
	if(p_transaccion='SAL_MOVDET_SEL') then
  	begin
    	v_consulta:='
	    select 
     		movdet.id_movimiento_det,
                movdet.id_movimiento,
                movdet.id_item,                    
                item.nombre as nombre_item,
                umed.codigo as codigo_unidad,
                movdet.cantidad as cantidad_item,
		movdet.cantidad_solicitada,
                movdet.costo_unitario,
                movdet.fecha_caducidad,
                usu1.cuenta as usr_reg,
                movdet.fecha_reg,
                usu2.cuenta as usr_mod,
                movdet.fecha_mod,
                item.codigo as codigo_item,
                (movdet.cantidad*movdet.costo_unitario) as costo_total
            from alm.tmovimiento_det movdet
            inner join alm.titem item on item.id_item = movdet.id_item
            inner join param.tunidad_medida umed on umed.id_unidad_medida = item.id_unidad_medida
            inner join segu.tusuario usu1 on usu1.id_usuario = movdet.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = movdet.id_usuario_mod
            where movdet.estado_reg = ''activo'' 
            	and movdet.id_movimiento = ' || v_parametros.id_movimiento || ' and ';

		v_consulta:=v_consulta||v_parametros.filtro;
        v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
		
        return v_consulta; 
    end;
    
  	/*********************************    
     #TRANSACCION:  'SAL_MOVDET_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        19-02-2013
    ***********************************/

    elsif(p_transaccion='SAL_MOVDET_CONT')then

    begin
        v_consulta:= '
            select count(movdet.id_movimiento_det)
            from alm.tmovimiento_det movdet
            inner join alm.titem item on item.id_item = movdet.id_item
            inner join param.tunidad_medida umed on umed.id_unidad_medida = item.id_unidad_medida
            inner join segu.tusuario usu1 on usu1.id_usuario = movdet.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = movdet.id_usuario_mod
            where movdet.estado_reg = ''activo'' 
                and movdet.id_movimiento = ' || v_parametros.id_movimiento || ' and ';
            
        v_consulta:=v_consulta||v_parametros.filtro;
        return v_consulta;
    end;
    else             
        raise exception 'Transaccion inexistente';
    end if;
  
EXCEPTION
	WHEN OTHERS THEN
            v_respuesta='';
            v_respuesta = pxp.f_agrega_clave(v_respuesta,'mensaje',SQLERRM);
            v_respuesta = pxp.f_agrega_clave(v_respuesta,'codigo_error',SQLSTATE);
            v_respuesta = pxp.f_agrega_clave(v_respuesta,'procedimientos',v_nombre_funcion);
            raise exception '%',v_respuesta;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION alm.ft_movimiento_det_sel(integer, integer, character varying, character varying)
  OWNER TO postgres;
