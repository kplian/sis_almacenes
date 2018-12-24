CREATE OR REPLACE FUNCTION alm.ft_salida_grupo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_salida_grupo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tsalida_grupo'
 AUTOR: 		 (admin)
 FECHA:	        17-10-2013 18:50:00
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
	v_id_salida_grupo	integer;
	v_result			varchar;
	v_total				numeric;
	v_tot_fun 			numeric;
    v_rec				record;
    v_id_estado_wf		integer;
    v_id_tipo_proceso	integer;
    v_id_proceso_wf		integer;
    v_id_tipo_estado	integer;
    v_id_estado_actual	integer;
			    
BEGIN

    v_nombre_funcion = 'alm.ft_salida_grupo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_SALGRU_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-10-2013 18:50:00
	***********************************/

	if(p_transaccion='SAL_SALGRU_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into alm.tsalida_grupo(
			id_movimiento_tipo,
			id_almacen,
			descripcion,
			fecha,
			observaciones,
			estado,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_movimiento_tipo,
			v_parametros.id_almacen,
			v_parametros.descripcion,
			v_parametros.fecha,
			v_parametros.observaciones,
			'borrador',
			'activo',
			p_id_usuario,
			now(),
			null,
			null
							
			)RETURNING id_salida_grupo into v_id_salida_grupo;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Salida Múltiple almacenado(a) con exito (id_salida_grupo'||v_id_salida_grupo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_salida_grupo',v_id_salida_grupo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_SALGRU_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-10-2013 18:50:00
	***********************************/

	elsif(p_transaccion='SAL_SALGRU_MOD')then

		begin
		
			if not exists(select 1 from alm.tsalida_grupo
						where id_salida_grupo = v_parametros.id_salida_grupo) then
				raise exception 'Solicitud no encontrada';
			end if;
			
			--Sentencia de la modificacion
			update alm.tsalida_grupo set
			id_movimiento_tipo = v_parametros.id_movimiento_tipo,
			id_almacen = v_parametros.id_almacen,
			descripcion = v_parametros.descripcion,
			fecha = v_parametros.fecha,
			observaciones = v_parametros.observaciones,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario
			where id_salida_grupo=v_parametros.id_salida_grupo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Salida Múltiple modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_salida_grupo',v_parametros.id_salida_grupo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_SALGRU_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-10-2013 18:50:00
	***********************************/

	elsif(p_transaccion='SAL_SALGRU_ELI')then

		begin
		
			if not exists(select 1 from alm.tsalida_grupo
						where id_salida_grupo = v_parametros.id_salida_grupo) then
				raise exception 'Solicitud no encontrada';
			end if;
			
			--Sentencia de la eliminacion
			delete from alm.tsalida_grupo
            where id_salida_grupo=v_parametros.id_salida_grupo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Salida Múltiple eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_salida_grupo',v_parametros.id_salida_grupo::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
		
	/*********************************    
 	#TRANSACCION:  'SAL_SALGRU_FIN'
 	#DESCRIPCION:	Finalización de la solicitud grupal
 	#AUTOR:			admin	
 	#FECHA:			17-10-2013 18:50:00
	***********************************/

	elsif(p_transaccion='SAL_SALGRU_FIN')then

		begin
			if not exists(select 1 from alm.tsalida_grupo
						where id_salida_grupo = v_parametros.id_salida_grupo) then
				raise exception 'Solicitud no encontrada';
			end if;
			if not exists(select 1 from alm.tsalida_grupo
						where id_salida_grupo = v_parametros.id_salida_grupo
						and estado = 'borrador') then
				raise exception 'La Solicitud debe estar en estado Borrador';
			end if;
			
			--Verifica que se haya asignado todos los items a los funcionarios
			v_total=0;
			v_tot_fun=0;
			
			select sum(cantidad_sol)
			into v_total 
			from alm.tsalida_grupo_item
			where id_salida_grupo = v_parametros.id_salida_grupo;
			
			select sum(gfun.cantidad_sol)
			into v_tot_fun 
			from alm.tsalida_grupo_item git
			inner join alm.tsalida_grupo_fun gfun on gfun.id_salida_grupo_item = git.id_salida_grupo_item
			where git.id_salida_grupo = v_parametros.id_salida_grupo;

			if v_total < v_tot_fun then
				raise exception 'La cantidad asignada a los funcionarios supera a la cantidad general definida';
			elsif v_total > v_tot_fun then
				raise exception 'Aún falta asignar items a los funcionarios para igualar a la cantidad general definida';
			end if;
			
			
			--Llamada a la función para generar las salidas por cada funcionario
			v_result = alm.f_generar_salida_func(p_id_usuario,v_parametros.id_salida_grupo);

			--Actualización del estado
			update alm.tsalida_grupo set
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			estado = 'finalizado'
			where id_salida_grupo = v_parametros.id_salida_grupo; 
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Salidas generadas'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_salida_grupo',v_parametros.id_salida_grupo::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
		
	/*********************************    
 	#TRANSACCION:  'SAL_SALGRU_RET'
 	#DESCRIPCION:	Retrocede una solicitud la solicitud grupal si es que ninguna de las solicitudes generadas han sido ya aprobadas
 	#AUTOR:			admin	
 	#FECHA:			17-10-2013 18:50:00
	***********************************/

	elsif(p_transaccion='SAL_SALGRU_RET')then

		begin
        
        	--------------------
            --(1) VALIDACIONES
            --------------------
			if not exists(select 1 from alm.tsalida_grupo
						where id_salida_grupo = v_parametros.id_salida_grupo) then
				raise exception 'Solicitud no encontrada';
			end if;
			if not exists(select 1 from alm.tsalida_grupo
						where id_salida_grupo = v_parametros.id_salida_grupo
						and estado = 'finalizado') then
				raise exception 'La Solicitud debe estar en estado Borrador';
			end if;
			
			--Verifica que todas las solicitudes generadas esten en estado borrador
			if exists(select 1 from alm.tmovimiento
					where id_salida_grupo = v_parametros.id_salida_grupo
					and estado_mov != 'borrador') then
				raise exception 'No es posible Retroceder la Solicitud, porque ya se aprobó alguna de las Salidas generadas';
			else
                ------------------------
                --(2)Cancela el Ingreso
                ------------------------
                for v_rec in (select id_movimiento
                			from alm.tmovimiento
                            where id_salida_grupo = v_parametros.id_salida_grupo) loop
                    --Obtiene el Proceso WF
                    SELECT
                    mov.id_estado_wf, pw.id_tipo_proceso, pw.id_proceso_wf
                    into
                    v_id_estado_wf, v_id_tipo_proceso, v_id_proceso_wf
                    FROM alm.tmovimiento mov
                    inner join wf.tproceso_wf pw on pw.id_proceso_wf = mov.id_proceso_wf
                    WHERE mov.id_movimiento = v_rec.id_movimiento;
                      
                    --Obtiene el estado cancelado del WF
                    select 
                    te.id_tipo_estado
                    into
                    v_id_tipo_estado
                    from wf.tproceso_wf pw 
                    inner join wf.ttipo_proceso tp on pw.id_tipo_proceso = tp.id_tipo_proceso
                    inner join wf.ttipo_estado te on te.id_tipo_proceso = tp.id_tipo_proceso and te.codigo = 'cancelado'               
                    where pw.id_proceso_wf = v_id_proceso_wf;
                         
                    --Se cancela el WF
                    v_id_estado_actual =  wf.f_registra_estado_wf(v_id_tipo_estado, 
                                                                   NULL, 
                                                                   v_id_estado_wf, 
                                                                   v_id_proceso_wf,
                                                                   p_id_usuario,
                                                                   null);
                      
                    --Cancela el movimiento
                    update alm.tmovimiento set
                    id_estado_wf =  v_id_estado_actual,
                    estado_mov = 'cancelado',
                    id_usuario_mod=p_id_usuario,
                    fecha_mod=now()
                    where id_movimiento = v_rec.id_movimiento;
                
                end loop;
                
                --Actualización del estado
                update alm.tsalida_grupo set
                fecha_mod = now(),
                id_usuario_mod = p_id_usuario,
                estado = 'borrador'
                where id_salida_grupo = v_parametros.id_salida_grupo; 

			end if;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Solicitud retrocedida'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_salida_grupo',v_parametros.id_salida_grupo::varchar);
              
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