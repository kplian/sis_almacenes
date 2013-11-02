CREATE OR REPLACE FUNCTION alm.f_verificar_existencias_item (
  p_id_movimiento integer,
  p_estado varchar,
  out po_errores varchar,
  out po_contador integer,
  out po_alertas varchar,
  out po_saldo_total numeric
)
RETURNS record AS
$body$
/*
Autor: RCM
Fecha: 16/10/2013
Descripción: Verifica si hay las existencias suficientes de un movimiento
*/

DECLARE

	v_saldo_cantidad numeric;
    g_registros	record;
    v_rec record;
    v_cantidad numeric;
    v_cant_aux numeric;

BEGIN

	--Obtención de datos del movimiento
    select mov.id_movimiento, mov.id_almacen, mov.fecha_mov, mtip.tipo
    into v_rec
    from alm.tmovimiento mov
    inner join alm.tmovimiento_tipo mtip
    on mtip.id_movimiento_tipo = mov.id_movimiento_tipo
    where id_movimiento = p_id_movimiento;
    
    --Validación de existencia del movimiento
    if v_rec.id_movimiento is null then
    	raise exception 'Movimiento inexistente';
    end if;
    
	--Inicialización de variables
    po_errores = '';
    po_alertas = '';
    po_contador = 0;
    po_saldo_total = 0;

    --Recorre todo el movimiento
    for g_registros in (select 
                        movdet.id_item,
                        item.nombre as nombre_item,
                        movdet.id_movimiento_det,
                        movdet.cantidad as cantidad_item,
                        movdet.cantidad_solicitada
                        from alm.tmovimiento_det movdet
                        inner join alm.titem item on item.id_item = movdet.id_item
                        where movdet.estado_reg = 'activo'
                        and movdet.id_movimiento = p_id_movimiento) loop
                            
        po_contador = po_contador + 1;
        
        v_cantidad = coalesce(g_registros.cantidad_item,coalesce(g_registros.cantidad_solicitada,-1));
        
        if v_rec.tipo = 'ingreso' then	
        	if v_cantidad <= 0 then
            	po_errores = po_errores || '\nEl item ' || g_registros.nombre_item || ' debe tener registrada una cantidad mayor a cero';
			end if;
            if g_registros.costo_unitario <= 0 then
            	po_errores = po_errores || '\nEl item ' || g_registros.nombre_item || ' no tiene registrado el costo';
            end if;
        else
        
        	--Verificamos que la cantidad no sea nula y que la cantidad requerida no sea mayor que el saldo 
            v_saldo_cantidad = alm.f_get_saldo_fisico_item(g_registros.id_item, v_rec.id_almacen, date(v_rec.fecha_mov));
            
            po_saldo_total = po_saldo_total + v_saldo_cantidad;
            
--            raise exception '1:%   2:%   3:%',g_registros.cantidad_item, g_registros.cantidad_solicitada, v_cantidad;
            
            --Alertas
            if v_saldo_cantidad = 0 then
                po_alertas = po_alertas || '\n- Existencias agotadas para el item: ' || g_registros.nombre_item;             	
            end if;
            if v_cantidad > v_saldo_cantidad then
                po_alertas = po_alertas || '\n- Existencias insuficientes para el item: ' || g_registros.nombre_item || ' (Disponible: '||v_saldo_cantidad||'; Solicitado:'||v_cantidad||')';
            end if;	
        
			--Si es para el estado finalizado, se asume que pasó la verificación en caso de que las existencias sean menores
            --Verifica que la cantidad no sea nula, si lo es asume el campo solicitaddo. Si las existencia son menores, coloca el saldo
        	if p_estado = 'finalizado' then
            	if g_registros.cantidad_item is null then
                	if v_cantidad > v_saldo_cantidad then
                    	v_cant_aux = v_saldo_cantidad;
                    else
                    	v_cant_aux = v_cantidad;
                    end if;
                    
                	update alm.tmovimiento_det set
                    cantidad = v_cant_aux
                    where id_movimiento_det = g_registros.id_movimiento_det;
                    raise notice '---------------ITEM:%    %  %',g_registros.id_item,v_cant_aux,g_registros.id_movimiento_det;
                end if;
            end if;
        
        end if;
                       
    end loop;

    --Respuesta
    return;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;