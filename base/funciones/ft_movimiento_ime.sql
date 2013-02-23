--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.ft_movimiento_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_movimiento_ime
 DESCRIPCION:    Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones) de la tabla 'alm.tmovimiento'
 AUTOR:          Gonzalo Sarmiento
 FECHA:          03-10-2012
 COMENTARIOS:   
************************************************************************/
DECLARE
  v_nombre_funcion 				varchar;  
  v_parametros					record;
  v_id_movimiento_tipo			integer;
  v_id_movimiento				integer;
  v_id_movimiento_tipo_ingreso	integer;
  v_id_movimiento_tipo_salida	integer;
  v_respuesta					varchar;
  v_id_movimiento_ingreso		integer;
  v_id_movimiento_salida		integer;
  v_transferencia				record;
  v_consulta					varchar;
  v_detalle						record;
  v_contador					numeric;
  v_contador_2					numeric;
  v_estado_almacen				varchar;
  v_estado_mov					varchar;
  g_registros					record;
  g_registros_2					record;
  v_tipo_mov					varchar;
  v_id_almacen					integer;
  v_codigo_valoracion			varchar;
  v_saldo_cantidad				numeric;
  v_aux_integer					integer;
  v_costo_valorado				numeric;
  v_cantidad_valorada			numeric;
  v_id_movimiento_det_val_desc 	integer;
  v_nombre_item					varchar;
  v_errores						varchar;
