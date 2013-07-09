CREATE OR REPLACE FUNCTION alm.f_get_saldo_item (
  p_id_item integer,
  pa_id_almacen integer [],
  p_fecha_hasta date
)
RETURNS numeric AS
$body$
/*
	Fecha: 02/07/2013
    Autor: RCM
    Descripción: Función que devuelve el saldo a una fecha de un item de uno o varios almacenes
*/
DECLARE

	v_saldo numeric;

BEGIN

	with saldos as
    (select
    mdet.id_item, mdet.cantidad
    from alm.tmovimiento mov
    inner join alm.tmovimiento_det mdet
    on mdet.id_movimiento = mov.id_movimiento
    inner join alm.tmovimiento_tipo mtipo
    on mtipo.id_movimiento_tipo = mov.id_movimiento_tipo
    where mov.estado_mov = 'finalizado'
    and mov.id_almacen = any (pa_id_almacen)
    and mtipo.tipo = 'ingreso'
    and date_trunc('day',mov.fecha_mov) <= p_fecha_hasta
    and mdet.id_item = p_id_item
    union all
    select
    mdet.id_item, -mdet.cantidad
    from alm.tmovimiento mov
    inner join alm.tmovimiento_det mdet
    on mdet.id_movimiento = mov.id_movimiento
    inner join alm.tmovimiento_tipo mtipo
    on mtipo.id_movimiento_tipo = mov.id_movimiento_tipo
    where mov.estado_mov = 'finalizado'
    and mov.id_almacen = any (pa_id_almacen)
    and mtipo.tipo = 'salida'
    and date_trunc('day',mov.fecha_mov) <= p_fecha_hasta
    and mdet.id_item = p_id_item)
    select
    sum(cantidad) as saldo
    into v_saldo
    from saldos
    group by id_item
    order by id_item;
    
    return coalesce(v_saldo,0);

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;