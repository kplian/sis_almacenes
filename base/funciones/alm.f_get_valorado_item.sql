CREATE OR REPLACE FUNCTION alm.f_get_valorado_item(IN p_id_item integer, IN p_id_almacen integer, IN p_valoracion character varying, IN p_cantidad_sol numeric, IN p_fecha_mov date, OUT r_costo_valorado numeric, OUT r_cantidad_valorada numeric, OUT r_id_movimiento_det_val_desc integer)
  RETURNS record AS
$BODY$
/**************************************************************************

 SISTEMA:   SISTEMA DE GESTION DE ALMACENES
 FUNCION:     alm.f_get_valorado_item
 DESCRIPCION:   Función que devuelve el costo unitario para el item: p_id_item en base 
        al parametro de criterio de valoración: p_criterio_valoracion que puede ser
                Promedio Ponderado, PEPS y UEPS.
                Posibles Valores  de p_criterio_valoracion:
                PP, PEPS, UEPS

 AUTOR:     Ariel Ayaviri Omonte
 FECHA:         22/02/2013
***************************************************************************/

DECLARE

  v_nombre_funcion      text;
    v_resp          varchar;
    v_consulta        varchar;  
    v_saldo_fisico      numeric;
    v_saldo_valorado    numeric;

BEGIN
    v_nombre_funcion = 'alm.f_get_valorado_item';    
    IF (p_cantidad_sol is null) THEN
      return;
    END IF;
    
   
    IF (p_valoracion = 'PP') THEN
        v_saldo_fisico = alm.f_get_saldo_fisico_item(p_id_item, p_id_almacen, p_fecha_mov);
        v_saldo_valorado = alm.f_get_saldo_valorado_item(p_id_item, p_id_almacen, p_fecha_mov);
        
        IF (v_saldo_fisico = 0) THEN
          r_costo_valorado = 0;
            r_cantidad_valorada = 0;
        END IF;
        
        r_costo_valorado = v_saldo_valorado/v_saldo_fisico;
        r_cantidad_valorada = p_cantidad_sol;
        
    ELSEIF (p_valoracion = 'PEPS') THEN
      --obtener el aux_saldo mas antiguo distinto de cero
        select detval.aux_saldo_fisico, detval.costo_unitario, detval.id_movimiento_det_valorado 
        into v_saldo_fisico, r_costo_valorado, r_id_movimiento_det_val_desc
        from alm.tmovimiento_det_valorado detval
        inner join alm.tmovimiento_det movdet on movdet.id_movimiento_det = detval.id_movimiento_det
        inner join alm.tmovimiento mov on mov.id_movimiento = movdet.id_movimiento
        inner join alm.tmovimiento_tipo movtip on movtip.id_movimiento_tipo = mov.id_movimiento_tipo
        where movdet.id_item = p_id_item
            and mov.id_almacen = p_id_almacen
            and movdet.estado_reg = 'activo'
            and mov.estado_reg = 'activo'
            and mov.estado_mov = 'finalizado'
            and movtip.tipo = 'ingreso'
            and detval.aux_saldo_fisico is not null
            and detval.aux_saldo_fisico > 0
        order by mov.fecha_mov asc limit 1;
        
        IF (v_saldo_fisico is null) THEN
          r_costo_valorado = 0;
            r_cantidad_valorada = 0;
        ELSE 
          --comparo si la cantidad del item solicitado es mayor que el saldo
            IF (p_cantidad_sol > v_saldo_fisico) THEN
                r_cantidad_valorada = v_saldo_fisico;
            ELSE
                r_cantidad_valorada = p_cantidad_sol;
            END IF;
        END IF;
        
    ELSEIF (p_valoracion = 'UEPS') THEN
      --obtener el aux_saldo mas reciente distinto de cero
        select detval.aux_saldo_fisico, detval.costo_unitario, detval.id_movimiento_det_valorado 
        into v_saldo_fisico, r_costo_valorado, r_id_movimiento_det_val_desc
        from alm.tmovimiento_det_valorado detval
        inner join alm.tmovimiento_det movdet on movdet.id_movimiento_det = detval.id_movimiento_det
        inner join alm.tmovimiento mov on mov.id_movimiento = movdet.id_movimiento
        inner join alm.tmovimiento_tipo movtip on movtip.id_movimiento_tipo = mov.id_movimiento_tipo
        where movdet.id_item = p_id_item
            and mov.id_almacen = p_id_almacen
            and movdet.estado_reg = 'activo'
            and mov.estado_reg = 'activo'
            and mov.estado_mov = 'finalizado'
            and movtip.tipo = 'ingreso'
            and detval.aux_saldo_fisico is not null
            and detval.aux_saldo_fisico > 0
        order by mov.fecha_mov desc limit 1;
        
        IF (v_saldo_fisico is null) THEN
          r_costo_valorado = 0;
            r_cantidad_valorada = 0;
        ELSE
          --comparo si la cantidad del item solicitado es mayor que el saldo
            IF (p_cantidad_sol > v_saldo_fisico) THEN
                r_cantidad_valorada = v_saldo_fisico;
            ELSE
                r_cantidad_valorada = p_cantidad_sol;
            END IF;
        END IF;
        
    END IF;

  return;

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
ALTER FUNCTION alm.f_get_valorado_item(integer, integer, character varying, numeric, date)
  OWNER TO postgres;
