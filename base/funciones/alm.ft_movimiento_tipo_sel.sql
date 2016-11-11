--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.ft_movimiento_tipo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_movimiento_tipo_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tmovimiento'
 AUTOR:          Ariel Ayaviri Omonte
 FECHA:          13-02-2013
 COMENTARIOS:
***************************************************************************/

DECLARE
  v_nombre_funcion	varchar;
  v_consulta 		varchar;
  v_parametros 		record;
  v_respuesta		varchar;
  v_filtro			varchar;
BEGIN
  v_nombre_funcion='alm.ft_movimiento_tipo_sel';
  v_parametros=pxp.f_get_record(p_tabla);

  /*********************************
     #TRANSACCION:  'SAL_MOVTIP_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        13-02-2013
    ***********************************/
	if(p_transaccion='SAL_MOVTIP_SEL')then
  	begin
    	v_consulta:='
        	select
                movtip.id_movimiento_tipo,
                movtip.codigo,
                movtip.nombre,
                movtip.tipo,
                usu1.cuenta as usr_reg,
                movtip.fecha_reg,
                usu2.cuenta as usr_mod,
                movtip.fecha_mod,
                movtip.read_only,
                movtip.id_proceso_macro,
                pm.nombre as desc_proceso_macro
            from alm.tmovimiento_tipo movtip
            inner join segu.tusuario usu1 on usu1.id_usuario = movtip.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = movtip.id_usuario_mod
            left join wf.tproceso_macro pm on pm.id_proceso_macro = movtip.id_proceso_macro
            where movtip.estado_reg = ''activo'' and ';
    	v_consulta:=v_consulta||v_parametros.filtro;
        v_consulta:=v_consulta||' order by '||v_parametros.ordenacion||' '||v_parametros.dir_ordenacion||' limit '||v_parametros.cantidad||' offset '||v_parametros.puntero;
        return v_consulta;
    end;
  /*********************************
     #TRANSACCION:  'SAL_MOVTIP_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        13-02-2013
    ***********************************/
	elsif(p_transaccion='SAL_MOVTIP_CONT')then
    begin
    	v_consulta:='
        	select count(movtip.id_movimiento_tipo)
            from alm.tmovimiento_tipo movtip
            inner join segu.tusuario usu1 on usu1.id_usuario = movtip.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = movtip.id_usuario_mod
			left join wf.tproceso_macro pm on pm.id_proceso_macro = movtip.id_proceso_macro
            where movtip.estado_reg = ''activo'' and ';
        v_consulta:= v_consulta||v_parametros.filtro;
        return v_consulta;
     end;

     /*********************************
     #TRANSACCION:  'SAL_MOVTIPCAR_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        Gonzalo Sarmiento
     #FECHA:        08-11-2016
    ***********************************/
	elsif(p_transaccion='SAL_MOVTIPCAR_SEL')then
  	begin

    	IF p_administrador !=1 THEN
           v_filtro = 'inner join alm.tmovimiento_tipo_uo mtuo on mtuo.id_movimiento_tipo = movtip.id_movimiento_tipo
           			   inner join orga.vfuncionario_cargo fun on fun.id_uo=mtuo.id_uo and fun.id_funcionario='||v_parametros.id_funcionario_usu||'';
         ELSE
             v_filtro = ' ';
        END IF;

    	v_consulta:='
        	select
                movtip.id_movimiento_tipo,
                movtip.codigo,
                movtip.nombre,
                movtip.tipo,
                usu1.cuenta as usr_reg,
                movtip.fecha_reg,
                usu2.cuenta as usr_mod,
                movtip.fecha_mod,
                movtip.read_only,
                movtip.id_proceso_macro,
                pm.nombre as desc_proceso_macro
            from alm.tmovimiento_tipo movtip
            inner join segu.tusuario usu1 on usu1.id_usuario = movtip.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = movtip.id_usuario_mod
            left join wf.tproceso_macro pm on pm.id_proceso_macro = movtip.id_proceso_macro '||v_filtro||
            ' where movtip.estado_reg = ''activo'' and ';
    	v_consulta:=v_consulta||v_parametros.filtro;
        v_consulta:=v_consulta||' order by '||v_parametros.ordenacion||' '||v_parametros.dir_ordenacion||' limit '||v_parametros.cantidad||' offset '||v_parametros.puntero;
        return v_consulta;
    end;

    /*********************************
     #TRANSACCION:  'SAL_MOVTIPCAR_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Gonzalo Sarmiento Sejas
     #FECHA:        08-11-2016
    ***********************************/
	elsif(p_transaccion='SAL_MOVTIPCAR_CONT')then
    begin
    	v_consulta:='
        	select count(movtip.id_movimiento_tipo)
            from alm.tmovimiento_tipo movtip
            inner join segu.tusuario usu1 on usu1.id_usuario = movtip.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = movtip.id_usuario_mod
			left join wf.tproceso_macro pm on pm.id_proceso_macro = movtip.id_proceso_macro
            inner join alm.tmovimiento_tipo_uo mtuo on mtuo.id_movimiento_tipo = movtip.id_movimiento_tipo
			inner join orga.vfuncionario_cargo fun on fun.id_uo=mtuo.id_uo and fun.id_funcionario='||v_parametros.id_funcionario_usu||'
            where movtip.estado_reg = ''activo'' and ';
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