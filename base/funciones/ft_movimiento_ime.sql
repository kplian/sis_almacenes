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
  v_tipo_mov_personalizado		varchar;
  v_id_almacen					integer;
  v_codigo_valoracion			varchar;
  v_saldo_cantidad				numeric;
  v_aux_integer					integer;
  v_costo_valorado				numeric;
  v_cantidad_valorada			numeric;
  v_id_movimiento_det_val_desc 	integer;
  v_nombre_item					varchar;
  v_errores						varchar;
  v_id_almacen_dest				integer;
  v_id_movimiento_dest			integer;
  v_id_movimiento_det_dest		integer;
  v_fecha_mov_ultima			timestamp;
  v_fecha_mov					timestamp;
  v_id_depto					integer;
  v_cod_documento				varchar;
  v_alerta_amarilla				numeric;
  v_alerta_roja					numeric;
  v_cantidad_minima				numeric;
  v_nombre_almacen				varchar;
  v_alerts						boolean;
  v_descripcion_alerta			varchar;
  v_mostrar_alerts				boolean;
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
            estado_mov,
            id_movimiento_origen
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
            'borrador',
            v_parametros.id_movimiento_origen
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
            observaciones = v_parametros.observaciones,
            id_movimiento_origen = v_parametros.id_movimiento_origen
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
        select alma.nombre, alma.estado, alma.id_departamento into v_nombre_almacen, v_estado_almacen, v_id_depto
        from alm.talmacen alma
        where alma.id_almacen = v_parametros.id_almacen;
        
        if (v_estado_almacen is null or v_estado_almacen = 'inactivo') then
        	raise exception '%', 'El almacen seleccionado para este movimiento no se encuentra activo';
        end if;
        
        --se obtienen los datos del movimiento a finalizar para realizar validaciones
        select mov.fecha_mov, movtip.tipo, movtip.nombre, mov.id_almacen_dest
        into v_fecha_mov, v_tipo_mov, v_tipo_mov_personalizado, v_id_almacen_dest
        from alm.tmovimiento mov 
        inner join alm.tmovimiento_tipo movtip on movtip.id_movimiento_tipo = mov.id_movimiento_tipo
        where mov.id_movimiento = v_parametros.id_movimiento;
        
        --Verificar que la fecha no sea anterior al ultimo registro finalizado.
        select max(mov.fecha_mov) into v_fecha_mov_ultima
        from alm.tmovimiento mov
        where mov.estado_mov = 'finalizado'
            and mov.estado_reg = 'activo';
        
        if (v_fecha_mov < v_fecha_mov_ultima) then
        	raise exception '%', 'La fecha del movimiento no debe ser anterior al ultimo movimiento finalizado';
        end if;

        --TODO: revisar si el periodo esta abierto.
        
        -- Busqueda de errores en las dependencias del movimiento
        v_errores = '';
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
        	v_cod_documento = 'MOVSAL';
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
                    costo_unitario = v_costo_valorado,
                    id_mov_det_val_origen = v_id_movimiento_det_val_desc
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
                        costo_unitario,
                        id_mov_det_val_origen
                    ) VALUES (
                        p_id_usuario,
                        now(),
                        'activo',
                        g_registros.id_movimiento_det,
                        v_cantidad_valorada,
                        v_costo_valorado,
                        v_id_movimiento_det_val_desc
                    );
                    
                    v_saldo_cantidad = v_saldo_cantidad - v_cantidad_valorada;
                END LOOP;
            END LOOP;
            
            --En el caso de que la salida sea por transferencia
            if (lower(v_tipo_mov_personalizado) like '%salida por transferencia%') then
                -- se debe insertar el registro de ingreso por transferencia en el destino
                insert into alm.tmovimiento (
                    id_usuario_reg,
                    fecha_reg, 
                    estado_reg,
                    id_movimiento_tipo, 
                    id_almacen,
                    fecha_mov,
                    estado_mov,
                    id_movimiento_origen
                ) values (
                    p_id_usuario,
                    now(),
                    'activo',
                    2,
                    v_id_almacen_dest,
                    v_parametros.fecha_mov,
                    'borrador',
                    v_parametros.id_movimiento
                ) RETURNING id_movimiento into v_id_movimiento_dest;
                
                --se copia el detalle del movimiento de salida por transferencia pero sin costos unitarios.
                FOR g_registros IN (
                    select 
                        movdet.id_movimiento_det,
                        movdet.id_item,
                        movdet.cantidad
                    from alm.tmovimiento_det movdet
					where movdet.id_movimiento = v_parametros.id_movimiento
                        and movdet.estado_reg = 'activo'
                ) LOOP
                	insert into alm.tmovimiento_det(
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
                        v_id_movimiento_dest,
                        g_registros.id_item,
                        g_registros.cantidad
                    ) RETURNING id_movimiento_det into v_id_movimiento_det_dest;
                    
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
                        v_id_movimiento_det_dest,
                        g_registros.cantidad
                    );
                END LOOP;
            end if;
            
        elseif(v_tipo_mov = 'ingreso') then
        	v_cod_documento = 'MOVIN';
        	select count(*) into v_contador
            from alm.tmovimiento_det movdet
            where movdet.id_movimiento = v_parametros.id_movimiento
            	and movdet.estado_reg = 'activo'
                and movdet.costo_unitario is null;
                
            if (v_contador > 0) then
            	raise exception '%', 'Todos los items del movimiento deben tener costo unitario.';
            end if;
        end if;
        
        --Actualiza el estado a finalizado cuando no hay ningun error
        update alm.tmovimiento set
        	estado_mov = 'finalizado',
            codigo = param.f_obtener_correlativo (v_cod_documento, NULL, NULL, v_id_depto, p_id_usuario, 'ALM', null)
        where id_movimiento = v_parametros.id_movimiento;
        
        --Se actualiza el saldo fisico del detalle valorado.
        update alm.tmovimiento_det_valorado detval set
            aux_saldo_fisico = detval.cantidad
        from alm.tmovimiento_det movdet
        where detval.id_movimiento_det = movdet.id_movimiento_det
            and movdet.id_movimiento = v_parametros.id_movimiento
            and movdet.estado_reg = 'activo'
            and detval.estado_reg = 'activo';
        
        
        --Se revisa si el movimiento es una salida y si las existencias de los items del movimiento han llegado a 
        -- su nivel de alerta en el stock.
        v_mostrar_alerts = false;
        if (v_tipo_mov = 'salida') then
            FOR g_registros IN (
                select 
                	item.nombre as nombre_item,
                    movdet.id_movimiento_det,
                    movdet.id_item
                from alm.tmovimiento_det movdet
                inner join alm.titem item on item.id_item = movdet.id_item
                where movdet.id_movimiento = v_parametros.id_movimiento
                    and movdet.estado_reg = 'activo'
            ) LOOP
            	v_saldo_cantidad = alm.f_get_saldo_fisico_item(g_registros.id_item, v_parametros.id_almacen);
                select 
                	almstock.cantidad_alerta_amarilla,
                    almstock.cantidad_alerta_roja,
                    almstock.cantidad_min
                into
                	v_alerta_amarilla,
                    v_alerta_roja,
                    v_cantidad_minima
                from alm.talmacen_stock almstock
                inner join alm.talmacen alma on alma.id_almacen = almstock.id_almacen
                where almstock.id_almacen = v_parametros.id_almacen
                	and almstock.id_item = g_registros.id_item;
                v_alerts = false;
                if (v_saldo_cantidad <= v_cantidad_minima) then
                	v_descripcion_alerta = 'Las existencias del item '||g_registros.nombre_item||' están por debajo del mínimo en el almacén: '||v_nombre_almacen;
                    v_alerts = true;
                elseif(v_saldo_cantidad <= v_alerta_roja) then
                	v_descripcion_alerta = 'Las existencias del item '||g_registros.nombre_item||' están por debajo de la alerta roja en el almacén: '||v_nombre_almacen;
                	v_alerts = true;
                elseif(v_saldo_cantidad <= v_alerta_amarilla) then
                	v_descripcion_alerta = 'Las existencias del item '||g_registros.nombre_item||' están por debajo de la alerta amarilla en el almacén: '||v_nombre_almacen;
                	v_alerts = true;
                end if;
                
                IF (v_alerts) THEN
                    FOR g_registros_2 IN (
                        select almu.id_usuario
                        from alm.talmacen_usuario almu
                        where almu.id_almacen = v_parametros.id_almacen
                    ) LOOP
                        v_aux_integer = param.f_inserta_alarma (
                            NULL,
                            v_descripcion_alerta,
                            NULL,
                            now()::date,
                            'notificacion',
                            NULL,
                            p_id_usuario,
                            NULL,
                            'Bajas existencias en Almacén: '||v_nombre_almacen,
                            '{}',
                            g_registros_2.id_usuario,
                            'Bajas existencias en Almacén: '||v_nombre_almacen
                        );
                        IF (g_registros_2.id_usuario = p_id_usuario) THEN
                        	v_mostrar_alerts = true;
                        END IF;
                    END LOOP;
                END IF;
            END LOOP;
            
        END IF;
        
     	v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento finalizado');
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);
        
        IF(v_mostrar_alerts) THEN
        	v_respuesta=pxp.f_agrega_clave(v_respuesta,'alerts',v_mostrar_alerts::varchar);
        END IF;
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
    /*********************************   
     #TRANSACCION:  'SAL_MOVREV_MOD'
     #DESCRIPCION:  Reversion de un movimiento
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        26-02-2013
    ***********************************/
    elseif (p_transaccion = 'SAL_MOVREV_MOD') then
    begin
    	--Revisar que sea el último movimiento finalizado.
        select mov.id_movimiento
        into v_id_movimiento
        from alm.tmovimiento mov
        where mov.estado_mov = 'finalizado'
        	and mov.estado_reg = 'activo' 
            order by mov.fecha_mov desc limit 1;
        
        if (v_id_movimiento != v_parametros.id_movimiento) then
        	raise exception '%', 'No se puede revertir el movimiento seleccionado. Para revertir un movimiento no deben existir movimiento finalizados despues de éste.';
        end if;
        
        --se obtienen los datos del movimiento a revertir
        select mov.fecha_mov, movtip.tipo, movtip.nombre, mov.id_almacen_dest
        into v_fecha_mov, v_tipo_mov, v_tipo_mov_personalizado, v_id_almacen_dest
        from alm.tmovimiento mov 
        inner join alm.tmovimiento_tipo movtip on movtip.id_movimiento_tipo = mov.id_movimiento_tipo
        where mov.id_movimiento = v_parametros.id_movimiento;
        
        -- solo para salidas.
        if (v_tipo_mov = 'salida') then
        -- BUCLE de los detalle del movimiento
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
            	--se obtiene el tipo de valoracion 
                --obtener el codigo del metodo de valoracion
                select metval.codigo into v_codigo_valoracion
                from alm.talmacen_stock alstock
                inner join alm.tmetodo_val metval on metval.id_metodo_val = alstock.id_metodo_val
                where alstock.id_almacen = v_parametros.id_almacen
                	and alstock.id_item = g_registros.id_item
                    and alstock.estado_reg = 'activo';
                
                --se va recorriendo todos los detalles valorados del detalle_movimiento
            	FOR g_registros_2 in (
                	select detval.cantidad, detval.id_mov_det_val_origen
                    from alm.tmovimiento_det_valorado detval
                    where detval.id_movimiento_det = g_registros.id_movimiento_det
                    order by detval.id_movimiento_det_valorado desc
                ) LOOP
                	IF (g_registros_2.id_mov_det_val_origen is not null) THEN
                        -- sumar la cantidad del ultimo detalle valorado al aux_saldo encontrado
                        update alm.tmovimiento_det_valorado set
                            id_usuario_mod = p_id_usuario,
                            fecha_mod = now(),
                            aux_saldo_fisico = aux_saldo_fisico + g_registros_2.cantidad
                        where id_movimiento_det_valorado = g_registros_2.id_mov_det_val_origen;
                    END IF;
                END LOOP;
                
                -- eliminar todos los det_valorados del detalle_movimiento
                delete from alm.tmovimiento_det_valorado detval
                where detval.id_movimiento_det = g_registros.id_movimiento_det;
                
                --Insertar un nuevo detalle_valorado con la cantidad del detalle_movimiento
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
                    g_registros.id_movimiento_det,
                    g_registros.cantidad_item
                );
            END LOOP;
        end if;
        
        --se devuelve el movimiento a estado borrador
        update alm.tmovimiento set
        	estado_mov = 'borrador'
        where id_movimiento = v_parametros.id_movimiento;
        
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento revertido');
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