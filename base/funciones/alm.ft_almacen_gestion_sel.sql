CREATE OR REPLACE FUNCTION "alm"."ft_almacen_gestion_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_almacen_gestion_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.talmacen_gestion'
 AUTOR: 		 (admin)
 FECHA:	        31-12-2013 14:15:09
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

	v_nombre_funcion = 'alm.ft_almacen_gestion_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_ALMGES_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		31-12-2013 14:15:09
	***********************************/

	if(p_transaccion='SAL_ALMGES_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						almges.id_almacen_gestion,
						almges.id_almacen,
						almges.id_gestion,
						almges.estado,
						almges.estado_reg,
						almges.id_usuario_reg,
						almges.fecha_reg,
						almges.fecha_mod,
						almges.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						gest.gestion::varchar as desc_gestion
						from alm.talmacen_gestion almges
						inner join segu.tusuario usu1 on usu1.id_usuario = almges.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = almges.id_usuario_mod
						inner join param.tgestion gest on gest.id_gestion = almges.id_gestion
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_ALMGES_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		31-12-2013 14:15:09
	***********************************/

	elsif(p_transaccion='SAL_ALMGES_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_almacen_gestion)
					    from alm.talmacen_gestion almges
					    inner join segu.tusuario usu1 on usu1.id_usuario = almges.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = almges.id_usuario_mod
						inner join param.tgestion gest on gest.id_gestion = almges.id_gestion
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
ALTER FUNCTION "alm"."ft_almacen_gestion_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
