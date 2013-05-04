CREATE OR REPLACE FUNCTION alm.ft_inventario_det_ime(p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
  RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_inventario_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tinventario_det'
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

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_inventario_det		integer;
    v_saldo_fisico			numeric;
			    
BEGIN

    v_nombre_funcion = 'alm.ft_inventario_det_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_DINV_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 21:26:02
	***********************************/

	if(p_transaccion='SAL_DINV_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into alm.tinventario_det(
			estado_reg,
			id_item,
			observaciones,
			cantidad_real,
			id_inventario,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			'activo',
			v_parametros.id_item,
			v_parametros.observaciones,
			v_parametros.cantidad_real,
			v_parametros.id_inventario,
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_inventario_det into v_id_inventario_det;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle Inventario almacenado(a) con exito (id_inventario_det'||v_id_inventario_det||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_inventario_det',v_id_inventario_det::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_DINV_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 21:26:02
	***********************************/

	elsif(p_transaccion='SAL_DINV_MOD')then

		begin
			--Sentencia de la modificacion
            v_saldo_fisico = alm.f_get_saldo_fisico_item(v_parametros.id_item, v_parametros.id_almacen, CURRENT_DATE);
            
			update alm.tinventario_det set
                id_item = v_parametros.id_item,
                observaciones = v_parametros.observaciones,
                cantidad_sistema = v_saldo_fisico,
                cantidad_real = v_parametros.cantidad_real,
                diferencia = v_saldo_fisico - v_parametros.cantidad_real,
                id_inventario = v_parametros.id_inventario,
                fecha_mod = now(),
                id_usuario_mod = p_id_usuario
			where id_inventario_det=v_parametros.id_inventario_det;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle Inventario modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_inventario_det',v_parametros.id_inventario_det::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_DINV_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 21:26:02
	***********************************/

	elsif(p_transaccion='SAL_DINV_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from alm.tinventario_det
            where id_inventario_det=v_parametros.id_inventario_det;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle Inventario eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_inventario_det',v_parametros.id_inventario_det::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

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
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION alm.ft_inventario_det_ime(integer, integer, character varying, character varying)
  OWNER TO postgres;