BEGIN
  v_nombre_funcion='alm.ft_movimiento_ime';
  v_parametros=pxp.f_get_record(p_tabla);
  
  
  /*********************************   
     #TRANSACCION:  'SAL_MOV_INS'
     #DESCRIPCION:  Insercion de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        03-10-2012
    ***********************************/
	if(p_transaccion='SAL_MOV_INS') then
	begin
		insert into alm.tmovimiento (
        	id_usuario_reg,
            fecha_reg, 
            estado_reg,
            id_movimiento_tipo, 
            id_almacen,
            id_funcionario, 
            id_proveedor,
            id_almacen_dest, 
            fecha_mov,
            descripcion,
            observaciones,
            estado_mov
        ) values (
        	p_id_usuario,
            now(),
            'activo',
        	v_parametros.id_movimiento_tipo,
            v_parametros.id_almacen,
            v_parametros.id_funcionario, 
            v_parametros.id_proveedor,
            v_parametros.id_almacen_dest,
            v_parametros.fecha_mov,
            v_parametros.descripcion,
            v_parametros.observaciones,
            'borrador'
        ) RETURNING id_movimiento into v_id_movimiento;

        v_respuesta =pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento almacenado correctamente');
        v_respuesta =pxp.f_agrega_clave(v_respuesta,'id_movimiento',v_id_movimiento::varchar);

        return v_respuesta;
    end;
  /*********************************   
     #TRANSACCION:  'SAL_MOV_MOD'
     #DESCRIPCION:  Modificacion de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        03-10-2012
    ***********************************/    	 
        		
	elseif(p_transaccion='SAL_MOV_MOD')then
  	begin
    	
    	select mov.estado_mov into v_estado_mov
        from alm.tmovimiento mov
        where mov.id_movimiento = v_parametros.id_movimiento;
        
        if (v_estado_mov = 'cancelado' or v_estado_mov = 'finalizado') then
        	raise exception '%', 'El movimiento actual no puede ser modificado';
        end if;
        
    	update alm.tmovimiento set       			 
        	id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            id_movimiento_tipo = v_parametros.id_movimiento_tipo,
        	id_almacen = v_parametros.id_almacen,
            id_funcionario = v_parametros.id_funcionario,
            id_proveedor = v_parametros.id_proveedor,
            id_almacen_dest = v_parametros.id_almacen_dest,
            fecha_mov = v_parametros.fecha_mov,
            descripcion = v_parametros.descripcion,
            observaciones = v_parametros.observaciones
        where id_movimiento = v_parametros.id_movimiento;
        
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento modificado con exito');
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);
        return v_respuesta;
    end;
  /*********************************   
     #TRANSACCION:  'SAL_MOV_ELI'
     #DESCRIPCION:  Eliminacion de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        03-10-2012
    ***********************************/
  	elseif(p_transaccion='SAL_MOV_ELI')then
  	begin
    	select mov.estado_mov into v_estado_mov
        from alm.tmovimiento mov
        where mov.id_movimiento = v_parametros.id_movimiento;
        
        if (v_estado_mov = 'cancelado' or v_estado_mov = 'finalizado') then
        	raise exception '%', 'El movimiento actual no puede ser eliminado';
        end if;
        
    	delete from alm.tmovimiento
        where id_movimiento=v_parametros.id_movimiento;

        v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento eliminado');
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);

        return v_respuesta;
    end;
    /*********************************   
     #TRANSACCION:  'SAL_MOVFIN_MOD'
     #DESCRIPCION:  Finalizacion de un movimiento
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        20-02-2013
    ***********************************/
	elseif(p_transaccion='SAL_MOVFIN_MOD')then
  	begin
    	--verificar que el almacen esté activo.
        select alma.estado into v_estado_almacen
        from alm.talmacen alma
        where alma.id_almacen = v_parametros.id_almacen;
        
        if (v_estado_almacen is null or v_estado_almacen = 'inactivo') then
        	raise exception '%', 'El almacen seleccionado para este movimiento no se encuentra activo';
        end if;
        
        --TODO: Verificar que la fecha no sea anterior al ultimo registro finalizado.
        
        --TODO: revisar si el periodo esta abierto.
        
        --se obtiene el tipo de movimiento para realizar validaciones
        select movtip.tipo into v_tipo_mov
        from alm.tmovimiento mov 
        inner join alm.tmovimiento_tipo movtip on movtip.id_movimiento_tipo = mov.id_movimiento_tipo
        where mov.id_movimiento = v_parametros.id_movimiento;
        
        -- Busqueda de errores en las dependencias del movimiento
        v_contador := 0;
        FOR g_registros in (
			select 
            	movdet.id_item,
            	item.nombre as nombre_item,
                movdet.id_movimiento_det,
				movdet.cantidad as cantidad_item
            from alm.tmovimiento_det movdet
            inner join alm.titem item on item.id_item = movdet.id_item
            where movdet.estado_reg = 'activo'
            	and movdet.id_movimiento = v_parametros.id_movimiento
		) LOOP
        	v_contador = v_contador + 1;
            
        	--Verificamos que la cantidad no sea nula y que la cantidad requerida no sea mayor que el saldo 
            v_saldo_cantidad = alm.f_get_saldo_fisico_item(g_registros.id_item, v_parametros.id_almacen);
            if (g_registros.cantidad_item is null or g_registros.cantidad_item < 0) then
            	v_errores = v_errores || '\nEl item ' || g_registros.nombre_item || ' debe tener cantidad registrada igual o mayor a cero';
            elseif (v_tipo_mov = 'salida' and g_registros.cantidad_item > v_saldo_cantidad) then
            	v_errores = v_errores || '\nNo existen suficientes existencias del item ' || g_registros.nombre_item || '. Solicitado: ' || g_registros.cantidad_item || '. Existencias: '|| v_saldo_cantidad;
            end if;
            
            v_contador_2 := 0;
            FOR g_registros_2 IN (
            	select 
                    detval.cantidad as cantidad_item
                from alm.tmovimiento_det_valorado detval
                inner join alm.tmovimiento_det movdet on movdet.id_movimiento_det = detval.id_movimiento_det
                where detval.estado_reg = 'activo'
                    and detval.id_movimiento_det = g_registros.id_movimiento_det 
            ) LOOP
            	v_contador_2 = v_contador_2 + 1;
                if (g_registros_2.cantidad_item is null or g_registros_2.cantidad_item < 0) THEN
                	v_errores = v_errores || '\n- El item ' || g_registros.nombre_item || ' debe contener valorados con cantidad mayor o igual que cero';
                end if;
                
            END LOOP;
            
            if (v_contador_2 = 0) then
            	v_errores = v_errores || '\n- El item ' || g_registros.nombre_item || ' debe tener al menos una cantidad para valorar';
            end if;
        END LOOP;
        
        --verificar que el movimiento tenga al menos un movimiento_detalle registrado.
        if (v_contador = 0) then
        	raise exception '%', 'El movimiento seleccionado debe tener al menos un item registrado en su detalle';
        end if;
        
        --muestra los errores si los hubiese
        if (v_errores != '') then
        	raise exception '%', v_errores;
        end if;
        
        --Si el movimiento que se desea finalizar es una salida entonces se debe valorar los detalles.
        if (v_tipo_mov = 'salida') then
        	
        	FOR g_registros IN (
            	select 
                	movdet.id_movimiento_det,
                	movdet.id_item,
                    itm.nombre as nombre_item,
                	movdet.cantidad,
                    detval.id_movimiento_det_valorado
                from alm.tmovimiento_det_valorado detval
                inner join alm.tmovimiento_det movdet on movdet.id_movimiento_det = detval.id_movimiento_det
                inner join alm.titem itm on itm.id_item = movdet.id_item
                where movdet.id_movimiento = v_parametros.id_movimiento
                	and movdet.estado_reg = 'activo'
            ) LOOP
            	--obtener el codigo del metodo de valoracion
                select metval.codigo into v_codigo_valoracion
                from alm.talmacen_stock alstock
                inner join alm.tmetodo_val metval on metval.id_metodo_val = alstock.id_metodo_val
                where alstock.id_almacen = v_parametros.id_almacen
                	and alstock.id_item = g_registros.id_item
                    and alstock.estado_reg = 'activo';
                
                v_saldo_cantidad = g_registros.cantidad;
                
                -- Verificar que el el item tenga un tipo de valoracion
				if (v_codigo_valoracion is null) then
                	raise exception '%', 'El item ' || g_registros.nombre_item || ' no tiene registrado un metodo de valoracion';
                end if;
                
                select r_costo_valorado, r_cantidad_valorada, r_id_movimiento_det_val_desc
                    into v_costo_valorado, v_cantidad_valorada, v_id_movimiento_det_val_desc
                from alm.f_get_valorado_item(g_registros.id_item, v_parametros.id_almacen, v_codigo_valoracion, v_saldo_cantidad);
                
                if (v_costo_valorado is null) then
                	raise exception '%', 'El item ' || g_registros.nombre_item || ' no pudo ser valorado';
                end if;
                
                IF (v_codigo_valoracion = 'PEPS' or v_codigo_valoracion = 'UEPS') THEN
                    --Se descuenta la cantidad valorada del detalle valorado que se utilizo en la valoracion
                    update alm.tmovimiento_det_valorado detval set
                        id_usuario_mod = p_id_usuario,
                        fecha_mod = now(),
                        aux_saldo_fisico = detval.aux_saldo_fisico - v_cantidad_valorada
                    where detval.id_movimiento_det_valorado = v_id_movimiento_det_val_desc;
                END IF;
                
                v_saldo_cantidad = v_saldo_cantidad - v_cantidad_valorada;
                
                update alm.tmovimiento_det_valorado set
                    id_usuario_mod = p_id_usuario,
                    fecha_mod = now(),
                    cantidad = v_cantidad_valorada,
                    costo_unitario = v_costo_valorado
                where id_movimiento_det_valorado = g_registros.id_movimiento_det_valorado;
                
                --si todavia hay saldo que valorar
                WHILE (v_saldo_cantidad > 0) LOOP
                	select r_costo_valorado, r_cantidad_valorada, r_id_movimiento_det_val_desc
                    	into v_costo_valorado, v_cantidad_valorada, v_id_movimiento_det_val_desc
                    from alm.f_get_valorado_item(g_registros.id_item, v_parametros.id_almacen, v_codigo_valoracion, v_saldo_cantidad);
                    
                    --Se descuenta la cantidad valorada del detalle valorado que se utilizo en la valoracion
                    update alm.tmovimiento_det_valorado detval set
                        id_usuario_mod = p_id_usuario,
                        fecha_mod = now(),
                        aux_saldo_fisico = detval.aux_saldo_fisico - v_cantidad_valorada
                    where detval.id_movimiento_det_valorado = v_id_movimiento_det_val_desc;
                    
                    --insertar un nuevo detalle valorado con la cantidad valorada y el costo unitario calculado
                    insert into alm.tmovimiento_det_valorado (
                        id_usuario_reg,
                        fecha_reg,
                        estado_reg,
                        id_movimiento_det,
                        cantidad,
                        costo_unitario
                    ) VALUES (
                        p_id_usuario,
                        now(),
                        'activo',
                        g_registros.id_movimiento_det,
                        v_cantidad_valorada,
                        v_costo_valorado
                    );
                    
                    v_saldo_cantidad = v_saldo_cantidad - v_cantidad_valorada;
                END LOOP;
            END LOOP;
            
        elseif(v_tipo_mov = 'ingreso') then
        	select count(*) into v_contador
            from alm.tmovimiento_det movdet
            where movdet.id_movimiento = v_parametros.id_movimiento
            	and movdet.estado_reg = 'activo'
                and movdet.costo_unitario is null;
                
            if (v_contador > 0) then
            	raise exception '%', 'Todos los items del movimiento deben tener costo unitario.';
            end if;
        end if;
        
    	update alm.tmovimiento set
        	estado_mov = 'finalizado'
        where id_movimiento = v_parametros.id_movimiento;
        
        update alm.tmovimiento_det_valorado detval set
            aux_saldo_fisico = detval.cantidad
        from alm.tmovimiento_det movdet
        where detval.id_movimiento_det = movdet.id_movimiento_det
            and movdet.id_movimiento = v_parametros.id_movimiento
            and movdet.estado_reg = 'activo'
            and detval.estado_reg = 'activo';
        
        --TODO: Pendiente para el issue de transferencia
        /*
    	if(v_parametros.operacion = 'finalizarTransferencia')then
        	begin
            	select * into v_transferencia from alm.tmovimiento where id_movimiento=v_parametros.id_movimiento;
                v_id_movimiento_tipo_ingreso=(select id_movimiento_tipo from alm.tmovimiento_tipo 
  						where codigo='INGRESO');
                
                v_id_movimiento_tipo_salida=(select id_movimiento_tipo from alm.tmovimiento_tipo 
  						where codigo='SALIDA');
                
                insert into alm.tmovimiento(
                id_movimiento_tipo,
                id_almacen,
                id_funcionario,
                fecha_mov,
                numero_mov,
                descripcion,
                observaciones,
                id_usuario_reg,
                fecha_reg,
                estado_mov)values(
                v_id_movimiento_tipo_ingreso,
                v_transferencia.id_almacen_dest,
                v_transferencia.id_funcionario,
                v_transferencia.fecha_mov,
                v_transferencia.numero_mov,
                v_transferencia.descripcion,
                v_transferencia.observaciones,
                v_transferencia.id_usuario_reg,
				now(),
                'finalizado')RETURNING id_movimiento into v_id_movimiento_ingreso;
				
                insert into alm.tmovimiento(
                id_movimiento_tipo,
                id_almacen,
                id_funcionario,
                fecha_mov,
                numero_mov,
                descripcion,
                observaciones,
                id_usuario_reg,
                fecha_reg,
                estado_mov)values(
                v_id_movimiento_tipo_salida,
                v_transferencia.id_almacen,
                v_transferencia.id_funcionario,
                v_transferencia.fecha_mov,
                v_transferencia.numero_mov,
                v_transferencia.descripcion,
                v_transferencia.observaciones,
                v_transferencia.id_usuario_reg,
                now(),
                'finalizado')RETURNING id_movimiento into v_id_movimiento_salida;
                
                v_consulta='select * from alm.tmovimiento_det where id_movimiento='||v_parametros.id_movimiento||'';
                FOR v_detalle IN EXECUTE(v_consulta)
                LOOP     
                	insert into alm.tmovimiento_det(
                    id_movimiento,id_item,cantidad, costo_unitario,fecha_caducidad,
                    id_usuario_reg,fecha_reg,estado_reg)values
                    (v_id_movimiento_ingreso, v_detalle.id_item,v_detalle.cantidad,
                    v_detalle.costo_unitario, v_detalle.fecha_caducidad,
                    v_detalle.id_usuario_reg,now(),'activo');
                    
                    insert into alm.tmovimiento_det(
                    id_movimiento,id_item, cantidad, costo_unitario,
                    fecha_caducidad, id_usuario_reg, fecha_reg, estado_reg)
                    values(
                    v_id_movimiento_salida, v_detalle.id_item, v_detalle.cantidad,
                    v_detalle.costo_unitario,v_detalle.fecha_caducidad,
                    v_detalle.id_usuario_reg, now(),'activo');                              
           		END LOOP;
        	end;
        end if;
        */
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento finalizado');
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);
        return v_respuesta;	
    end;
	/*********************************   
     #TRANSACCION:  'SAL_MOVCNL_MOD'
     #DESCRIPCION:  Cancelacion de un movimiento
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        20-02-2013
    ***********************************/
	elseif (p_transaccion='SAL_MOVCNL_MOD') then
  	begin
    	update alm.tmovimiento set
        	estado_mov = 'cancelado'
        where id_movimiento = v_parametros.id_movimiento;

        v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento cancelado');
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);

        return v_respuesta;
    end;
  else
  	 raise exception 'Transaccion inexistente: %',p_transaccion;
  end if;
EXCEPTION
  WHEN OTHERS THEN
        v_respuesta='';
        v_respuesta = pxp.f_agrega_clave(v_respuesta,'mensaje',SQLERRM);
        v_respuesta = pxp.f_agrega_clave(v_respuesta,'codigo_error',SQLSTATE);
        v_respuesta = pxp.f_agrega_clave(v_respuesta,'procedimientos',v_nombre_funcion);
        raise exception '%',v_respuesta;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;