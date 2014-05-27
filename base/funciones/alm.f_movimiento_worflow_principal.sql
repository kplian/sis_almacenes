--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.f_movimiento_workflow_principal (
  p_id_usuario integer,
  p_parametros public.hstore
)
RETURNS varchar AS
$body$
/*
Autor: RCM
Fecha: 22/10/2013
Descripción: Función que se encarga de direccionar el worflow principal de los movimientos.
			
Nota: (Se independiza esta funcionalidad que estaba en la función alm.f_movimiento_ime para poder reutilizarla desde otros lados)
*/

DECLARE

	v_fecha_mov         			timestamp;
    v_tipo_mov          			varchar;
    v_tipo_mov_personalizado    	varchar;
    v_id_almacen_dest       		integer;
    v_id_almacen					integer;
    v_id_depto						integer;
    v_codigo_mov_tipo				varchar;
    v_codigo_mov					varchar;
    v_id_funcionario				integer;
    v_nombre_almacen        		varchar;
    v_estado_almacen        		varchar;
    v_cod_almacen					varchar;
    v_cod_documento					varchar;
    v_id_proceso_wf					integer;
    v_id_estado_wf					integer;
    v_estado_mov          			varchar;
    va_id_tipo_estado 				integer [];
    va_codigo_estado 				varchar [];
    va_disparador 					varchar [];
    va_regla 						varchar [];
    va_prioridad 					integer []; 
    v_id_tipo_proceso				integer;
    v_id_tipo_estado				integer;
    v_rec_wf						record;
    v_tipo_nodo						varchar;
    v_id_periodo					integer;
    v_fecha_mov_ultima      		timestamp;
    v_errores           			varchar;
    v_contador          			numeric;
    v_respuesta						varchar;
    v_num_funcionarios				integer;
    v_cont							integer;
    g_registros						record;
    v_id_funcionario_estado			integer;
    v_id_estado_actual				integer;
    v_codigo_estado					varchar;
    v_id_movimiento_tipo			integer;
    v_id_gestion					integer;
    v_id_movimiento_dest			integer;
    v_id_movimiento_det_dest    	integer;
    v_plantilla_cbte				varchar;
    v_result						varchar;
    v_id_usuario_reg				integer;
    v_id_estado_wf_ant				integer;    
    v_id_int_comprobante			integer; 
    v_alertas						varchar;
    v_saldo_total      				numeric;
    v_alertas_exis					varchar;
    v_salto_total					numeric;
    
    v_nombre_funcion  				varchar;
    v_resp            				varchar;

