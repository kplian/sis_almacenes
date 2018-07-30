CREATE OR REPLACE FUNCTION "alm"."ft_movimiento_grupo_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_movimiento_grupo_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tmovimiento_grupo'
 AUTOR: 		 (admin)
 FECHA:	        18-10-2013 21:26:04
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

	v_nombre_funcion = 'alm.ft_movimiento_grupo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_MOVGRU_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		18-10-2013 21:26:04
	***********************************/

	if(p_transaccion='SAL_MOVGRU_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						movgru.id_movimiento_grupo,
						movgru.id_int_comprobante,
						movgru.descripcion,
						movgru.id_almacen,
						movgru.fecha_ini,
						movgru.estado,
						movgru.fecha_fin,
						movgru.estado_reg,
						movgru.id_usuario_reg,
						movgru.fecha_reg,
						movgru.fecha_mod,
						movgru.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
						alm.codigo || '' - '' || alm.nombre as desc_almacen,
						cbte.nro_cbte,
						movgru.id_depto_conta,
						dpto.nombre as nombre_depto
						from alm.tmovimiento_grupo movgru
						inner join segu.tusuario usu1 on usu1.id_usuario = movgru.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = movgru.id_usuario_mod
						inner join alm.talmacen alm on alm.id_almacen = movgru.id_almacen
						left join conta.tint_comprobante cbte on cbte.id_int_comprobante = movgru.id_int_comprobante
						inner join param.tdepto dpto
						on dpto.id_depto = movgru.id_depto_conta
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_MOVGRU_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		18-10-2013 21:26:04
	***********************************/

	elsif(p_transaccion='SAL_MOVGRU_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_movimiento_grupo)
					    from alm.tmovimiento_grupo movgru
					    inner join segu.tusuario usu1 on usu1.id_usuario = movgru.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = movgru.id_usuario_mod
						inner join alm.talmacen alm on alm.id_almacen = movgru.id_almacen
						left join conta.tint_comprobante cbte on cbte.id_int_comprobante = movgru.id_int_comprobante
						inner join param.tdepto dpto
						on dpto.id_depto = movgru.id_depto_conta
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
ALTER FUNCTION "alm"."ft_movimiento_grupo_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
