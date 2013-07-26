--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.ft_inventario_det_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_inventario_det_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tinventario_det'
 AUTOR: 		 (admin)
 FECHA:	        15-03-2013 21:26:02
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

	v_nombre_funcion = 'alm.ft_inventario_det_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_DINV_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 21:26:02
	***********************************/

	if(p_transaccion='SAL_DINV_SEL')then
     				
    	begin
        	
            update alm.tinventario_det invdet set
            cantidad_sistema = alm.f_get_saldo_fisico_item(invdet.id_item, v_parametros.id_almacen, CURRENT_DATE)
    	    where invdet.id_inventario = v_parametros.id_inventario;
            
    		--Sentencia de la consulta
			v_consulta:='select
						dinv.id_inventario_det,
						dinv.estado_reg,
						dinv.id_item,
                        itm.nombre as nombre_item,
                        itm.codigo as codigo_item,
						dinv.diferencia,
						dinv.observaciones,
						dinv.cantidad_real,
						dinv.cantidad_sistema,
						dinv.id_inventario,
						dinv.fecha_reg,
						dinv.id_usuario_reg,
						dinv.fecha_mod,
						dinv.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from alm.tinventario_det dinv
						inner join segu.tusuario usu1 on usu1.id_usuario = dinv.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = dinv.id_usuario_mod
                        inner join alm.titem itm on itm.id_item = dinv.id_item
				        where dinv.estado_reg = ''activo'' and dinv.id_inventario = ' || v_parametros.id_inventario || ' and ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_DINV_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 21:26:02
	***********************************/

	elsif(p_transaccion='SAL_DINV_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_inventario_det)
					    from alm.tinventario_det dinv
						inner join segu.tusuario usu1 on usu1.id_usuario = dinv.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = dinv.id_usuario_mod
                        inner join alm.titem itm on itm.id_item = dinv.id_item
				        where dinv.estado_reg = ''activo'' and dinv.id_inventario = ' || v_parametros.id_inventario || ' and ';
			
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