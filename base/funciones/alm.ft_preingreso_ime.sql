CREATE OR REPLACE FUNCTION alm.ft_preingreso_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_preingreso_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tpreingreso'
 AUTOR: 		 (admin)
 FECHA:	        07-10-2013 16:56:43
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
	v_id_preingreso			integer;
	v_result				varchar;
			    
BEGIN

    v_nombre_funcion = 'alm.ft_preingreso_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_PREING_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-10-2013 16:56:43
	***********************************/

	if(p_transaccion='SAL_PREING_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into alm.tpreingreso(
			estado_reg,
			id_cotizacion,
			id_almacen,
			id_depto,
			id_estado_wf,
			id_proceso_wf,
			estado,
			id_moneda,
			tipo,
			descripcion,
			id_usuario_reg,
			fecha_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.id_cotizacion,
			v_parametros.id_almacen,
			v_parametros.id_depto,
			v_parametros.id_estado_wf,
			v_parametros.id_proceso_wf,
			v_parametros.estado,
			v_parametros.id_moneda,
			v_parametros.tipo,
			v_parametros.descripcion,
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_preingreso into v_id_preingreso;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Preingreso almacenado(a) con exito (id_preingreso'||v_id_preingreso||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_preingreso',v_id_preingreso::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_PREING_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-10-2013 16:56:43
	***********************************/

	elsif(p_transaccion='SAL_PREING_MOD')then

		begin
			--Sentencia de la modificacion
			update alm.tpreingreso set
			id_cotizacion = v_parametros.id_cotizacion,
			id_almacen = v_parametros.id_almacen,
			id_depto = v_parametros.id_depto,
			id_estado_wf = v_parametros.id_estado_wf,
			id_proceso_wf = v_parametros.id_proceso_wf,
			estado = v_parametros.estado,
			id_moneda = v_parametros.id_moneda,
			tipo = v_parametros.tipo,
			descripcion = v_parametros.descripcion,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now()
			where id_preingreso=v_parametros.id_preingreso;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Preingreso modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_preingreso',v_parametros.id_preingreso::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_PREING_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		07-10-2013 16:56:43
	***********************************/

	elsif(p_transaccion='SAL_PREING_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from alm.tpreingreso
            where id_preingreso=v_parametros.id_preingreso;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Preingreso eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_preingreso',v_parametros.id_preingreso::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
		
	/*********************************    
 	#TRANSACCION:  'SAL_INGRES_GEN'
 	#DESCRIPCION:	GEneración de ingreso a Almacenes o Activos Fijos
 	#AUTOR:			RCM
 	#FECHA:			08/10/2013
	***********************************/

	elsif(p_transaccion='SAL_INGRES_GEN')then

		begin
        
			--Llamada a la función de generación de ingreso
			v_result = alm.f_generar_ingreso(p_id_usuario, v_parametros.id_preingreso);
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle Preingreso modificado(a)'); 
               
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