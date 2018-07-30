CREATE OR REPLACE FUNCTION alm.f_generar_ingreso (
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

  v_nombre_funcion = 'alm.f_generar_ingreso';
 
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
    if v_rec.estado != 'borrador' then
      raise exception 'El estado del Preingreso debe ser "Borrador", está en "%"',v_rec.estado;
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
    --Items listos para generación de ingreso
    if not exists(select 1
                  from alm.tpreingreso_det
                  where id_preingreso = v_rec.id_preingreso
                  and sw_generar = 'si'
                  and estado = 'mod') then
      raise exception 'El detalle de Preingreso no tiene los Registros marcados para Generación del Ingreso';
    end if;
    --Verifica si es por Almacen o Activo que tengan los datos mínimos
    if exists(select 1
                from alm.tpreingreso_det pdet
                inner join alm.tpreingreso ping on ping.id_preingreso = pdet.id_preingreso
                where pdet.id_preingreso = v_rec.id_preingreso
                and pdet.sw_generar = 'si'
                and ping.tipo='almacen'
                and pdet.id_item is null 
                and pdet.id_almacen is null) then
      raise exception 'Datos incompletos, defina el Item y el Almacén destino';
    end if;
    if exists(select 1
                from alm.tpreingreso_det pdet
                inner join alm.tpreingreso ping on ping.id_preingreso = pdet.id_preingreso
                where pdet.id_preingreso = v_rec.id_preingreso
                and pdet.sw_generar = 'si'
                and ping.tipo='activo_fijo'
                and pdet.id_clasificacion is null 
                and pdet.id_depto is null) then
      raise exception 'Datos incompletos, defina la Clasificación y el Depto. destino';
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
    
    
    
    ---------------------------------------------------
    --GENERACION DE INGRESOS A ALMACEN O ACTIVOS FIJOS 
    ---------------------------------------------------
    if v_rec.tipo = 'almacen' then
    
      for v_rec_det in (select distinct id_almacen
                          from alm.tpreingreso_det
                          where id_preingreso = v_rec.id_preingreso
                          and sw_generar = 'si'
                          and estado = 'mod') loop
                          
          --Inicio del tramite en el sistema de WF
            select 
            ps_num_tramite, ps_id_proceso_wf, ps_id_estado_wf, ps_codigo_estado 
            into
            v_num_tramite, v_id_proceso_wf, v_id_estado_wf, v_codigo_estado   
            from wf.f_inicia_tramite(
               p_id_usuario, 
               p_id_usuario_ai,
               p_usuario,
               v_id_gestion,
               v_codigo_tipo_proceso, 
               v_rec.id_funcionario,
            NULL,
            'Generación de ingreso a almacén',
            'IN-S/N'
            );

          --Cabecera
            insert into alm.tmovimiento(
            id_usuario_reg, fecha_reg, estado_reg,
            id_movimiento_tipo, id_almacen, id_funcionario, fecha_mov,
            descripcion, id_proceso_macro, id_estado_wf, id_proceso_wf,
            estado_mov, id_preingreso, id_depto_conta, id_usuario_ai, usuario_ai
            ) values(
            p_id_usuario, now(),'activo',
            v_id_movimiento_tipo, v_rec_det.id_almacen, v_rec.id_funcionario, now(),
            v_rec.descripcion, v_id_proceso_macro, v_id_estado_wf, v_id_proceso_wf,
            v_codigo_estado, v_rec.id_preingreso, v_rec.id_depto_conta, p_id_usuario_ai, p_usuario
            ) returning id_movimiento into v_id_movimiento;
            
            --Detalle del ingreso
            for v_rec_val in (select
                              pdet.id_item, pdet.cantidad_det, pdet.precio_compra, 
                              pdet.observaciones, sdet.id_concepto_ingas
                              from alm.tpreingreso_det pdet
                              inner join adq.tcotizacion_det cdet on cdet.id_cotizacion_det = pdet.id_cotizacion_det
                              inner join adq.tsolicitud_det sdet on sdet.id_solicitud_det = cdet.id_solicitud_det
                              where pdet.id_preingreso = v_rec.id_preingreso
                              and pdet.id_almacen = v_rec_det.id_almacen
                              and pdet.sw_generar = 'si'
                              and pdet.estado = 'mod') loop
                              
                insert into alm.tmovimiento_det(
                id_usuario_reg, fecha_reg, estado_reg,
                id_movimiento, id_item, cantidad, costo_unitario, cantidad_solicitada,
                observaciones, id_concepto_ingas
                ) values(
                p_id_usuario, now(),'activo',
                v_id_movimiento, v_rec_val.id_item, v_rec_val.cantidad_det, v_rec_val.precio_compra,v_rec_val.cantidad_det,
                v_rec_val.observaciones, v_rec_val.id_concepto_ingas
                ) returning id_movimiento_det into v_id_movimiento_det;
                
                --Detalle valorado
                insert into alm.tmovimiento_det_valorado (
                id_usuario_reg,fecha_reg,estado_reg,id_movimiento_det,
                cantidad,costo_unitario
                ) values (
                p_id_usuario,now(),'activo',v_id_movimiento_det,
                v_rec_val.cantidad_det, v_rec_val.precio_compra
                );
                
            end loop;

        end loop;
    
    
    elsif v_rec.tipo = 'activo_fijo' then
    
      --Verificación de destino de generación de ingreso a activos fijos
        if pxp.f_get_variable_global('alm_migrar_af_endesis')='si' then
            --Llama ala funcion de ENDESIS para generar el ingreso de activos fijos
            --funcion para obtener cadena de conexion
            v_cadena_cnx =  migra.f_obtener_cadena_conexion();
            
            v_consulta = 'select migracion.f_af_genera_registro_af('||
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
          --Ingreso a Activos Fijos de PXP;
          v_resp = kaf.f_i_alm_preingreso__genera_registro_af(p_id_usuario,v_rec.id_preingreso);
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