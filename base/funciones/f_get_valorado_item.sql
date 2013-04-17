CREATE OR REPLACE FUNCTION alm.f_get_valorado_item (
  p_id_item integer,
  p_id_almacen integer,
  p_valoracion varchar,
  p_cantidad_sol numeric,
  out r_costo_valorado numeric,
  out r_cantidad_valorada numeric,
  out r_id_movimiento_det_val_desc integer
)
RETURNS record AS
$body$
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
        v_saldo_fisico = alm.f_get_saldo_fisico_item(p_id_item, p_id_almacen);
        v_saldo_valorado = alm.f_get_saldo_valorado_item(p_id_item, p_id_almacen);
        
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
   
--    DROP TABLE IF EXISTS  tt_item_costo_unitario;
    
        
    /***********************************
    # Consulta para obtener el costo unitario para el item: p_id_item en funcion al parametro
    # del criterio de valoracion enviado: FIFO, LIFO o Promedio 
    # Cuando el saldo es positivo devuelve la cantidad que es un valor numeric,
    # si el item no existe devulve 0.
    ***********************************/
   
/*
    if(p_criterio_valoracion = 1) then --FIFO: 1
      begin
        
        -- Obtener el costo_unitario del primer ingreso      
        v_consulta = '
        WITH item_ingresos_valorado
          AS  (
                SELECT movdet.id_movimiento_det, movdet.id_item, mov.id_movimiento, movdet.costo_unitario
                FROM alm.tmovimiento_det movdet
                INNER JOIN alm.tmovimiento mov ON mov.id_movimiento = movdet.id_movimiento
                INNER JOIN alm.tmovimiento_tipo movti ON mov.id_movimiento_tipo = movti.id_movimiento_tipo
                WHERE movti.codigo ilike ''INGRESO'' and movdet.id_item ='|| p_id_item ||'      
                ORDER BY movdet.id_movimiento_det asc limit 1 
              )
          SELECT * INTO TEMP tt_item_costo_unitario FROM  item_ingresos_valorado';
      execute(v_consulta);
        
      end;
    elsif(p_criterio_valoracion = 2) then --LIFO: 2
      begin
        
        -- Obtener el costo_unitario del ultimo ingreso 
        v_consulta = '
        WITH item_ingresos_valorado
          AS  (
                SELECT movdet.id_movimiento_det, movdet.id_item, mov.id_movimiento, movdet.costo_unitario
                FROM alm.tmovimiento_det movdet
                INNER JOIN alm.tmovimiento mov ON mov.id_movimiento = movdet.id_movimiento
                INNER JOIN alm.tmovimiento_tipo movti ON mov.id_movimiento_tipo = movti.id_movimiento_tipo
                WHERE movti.codigo ilike ''INGRESO'' and movdet.id_item ='|| p_id_item ||'
                ORDER BY movdet.id_movimiento_det asc limit 1 
              )
          SELECT * INTO TEMP tt_item_costo_unitario  FROM  item_ingresos_valorado';
      execute(v_consulta);
        
        end;
    
    elsif(p_criterio_valoracion = 3) then --Promedio: 3
      begin
        
        -- Obtener el costo_unitario promedio de todos los ingresos
        v_consulta = '
        WITH item_ingresos_valorado
          AS  (
                SELECT movdet.id_item, array_agg(mov.id_movimiento) AS id_movimiento,
                sum(movdet.cantidad) AS cantidad_total, sum(movdet.costo_unitario * movdet.cantidad) AS costo_unitario_total
                FROM alm.tmovimiento_det movdet
                INNER JOIN alm.tmovimiento mov ON mov.id_movimiento = movdet.id_movimiento
                INNER JOIN alm.tmovimiento_tipo movti ON mov.id_movimiento_tipo = movti.id_movimiento_tipo
                WHERE movti.codigo ilike ''INGRESO'' and movdet.id_item ='|| p_id_item ||'
                GROUP BY id_item
              ),
          costo_promedio
          AS (    
              SELECT *, (costo_unitario_total /cantidad_total) AS costo_unitario FROM  item_ingresos_valorado
              )
        SELECT * INTO TEMP tt_item_costo_unitario  FROM costo_promedio';
      execute(v_consulta);
        
        end;
        
    ELSE
      raise exception 'Opcion de valoracion de item invalida.';

    END IF;
        
    SELECT costo_unitario INTO v_item_costo_unitario FROM tt_item_costo_unitario;    
    
    IF v_item_costo_unitario <= 0 OR v_item_costo_unitario IS NULL THEN
        v_item_costo_unitario = 0;
    END IF;    
    
    RETURN v_item_costo_unitario;
  
    -- En caso de que se requiera retornar un record (RETURNS SETOF  record AS $$) 
    -- con la información de las cantidaddes de los ingresos y salidas ademas del saldo. 
    
    --RETURN QUERY SELECT * FROM tt_item_saldo;
    --SETOF  record
    */
    
    --El SELECT para obtener los valores seria:
    /*
      SELECT * gem.f_get_valorado_item ( 5 ) 
         f ( id_item  integer,              
             id_movimiento_ingresos integer[],
             id_movimiento_salidas integer[],
             suma_ingresos numeric,
             suma_salidas numeric,
             saldo numeric
          );
    */
EXCEPTION         

  WHEN OTHERS THEN

      v_resp='';

      v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);

      v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);

      v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);

      raise exception '%',v_resp;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;