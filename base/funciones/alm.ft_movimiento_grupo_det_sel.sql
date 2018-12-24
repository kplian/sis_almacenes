CREATE OR REPLACE FUNCTION "alm"."ft_movimiento_grupo_det_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_movimiento_grupo_det_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tmovimiento_grupo_det'
 AUTOR: 		 (admin)
 FECHA:	        18-10-2013 21:26:09
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'alm.ft_movimiento_grupo_det_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_MOGRDE_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		18-10-2013 21:26:09
	***********************************/

	if(p_transaccion='SAL_MOGRDE_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						mogrde.id_movimiento_grupo_det,
						mogrde.estado_reg,
						mogrde.id_movimiento,
						mogrde.id_movimiento_grupo,
						mogrde.id_usuario_reg,
						mogrde.fecha_reg,
						mogrde.id_usuario_mod,
						mogrde.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						mov.codigo as nro_mov,
						mov.fecha_mov
						from alm.tmovimiento_grupo_det mogrde
						inner join segu.tusuario usu1 on usu1.id_usuario = mogrde.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = mogrde.id_usuario_mod
						inner join alm.tmovimiento mov on mov.id_movimiento = mogrde.id_movimiento
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_MOGRDE_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		18-10-2013 21:26:09
	***********************************/

	elsif(p_transaccion='SAL_MOGRDE_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_movimiento_grupo_det)
					    from alm.tmovimiento_grupo_det mogrde
					    inner join segu.tusuario usu1 on usu1.id_usuario = mogrde.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = mogrde.id_usuario_mod
						inner join alm.tmovimiento mov on mov.id_movimiento = mogrde.id_movimiento
					    where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
	end if;
					
EXCEPTION
					
	WHEN OTHERS THEN
			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "alm"."ft_movimiento_grupo_det_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
