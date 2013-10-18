CREATE OR REPLACE FUNCTION "alm"."ft_salida_grupo_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_salida_grupo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tsalida_grupo'
 AUTOR: 		 (admin)
 FECHA:	        17-10-2013 18:50:00
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

	v_nombre_funcion = 'alm.ft_salida_grupo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_SALGRU_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		17-10-2013 18:50:00
	***********************************/

	if(p_transaccion='SAL_SALGRU_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						salgru.id_salida_grupo,
						salgru.id_movimiento_tipo,
						salgru.id_almacen,
						salgru.descripcion,
						salgru.fecha,
						salgru.observaciones,
						salgru.estado,
						salgru.estado_reg,
						salgru.id_usuario_reg,
						salgru.fecha_reg,
						salgru.fecha_mod,
						salgru.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						alm.codigo || '' - '' || alm.nombre as desc_almacen
						from alm.tsalida_grupo salgru
						inner join segu.tusuario usu1 on usu1.id_usuario = salgru.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = salgru.id_usuario_mod
						inner join alm.talmacen alm on alm.id_almacen = salgru.id_almacen
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_SALGRU_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		17-10-2013 18:50:00
	***********************************/

	elsif(p_transaccion='SAL_SALGRU_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_salida_grupo)
					    from alm.tsalida_grupo salgru
					    inner join segu.tusuario usu1 on usu1.id_usuario = salgru.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = salgru.id_usuario_mod
						inner join alm.talmacen alm on alm.id_almacen = salgru.id_almacen
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
ALTER FUNCTION "alm"."ft_salida_grupo_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
