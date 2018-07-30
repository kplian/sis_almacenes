--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.f_get_saldo_fisico_item (
  p_id_item integer,
  p_id_almacen integer,
  p_fecha_hasta date,
  p_incluir_pendientes varchar = 'no'::character varying
)
RETURNS numeric AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE ALMACENES
 FUNCION: 		alm.f_get_saldo_fisico_item1
 DESCRIPCION:   Función que devuelve la cantidad existente del item con ID: p_id_item
 RETORNA:		Devuelve el valor de la cantidad disponible para el item: p_id_item
 AUTOR: 		Ariel Gayaviri Omonte
 FECHA:	        19/02/2013
 COMENTARIOS:	
 *********************************** CAMBIOS
  DESCRIPCION:  se agrega el filtro al tipo demovimeinto de invetarios final para no ser considerado en el calculo
                por ejemplo el repote de kardek al 31 de diciembre no tiene que considerar la salida realizada por el inventario final
 AUTOR: 		RAC
 FECHA:	        10/04/2014
 
  *********************************** CAMBIOS
  DESCRIPCION:  Se agrega parametro p_incluir_pendientes para tomar las salidas q no han sido finalizadas
 AUTOR: 		JRR
 FECHA:	        02/05/2014
 
***************************************************************************/

DECLARE

	v_nombre_funcion	text;
    v_resp				varchar;
    v_item_saldo 		numeric;
   	v_resultado 		record;
   	v_consulta  		varchar;
    v_ingresos			numeric;
  	v_salidas			numeric;
    v_existencias		numeric;
    
    v_fecha_fin date;
    va_id_movimiento_inv_fin integer[];
	v_estado_salida		varchar;
BEGIN

  --raise exception '%',p_fecha_hasta;

    v_fecha_fin = p_fecha_hasta::DATE;
    p_fecha_hasta = p_fecha_hasta + interval '1 day';
    v_nombre_funcion = 'alm.f_get_saldo_fisico_item';
    v_item_saldo := 0;
    
    --  identifica si tiene cirres al dia solcitado 
    select 
      pxp.aggarray(id_movimiento)
    into
     va_id_movimiento_inv_fin
    from alm.tmovimiento m 
    inner join alm.tmovimiento_tipo mt  
       on   mt.id_movimiento_tipo = m.id_movimiento_tipo  
       and  mt.codigo ='INVFIN' and m.fecha_mov::date = v_fecha_fin;
    
    
    
    
    select coalesce(sum(movdet.cantidad),0) into v_ingresos
    from alm.tmovimiento_det movdet
    inner join alm.tmovimiento mov on mov.id_movimiento = movdet.id_movimiento
    inner join alm.tmovimiento_tipo movtip on movtip.id_movimiento_tipo = mov.id_movimiento_tipo
    where movdet.estado_reg = 'activo'
        and movtip.tipo like '%ingreso%'
	and movdet.id_item = p_id_item
        and mov.estado_mov = 'finalizado'
        and mov.id_almacen = p_id_almacen
        and mov.fecha_mov < p_fecha_hasta;
    
   --salidas 

	if (p_incluir_pendientes = 'si') then
    	v_estado_salida = ' and mov.estado_mov not in(''anulado'', ''eliminado'') ';
    else
    	v_estado_salida = ' and mov.estado_mov = ''finalizado'' ';    
    end if;
        
        
    execute('select coalesce(sum(movdet.cantidad),0)  
    from alm.tmovimiento_det movdet
    
    inner join alm.tmovimiento mov on mov.id_movimiento = movdet.id_movimiento   
                                  and mov.id_movimiento not in ('||COALESCE(array_to_string(va_id_movimiento_inv_fin,','),'0')||')
    
    inner join alm.tmovimiento_tipo movtip on movtip.id_movimiento_tipo = mov.id_movimiento_tipo 
    where movdet.estado_reg = ''activo''  
        and movtip.tipo like ''%salida%''  
        and movdet.id_item = '||p_id_item|| v_estado_salida || '  
          
        and mov.id_almacen = '||p_id_almacen|| '   
        and mov.fecha_mov < '''||p_fecha_hasta||'''') into v_salidas;  
        
        
    
    if (v_ingresos is null) then
    	v_existencias = 0;
    elseif (v_salidas is null) then
    	v_existencias = v_ingresos;
    else
    	v_existencias = v_ingresos - v_salidas;
    end if;
    
    return coalesce(v_existencias,0);
    
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