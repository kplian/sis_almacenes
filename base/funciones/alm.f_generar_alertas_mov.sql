CREATE OR REPLACE FUNCTION alm.f_generar_alertas_mov (
  p_id_usuario integer,
  p_id_movimiento integer
)
RETURNS boolean AS
$body$
/*
Autor: RCM
Fecha: 09/10/2013
Descripción: Generación de alertas en función de la definición de alarmas por item y almacén
*/

DECLARE

	v_mostrar_alerts        		boolean;
    g_registros         			record;
    v_rec							record;
    v_saldo_cantidad        		numeric;
    v_alerta_amarilla       		numeric;
	v_alerta_roja         			numeric;
	v_cantidad_minima       		numeric;
    v_alerts            			boolean;
    g_registros_2         			record;
    v_aux_integer					integer;
    v_asunto_alerta					varchar;
    v_descripcion_alerta      		varchar;
    v_resp							boolean;

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
    
	--3.Generación de Alertas
    v_mostrar_alerts = false;
	if (v_rec.tipo_mov = 'salida') then
    	FOR g_registros IN (select 
                             item.nombre as nombre_item,
                             movdet.id_movimiento_det,
                             movdet.id_item,
                             item.codigo as codigo_item
                             from alm.tmovimiento_det movdet
                             inner join alm.titem item on item.id_item = movdet.id_item
                             where movdet.id_movimiento = p_id_movimiento
                             and movdet.estado_reg = 'activo') LOOP
            --Obtiene el saldo del material        	
			v_saldo_cantidad = alm.f_get_saldo_fisico_item(g_registros.id_item, v_rec.id_almacen, date(v_rec.fecha_mov));
	
    		--Obtiene las existencias definidas en las alertas
            select 
            almstock.cantidad_alerta_amarilla,almstock.cantidad_alerta_roja,almstock.cantidad_min
            into
            v_alerta_amarilla,v_alerta_roja,v_cantidad_minima
            from alm.talmacen_stock almstock
            inner join alm.talmacen alma on alma.id_almacen = almstock.id_almacen
            where almstock.id_almacen = v_rec.id_almacen
            and almstock.id_item = g_registros.id_item;
            --Inicializa bandera
            v_alerts = false;
            --Evalua las cantidades
            if (v_saldo_cantidad <= v_cantidad_minima) then
				v_asunto_alerta = 'Bajas Existencias [Almacen: '||v_rec.cod_almacen||', Codigo: '||g_registros.codigo_item|| ']';
                v_descripcion_alerta = '<b>Desde: </b> '||v_rec.fecha_mov ||'<br>
                                          <b>Almacén: </b> '||v_rec.cod_almacen || ' - ' || v_rec.nombre_almacen||'<br>
                                          <b>Código Item: </b> '||g_registros.codigo_item ||'<br>
                                          <b>Item: </b> '||g_registros.nombre_item ||'<br>
                                          <b>Código Item: </b> '||g_registros.codigo_item ||'<br>
                                          <b>Cantidad Actual: </b> '||v_saldo_cantidad ||'<br>
                                          <b>Cantidad Mínima: </b> '||v_cantidad_minima ||'<br>
                                          <b>Diferencia: </b> '||v_cantidad_minima-v_saldo_cantidad ||'<br>
                                          <br>
                                          <b>Mensaje: </b>Se está llegando a cantidades bajas de existencias. La cantidad mínima es de '||v_cantidad_minima||' y el saldo actual es de '||v_saldo_cantidad||'. Se le recomienda aumentar la cantidad en stock.';
                v_alerts = true;
                          	
            elseif(v_saldo_cantidad <= v_alerta_roja) then
                v_asunto_alerta = 'ALERTA ROJA [Almacen: '||v_rec.cod_almacen||', Codigo: '||g_registros.codigo_item|| '] !!!';
                v_descripcion_alerta = '<b>Desde: </b> '||v_rec.fecha_mov ||'<br>
                                        <b>Almacén: </b> '||v_rec.cod_almacen || ' - ' || v_rec.nombre_almacen||'<br>
                                        <b>Código Item: </b> '||g_registros.codigo_item ||'<br>
                                        <b>Item: </b> '||g_registros.nombre_item ||'<br>
                                        <b>Código Item: </b> '||g_registros.codigo_item ||'<br>
                                        <b>Cantidad Actual: </b> '||v_saldo_cantidad ||'<br>
                                        <b>Cantidad Alerta Roja: </b> '||v_alerta_roja ||'<br>
                                        <b>Diferencia: </b> '||v_alerta_roja-v_saldo_cantidad ||'<br>
                                        <br>
                                        <b>Mensaje: </b>Se ha llegado a un nivel crítico de existencias. El nivel mínimo debería ser de :'||v_alerta_roja ||', y el saldo actual es de '||v_saldo_cantidad||'. Debe abastecerse con urgencia de este material.';
                v_alerts = true;
                            
            elseif(v_saldo_cantidad <= v_alerta_amarilla) then
                v_asunto_alerta = 'Alerta Amarilla [Almacen: '||v_rec.cod_almacen||', Codigo: '||g_registros.codigo_item|| ']';
                v_descripcion_alerta = '<b>Desde: </b> '||v_rec.fecha_mov ||'<br>
                                        <b>Almacén: </b> '||v_rec.cod_almacen || ' - ' || v_rec.nombre_almacen||'<br>
                                        <b>Código Item: </b> '||g_registros.codigo_item ||'<br>
                                        <b>Item: </b> '||g_registros.nombre_item ||'<br>
                                        <b>Código Item: </b> '||g_registros.codigo_item ||'<br>
                                        <b>Cantidad Actual: </b> '||v_saldo_cantidad ||'<br>
                                        <b>Cantidad Alerta Amarilla: </b> '||v_alerta_amarilla ||'<br>
                                        <b>Diferencia: </b> '||v_alerta_amarilla-v_saldo_cantidad ||'<br>
                                        <br>
                                        <b>Mensaje: </b>Se está llegando a cantidades bajas de existencias. La cantidad de Alerta Amarilla es'||v_alerta_amarilla||' y el saldo actual es de '||v_saldo_cantidad||'. Se le recomienda aumentar la cantidad en stock.';
                v_alerts = true;
            end if;
                        
            --Hace registro de las alarmas por usuario
            v_resp=false;
            IF (v_alerts) THEN
                FOR g_registros_2 IN (select almu.id_usuario
                                      from alm.talmacen_usuario almu
                                      where almu.id_almacen = v_rec.id_almacen) LOOP
					v_resp=true;
                    v_aux_integer = param.f_inserta_alarma (
                        NULL,
                        v_descripcion_alerta,
                        NULL,
                        now()::date,
                        'notificacion',
                        NULL,
                        p_id_usuario,
                        NULL,
                        v_asunto_alerta,
                        '{}',
                        g_registros_2.id_usuario,
                        v_asunto_alerta
                    );
                    IF (g_registros_2.id_usuario = p_id_usuario) THEN
                      v_mostrar_alerts = true;
                    END IF;
                END LOOP;
            END IF;
        END LOOP;
    ELSE
    	--No se envía alertas
    	v_resp=false;    	            
    END IF;
    
    --4.Respuesta
    return v_resp;
    
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;