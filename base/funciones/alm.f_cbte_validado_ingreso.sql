CREATE OR REPLACE FUNCTION alm.f_cbte_validado_ingreso (
  p_id_usuario integer,
  p_id_int_comprobante integer
)
RETURNS boolean AS
$body$
/*
Autor: RCM
Fecha: 22/10/2013
Descripción: Función para finalización de ingresos después de la validación del comprobante
*/

DECLARE

	v_id_movimiento integer;
    v_id_almacen integer;
    v_fecha_mov integer;
    v_operacion varchar;
    v_id_proceso_wf					integer;
    v_id_estado_wf					integer;
    v_estado_mov          			varchar;
    va_id_tipo_estado 				integer [];
    va_codigo_estado 				varchar [];
    va_disparador 					varchar [];
    va_regla 						varchar [];
    va_prioridad 					integer []; 
    v_id_funcionario_wf				integer;
    v_obs							varchar;
    v_resp							varchar;
    v_rec							record;

BEGIN

	----------------------------------
    --(1) INICIALIZACIÓN DE VARIABLES
    ----------------------------------
    v_operacion = 'siguiente';
    v_id_funcionario_wf = null;
    v_obs = 'Ninguna';

    ------------------------------
    --(2) OBTENCION DATOS MOVIMIENTO
    ------------------------------
    --Se obtienen los datos del movimiento a finalizar
    select
    mov.id_movimiento, mov.fecha_mov, mov.id_almacen
    into
    v_id_movimiento, v_fecha_mov, v_id_almacen
    from conta.tint_comprobante cbte
	inner join alm.tmovimiento mov  on mov.id_int_comprobante = cbte.id_int_comprobante
    where cbte.id_int_comprobante = p_id_int_comprobante;
    
	----------------------------------
    --(3) OBTENCIÓN DE DATOS WORK FLOW
    ----------------------------------
    select
    m.id_proceso_wf, m.id_estado_wf, m.estado_mov
    into            
    v_id_proceso_wf, v_id_estado_wf, v_estado_mov
    from alm.tmovimiento m
    where m.id_movimiento=v_id_movimiento;
                
    --Siguiente estado correspondiente al proceso del WF
    SELECT 
    ps_id_tipo_estado, ps_codigo_estado, ps_disparador, ps_regla, ps_prioridad
    into
    va_id_tipo_estado, va_codigo_estado, va_disparador, va_regla, va_prioridad
    FROM wf.f_obtener_estado_wf(v_id_proceso_wf, v_id_estado_wf,NULL,'siguiente');
    
    --Verifica que no haya más de un estado para la finalización
    if array_length(va_id_tipo_estado,1)>1  THEN           
		raise exception 'El siguiente estado debería ser únicamente el de finalización, pero el WF está configurado con más de un estado. Revise la configuración del WF';                    
    else
        --No hay estado siguiente
      raise exception '%', 'Nada que hacer. No hay ningún estado siguiente';
    end if;
    
    --Prepara los parámetros para llamar al workflow en un hstore
    select 
    v_id_movimiento,
    v_operacion,
    v_id_almacen,
    va_id_tipo_estado[1],
    v_id_funcionario_wf,
    v_fecha_mov,
    v_obs
    into v_rec;
    
    --Llamada a la función del worflow de Almacenes
    v_resp = alm.f_movimiento_workflow_principal(p_id_usuario,hstore(v_rec));
    
    --Respuesta
    return true;
    

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;