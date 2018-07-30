CREATE OR REPLACE FUNCTION "alm"."ft_periodo_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_periodo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tperiodo'
 AUTOR: 		 (admin)
 FECHA:	        19-06-2013 08:33:57
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
	v_id_periodo			integer;
	v_estado_reg			varchar;
			    
BEGIN

    v_nombre_funcion = 'alm.ft_periodo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_ALMPER_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-06-2013 08:33:57
	***********************************/

	if(p_transaccion='SAL_ALMPER_INS')then
					
        begin
        
        	--Verificación de no duplicación de periodo
        	if exists(select 1 from alm.tperiodo
        			  where to_char(v_parametros.periodo,'mm/yyyy') = to_char(periodo,'mm/yyyy')) then
        		raise exception 'Este Período ya fue registrado';
        	end if;
        	
        	--Sentencia de la insercion
        	insert into alm.tperiodo(
			fecha_fin,
			fecha_ini,
			estado_reg,
			periodo,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.fecha_fin,
			v_parametros.fecha_ini,
			'activo',
			v_parametros.periodo,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_periodo into v_id_periodo;
			
			--Registro en el log
			insert into alm.tperiodo_log(
			id_periodo, estado_reg_ant, estado_reg
			) values(
			v_id_periodo, null, 'activo'	
			);
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Períodos almacenado(a) con exito (id_periodo'||v_id_periodo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_periodo',v_id_periodo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_ALMPER_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-06-2013 08:33:57
	***********************************/

	elsif(p_transaccion='SAL_ALMPER_MOD')then

		begin
			--Verificación de existencia del periodo
        	if not exists(select 1 from alm.tperiodo
        			  where id_periodo = v_parametros.id_periodo) then
        		raise exception 'Período inexistente';
        	end if;
        	
			--Verificación de no duplicación de periodo
        	if exists(select 1 from alm.tperiodo
        			  where to_char(v_parametros.periodo,'mm/yyyy') = to_char(periodo,'mm/yyyy')
        			  and id_periodo != v_parametros.id_periodo) then
        		raise exception 'Este Período ya fue registrado';
        	end if;
        	
			--Sentencia de la modificacion
			update alm.tperiodo set
			fecha_fin = v_parametros.fecha_fin,
			fecha_ini = v_parametros.fecha_ini,
			periodo = v_parametros.periodo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_periodo=v_parametros.id_periodo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Períodos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_periodo',v_parametros.id_periodo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_ALMPER_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		19-06-2013 08:33:57
	***********************************/

	elsif(p_transaccion='SAL_ALMPER_ELI')then

		begin
		
			--Verificación de existencia del periodo
        	if not exists(select 1 from alm.tperiodo
        			  where id_periodo = v_parametros.id_periodo) then
        		raise exception 'Período inexistente';
        	end if;
        	
			--Sentencia de la eliminacion
			delete from alm.tperiodo
            where id_periodo=v_parametros.id_periodo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Períodos eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_periodo',v_parametros.id_periodo::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
		
	/*********************************    
 	#TRANSACCION:  'SAL_PEABCE_MOD'
 	#DESCRIPCION:	Abrir/Cerrar/Reabrir periodo
 	#AUTOR:		rcm	
 	#FECHA:		20/06/2013
	***********************************/

	elsif(p_transaccion='SAL_PEABCE_MOD')then

		begin
		
			--Verificación de existencia del periodo
        	if not exists(select 1 from alm.tperiodo
        			  where id_periodo = v_parametros.id_periodo) then
        		raise exception 'Período inexistente';
        	else
        		select estado_reg
        		into v_estado_reg
        		from alm.tperiodo
        		where id_periodo = v_parametros.id_periodo;
        	end if;
        	
        	--Verificación de correctitud de nuevo estado
        	if v_parametros.nuevo_estado not in ('abierto','cerrado') then
        		raise exception 'Estado no válido';
        	end if;
        	
			--Sentencia de la modificacion
			update alm.tperiodo set
			estado_reg = v_parametros.nuevo_estado,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_periodo=v_parametros.id_periodo;
			
			--Registro de log
			insert into alm.tperiodo_log(
			id_periodo, estado_reg_ant, estado_reg
			) values(
			v_parametros.id_periodo, v_estado_reg, v_parametros.nuevo_estado
			);
			
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Período ' || v_parametros.nuevo_estado); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_periodo',v_parametros.id_periodo::varchar);
               
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
ALTER FUNCTION "alm"."ft_periodo_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
