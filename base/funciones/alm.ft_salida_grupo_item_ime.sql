CREATE OR REPLACE FUNCTION "alm"."ft_salida_grupo_item_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_salida_grupo_item_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tsalida_grupo_item'
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

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_salida_grupo_item	integer;
			    
BEGIN

    v_nombre_funcion = 'alm.ft_salida_grupo_item_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_SAGRIT_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-10-2013 20:34:52
	***********************************/

	if(p_transaccion='SAL_SAGRIT_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into alm.tsalida_grupo_item(
			observaciones,
			estado_reg,
			id_item,
			cantidad_sol,
			id_salida_grupo,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.observaciones,
			'activo',
			v_parametros.id_item,
			v_parametros.cantidad_sol,
			v_parametros.id_salida_grupo,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_salida_grupo_item into v_id_salida_grupo_item;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle almacenado(a) con exito (id_salida_grupo_item'||v_id_salida_grupo_item||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_salida_grupo_item',v_id_salida_grupo_item::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_SAGRIT_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-10-2013 20:34:52
	***********************************/

	elsif(p_transaccion='SAL_SAGRIT_MOD')then

		begin
			--Sentencia de la modificacion
			update alm.tsalida_grupo_item set
			observaciones = v_parametros.observaciones,
			id_item = v_parametros.id_item,
			cantidad_sol = v_parametros.cantidad_sol,
			id_salida_grupo = v_parametros.id_salida_grupo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_salida_grupo_item=v_parametros.id_salida_grupo_item;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_salida_grupo_item',v_parametros.id_salida_grupo_item::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_SAGRIT_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-10-2013 20:34:52
	***********************************/

	elsif(p_transaccion='SAL_SAGRIT_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from alm.tsalida_grupo_item
            where id_salida_grupo_item=v_parametros.id_salida_grupo_item;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_salida_grupo_item',v_parametros.id_salida_grupo_item::varchar);
              
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
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "alm"."ft_salida_grupo_item_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
