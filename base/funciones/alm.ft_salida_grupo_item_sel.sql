CREATE OR REPLACE FUNCTION "alm"."ft_salida_grupo_item_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_salida_grupo_item_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tsalida_grupo_item'
 AUTOR: 		 (admin)
 FECHA:	        17-10-2013 20:34:52
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

	v_nombre_funcion = 'alm.ft_salida_grupo_item_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_SAGRIT_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		17-10-2013 20:34:52
	***********************************/

	if(p_transaccion='SAL_SAGRIT_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						sagrit.id_salida_grupo_item,
						sagrit.observaciones,
						sagrit.estado_reg,
						sagrit.id_item,
						sagrit.cantidad_sol,
						sagrit.id_salida_grupo,
						sagrit.id_usuario_reg,
						sagrit.fecha_reg,
						sagrit.id_usuario_mod,
						sagrit.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						coalesce(item.codigo,''S/C'') || '' - '' || item.nombre as desc_item	
						from alm.tsalida_grupo_item sagrit
						inner join segu.tusuario usu1 on usu1.id_usuario = sagrit.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sagrit.id_usuario_mod
						inner join alm.titem item on item.id_item = sagrit.id_item
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_SAGRIT_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		17-10-2013 20:34:52
	***********************************/

	elsif(p_transaccion='SAL_SAGRIT_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_salida_grupo_item)
					    from alm.tsalida_grupo_item sagrit
					    inner join segu.tusuario usu1 on usu1.id_usuario = sagrit.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = sagrit.id_usuario_mod
						inner join alm.titem item on item.id_item = sagrit.id_item
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
ALTER FUNCTION "alm"."ft_salida_grupo_item_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
