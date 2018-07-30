CREATE OR REPLACE FUNCTION "alm"."ft_movimiento_grupo_det_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_movimiento_grupo_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tmovimiento_grupo_det'
 AUTOR: 		 (admin)
 FECHA:	        18-10-2013 21:26:09
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
	v_id_movimiento_grupo_det	integer;
			    
BEGIN

    v_nombre_funcion = 'alm.ft_movimiento_grupo_det_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_MOGRDE_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-10-2013 21:26:09
	***********************************/

	if(p_transaccion='SAL_MOGRDE_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into alm.tmovimiento_grupo_det(
			estado_reg,
			id_movimiento,
			id_movimiento_grupo,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.id_movimiento,
			v_parametros.id_movimiento_grupo,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_movimiento_grupo_det into v_id_movimiento_grupo_det;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle almacenado(a) con exito (id_movimiento_grupo_det'||v_id_movimiento_grupo_det||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento_grupo_det',v_id_movimiento_grupo_det::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_MOGRDE_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-10-2013 21:26:09
	***********************************/

	elsif(p_transaccion='SAL_MOGRDE_MOD')then

		begin
			--Sentencia de la modificacion
			update alm.tmovimiento_grupo_det set
			id_movimiento = v_parametros.id_movimiento,
			id_movimiento_grupo = v_parametros.id_movimiento_grupo,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_movimiento_grupo_det=v_parametros.id_movimiento_grupo_det;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento_grupo_det',v_parametros.id_movimiento_grupo_det::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_MOGRDE_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-10-2013 21:26:09
	***********************************/

	elsif(p_transaccion='SAL_MOGRDE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from alm.tmovimiento_grupo_det
            where id_movimiento_grupo_det=v_parametros.id_movimiento_grupo_det;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento_grupo_det',v_parametros.id_movimiento_grupo_det::varchar);
              
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
ALTER FUNCTION "alm"."ft_movimiento_grupo_det_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
