--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.ft_inventario_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_inventario_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tinventario'
 AUTOR: 		 (admin)
 FECHA:	        15-03-2013 15:36:09
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

	v_nombre_funcion = 'alm.ft_inventario_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_INV_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 15:36:09
	***********************************/

	if(p_transaccion='SAL_INV_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						inv.id_inventario,
						inv.estado_reg,
						inv.id_almacen,
                        almo.nombre as nombre_almacen,
						inv.fecha_inv_planif,
						inv.estado,
						inv.observaciones,
						inv.fecha_inv_ejec,
						inv.completo,
						inv.id_usuario_resp,
                        usuinv.cuenta as nombre_usuario,
						inv.fecha_reg,
						inv.id_usuario_reg,
						inv.fecha_mod,
						inv.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        inv.id_usuario_asis,
                        usuasis.cuenta as nombre_usuario_asis	
						from alm.tinventario inv
						inner join segu.tusuario usu1 on usu1.id_usuario = inv.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = inv.id_usuario_mod
                        inner join alm.talmacen almo on almo.id_almacen = inv.id_almacen
                        inner join segu.tusuario usuinv on usuinv.id_usuario = inv.id_usuario_resp
						left join segu.tusuario usuasis on usuasis.id_usuario = inv.id_usuario_asis
				        where inv.estado_reg = ''activo'' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_INV_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 15:36:09
	***********************************/

	elsif(p_transaccion='SAL_INV_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_inventario)
					    from alm.tinventario inv
					    inner join segu.tusuario usu1 on usu1.id_usuario = inv.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = inv.id_usuario_mod
                        inner join alm.talmacen almo on almo.id_almacen = inv.id_almacen
                        inner join segu.tusuario usuinv on usuinv.id_usuario = inv.id_usuario_resp
						left join segu.tusuario usuasis on usuasis.id_usuario = inv.id_usuario_asis
				        where inv.estado_reg = ''activo'' and ';
			
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;