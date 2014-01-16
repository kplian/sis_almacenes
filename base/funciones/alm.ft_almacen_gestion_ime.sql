CREATE OR REPLACE FUNCTION alm.ft_almacen_gestion_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_almacen_gestion_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.talmacen_gestion'
 AUTOR: 		 (admin)
 FECHA:	        31-12-2013 14:15:09
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
	v_id_almacen_gestion	integer;
	v_estado				varchar;
	v_accion				varchar;
	v_result				varchar;
			    
BEGIN

    v_nombre_funcion = 'alm.ft_almacen_gestion_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_ALMGES_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		31-12-2013 14:15:09
	***********************************/

	if(p_transaccion='SAL_ALMGES_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into alm.talmacen_gestion(
			id_almacen,
			id_gestion,
			estado,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_almacen,
			v_parametros.id_gestion,
			'registrado',
			'activo',
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_almacen_gestion into v_id_almacen_gestion;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Gestión Almacenes almacenado(a) con exito (id_almacen_gestion'||v_id_almacen_gestion||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_almacen_gestion',v_id_almacen_gestion::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_ALMGES_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		31-12-2013 14:15:09
	***********************************/

	elsif(p_transaccion='SAL_ALMGES_MOD')then

		begin
			--Sentencia de la modificacion
			update alm.talmacen_gestion set
			id_almacen = v_parametros.id_almacen,
			id_gestion = v_parametros.id_gestion,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_almacen_gestion=v_parametros.id_almacen_gestion;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Gestión Almacenes modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_almacen_gestion',v_parametros.id_almacen_gestion::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_ALMGES_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		31-12-2013 14:15:09
	***********************************/

	elsif(p_transaccion='SAL_ALMGES_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from alm.talmacen_gestion
            where id_almacen_gestion=v_parametros.id_almacen_gestion;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Gestión Almacenes eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_almacen_gestion',v_parametros.id_almacen_gestion::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
		
	/*********************************    
 	#TRANSACCION:  'SAL_ACCGES_INS'
 	#DESCRIPCION:	Acciones para realizar sobre la gestión
 	#AUTOR:			RCM	
 	#FECHA:			31-12-2013 14:15:09
	***********************************/

	elsif(p_transaccion='SAL_ACCGES_INS')then

		begin
			--1.Validación de existencia del registro
			if not exists(select 1 from alm.talmacen_gestion
						where id_almacen_gestion = v_parametros.id_almacen_gestion) then
				raise exception 'Gestión del almacén inexistente';
			end if;
			
			--2.Obtención de datos
			select estado
			into v_estado
			from alm.talmacen_gestion
			where id_almacen_gestion = v_parametros.id_almacen_gestion;

			--3.Identificación de acción a realizar
			if v_estado = 'registrado' then
				--Apertura
				v_accion = 'Abierta';
				v_result = alm.f_registrar_almacen_gestion_log(p_id_usuario,v_parametros.id_almacen_gestion,'abrir');
			elsif v_estado = 'abierto' then
				--Cierre
				v_accion = 'Cerrada';
				v_result = alm.f_registrar_almacen_gestion_log(p_id_usuario,v_parametros.id_almacen_gestion,'cerrar');
			elsif v_estado = 'cerrado' then
				--Reapertura
				v_accion = 'Reabierta';
				v_result = alm.f_registrar_almacen_gestion_log(p_id_usuario,v_parametros.id_almacen_gestion,'reabrir');
			else
				raise exception 'Estado de la Gestión inaplicable';
			end if;
			
			if v_result = '' then
				v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Gestión '||v_accion||' con éxito'); 
                v_resp = pxp.f_agrega_clave(v_resp,'mensaje_vista','Gestión '||v_accion||' con éxito'); 
            	v_resp = pxp.f_agrega_clave(v_resp,'id_almacen_gestion',v_parametros.id_almacen_gestion::varchar);
                v_resp = pxp.f_agrega_clave(v_resp,'error_logico','no'::varchar);
            else
            	v_resp = v_result;
			end if;
              
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