BEGIN

   v_nombre_funcion = 'alm.f_movimiento_workflow_principal ';

	------------------------------
    --1.OBTENCION DATOS MOVIMIENTO
    ------------------------------
    --Se obtienen los datos del movimiento a finalizar
    select
    mov.fecha_mov, movtip.tipo, movtip.nombre, mov.id_almacen_dest,
    mov.id_almacen, alma.id_departamento, movtip.codigo, mov.codigo, mov.id_funcionario,
    alma.nombre, alma.estado, alma.codigo
    into
    v_fecha_mov, v_tipo_mov, v_tipo_mov_personalizado, v_id_almacen_dest,
    v_id_almacen, v_id_depto, v_codigo_mov_tipo, v_codigo_mov, v_id_funcionario,
    v_nombre_almacen, v_estado_almacen, v_cod_almacen
    from alm.tmovimiento mov 
    inner join alm.tmovimiento_tipo movtip on movtip.id_movimiento_tipo = mov.id_movimiento_tipo
    inner join alm.talmacen alma on alma.id_almacen = mov.id_almacen
    where mov.id_movimiento = (p_parametros->'id_movimiento')::integer; 
            
    --Definición del tipo de documento
    if (v_tipo_mov = 'salida') then
        v_cod_documento = 'MOVSAL';
    elsif (v_tipo_mov = 'ingreso')then
        v_cod_documento = 'MOVIN';
    end if;
        
    ----------------------------------
    --2.OBTENCIÓN DE DATOS WORK FLOW
    ----------------------------------
    select
    m.id_proceso_wf, m.id_estado_wf, m.estado_mov
    into            
    v_id_proceso_wf, v_id_estado_wf, v_estado_mov
    from alm.tmovimiento m
    where m.id_movimiento=(p_parametros->'id_movimiento')::integer;
                
    --Siguiente estado correspondiente al proceso del WF
    SELECT 
    ps_id_tipo_estado, ps_codigo_estado, ps_disparador, ps_regla, ps_prioridad
    into
    va_id_tipo_estado, va_codigo_estado, va_disparador, va_regla, va_prioridad
    FROM wf.f_obtener_estado_wf(v_id_proceso_wf, v_id_estado_wf,NULL,'siguiente');
            
    --Obtención del Tipo de Proceso
    select pw.id_tipo_proceso
    into v_id_tipo_proceso
    from wf.tproceso_wf  pw
    where pw.id_proceso_wf = v_id_proceso_wf;
			
    --Obtención del tipo de estado   
    select ew.id_tipo_estado 
    into v_id_tipo_estado
    from wf.testado_wf ew
    where ew.id_estado_wf = v_id_estado_wf;

    --Datos del nodo
    select inicio, fin, tipo_asignacion
    into v_rec_wf
    from wf.ttipo_estado te
    where te.id_tipo_estado = va_id_tipo_estado[1];
            
    if v_rec_wf.inicio = 'si' then
        v_tipo_nodo = 'inicial';
    elsif v_rec_wf.fin = 'si' then
        v_tipo_nodo = 'final';
    else
        v_tipo_nodo = 'intermedio';
    end if;
    
    --Se revisa si el periodo esta abierto
    select pers.id_periodo into v_id_periodo --pesu.id_periodo, pesu.estado into v_id_periodo, v_estado_periodo_subsistema
    from param.tperiodo_subsistema pers
    inner join param.tperiodo per
    on per.id_periodo = pers.id_periodo 
    inner join segu.tsubsistema sis
    on sis.id_subsistema = pers.id_subsistema
    where sis.codigo = 'ALM' 
    and date_trunc('day',v_fecha_mov) between per.fecha_ini and per.fecha_fin
    and pers.estado = 'abierto';

    -------------------------
    --3. ACCIONES A REALIZAR
    -------------------------
            
    IF  (p_parametros->'operacion')::varchar = 'verificar' THEN
        -------------------------
        --3.1 VALIDACIÓN GENERAL
        -------------------------
        --Verificar que el almacen esté activo
        if (v_estado_almacen is null or v_estado_almacen = 'inactivo') then
          raise exception '%', 'El Almacén seleccionado no se encuentra Activo';
        end if;

        if v_id_periodo is null then
            raise exception 'El Período correspondiente a: %, no está Abierto. Comuníquese con el Encargado de Almacenes', to_char(v_fecha_mov,'mm/yyyy');
        end if;
    	        
        --Verificar que la fecha no sea anterior al ultimo registro finalizado.
        select max(mov.fecha_mov) into v_fecha_mov_ultima
        from alm.tmovimiento mov
        where mov.estado_mov = 'finalizado'
            and mov.estado_reg = 'activo'
            and mov.id_almacen = (p_parametros->'id_almacen')::integer;
    	        
        if (date(v_fecha_mov) < date(v_fecha_mov_ultima)) then
          raise exception '%', 'La fecha del movimiento no debe ser anterior al ultimo movimiento finalizado';
        end if;
        
        --Verificación de existencias y algunos errores
        select po_errores, po_contador, po_alertas, po_saldo_total
        into v_errores, v_contador, v_alertas_exis, v_saldo_total
        from alm.f_verificar_existencias_item((p_parametros->'id_movimiento')::integer,v_codigo_estado);
        
        if v_contador = 0 then
            raise exception 'No se ha registrado ningún Item en el detalle del movimiento';
        end if;
        if v_errores != '' then
            raise exception '%',v_errores;
        end if;
        
                
        ---------------------------------------------
        --3.2 VALIDACIÓN ESPECÍFICA POR TIPO DE NODO
        ---------------------------------------------
        v_respuesta =pxp.f_agrega_clave(v_respuesta,'mensaje','Verificación realizada');
        if v_tipo_nodo = 'inicial' then
            --Implementar
        elsif v_tipo_nodo = 'final' then
            --Implementar
        elsif v_tipo_nodo = 'intermedio' then
            --Implementar
        end if;
                
        ------------------------------
        --3.3 DEFINICION DE RESPUESTA
        ------------------------------
        --Respuesta de la verificación de existencias
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'alertas',v_alertas_exis);
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'saldo_total',v_saldo_total::varchar);
        
        
        --WF cantidad estados
        if array_length(va_id_tipo_estado,1)>0  THEN           
            v_respuesta=pxp.f_agrega_clave(v_respuesta,'wf_cant_estados',array_length(va_id_tipo_estado,1)::varchar);
                    
            if array_length(va_id_tipo_estado,1)= 1 then
                v_respuesta=pxp.f_agrega_clave(v_respuesta,'wf_id_tipo_estado',va_id_tipo_estado[1]::varchar);
                v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_tipo_estado_wf',va_id_tipo_estado[1]::varchar);
            end if;
                    
            v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_tipo_proceso',v_id_tipo_proceso::varchar);
            v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_tipo_estado_padre',v_id_tipo_estado::varchar);
                    
        else
            --No hay estado siguiente
          raise exception '%', 'Nada que hacer. No hay ningún estado siguiente';
        end if;
                
        --WF cantidad funcionarios
        v_num_funcionarios=0;
        --Verifica si el estado acepta funcionarios
        if v_rec_wf.tipo_asignacion != 'ninguno' then
            select *
            into v_num_funcionarios 
            from wf.f_funcionario_wf_sel(p_id_usuario, va_id_tipo_estado[1],v_fecha_mov::date,v_id_estado_wf,true) as (total bigint);
                    
            v_cont=1;
            for g_registros in (SELECT id_funcionario, desc_funcionario, desc_funcionario_cargo
                                from wf.f_funcionario_wf_sel(
                                p_id_usuario, 
                                va_id_tipo_estado[1], 
                                v_fecha_mov::date,
                                v_id_estado_wf,
                                false) 
                                AS (id_funcionario integer,
                                desc_funcionario text,
                                desc_funcionario_cargo text,
                                prioridad integer)) loop
                if v_cont = 1 then
                    v_id_funcionario_estado = g_registros.id_funcionario;
                end if;
                v_cont = v_cont + 1;
            end loop;
                  
            v_respuesta=pxp.f_agrega_clave(v_respuesta,'wf_cant_funcionarios',v_num_funcionarios::varchar);

            if v_num_funcionarios = 1 then
                v_respuesta=pxp.f_agrega_clave(v_respuesta,'wf_id_funcionario',v_id_funcionario_estado::varchar);
                v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_funcionario_wf',v_id_funcionario_estado::varchar);
            end if;

        else
            --Respuesta de que no hay funcionarios
            v_respuesta=pxp.f_agrega_clave(v_respuesta,'wf_cant_funcionarios','0');
        end if;
                
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_estado_wf',v_id_estado_wf::varchar);
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'fecha',v_fecha_mov::varchar);

     ELSIF (p_parametros->'operacion')::varchar = 'siguiente' THEN  
            
        ----------------------------------------
        --4.REGISTRO NUEVO ESTADO DEL WORK FLOW
        ----------------------------------------
        v_id_estado_actual =  wf.f_registra_estado_wf((p_parametros->'id_tipo_estado')::integer,--va_id_tipo_estado[1], 
                                                      (p_parametros->'id_funcionario_wf')::integer,--v_id_funcionario_estado, 
                                                      v_id_estado_wf, 
                                                      v_id_proceso_wf,
                                                      p_id_usuario,
                                                      (p_parametros->'_id_usuario_ai')::integer,
                                                      (p_parametros->'_nombre_usuario_ai')::varchar,
                                                      NULL);
                                                      
       
             	
        --Obtiene el código del estado obtenido                      
        select te.codigo
        into v_codigo_estado
        from wf.testado_wf ewf
        inner join wf.ttipo_estado te on te.id_tipo_estado = ewf.id_tipo_estado
        where ewf.id_estado_wf = v_id_estado_actual;

        -----------------------
        --5.ACCIONES GENERALES
        -----------------------
        --Se obtiene la fecha_mov del último movimiento finalizado en la fecha_mov del movimiento que se va a finalizar.
        select max(mov.fecha_mov) into v_fecha_mov_ultima
        from alm.tmovimiento mov
        where date(mov.fecha_mov) = date(v_fecha_mov) 
        and mov.estado_mov = 'finalizado'
        and mov.id_almacen = (p_parametros->'id_almacen')::integer;
        	        
        if (v_fecha_mov_ultima is not null) then
          v_fecha_mov = v_fecha_mov_ultima + interval '1 min';
        else 
          v_fecha_mov = date(v_fecha_mov) + interval '1 min';
        end if;
                
        --Obtención del número del movimiento
        if v_codigo_mov is null then 
            v_codigo_mov = param.f_obtener_correlativo (v_cod_documento, v_id_periodo, NULL, v_id_depto, p_id_usuario, 'ALM', null,2,3,'alm.talmacen',(p_parametros->'id_almacen')::integer,v_cod_almacen);
            update alm.tmovimiento set
            codigo = v_codigo_mov
            where id_movimiento = (p_parametros->'id_movimiento')::integer;
        end if;

        
        --------------------------------------------
        --6.VERIFICA SI ES SALIDA POR TRANSFERENCIA
        --------------------------------------------
        --Si es una salida por transferencia genera un ingreso
        if v_codigo_mov_tipo = 'SALTRNSF' then
            --Obtiene el movimiento tipo de ingreso por transferencia
            select id_movimiento_tipo
            into v_id_movimiento_tipo
            from alm.tmovimiento_tipo
            where codigo = 'INTRNSF';
                    
            if v_id_movimiento_tipo is null then
                raise exception 'Error al generar el ingreso por Transferencia, no se encuentra el Tipo de Movimiento para Ingreso por Transferencia';
            end if;
                    
            --Obtiene la gestión actual
            select ges.id_gestion
            into v_id_gestion
            from param.tgestion ges
            where ges.gestion = to_char(now(),'yyyy'::integer)
            limit 1 offset 0;
                    
            if v_id_gestion is null then
              raise exception 'No se tiene una gestion configurada para la fecha %',(p_parametros->'fecha')::date; 
            end if;
                    
            --Define los parámetros para generar el ingreso
            select
            v_id_movimiento_tipo as id_movimiento_tipo,--(p_parametros->'id_movimiento')::integer_tipo,
            v_id_almacen_dest as id_almacen,--(p_parametros->'id_almacen')::integer,
            v_id_funcionario as id_funcionario,--v_parametros.id_funcionario, 
            NULL as id_proveedor,--v_parametros.id_proveedor,
            NULL as id_almacen_dest,--v_parametros-.id_almacen_dest,
            now() as fecha_mov,--(v_parametros.fecha_mov,
            'Ingreso por transferencia correspondiente a la salida: ' || coalesce(v_codigo_mov,'S/C'),--v_parametros.descripcion,
            NULL as observaciones,--(p_parametros->'obs')::varcharervaciones,
            (p_parametros->'id_movimiento')::integer as id_movimiento,--(p_parametros->'id_movimiento')::integer_origen
            v_id_gestion as id_gestion --id_gestion
            into g_registros;
                
            --Llama a la función de registro del movimiento
            v_id_movimiento_dest = alm.f_insercion_movimiento(p_id_usuario,hstore(g_registros));
                   
            --Copia el detalle del movimiento de salida por transferencia pero sin costos unitarios.
            for g_registros in (select 
                                movdet.id_movimiento_det,
                                movdet.id_item,
                                movdet.cantidad,
                                movdet.costo_unitario,
                                movdet.observaciones
                                from alm.tmovimiento_det movdet
                                where movdet.id_movimiento = (p_parametros->'id_movimiento')::integer
                                and movdet.estado_reg = 'activo') loop
                insert into alm.tmovimiento_det(
                    id_usuario_reg,
                    fecha_reg,
                    estado_reg,
                    id_movimiento,
                    id_item,
                    cantidad,
                    cantidad_solicitada,
                    costo_unitario,
                    observaciones
                ) values (
                    p_id_usuario,
                    now(),
                    'activo',
                    v_id_movimiento_dest,
                    g_registros.id_item,
                    g_registros.cantidad,
                    g_registros.cantidad,
                    g_registros.costo_unitario,
                    g_registros.observaciones
                ) returning id_movimiento_det into v_id_movimiento_det_dest;
        	                    
                insert into alm.tmovimiento_det_valorado (
                    id_usuario_reg,
                    fecha_reg,
                    estado_reg,
                    id_movimiento_det,
                    cantidad,
                    costo_unitario
                ) values (
                    p_id_usuario,
                    now(),
                    'activo',
                    v_id_movimiento_det_dest,
                    g_registros.cantidad,
                    g_registros.costo_unitario
                );
            end loop;
                        
        end if;
        
        
                
        --------------------------------
        --3.4 ACCIONES POR TIPO DE NODO
        --------------------------------
        if v_tipo_nodo = 'inicial' then
            --Implementar
        elsif v_tipo_nodo = 'intermedio' then
            --Verifica si el nuevo estado es en Contabilidad y es un ingreso
            if v_codigo_estado = 'contabilidad' then
                if v_tipo_mov = 'ingreso' then
                    v_plantilla_cbte = 'INGALM';
                else
                    --Para caso de salida no se implementa, porque se hará un comprobante por mes de todas las salidas
                    v_plantilla_cbte = '';
                end if;
                        
                if v_plantilla_cbte != '' then
                    v_id_int_comprobante = alm.f_generar_cbtes(p_id_usuario,v_plantilla_cbte,(p_parametros->'id_movimiento')::integer,null);
                end if;
            end if;

        elsif v_tipo_nodo = 'final' then
			--Verificación de existencias y algunos errores
            select po_errores, po_contador, po_alertas, po_saldo_total
            into v_errores, v_contador, v_alertas_exis, v_saldo_total
            from alm.f_verificar_existencias_item((p_parametros->'id_movimiento')::integer,v_codigo_estado);
            
--            raise exception 'A:%  B:%  C:%  D:%  E:%',v_errores, v_contador, v_alertas_exis, v_saldo_total,v_codigo_estado;

--poner raise para ver si tiene cantidad
            
            if v_errores != '' then
            	raise exception '%',v_errores;
        	end if;

            --Ejecuta la valoración del movimiento
            v_result = alm.f_valoracion_mov(p_id_usuario,(p_parametros->'id_movimiento')::integer);
            
        end if;
        
        --Actualiza estado de WF
	    update alm.tmovimiento set
	    id_estado_wf = v_id_estado_actual,           
	    estado_mov = v_codigo_estado,
	    fecha_mov = v_fecha_mov,
	    fecha_mod = now(),
	    id_usuario_mod = p_id_usuario,
        id_usuario_ai = (p_parametros->'_id_usuario_ai')::integer,
        usuario_ai = (p_parametros->'_nombre_usuario_ai')::varchar
	    where id_movimiento = (p_parametros->'id_movimiento')::integer;
              
    ELSIF (p_parametros->'operacion')::varchar = 'anterior' THEN
          
        --Recupera estado anterior segun Log del WF
        SELECT  
        ps_id_tipo_estado,ps_id_funcionario,ps_id_usuario_reg,
        ps_id_depto,ps_codigo_estado,ps_id_estado_wf_ant
        into
        v_id_tipo_estado,v_id_funcionario,v_id_usuario_reg,
        v_id_depto,v_codigo_estado,v_id_estado_wf_ant 
        FROM wf.f_obtener_estado_ant_log_wf(v_id_estado_wf);
                            
        --Encuentra el proceso
        select ew.id_proceso_wf 
        into v_id_proceso_wf
        from wf.testado_wf ew
        where ew.id_estado_wf= v_id_estado_wf_ant;
                          
        --Registra nuevo estado
        v_id_estado_actual = wf.f_registra_estado_wf(
                      v_id_tipo_estado, 
                      v_id_funcionario, 
                      v_id_estado_wf, 
                      v_id_proceso_wf, 
                      p_id_usuario,
                      (p_parametros->'_id_usuario_ai')::integer,
                      (p_parametros->'_nombre_usuario_ai')::varchar,
                      v_id_depto,
                      (p_parametros->'obs')::varchar);
                          
        --Actualiza estado del movimiento
        update alm.tmovimiento  set 
        id_estado_wf = v_id_estado_actual,
        estado_mov = v_codigo_estado,
        id_usuario_mod = p_id_usuario,
        fecha_mod = now(),
        id_usuario_ai = (p_parametros->'_id_usuario_ai')::integer,
        usuario_ai = (p_parametros->'_nombre_usuario_ai')::varchar
        where id_movimiento = (p_parametros->'id_movimiento')::integer;
                             
        v_respuesta = pxp.f_agrega_clave(v_respuesta,'mensaje','Se retrocedió el movimiento al estado anterior)'); 
            
    ELSIF (p_parametros->'operacion')::varchar = 'inicio' THEN
            
        SELECT
        mov.id_estado_wf, pw.id_tipo_proceso, pw.id_proceso_wf
        into
        v_id_estado_wf, v_id_tipo_proceso, v_id_proceso_wf
        FROM alm.tmovimiento mov
        inner join wf.tproceso_wf pw on pw.id_proceso_wf = mov.id_proceso_wf
        WHERE mov.id_movimiento = (p_parametros->'id_movimiento')::integer;
      
        --Recuperamos el estado inicial segun tipo_proceso
        SELECT  
        ps_id_tipo_estado, ps_codigo_estado
        into
        v_id_tipo_estado,v_codigo_estado
        FROM wf.f_obtener_tipo_estado_inicial_del_tipo_proceso(v_id_tipo_proceso);
                 
        --Recupera el funcionario según log
        SELECT 
        ps_id_funcionario, ps_codigo_estado, ps_id_depto
        into
        v_id_funcionario, v_codigo_estado, v_id_depto
        FROM wf.f_obtener_estado_segun_log_wf(v_id_estado_wf, v_id_tipo_estado);
                
         --Registra estado borrador
         v_id_estado_actual = wf.f_registra_estado_wf(
                v_id_tipo_estado, 
                v_id_funcionario, 
                v_id_estado_wf, 
                v_id_proceso_wf, 
                p_id_usuario,
                (p_parametros->'_id_usuario_ai')::integer,
                (p_parametros->'_nombre_usuario_ai')::varchar,
                v_id_depto,
                (p_parametros->'obs')::varchar);
                          
         --Actualiza estado en el movimiento
         update alm.tmovimiento  m set 
         id_estado_wf = v_id_estado_actual,
         estado_mov = v_codigo_estado,
         id_usuario_mod = p_id_usuario,
         fecha_mod = now(),
         id_usuario_ai = (p_parametros->'_id_usuario_ai')::integer,
         usuario_ai = (p_parametros->'_nombre_usuario_ai')::VARCHAR
         where id_movimiento = (p_parametros->'id_movimiento')::integer;             
                
         --Respuesta
         v_respuesta = pxp.f_agrega_clave(v_respuesta,'mensaje','Se regreso al estado inicial'); 
           
    ELSE
                  
        raise exception 'Operación no identificada %',COALESCE( (p_parametros->'operacion')::varchar,'--');
                  
    END IF; 
    
    --Respuesta
    return v_respuesta;
    
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