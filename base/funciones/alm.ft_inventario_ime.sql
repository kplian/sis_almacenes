CREATE OR REPLACE FUNCTION alm.ft_inventario_ime(p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
  RETURNS character varying AS
$BODY$
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
	v_id_inventario			integer;
    v_fecha_inv_ejec		timestamp;
    v_fecha_inv_planif		timestamp;
    v_cont					integer;
    g_registros				record;
    v_boolean 				boolean;
    v_id_movimiento			integer;
    v_id_movimiento_det		integer;
			    
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
			
            if (v_parametros.completo = 'si') then
            	FOR g_registros IN (
                	select id_item from alm.titem where estado_reg = 'activo'
                ) LOOP
                    insert into alm.tinventario_det(
                    	id_inventario,
                        id_item,
                        fecha_reg,
                        id_usuario_reg,
                        fecha_mod,
                        id_usuario_mod
                    ) values (
                    	v_id_inventario,
                        g_registros.id_item,
                        now(),
                        p_id_usuario,
                        null,
                        null
                    );
                END LOOP;
            end if;
            
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
        	select count(id_inventario_det) into v_cont
            from alm.tinventario_det 
            where id_inventario = v_parametros.id_inventario;
        	
            IF(v_cont = 0) THEN
            	raise exception '%', 'No se puede finalizar el registro de la Orden de Inventario: Debe tener al menos un item a inventariar.';
            END IF;
			update alm.tinventario set
                estado = 'pendiente_ejecucion'
			where id_inventario=v_parametros.id_inventario;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Inventario actualizado'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_inventario',v_parametros.id_inventario::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
    
    /*********************************    
 	#TRANSACCION:  'SAL_INVINIEJE_MOD'
 	#DESCRIPCION:	Finalizacion de registro Orden Inventario
 	#AUTOR:			Ariel Ayaviri Omonte
 	#FECHA:			15-03-2013 15:36:09
	***********************************/

	elsif(p_transaccion='SAL_INVINIEJE_MOD')then

		begin
			update alm.tinventario set
                estado = 'ejecucion'
			where id_inventario=v_parametros.id_inventario;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Inventario actualizado'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_inventario',v_parametros.id_inventario::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;    
    /*********************************    
 	#TRANSACCION:  'SAL_INVFINEJE_MOD'
 	#DESCRIPCION:	Finalizacion de registro Orden Inventario
 	#AUTOR:			Ariel Ayaviri Omonte
 	#FECHA:			18-03-2013
	***********************************/

	elsif(p_transaccion='SAL_INVFINEJE_MOD')then

		begin
        	
        	select fecha_inv_ejec, fecha_inv_planif into v_fecha_inv_ejec, v_fecha_inv_planif
            from alm.tinventario 
            where id_inventario = v_parametros.id_inventario;
        	
            IF (v_fecha_inv_ejec is not null) THEN
                IF (v_fecha_inv_ejec < v_fecha_inv_planif) THEN
                	raise exception '%', 'No se puede finalizar el llenado del inventario: La fecha de Ejecución no puede ser anterior a la fecha de planificacion.';
                ELSE
                	
                	v_boolean = alm.f_actualizar_saldos_inventario(v_parametros.id_inventario);
                	update alm.tinventario set
                        estado = 'revision'
                    where id_inventario=v_parametros.id_inventario;
                END IF;
            ELSE
            	raise exception '%', 'No se puede finalizar el llenado del inventario. Debe especificar la fecha de ejecución ';
            END IF;
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Inventario actualizado'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_inventario',v_parametros.id_inventario::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
    
    /*********************************    
 	#TRANSACCION:  'SAL_INVFINREV_MOD'
 	#DESCRIPCION:	Finalizacion de registro Orden Inventario
 	#AUTOR:			Ariel Ayaviri Omonte
 	#FECHA:			18-03-2013
	***********************************/

	elsif(p_transaccion='SAL_INVFINREV_MOD')then

		begin
			update alm.tinventario set
                estado = 'finalizado'
			where id_inventario=v_parametros.id_inventario;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Inventario actualizado'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_inventario',v_parametros.id_inventario::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
    
    /*********************************    
 	#TRANSACCION:  'SAL_INVCORRREV_MOD'
 	#DESCRIPCION:	Devuelve el inventario para correccion
 	#AUTOR:			Ariel Ayaviri Omonte
 	#FECHA:			18-03-2013
	***********************************/

	elsif(p_transaccion='SAL_INVCORRREV_MOD')then

		begin
			update alm.tinventario set
                estado = 'pendiente_correccion'
			where id_inventario=v_parametros.id_inventario;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Inventario actualizado'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_inventario',v_parametros.id_inventario::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
    
    /*********************************    
 	#TRANSACCION:  'SAL_INVREVDIF_MOD'
 	#DESCRIPCION:	Revision de diferencias en el inventario detalle
 	#AUTOR:			Ariel Ayaviri Omonte
 	#FECHA:			20-03-2013
	***********************************/

	elsif(p_transaccion='SAL_INVREVDIF_MOD')then

		begin
        	-- Se actualizan los saldos de los items del sistema.
        	v_boolean = alm.f_actualizar_saldos_inventario(v_parametros.id_inventario);
            
            --se obtiene la cantidad de registros con diferencias
        	
            select count(invdet.id_inventario_det) into v_cont
            from alm.tinventario_det invdet
            where invdet.id_inventario = v_parametros.id_inventario
            	and invdet.diferencia <> 0;
        	   
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Revision de diferencias en el inventario'); 
            v_resp = pxp.f_agrega_clave(v_resp,'cant_diferencias',v_cont::varchar);
            
            --Devuelve la respuesta
            return v_resp;

		end;
    /*********************************    
 	#TRANSACCION:  'SAL_INVNIVMOV_MOD'
 	#DESCRIPCION:	Realiza la insercion de los movimientos necesarios para la nivelacion de saldos.
 	#AUTOR:			Ariel Ayaviri Omonte
 	#FECHA:			20-03-2013
	***********************************/

	elsif(p_transaccion='SAL_INVNIVMOV_MOD')then
		begin
        	-- Se actualizan los saldos de los items del sistema.
        	v_boolean = alm.f_actualizar_saldos_inventario(v_parametros.id_inventario);
            
            --se se crea un movimiento para ingreso de las existencias faltantes
	    FOR g_registros in (
                select
                    invdet.id_item,
                    invdet.diferencia,
                    inv.id_almacen
                from alm.tinventario_det invdet
                inner join alm.tinventario inv on inv.id_inventario = invdet.id_inventario
                where invdet.id_inventario = v_parametros.id_inventario
                	and invdet.diferencia < 0
            ) LOOP
            	if (v_id_movimiento is null) then
                    insert into alm.tmovimiento (
                        id_usuario_reg,
                        fecha_reg, 
                        estado_reg,
                        id_movimiento_tipo, 
                        id_almacen,
                        fecha_mov,
                        descripcion,
                        observaciones,
                        estado_mov
                    ) values (
                        p_id_usuario,
                        now(),
                        'activo',
                        alm.f_get_id_tipo_mov_por_codigo('INAJUST'),
                        g_registros.id_almacen,
                        date(now()) + interval '12 hours',
                        'Ingreso por ajuste de inventario',
                        'Generado automáticamente',
                        'borrador'
                    ) RETURNING id_movimiento into v_id_movimiento;
                end if;
                
                insert into alm.tmovimiento_det (
                    id_usuario_reg,
                    fecha_reg,
                    estado_reg,
                    id_movimiento,
                    id_item,
                    cantidad
                ) VALUES (
                    p_id_usuario,
                    now(),
                    'activo',
                    v_id_movimiento,
                    g_registros.id_item,
                    g_registros.diferencia * -1
                ) RETURNING id_movimiento_det into v_id_movimiento_det;
                
                insert into alm.tmovimiento_det_valorado (
                    id_usuario_reg,
                    fecha_reg,
                    estado_reg,
                    id_movimiento_det,
                    cantidad
                ) VALUES (
                    p_id_usuario,
                    now(),
                    'activo',
                    v_id_movimiento_det,
                    g_registros.diferencia * -1
                );
                
            END LOOP;
            
            v_id_movimiento = null;

	    --se se crea un movimiento para la salida de las existencias sobrantes
	    FOR g_registros in (
                select
                    invdet.id_item,
                    invdet.diferencia,
                    inv.id_almacen
                from alm.tinventario_det invdet
                inner join alm.tinventario inv on inv.id_inventario = invdet.id_inventario
                where invdet.id_inventario = v_parametros.id_inventario
                	and invdet.diferencia > 0
            ) LOOP
            	if (v_id_movimiento is null) then
                    insert into alm.tmovimiento (
                        id_usuario_reg,
                        fecha_reg, 
                        estado_reg,
                        id_movimiento_tipo, 
                        id_almacen,
                        fecha_mov,
                        descripcion,
                        observaciones,
                        estado_mov
                    ) values (
                        p_id_usuario,
                        now(),
                        'activo',
                        alm.f_get_id_tipo_mov_por_codigo('SALAJUST'),
                        g_registros.id_almacen,
                        date(now()) + interval '12 hours',
                        'Salida por ajuste de inventario',
                        'Generado automáticamente',
                        'borrador'
                    ) RETURNING id_movimiento into v_id_movimiento;
                end if;
                
                insert into alm.tmovimiento_det (
                    id_usuario_reg,
                    fecha_reg,
                    estado_reg,
                    id_movimiento,
                    id_item,
                    cantidad
                ) VALUES (
                    p_id_usuario,
                    now(),
                    'activo',
                    v_id_movimiento,
                    g_registros.id_item,
                    g_registros.diferencia
                ) RETURNING id_movimiento_det into v_id_movimiento_det;
                
                insert into alm.tmovimiento_det_valorado (
                    id_usuario_reg,
                    fecha_reg,
                    estado_reg,
                    id_movimiento_det,
                    cantidad
                ) VALUES (
                    p_id_usuario,
                    now(),
                    'activo',
                    v_id_movimiento_det,
                    g_registros.diferencia
                );
                
            END LOOP;
            
            v_id_movimiento = null;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Insercion de ajustes realizado'); 
            
            --Devuelve la respuesta
            return v_resp;

	end;
    
    /*********************************    
 	#TRANSACCION:  'SAL_INVACTSALD_MOD'
 	#DESCRIPCION:	Actualiza los saldos del inventario
 	#AUTOR:			Ariel Ayaviri Omonte
 	#FECHA:			20-03-2013
	***********************************/

	elsif(p_transaccion='SAL_INVACTSALD_MOD')then

		begin
        	-- Se actualizan los saldos de los items del sistema.
        	v_boolean = alm.f_actualizar_saldos_inventario(v_parametros.id_inventario);
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Revision de diferencias en el inventario'); 
            v_resp = pxp.f_agrega_clave(v_resp,'exito',v_boolean::varchar);
            
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
ALTER FUNCTION alm.ft_inventario_ime(integer, integer, character varying, character varying)
  OWNER TO postgres;
