--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.ft_movimiento_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/***************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_movimiento_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tmovimiento'
 AUTOR:          Gonzalo Sarmiento
 FECHA:          02-10-2012
 COMENTARIOS:   
***************************************************************************/

DECLARE
  v_nombre_funcion	varchar;
  v_consulta 		varchar;
  v_parametros 		record;
  v_respuesta		varchar;
BEGIN
  v_nombre_funcion='alm.ft_movimiento_sel';
  v_parametros=pxp.f_get_record(p_tabla);
  
  /*********************************   
     #TRANSACCION:  'SAL_MOV_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        02-12-2012
    ***********************************/
  
	if(p_transaccion='SAL_MOV_SEL')then
  	begin
    	v_consulta:='
        	SELECT
            	mov.id_movimiento,
                movtip.tipo as tipo,
            	mov.id_movimiento_tipo,
                movtip.nombre as nombre_movimiento_tipo,
            	mov.id_funcionario,
                person_fun.nombre_completo1::varchar as nombre_funcionario,
            	mov.id_proveedor,
                (case 
                	when mov.id_proveedor is not null and pro.id_institucion is not null then
                    	inst.nombre 
                    when mov.id_proveedor is not null and pro.id_persona is not null then 
                    	person.nombre_completo1
            		else 
                    	''''
                end)::varchar as nombre_proveedor,
                mov.id_almacen,
                almo.nombre as nombre_almacen,
            	mov.id_almacen_dest,
                almd.nombre as nombre_almacen_destino,
            	mov.fecha_mov,
            	mov.codigo,
            	mov.descripcion,
            	mov.observaciones,
            	mov.estado_mov,
            	usu1.cuenta as usr_reg,
            	mov.fecha_reg,
            	usu2.cuenta as usr_mod,
            	mov.fecha_mod
            FROM alm.tmovimiento mov
            INNER JOIN alm.tmovimiento_tipo movtip on movtip.id_movimiento_tipo = mov.id_movimiento_tipo
            LEFT JOIN orga.tfuncionario fun on fun.id_funcionario = mov.id_funcionario
            LEFT JOIN segu.vpersona person_fun on person_fun.id_persona = fun.id_persona
            LEFT JOIN param.vproveedor pro on pro.id_proveedor = mov.id_proveedor
            LEFT JOIN segu.vpersona person on person.id_persona = pro.id_persona
            LEFT JOIN param.tinstitucion inst on inst.id_institucion = pro.id_institucion
            INNER JOIN alm.talmacen almo on almo.id_almacen = mov.id_almacen
            LEFT JOIN alm.talmacen almd on almd.id_almacen = mov.id_almacen_dest
            INNER JOIN segu.tusuario usu1 on usu1.id_usuario = movtip.id_usuario_reg
            LEFT JOIN segu.tusuario usu2 on usu2.id_usuario = movtip.id_usuario_mod
			WHERE mov.estado_reg = ''activo'' and ';
    	v_consulta:=v_consulta||v_parametros.filtro;
        v_consulta:=v_consulta||' order by '||v_parametros.ordenacion||' '||v_parametros.dir_ordenacion||' limit '||v_parametros.cantidad||' offset '||v_parametros.puntero;
        return v_consulta;
    end;
  /*********************************   
     #TRANSACCION:  'SAL_MOV_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        24-09-2012
    ***********************************/
  elsif(p_transaccion='SAL_MOV_CONT')then
    begin
    	v_consulta:='
        	select count(mov.id_movimiento)
        	FROM alm.tmovimiento mov
            INNER JOIN alm.tmovimiento_tipo movtip on movtip.id_movimiento_tipo = mov.id_movimiento_tipo
            LEFT JOIN orga.tfuncionario fun on fun.id_funcionario = mov.id_funcionario
            LEFT JOIN segu.vpersona person_fun on person_fun.id_persona = fun.id_persona
            LEFT JOIN param.vproveedor pro on pro.id_proveedor = mov.id_proveedor
            LEFT JOIN segu.vpersona person on person.id_persona = pro.id_persona
            LEFT JOIN param.tinstitucion inst on inst.id_institucion = pro.id_institucion
            INNER JOIN alm.talmacen almo on almo.id_almacen = mov.id_almacen
            LEFT JOIN alm.talmacen almd on almd.id_almacen = mov.id_almacen_dest
            INNER JOIN segu.tusuario usu1 on usu1.id_usuario = movtip.id_usuario_reg
            LEFT JOIN segu.tusuario usu2 on usu2.id_usuario = movtip.id_usuario_mod
			WHERE mov.estado_reg = ''activo'' and ';
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