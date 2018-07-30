CREATE OR REPLACE FUNCTION "alm"."ft_movimiento_tipo_item_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_movimiento_tipo_item_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tmovimiento_tipo_item'
 AUTOR: 		 (admin)
 FECHA:	        21-08-2013 14:31:37
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

	v_nombre_funcion = 'alm.ft_movimiento_tipo_item_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_TIMITE_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		21-08-2013 14:31:37
	***********************************/

	if(p_transaccion='SAL_TIMITE_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						timite.id_movimiento_tipo_item,
						timite.id_item,
						timite.id_movimiento_tipo,
						timite.id_clasificacion,
						timite.estado_reg,
						timite.id_usuario_reg,
						timite.fecha_reg,
						timite.fecha_mod,
						timite.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						ite.codigo as codigo_item,
						ite.nombre as desc_item,
						cla.codigo_largo as codigo_clasif,
						cla.nombre as desc_clasif
						from alm.tmovimiento_tipo_item timite
						inner join segu.tusuario usu1 on usu1.id_usuario = timite.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = timite.id_usuario_mod
						left join alm.titem ite on ite.id_item = timite.id_item
						left join alm.tclasificacion cla on cla.id_clasificacion = timite.id_clasificacion
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_TIMITE_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		21-08-2013 14:31:37
	***********************************/

	elsif(p_transaccion='SAL_TIMITE_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_movimiento_tipo_item)
					    from alm.tmovimiento_tipo_item timite
					    inner join segu.tusuario usu1 on usu1.id_usuario = timite.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = timite.id_usuario_mod
						left join alm.titem ite on ite.id_item = timite.id_item
						left join alm.tclasificacion cla on cla.id_clasificacion = timite.id_clasificacion
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
ALTER FUNCTION "alm"."ft_movimiento_tipo_item_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
