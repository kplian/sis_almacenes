CREATE OR REPLACE FUNCTION alm.f_insercion_movimiento_externo (
  p_id_usuario integer,
  p_id_movimiento_tipo integer,
  p_id_almacen integer,
  p_id_funcionario integer,
  p_id_proveedor integer,
  p_id_almacen_dest integer,
  p_fecha_mov date,
  p_descripcion varchar,
  p_observaciones varchar,
  p_id_movimiento_origen integer,
  p_id_gestion integer,
  p_id_depto_conta integer
)
RETURNS integer AS
$body$
DECLARE
  v_registros 		record;
  v_id_movimiento	integer;
  
BEGIN
  	select
        p_id_movimiento_tipo as id_movimiento_tipo,
        p_id_almacen as id_almacen,
        p_id_funcionario as id_funcionario, 
        p_id_proveedor as id_proveedor,
        p_id_almacen_dest as id_almacen_dest,
        p_fecha_mov as fecha_mov,
        p_descripcion as descripcion,
        p_observaciones as observaciones,
        p_id_movimiento_origen as id_movimiento_origen,
        p_id_gestion as id_gestion,
        p_id_depto_conta as id_depto_conta
    into v_registros;
    v_id_movimiento = alm.f_insercion_movimiento(p_id_usuario,hstore(v_registros));
    
    return v_id_movimiento;
    
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;