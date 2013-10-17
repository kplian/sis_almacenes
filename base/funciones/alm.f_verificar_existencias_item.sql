CREATE OR REPLACE FUNCTION alm.f_verificar_existencias_item (
  p_id_movimiento integer,
  out po_errores varchar,
  out po_contador integer
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
    po_contador = 0;
    
    --Sólo verifica existencia para salidas
    if v_rec.tipo = 'salida' then
    	--Recorre todo el movimiento
        for g_registros in (select 
                            movdet.id_item,
                            item.nombre as nombre_item,
                            movdet.id_movimiento_det,
                            movdet.cantidad as cantidad_item
                            from alm.tmovimiento_det movdet
                            inner join alm.titem item on item.id_item = movdet.id_item
                            where movdet.estado_reg = 'activo'
                            and movdet.id_movimiento = p_id_movimiento) loop
                            
            po_contador = po_contador + 1;
        				
            --Verificamos que la cantidad no sea nula y que la cantidad requerida no sea mayor que el saldo 
            v_saldo_cantidad = alm.f_get_saldo_fisico_item(g_registros.id_item, v_rec.id_almacen, date(v_rec.fecha_mov));
        	            
            if (g_registros.cantidad_item is null or g_registros.cantidad_item < 0) then
              po_errores = po_errores || '\nEl item ' || g_registros.nombre_item || ' debe tener cantidad registrada igual o mayor a cero';
            --elseif (v_tipo_mov = 'salida' and g_registros.cantidad_item > v_saldo_cantidad) then
              --RCM 24042013: se añade opción para que se entregue lo existente si es que no hay suficiente
              --po_errores = po_errores || '\nNo existen suficientes existencias del item ' || g_registros.nombre_item || '. Solicitado: ' || g_registros.cantidad_item || '. Existencias: '|| v_saldo_cantidad;
             po_errores = po_errores || '\n- El item ' || g_registros.nombre_item || ' debe tener al menos una cantidad para valorar';
            end if;
                       
        END LOOP;
    
    end if;
    
    return;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;