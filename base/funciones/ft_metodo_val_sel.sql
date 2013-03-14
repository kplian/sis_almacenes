--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.ft_metodo_val_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_metodo_val_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tmovimiento'
 AUTOR:          Ariel Ayaviri Omonte
 FECHA:          14-02-2013
 COMENTARIOS:   
***************************************************************************/

DECLARE
  v_nombre_funcion	varchar;
  v_consulta 		varchar;
  v_parametros 		record;
  v_respuesta		varchar;
BEGIN
  v_nombre_funcion='alm.ft_metodo_val_sel';
  v_parametros=pxp.f_get_record(p_tabla);
  
  /*********************************   
     #TRANSACCION:  'SAL_MEVAL_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        14-02-2013
    ***********************************/
	if(p_transaccion='SAL_MEVAL_SEL')then
  	begin
    	v_consulta:='
        	select
                meval.id_metodo_val,
                meval.codigo,
                meval.nombre,
                meval.descripcion,
                usu1.cuenta as usr_reg,
                meval.fecha_reg,
                usu2.cuenta as usr_mod,
                meval.fecha_mod,
                meval.read_only
            from alm.tmetodo_val meval
            inner join segu.tusuario usu1 on usu1.id_usuario = meval.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = meval.id_usuario_mod
            where meval.estado_reg = ''activo'' and ';
    	v_consulta:=v_consulta||v_parametros.filtro;
        v_consulta:=v_consulta||' order by '||v_parametros.ordenacion||' '||v_parametros.dir_ordenacion||' limit '||v_parametros.cantidad||' offset '||v_parametros.puntero;        	
        return v_consulta;
    end;
  /*********************************   
     #TRANSACCION:  'SAL_MEVAL_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        14-02-2013
    ***********************************/
	elsif(p_transaccion='SAL_MEVAL_CONT')then
    begin
    	v_consulta:='
        	select count(meval.id_metodo_val)
            from alm.tmetodo_val meval
            inner join segu.tusuario usu1 on usu1.id_usuario = meval.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = meval.id_usuario_mod
            where meval.estado_reg = ''activo'' and ';
        v_consulta:= v_consulta||v_parametros.filtro;
        return v_consulta;
     end;
  end if;
EXCEPTION
  WHEN OTHERS THEN
    v_respuesta='';
    v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje',SQLERRM);
    v_respuesta=pxp.f_agrega_clave(v_respuesta,'codigo_error',SQLSTATE);
    v_respuesta=pxp.f_agrega_clave(v_respuesta,'procedimiento',v_nombre_funcion);
    raise exception '%',v_respuesta;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;