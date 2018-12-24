CREATE OR REPLACE FUNCTION "alm"."ft_periodo_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
  SISTEMA:		Sistema de Almacenes
  FUNCION: 		alm.ft_periodo_sel
  DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tperiodo'
  AUTOR: 		 (admin)
  FECHA:	        19-06-2013 08:33:57
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
 
  v_nombre_funcion = 'alm.ft_periodo_sel';
  
  v_parametros = pxp.f_get_record(p_tabla);
 
 	/********************************* 
 	 #TRANSACCION:  'SAL_PREING_SEL'
  	 #DESCRIPCION:	Consulta de datos
  	 #AUTOR:		admin	
	 #FECHA:		19-06-2013 08:33:57
 	***********************************/
 	
    if(p_transaccion='SAL_ALMPER_SEL') then
    
    			
     	begin
     		--Sentencia de la consulta
 			v_consulta:='select
						almper.id_periodo,
						almper.fecha_fin,
						almper.fecha_ini,
						almper.estado_reg,
						almper.periodo,
						almper.id_usuario_reg,
						almper.fecha_reg,
						almper.fecha_mod,
						almper.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from alm.tperiodo almper
						inner join segu.tusuario usu1 on usu1.id_usuario = almper.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = almper.id_usuario_mod
						where  ';
 			
 			--Definicion de la respuesta
 			v_consulta:=v_consulta||v_parametros.filtro;
 			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
 
 			--Devuelve la respuesta
 			return v_consulta;
 						
 		end;
 
 	/*********************************  
 	 #TRANSACCION:  'SAL_ALMPER_CONT'
  	 #DESCRIPCION:	Conteo de registros
  	 #AUTOR:		admin	
 	 #FECHA:		19-06-2013 08:33:57
 	***********************************/ 
 	

elsif(p_transaccion='SAL_ALMPER_CONT')then
 
 		begin
 			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_periodo)
					    from alm.tperiodo almper
					    inner join segu.tusuario usu1 on usu1.id_usuario = almper.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = almper.id_usuario_mod
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
ALTER FUNCTION "alm"."ft_periodo_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
