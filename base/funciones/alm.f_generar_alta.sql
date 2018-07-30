CREATE OR REPLACE FUNCTION alm.f_generar_alta (
  p_id_usuario integer,
  p_id_usuario_ai integer,
  p_usuario varchar,
  p_id_preingreso integer
)
RETURNS varchar AS
$body$
/*
Autor: RCM
Fecha: 04/10/2013
Descripción: Genera el ingreso a Almacén o a Activos Fijos a partir de un preingreso
*/
DECLARE

  v_resp varchar;
    v_rec record;
    v_rec_det record;
    v_rec_val record;
    v_id_movimiento integer;
    v_id_movimiento_tipo integer;
    v_codigo_tipo_proceso varchar;
    v_id_proceso_macro integer;
    v_id_gestion integer;
    v_num_tramite varchar;
    v_id_proceso_wf integer;
    v_id_estado_wf integer;
    v_codigo_estado varchar;
    v_nombre_funcion varchar;
    v_id_proceso_wf_cot integer;
    v_id_estado_wf_cot integer;
    v_codigo_estado_cot varchar;
    v_id_proceso_macro_cot integer;
    
    va_id_tipo_estado integer [];
    va_codigo_estado varchar [];
    va_disparador varchar [];
    va_regla varchar [];
    va_prioridad integer [];
    v_id_estado_actual  integer;
    v_id_movimiento_det integer;
    v_cadena_cnx    varchar;
    v_consulta      varchar;
    v_res_cone      varchar;
    
