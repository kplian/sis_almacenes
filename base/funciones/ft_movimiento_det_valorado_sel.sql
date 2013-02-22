--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.ft_movimiento_det_valorado_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_movimiento_det_valorado_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.tdepto_usuario'
 AUTOR:          Ariel Ayaviri Omonte
 FECHA:          21-02-2013
 COMENTARIOS:    
***************************************************************************/

DECLARE
  v_nombre_funcion	text;
  v_parametros 		record;
  v_consulta 		varchar;
  v_respuesta 		varchar;
BEGIN
  v_nombre_funcion = 'alm.ft_movimiento_det_valorado_sel';
  v_parametros = pxp.f_get_record(p_tabla);
  
  /*********************************    
     #TRANSACCION:  'SAL_DETVAL_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        19-02-2013
    ***********************************/ 
    if(p_transaccion='SAL_DETVAL_SEL') then
  	begin
    	v_consulta:='
        	select 
     			detval.id_movimiento_det_valorado,
                detval.id_movimiento_det,
                detval.cantidad as cantidad_item,
                detval.costo_unitario,
                usu1.cuenta as usr_reg,
                detval.fecha_reg,
                usu2.cuenta as usr_mod,
                detval.fecha_mod
            from alm.tmovimiento_det_valorado detval
            inner join alm.tmovimiento_det movdet on movdet.id_movimiento_det = detval.id_movimiento_det
            inner join segu.tusuario usu1 on usu1.id_usuario = detval.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = detval.id_usuario_mod
            where detval.estado_reg = ''activo'' 
            	and detval.id_movimiento_det = ' || v_parametros.id_movimiento_det || ' and ';

		v_consulta:=v_consulta||v_parametros.filtro;
        v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
		
        return v_consulta; 
    end;
    
  	/*********************************    
     #TRANSACCION:  'SAL_DETVAL_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        19-02-2013
    ***********************************/

    elsif(p_transaccion='SAL_DETVAL_CONT')then

    begin
        v_consulta:= '
            select count(detval.id_movimiento_det_valorado)
            from alm.tmovimiento_det_valorado detval
            inner join alm.tmovimiento_det movdet on movdet.id_movimiento_det = detval.id_movimiento_det
            inner join segu.tusuario usu1 on usu1.id_usuario = detval.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = detval.id_usuario_mod
            where detval.estado_reg = ''activo'' 
            	and detval.id_movimiento_det = ' || v_parametros.id_movimiento_det || ' and ';
            
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;