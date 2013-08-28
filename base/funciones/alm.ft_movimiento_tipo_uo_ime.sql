CREATE OR REPLACE FUNCTION "alm"."ft_movimiento_tipo_uo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_movimiento_tipo_uo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tmovimiento_tipo_uo'
 AUTOR: 		 (admin)
 FECHA:	        22-08-2013 22:55:37
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
	v_id_movimiento_tipo_uo	integer;
	v_sql 					varchar;
			    
BEGIN

    v_nombre_funcion = 'alm.ft_movimiento_tipo_uo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_TIMVUO_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-08-2013 22:55:37
	***********************************/

	if(p_transaccion='SAL_TIMVUO_INS')then
					
        begin
        	--Guardando el array de UOs
        	if coalesce(v_parametros.id_uo,'') != '' then
                v_sql = '
                        insert into alm.tmovimiento_tipo_uo(
                        id_uo, id_movimiento_tipo, estado_reg, id_usuario_reg, fecha_reg)
                        select
                        uo.id_uo,' || v_parametros.id_movimiento_tipo ||', ''activo'','||p_id_usuario||',now()
                        from orga.tuo uo
                        where uo.id_uo = ANY(ARRAY['||v_parametros.id_uo||'])
                        and uo.id_uo not in (select id_uo
                                            from alm.tmovimiento_tipo_uo
                                            where id_uo is not null
                                            and id_movimiento_tipo = ' || v_parametros.id_movimiento_tipo ||')';
                execute(v_sql);
            end if;

			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Movimiento/Organigrama almacenado(a) con exito'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento_tipo',v_parametros.id_movimiento_tipo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_TIMVUO_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		22-08-2013 22:55:37
	***********************************/

	elsif(p_transaccion='SAL_TIMVUO_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from alm.tmovimiento_tipo_uo
            where id_movimiento_tipo_uo=v_parametros.id_movimiento_tipo_uo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Movimiento/Organigrama eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento_tipo_uo',v_parametros.id_movimiento_tipo_uo::varchar);
              
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
ALTER FUNCTION "alm"."ft_movimiento_tipo_uo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
