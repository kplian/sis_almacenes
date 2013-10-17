CREATE OR REPLACE FUNCTION alm.f_valoracion_mov (
  p_id_usuario integer,
  p_id_movimiento integer
)
RETURNS varchar AS
$body$
/*
Autor: RCM
Fecha: 09/10/203
Descripción: FUnción que realiza la valoración de los movimientos siguiendo los Métodos PEPS, UEPS o Promedio Ponderado,
en función de como está parametrizado el item por almacén
*/
DECLARE

  	v_rec record;
  	v_cod_documento varchar;
  	v_codigo_valoracion varchar;
  	g_registros record;
  	v_cant_aux            			numeric;
  	v_saldo_cantidad        		numeric;
  	v_costo_valorado        		numeric;
	v_cantidad_valorada     		numeric;
	v_id_movimiento_det_val_desc  	integer;
  
BEGIN

    --1.Obtención de Datos
    select mov.id_almacen, mov.fecha_mov, alma.codigo as cod_almacen,
    alma.nombre as nombre_almacen, mtip.tipo as tipo_mov, mov.id_movimiento
    into v_rec
    from alm.tmovimiento mov
    inner join alm.talmacen alma on alma.id_almacen = mov.id_almacen
    inner join alm.tmovimiento_tipo mtip on mtip.id_movimiento_tipo = mov.id_movimiento_tipo
    where mov.id_movimiento = p_id_movimiento;
    
    --2.Validación de existencia de movimiento
    if v_rec.id_movimiento is null then
    	raise exception 'Alertas no generadas: movimiento inexistente';
    end if;
  
	--Valora solo cuando es salida
	if (v_rec.tipo_mov = 'salida') then
        v_cod_documento = 'MOVSAL';
        FOR g_registros IN (select 
                          movdet.id_movimiento_det,
                          movdet.id_item,
                          itm.nombre as nombre_item,
                          movdet.cantidad,
                          detval.id_movimiento_det_valorado
                          from alm.tmovimiento_det_valorado detval
                          inner join alm.tmovimiento_det movdet on movdet.id_movimiento_det = detval.id_movimiento_det
                          inner join alm.titem itm on itm.id_item = movdet.id_item
                          where movdet.id_movimiento = p_id_movimiento
                          and movdet.estado_reg = 'activo') LOOP
                          
			--Obtener el Método de valoración
            select metval.codigo
            into v_codigo_valoracion
            from alm.talmacen_stock alstock
            inner join alm.tmetodo_val metval on metval.id_metodo_val = alstock.id_metodo_val
            where alstock.id_almacen = v_rec.id_almacen
            and alstock.id_item = g_registros.id_item
            and alstock.estado_reg = 'activo';
	                
            v_cant_aux = alm.f_get_saldo_fisico_item(g_registros.id_item, v_rec.id_almacen, date(v_rec.fecha_mov));
				
            --RCM
            if g_registros.cantidad > v_cant_aux then
                v_saldo_cantidad = v_cant_aux;
                update alm.tmovimiento_det set
                cantidad = v_cant_aux
                where id_movimiento_det = g_registros.id_movimiento_det;
            else
                v_saldo_cantidad = g_registros.cantidad;  
            end if;
            --FIN RCM
	                
	                
            -- Verificar que el el item tenga un tipo de valoracion
            if (v_codigo_valoracion is null) then
                raise exception '%', 'El item ' || g_registros.nombre_item || ' no tiene registrado un metodo de valoracion';
            end if;
	                
            select r_costo_valorado, r_cantidad_valorada, r_id_movimiento_det_val_desc
            into v_costo_valorado, v_cantidad_valorada, v_id_movimiento_det_val_desc
            from alm.f_get_valorado_item(g_registros.id_item, v_rec.id_almacen, v_codigo_valoracion, v_saldo_cantidad, date(v_rec.fecha_mov));
	
            if (v_costo_valorado is null) then
                raise exception '%', 'El item ' || g_registros.nombre_item || ' no pudo ser valorado. Probablemente no se haya definido la cantidad real a entregar.';
            end if;
	                
            if (v_codigo_valoracion = 'PEPS' or v_codigo_valoracion = 'UEPS') THEN
                --Se descuenta la cantidad valorada del detalle valorado que se utilizo en la valoracion
                update alm.tmovimiento_det_valorado detval set
                id_usuario_mod = p_id_usuario,
                fecha_mod = now(),
                aux_saldo_fisico = detval.aux_saldo_fisico - v_cantidad_valorada
                where detval.id_movimiento_det_valorado = v_id_movimiento_det_val_desc;
            end if;
	                
            v_saldo_cantidad = v_saldo_cantidad - v_cantidad_valorada;
	                
            update alm.tmovimiento_det_valorado set
            id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            cantidad = v_cantidad_valorada,
            costo_unitario = v_costo_valorado,
            id_mov_det_val_origen = v_id_movimiento_det_val_desc
            where id_movimiento_det_valorado = g_registros.id_movimiento_det_valorado;
	                
            --Si todavia hay saldo que valorar
			WHILE (v_saldo_cantidad > 0) LOOP
            
				select r_costo_valorado, r_cantidad_valorada, r_id_movimiento_det_val_desc
                into v_costo_valorado, v_cantidad_valorada, v_id_movimiento_det_val_desc
                from alm.f_get_valorado_item(g_registros.id_item, v_rec.id_almacen, v_codigo_valoracion, 
                							v_saldo_cantidad, date(v_fecha_mov));
	                    
                --Se descuenta la cantidad valorada del detalle valorado que se utilizo en la valoracion
                update alm.tmovimiento_det_valorado detval set
                id_usuario_mod = p_id_usuario,
                fecha_mod = now(),
                aux_saldo_fisico = detval.aux_saldo_fisico - v_cantidad_valorada
                where detval.id_movimiento_det_valorado = v_id_movimiento_det_val_desc;
	                    
                --Insertar un nuevo detalle valorado con la cantidad valorada y el costo unitario calculado
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
        
        --Se actualiza el saldo fisico del detalle valorado.
        update alm.tmovimiento_det_valorado detval set
        aux_saldo_fisico = detval.cantidad
        from alm.tmovimiento_det movdet
        where detval.id_movimiento_det = movdet.id_movimiento_det
        and movdet.id_movimiento = p_id_movimiento
        and movdet.estado_reg = 'activo'
        and detval.estado_reg = 'activo';

	end if;
    
    --Respuesta
    return 'Hecho';
	        


END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;