----------------------------- SQL ---------------------------------
CREATE OR REPLACE FUNCTION alm.ft_movimiento_tipo_almacen_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_movimiento_tipo_almacen_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tmovimiento_tipo_almacen'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        13-07-2016 19:37:32
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

	v_nombre_funcion = 'alm.ft_movimiento_tipo_almacen_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_TPMOVALM_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		Gonzalo Sarmiento Sejas
 	#FECHA:		13-07-2016 19:37:32
	***********************************/

	if(p_transaccion='SAL_TPMOVALM_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tpmovalm.id_movimiento_tipo_almacen,
						tpmovalm.id_movimiento_tipo,
						tpmovalm.id_almacen,
                        al.nombre,
						tpmovalm.estado_reg,
						tpmovalm.id_usuario_reg,
						tpmovalm.usuario_ai,
						tpmovalm.fecha_reg,
						tpmovalm.id_usuario_ai,
						tpmovalm.fecha_mod,
						tpmovalm.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from alm.tmovimiento_tipo_almacen tpmovalm
                        inner join alm.talmacen al on al.id_almacen=tpmovalm.id_almacen
						inner join segu.tusuario usu1 on usu1.id_usuario = tpmovalm.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tpmovalm.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_TPMOVALM_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas
 	#FECHA:		13-07-2016 19:37:32
	***********************************/

	elsif(p_transaccion='SAL_TPMOVALM_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_movimiento_tipo_almacen)
					    from alm.tmovimiento_tipo_almacen tpmovalm
                        inner join alm.talmacen al on al.id_almacen=tpmovalm.id_almacen
					    inner join segu.tusuario usu1 on usu1.id_usuario = tpmovalm.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tpmovalm.id_usuario_mod
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;