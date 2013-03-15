--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.ft_inventario_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_inventario_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tinventario'
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

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_inventario	integer;
			    
BEGIN

    v_nombre_funcion = 'alm.ft_inventario_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_INV_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 15:36:09
	***********************************/

	if(p_transaccion='SAL_INV_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into alm.tinventario(
                estado_reg,
                id_almacen,
                fecha_inv_planif,
                estado,
                observaciones,
                fecha_inv_ejec,
                completo,
                id_usuario_resp,
                fecha_reg,
                id_usuario_reg,
                fecha_mod,
                id_usuario_mod
          	) values(
                'activo',
                v_parametros.id_almacen,
                v_parametros.fecha_inv_planif,
                'borrador',
                v_parametros.observaciones,
                v_parametros.fecha_inv_ejec,
                v_parametros.completo,
                v_parametros.id_usuario_resp,
                now(),
                p_id_usuario,
                null,
                null
			)RETURNING id_inventario into v_id_inventario;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Inventario almacenado(a) con exito (id_inventario'||v_id_inventario||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_inventario',v_id_inventario::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_INV_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 15:36:09
	***********************************/

	elsif(p_transaccion='SAL_INV_MOD')then

		begin
			--Sentencia de la modificacion
			update alm.tinventario set
                id_almacen = v_parametros.id_almacen,
                fecha_inv_planif = v_parametros.fecha_inv_planif,
                observaciones = v_parametros.observaciones,
                fecha_inv_ejec = v_parametros.fecha_inv_ejec,
                completo = v_parametros.completo,
                id_usuario_resp = v_parametros.id_usuario_resp,
                fecha_mod = now(),
                id_usuario_mod = p_id_usuario
			where id_inventario=v_parametros.id_inventario;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Inventario modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_inventario',v_parametros.id_inventario::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_INV_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		15-03-2013 15:36:09
	***********************************/

	elsif(p_transaccion='SAL_INV_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from alm.tinventario
            where id_inventario=v_parametros.id_inventario;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Inventario eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_inventario',v_parametros.id_inventario::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
	/*********************************    
 	#TRANSACCION:  'SAL_INVFINREG_MOD'
 	#DESCRIPCION:	Finalizacion de registro Orden Inventario
 	#AUTOR:			Ariel Ayaviri Omonte
 	#FECHA:			15-03-2013 15:36:09
	***********************************/

	elsif(p_transaccion='SAL_INVFINREG_MOD')then

		begin
			update alm.tinventario set
                estado = 'pendiente_ejecucion'
			where id_inventario=v_parametros.id_inventario;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Inventario actualizado'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_inventario',v_parametros.id_inventario::varchar);
              
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
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;