BEGIN

  v_nombre_funcion = 'alm.f_generar_alta';
 
  ---------------------
    --OBTENCION DE DATOS
    ---------------------
    --Preingreso
    select pre.id_preingreso, pre.estado, pre.tipo, sol.id_funcionario,
    pre.descripcion, pre.id_depto_conta
    into v_rec
    from alm.tpreingreso pre
    inner join adq.tcotizacion cot on cot.id_cotizacion = pre.id_cotizacion
    inner join adq.tproceso_compra pro on pro.id_proceso_compra = cot.id_proceso_compra
    inner join adq.tsolicitud sol on sol.id_solicitud = pro.id_solicitud
    where id_preingreso = p_id_preingreso;
    
    --Movimiento tipo para Ingresos del sistema de Adquisiciones
    select id_movimiento_tipo
    into v_id_movimiento_tipo
    from alm.tmovimiento_tipo
    where codigo = 'INADQ';
    
    --Datos de WF para el Ingreso
    select tp.codigo, pm.id_proceso_macro 
    into v_codigo_tipo_proceso, v_id_proceso_macro
    from  alm.tmovimiento_tipo mt
    inner join wf.tproceso_macro pm on pm.id_proceso_macro =  mt.id_proceso_macro
    inner join wf.ttipo_proceso tp on tp.id_proceso_macro = pm.id_proceso_macro
    where mt.id_movimiento_tipo = v_id_movimiento_tipo
    and tp.estado_reg = 'activo'
    and tp.inicio = 'si';
    
    --Gestión
    select id_gestion
    into v_id_gestion
    from param.tgestion
    where gestion = to_char(now(),'yyyy')::integer;
    
    --Datos WF del Preingreso
    select
    pre.id_proceso_wf, pre.id_estado_wf, pre.estado,
    sol.id_proceso_macro
    into 
    v_id_proceso_wf_cot, v_id_estado_wf_cot, v_codigo_estado_cot,
    v_id_proceso_macro_cot
    from alm.tpreingreso pre
    inner join adq.tcotizacion cot on cot.id_cotizacion = pre.id_cotizacion
    inner join adq.tproceso_compra pro on pro.id_proceso_compra = cot.id_proceso_compra
    inner join adq.tsolicitud sol on sol.id_solicitud = pro.id_solicitud
    where pre.id_preingreso = p_id_preingreso;
    
    
    ---------------
    --VALIDACIONES 
    ---------------
    --Existencia del preingreso
    if v_rec.id_preingreso is null then
      raise exception 'Preingreso inexistente';
    end if;
    --Estado
    if v_rec.estado != 'registrado' then
      raise exception 'El estado del Preingreso debe ser "Registrado", está en "%"',v_rec.estado;
    end if;
    --Tipo de ingreso
    if v_rec.tipo not in ('almacen','activo_fijo') then
      raise exception 'Tipo Preingreso no válido: "%"',v_rec.tipo;
    end if;
    --Movimiento Tipo
    if v_id_movimiento_tipo is null then
      raise exception 'No existe el Tipo de Movimiento';
    end if;
    --WF Ingreso
    if v_id_proceso_macro is null then
      raise exception 'El Workflow para el ingreso no está configurado';
    end if;
    --Gestión
    if v_id_gestion is null then
      raise exception 'Gestión no encontrada';
    end if;
    --WF Preingreso
    if v_id_proceso_macro_cot is null then
      raise exception 'El Workflow del Preingreso no está configurado';
    end if;
    
    
    
    
     -------------------------
    --Finaliza el Preingreso
    -------------------------
    --Obtener siguiente estado correpondiente al proceso del WF del preingreso
    SELECT 
    ps_id_tipo_estado, ps_codigo_estado, ps_disparador, ps_regla, ps_prioridad
    into
    va_id_tipo_estado, va_codigo_estado, va_disparador, va_regla, va_prioridad
    FROM wf.f_obtener_estado_wf(v_id_proceso_wf_cot, v_id_estado_wf_cot,NULL,'siguiente');

    --Validaciones
    if va_id_tipo_estado[2] is not null then
        raise exception 'El proceso se encuentra mal parametrizado dentro de Work Flow, la finalizacion del Preingreso solo admite un estado siguiente';
    end if;
          
    if  va_id_tipo_estado[1] is  null  then
      raise exception ' El proceso de Work Flow esta mal parametrizado, no tiene un estado siguiente para la finalizacion';
    end if;
    
   -- raise exception '%  -  %',va_id_tipo_estado[1],va_codigo_estado[1];
   
    v_id_estado_actual =  wf.f_registra_estado_wf(va_id_tipo_estado[1], 
                                                 NULL, 
                                                 v_id_estado_wf_cot, 
                                                 v_id_proceso_wf_cot,
                                                 p_id_usuario,
                                                 p_id_usuario_ai,
                                                 p_usuario,
                                                 NULL,
                                                 'Preingreso realizado',
                                                 '',
                                                 'Preingreso');

    --Actualiza estado en preingreso
    update alm.tpreingreso set 
    id_estado_wf =  v_id_estado_actual,
    estado = va_codigo_estado[1],
    id_usuario_mod=p_id_usuario,
    fecha_mod=now()
    where id_preingreso = v_rec.id_preingreso;
    
    
    
        
    if v_rec.tipo = 'activo_fijo' then
     
   
    
      --Verificación de destino de generación de ingreso a activos fijos
        if pxp.f_get_variable_global('alm_migrar_af_endesis')='si' then
          --Llama ala funcion de ENDESIS para generar el ingreso de activos fijos
            --funcion para obtener cadena de conexion
      v_cadena_cnx =  migra.f_obtener_cadena_conexion();
            
            v_consulta = 'select migracion.f_af_genera_alta_af('||
                          p_id_usuario ||',' ||
                          COALESCE(v_rec.id_preingreso::varchar,'NULL')||')';
                          
      --Abre una conexion con dblink para ejecutar la consulta
            v_resp =  (SELECT dblink_connect(v_cadena_cnx));
           
            
                       
            if (v_resp!='OK') THEN
                --Error al abrir la conexión  
                raise exception 'FALLA CONEXION A LA BASE DE DATOS CON DBLINK';
            else
                PERFORM * FROM dblink(v_consulta,true) AS (resp varchar);
                v_res_cone=(select dblink_disconnect());
            end if;
            

        else
          --raise exception 'TODO: implementar ingreso a Activos Fijos de PXP';
          v_resp = kaf.f_i_alm_preingreso__genera_alta_af(p_id_usuario,p_id_preingreso);
        end if;

    end if;
    
   

    
  
    ------------
    --RESPUESTA
    ------------
    return 'Ingreso generado';


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