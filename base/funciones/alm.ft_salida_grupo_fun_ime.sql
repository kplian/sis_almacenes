CREATE OR REPLACE FUNCTION "alm"."ft_salida_grupo_fun_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_salida_grupo_fun_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tsalida_grupo_fun'
 AUTOR: 		 (admin)
 FECHA:	        18-10-2013 02:54:34
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
	v_id_salida_grupo_fun	integer;
	v_total_fun 			numeric;
	v_total_item			numeric;
			    
BEGIN

    v_nombre_funcion = 'alm.ft_salida_grupo_fun_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_GRITFU_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-10-2013 02:54:34
	***********************************/

	if(p_transaccion='SAL_GRITFU_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into alm.tsalida_grupo_fun(
			id_funcionario,
			id_salida_grupo_item,
			cantidad_sol,
			observaciones,
			estado_reg,
			fecha_reg,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_funcionario,
			v_parametros.id_salida_grupo_item,
			v_parametros.cantidad_sol,
			v_parametros.observaciones,
			'activo',
			now(),
			p_id_usuario,
			null,
			null
							
			)RETURNING id_salida_grupo_fun into v_id_salida_grupo_fun;
			
			--Verifica que no se pase de la cantidad del padre
			select sum(cantidad_sol)
			into v_total_fun
			from alm.tsalida_grupo_fun
			where id_salida_grupo_item = v_parametros.id_salida_grupo_item;
			
			select sum(cantidad_sol)
			into v_total_item
			from alm.tsalida_grupo_item
			where id_salida_grupo_item = v_parametros.id_salida_grupo_item;
			
			if v_total_fun > v_total_item then
				raise exception 'La cantidad asignada al funcionario supera la Cantidad general definida para el Item';
			end if;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Por funcionario almacenado(a) con exito (id_salida_grupo_fun'||v_id_salida_grupo_fun||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_salida_grupo_fun',v_id_salida_grupo_fun::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_GRITFU_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-10-2013 02:54:34
	***********************************/

	elsif(p_transaccion='SAL_GRITFU_MOD')then

		begin
			--Sentencia de la modificacion
			update alm.tsalida_grupo_fun set
			id_funcionario = v_parametros.id_funcionario,
			id_salida_grupo_item = v_parametros.id_salida_grupo_item,
			cantidad_sol = v_parametros.cantidad_sol,
			observaciones = v_parametros.observaciones,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_salida_grupo_fun=v_parametros.id_salida_grupo_fun;
			
			--Verifica que no se pase de la cantidad del padre
			select sum(cantidad_sol)
			into v_total_fun
			from alm.tsalida_grupo_fun
			where id_salida_grupo_item = v_parametros.id_salida_grupo_item;
			
			select sum(cantidad_sol)
			into v_total_item
			from alm.tsalida_grupo_item
			where id_salida_grupo_item = v_parametros.id_salida_grupo_item;
			
			if v_total_fun > v_total_item then
				raise exception 'La cantidad asignada al funcionario supera la Cantidad general definida para el Item';
			end if;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Por funcionario modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_salida_grupo_fun',v_parametros.id_salida_grupo_fun::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_GRITFU_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-10-2013 02:54:34
	***********************************/

	elsif(p_transaccion='SAL_GRITFU_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from alm.tsalida_grupo_fun
            where id_salida_grupo_fun=v_parametros.id_salida_grupo_fun;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Por funcionario eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_salida_grupo_fun',v_parametros.id_salida_grupo_fun::varchar);
              
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
ALTER FUNCTION "alm"."ft_salida_grupo_fun_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
