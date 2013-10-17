CREATE OR REPLACE FUNCTION alm.ft_movimiento_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_movimiento_ime
 DESCRIPCION:    Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones) de la tabla 'alm.tmovimiento'
 AUTOR:          Gonzalo Sarmiento
 FECHA:          03-10-2012
 COMENTARIOS:   
************************************************************************/
DECLARE

	v_nombre_funcion        		varchar;  
	v_parametros          			record;
	v_id_movimiento_tipo    		integer;
	v_id_movimiento       			integer;
	v_id_movimiento_tipo_ingreso  	integer;
	v_id_movimiento_tipo_salida 	integer;
	v_respuesta         			varchar;
	v_id_movimiento_ingreso   		integer;
	v_id_movimiento_salida    		integer;
	v_transferencia       			record;
	v_consulta          			varchar;
	v_detalle           			record;
	v_contador          			numeric;
	v_contador_2          			numeric;
	v_estado_almacen        		varchar;
	v_estado_mov          			varchar;
	g_registros         			record;
	g_registros_2         			record;
	v_tipo_mov          			varchar;
	v_tipo_mov_personalizado    	varchar;
	v_id_almacen          			integer;
	v_codigo_valoracion     		varchar;
	v_saldo_cantidad        		numeric;
	v_aux_integer         			integer;
	v_costo_valorado        		numeric;
	v_cantidad_valorada     		numeric;
	v_id_movimiento_det_val_desc  	integer;
	v_nombre_item         			varchar;
	v_errores           			varchar;
	v_id_almacen_dest       		integer;
	v_id_movimiento_dest      		integer;
	v_id_movimiento_det_dest    	integer;
	v_fecha_mov_ultima      		timestamp;
	v_fecha_mov         			timestamp;
	v_id_depto          			integer;
	v_cod_documento       			varchar;
	v_alerta_amarilla       		numeric;
	v_alerta_roja         			numeric;
	v_cantidad_minima       		numeric;
	v_nombre_almacen        		varchar;
	v_alerts            			boolean;
	v_descripcion_alerta      		varchar;
	v_mostrar_alerts        		boolean;
	v_cant_aux            			numeric;
	v_id_periodo					integer;
	v_estado_periodo_subsistema		varchar;
	v_cod_almacen					varchar;
    v_codigo_tipo_proceso			varchar;
    v_id_proceso_macro				integer;
    v_num_tramite 					varchar;
    v_id_proceso_wf					integer;
    v_id_estado_wf					integer;
    v_codigo_estado					varchar;
    
    va_id_tipo_estado 				integer [];
    va_codigo_estado 				varchar [];
    va_disparador 					varchar [];
    va_regla 						varchar [];
    va_prioridad 					integer []; 
    
    v_id_estado_actual  			integer;
    
    v_id_tipo_estado				integer;
    v_id_tipo_proceso				integer;
    v_id_funcionario				integer;
    v_id_usuario_reg				integer;
    v_id_estado_wf_ant				integer;           
    
    v_pedir_obs						varchar;
    v_num_estados					integer;
    v_num_funcionarios				integer;
    v_num_deptos					integer;
    v_id_funcionario_estado			integer;
    v_id_depto_estado				integer;
    v_codigo_estado_siguiente		varchar;
    v_obs							text;
    v_uo_sol						varchar;
    v_codigo						varchar;
    v_asunto_alerta					varchar;
    v_id_preingreso					integer;
    v_rec_wf						record;
    v_codigo_mov_tipo				varchar;
    v_result						varchar;
    v_codigo_mov					varchar;
    v_tipo_nodo						varchar;
    v_aux_estado_wf					varchar;
    v_cont							integer;
    v_id_gestion					integer;
    v_aux_nombre_estado_wf			varchar;
    
BEGIN

	v_nombre_funcion='alm.ft_movimiento_ime';
	v_parametros=pxp.f_get_record(p_tabla);
  
  
	 /*********************************   	
     #TRANSACCION:  'SAL_MOV_INS'
     #DESCRIPCION:  Insercion de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        03-10-2012
    ***********************************/
	if(p_transaccion='SAL_MOV_INS') then
  	begin
    
    	select
        v_parametros.id_movimiento_tipo,
        v_parametros.id_almacen,
        v_parametros.id_funcionario, 
        v_parametros.id_proveedor,
        v_parametros.id_almacen_dest,
        v_parametros.fecha_mov,
        v_parametros.descripcion,
        v_parametros.observaciones,
        v_parametros.id_movimiento_origen,
        v_parametros.id_gestion
        into g_registros;
        
        --Llama a la función de registro del movimiento
        v_id_movimiento = alm.f_insercion_movimiento(p_id_usuario,hstore(g_registros));
  
        v_respuesta =pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento almacenado correctamente');
        v_respuesta =pxp.f_agrega_clave(v_respuesta,'id_movimiento',v_id_movimiento::varchar);

        return v_respuesta;
	end;
  /*********************************   
     #TRANSACCION:  'SAL_MOV_MOD'
     #DESCRIPCION:  Modificacion de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        03-10-2012
    ***********************************/       
            
  elseif(p_transaccion='SAL_MOV_MOD')then
    begin
      
      select mov.estado_mov into v_estado_mov
      from alm.tmovimiento mov
      where mov.id_movimiento = v_parametros.id_movimiento;
        
      if (v_estado_mov = 'cancelado' or v_estado_mov = 'finalizado') then
          raise exception '%', 'El movimiento actual no puede ser modificado';
      end if;
       
      update alm.tmovimiento set             
          id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            id_movimiento_tipo = v_parametros.id_movimiento_tipo,
          	id_almacen = v_parametros.id_almacen,
            id_funcionario = v_parametros.id_funcionario,
            id_proveedor = v_parametros.id_proveedor,
            id_almacen_dest = v_parametros.id_almacen_dest,
            fecha_mov = date(v_parametros.fecha_mov) + interval '12 hours',
            descripcion = v_parametros.descripcion,
            observaciones = v_parametros.observaciones,
            id_movimiento_origen = v_parametros.id_movimiento_origen
        where id_movimiento = v_parametros.id_movimiento;
        
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento modificado con exito');
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);
        return v_respuesta;
        
    end;
  	/*********************************   
     #TRANSACCION:  'SAL_MOV_ELI'
     #DESCRIPCION:  Eliminacion de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        03-10-2012
    ***********************************/
    elseif(p_transaccion='SAL_MOV_ELI')then
		begin
            select mov.estado_mov, mov.id_preingreso
            into v_estado_mov, v_id_preingreso
            from alm.tmovimiento mov
            where mov.id_movimiento = v_parametros.id_movimiento;
              
            if (v_estado_mov = 'cancelado' or v_estado_mov = 'finalizado') then
                raise exception '%', 'El movimiento actual no puede ser eliminado';
            end if;
            
            if (v_id_preingreso is not null) then
                raise exception '%', 'El movimiento no puede eliminarse porque viene de un Preingreso finalizado';
            end if;
              
            delete from alm.tmovimiento
            where id_movimiento=v_parametros.id_movimiento;

            v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento eliminado');
            v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);

            return v_respuesta;
        end;
    
    /*********************************   
     #TRANSACCION:  'SAL_MOVFIN_MOD'
     #DESCRIPCION:  Finalizacion de un movimiento
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        20-02-2013
    ***********************************/
    /*
    MODIFICACIONES
    AUTOR: RCM
    FECHA: 10/10/2013
    DESCRIPCION: SE REESTRUCTURA LA FINALIZACIÓN Y CAMBIO DE ESTADOS PARA QUE UN SOLO PROCEDIMIENTO DIRECCIONE AL SIGUIENTE ESTADO
    */
	elseif(p_transaccion='SAL_MOVFIN_MOD')then
	
    	begin
        
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
            where mov.id_movimiento = v_parametros.id_movimiento; 
            
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
            where m.id_movimiento=v_parametros.id_movimiento;
                
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

			-------------------------
            --3. ACCIONES A REALIZAR
            -------------------------
            
            IF  v_parametros.operacion = 'verificar' THEN
				-------------------------
                --3.1 VALIDACIÓN GENERAL
                -------------------------
                --Verificar que el almacen esté activo
                if (v_estado_almacen is null or v_estado_almacen = 'inactivo') then
                  raise exception '%', 'El Almacén seleccionado no se encuentra Activo';
                end if;
    	        
                --Se obtienen los datos del movimiento a finalizar para realizar validaciones
                select mov.fecha_mov
                into v_fecha_mov
                from alm.tmovimiento mov 
                where mov.id_movimiento = v_parametros.id_movimiento;
    	        
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
    	
                if v_id_periodo is null then
                    raise exception 'El Período correspondiente a: %, no está Abierto. Comuníquese con el Encargado de Almacenes', to_char(v_fecha_mov,'mm/yyyy');
                end if;
    	        
                --Verificar que la fecha no sea anterior al ultimo registro finalizado.
                select max(mov.fecha_mov) into v_fecha_mov_ultima
                from alm.tmovimiento mov
                where mov.estado_mov = 'finalizado'
                    and mov.estado_reg = 'activo'
                    and mov.id_almacen = v_parametros.id_almacen;
    	        
                if (date(v_fecha_mov) < date(v_fecha_mov_ultima)) then
                  raise exception '%', 'La fecha del movimiento no debe ser anterior al ultimo movimiento finalizado';
                end if;
    	
                --Verificación de existencias y algunos errores
                select po_errores, po_contador
                into v_errores, v_contador
                from alm.f_verificar_existencias_item(v_parametros.id_movimiento);
                
                /*v_errores = '';
                v_contador := 0;
                for g_registros in (select 
                                    movdet.id_item,
                                    item.nombre as nombre_item,
                                    movdet.id_movimiento_det,
                                    movdet.cantidad as cantidad_item
                                    from alm.tmovimiento_det movdet
                                    inner join alm.titem item on item.id_item = movdet.id_item
                                    where movdet.estado_reg = 'activo'
                                    and movdet.id_movimiento = v_parametros.id_movimiento) loop
                    v_contador = v_contador + 1;
    				
                    --Verificamos que la cantidad no sea nula y que la cantidad requerida no sea mayor que el saldo 
                    v_saldo_cantidad = alm.f_get_saldo_fisico_item(g_registros.id_item, v_parametros.id_almacen, date(v_fecha_mov));
    	            
                    if (g_registros.cantidad_item is null or g_registros.cantidad_item < 0) then
                      v_errores = v_errores || '\nEl item ' || g_registros.nombre_item || ' debe tener cantidad registrada igual o mayor a cero';
                    --elseif (v_tipo_mov = 'salida' and g_registros.cantidad_item > v_saldo_cantidad) then
                      --RCM 24042013: se añade opción para que se entregue lo existente si es que no hay suficiente
                      --v_errores = v_errores || '\nNo existen suficientes existencias del item ' || g_registros.nombre_item || '. Solicitado: ' || g_registros.cantidad_item || '. Existencias: '|| v_saldo_cantidad;
                     v_errores = v_errores || '\n- El item ' || g_registros.nombre_item || ' debe tener al menos una cantidad para valorar';
                    end if;
                   
                END LOOP;*/
                
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
                --WF cantidad estados
                if array_length(va_id_tipo_estado,1)>0  THEN           
					v_respuesta=pxp.f_agrega_clave(v_respuesta,'wf_cant_estados',array_length(va_id_tipo_estado,1)::varchar);
                    
                    if array_length(va_id_tipo_estado,1)= 1 then
                    	v_respuesta=pxp.f_agrega_clave(v_respuesta,'wf_id_tipo_estado',va_id_tipo_estado[1]::varchar);
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
                    end if;

                else
                	--Respuesta de que no hay funcionarios
                	v_respuesta=pxp.f_agrega_clave(v_respuesta,'wf_cant_funcionarios','0');
                end if;
                
                v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_estado_wf',v_id_estado_wf::varchar);
                v_respuesta=pxp.f_agrega_clave(v_respuesta,'fecha',v_fecha_mov::varchar);

         ELSIF v_parametros.operacion = 'siguiente' THEN  
        
        	--------------------------------
            --3.4 ACCIONES POR TIPO DE NODO
            --------------------------------
            if v_tipo_nodo = 'inicial' then
                --Implementar
            elsif v_tipo_nodo = 'intermedio' then
                --Implementar
            elsif v_tipo_nodo = 'final' then
                --Ejecuta la valoración del movimiento
                v_result = alm.f_valoracion_mov(p_id_usuario,v_parametros.id_movimiento);
            end if;

            ----------------------------------------
            --4.REGISTRO NUEVO ESTADO DEL WORK FLOW
            ----------------------------------------
            v_id_estado_actual =  wf.f_registra_estado_wf(v_parametros.id_tipo_estado,--va_id_tipo_estado[1], 
                                                          v_parametros.id_funcionario_wf,--v_id_funcionario_estado, 
                                                          v_id_estado_wf, 
                                                          v_id_proceso_wf,
                                                          p_id_usuario,
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
            and mov.id_almacen = v_parametros.id_almacen;
    	        
            if (v_fecha_mov_ultima is not null) then
              v_fecha_mov = v_fecha_mov_ultima + interval '1 min';
            else 
              v_fecha_mov = date(v_fecha_mov) + interval '1 min';
            end if;
            
            --Obtención del número del movimiento
            if v_codigo_mov is null then 
            	v_codigo_mov = param.f_obtener_correlativo (v_cod_documento, v_id_periodo, NULL, v_id_depto, p_id_usuario, 'ALM', null,2,3,'alm.talmacen',v_parametros.id_almacen,v_cod_almacen);
                
                update alm.tmovimiento set
                codigo = v_codigo_mov
                where id_movimiento = v_parametros.id_movimiento;
            end if;

            --Actualiza estado de WF
            update alm.tmovimiento set
            id_estado_wf = v_id_estado_actual,           
            estado_mov = v_codigo_estado,
            fecha_mov = v_fecha_mov,
            fecha_mod = now()
            where id_movimiento = v_parametros.id_movimiento;
        
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
                  raise exception 'No se tiene una gestion configurada para la fecha %',v_parametros.fecha; 
                end if;
                
                --Define los parámetros para generar el ingreso
                select
                v_id_movimiento_tipo,--v_parametros.id_movimiento_tipo,
                v_id_almacen_dest,--v_parametros.id_almacen,
                v_id_funcionario,--v_parametros.id_funcionario, 
                NULL,--v_parametros.id_proveedor,
                NULL,--v_parametros.id_almacen_dest,
                now(),--v_parametros.fecha_mov,
                'Ingreso por transferencia correspondiente a la salida: ' || coalesce(v_codigo_mov,'S/C'),--v_parametros.descripcion,
                NULL,--v_parametros.observaciones,
                v_parametros.id_movimiento,--v_parametros.id_movimiento_origen
                v_id_gestion --id_gestion
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
                                	where movdet.id_movimiento = v_parametros.id_movimiento
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
            
            -----------------------
            --7.GENERACIÓN DE ALERTAS
            -----------------------
            v_mostrar_alerts = alm.f_generar_alertas_mov(p_id_usuario, v_parametros.id_movimiento);

		ELSIF v_parametros.operacion = 'anterior' THEN
        
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
                          v_id_depto,
                          v_parametros.obs);
                      
			--Actualiza estado del movimiento
            update alm.tmovimiento  set 
            id_estado_wf = v_id_estado_actual,
            estado_mov = v_codigo_estado,
            id_usuario_mod = p_id_usuario,
            fecha_mod = now()
            where id_movimiento = v_parametros.id_movimiento;
                         
            v_respuesta = pxp.f_agrega_clave(v_respuesta,'mensaje','Se retrocedió el movimiento al estado anterior)'); 
        
        ELSIF v_parametros.operacion = 'inicio' THEN
        
			SELECT
            mov.id_estado_wf, pw.id_tipo_proceso, pw.id_proceso_wf
           	into
            v_id_estado_wf, v_id_tipo_proceso, v_id_proceso_wf
           	FROM alm.tmovimiento mov
           	inner join wf.tproceso_wf pw on pw.id_proceso_wf = mov.id_proceso_wf
           	WHERE mov.id_movimiento = v_parametros.id_movimiento;
  
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
                    v_id_depto,
                    v_parametros.obs);
                      
             --Actualiza estado en el movimiento
             update alm.tmovimiento  m set 
             id_estado_wf = v_id_estado_actual,
             estado_mov = v_codigo_estado,
             id_usuario_mod = p_id_usuario,
             fecha_mod = now()
             where id_movimiento = v_parametros.id_movimiento;             
            
             --Respuesta
             v_respuesta = pxp.f_agrega_clave(v_respuesta,'mensaje','Se regreso al estado inicial'); 
             
       
        ELSE
              
            raise exception 'Operación no identificada %',COALESCE( v_parametros.operacion,'--');
              
      	END IF;   
         
    
        --------------
        --8.RESPUESTA
        --------------
        --v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento finalizado');
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);
		
    	    
        if v_mostrar_alerts then
            v_respuesta=pxp.f_agrega_clave(v_respuesta,'alerts',v_mostrar_alerts::varchar);
        end if;
        
          
        --Devuelve respuesta	    
        return v_respuesta; 
    	
    end;
  	
    /*********************************   
     #TRANSACCION:  'SAL_MOVCNL_MOD'
     #DESCRIPCION:  Cancelacion de un movimiento
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        20-02-2013
    ***********************************/
	elseif (p_transaccion='SAL_MOVCNL_MOD') then
    	begin
        
            --Obtiene el Proceso WF
            SELECT
            mov.id_estado_wf, pw.id_tipo_proceso, pw.id_proceso_wf
           	into
            v_id_estado_wf, v_id_tipo_proceso, v_id_proceso_wf
           	FROM alm.tmovimiento mov
           	inner join wf.tproceso_wf pw on pw.id_proceso_wf = mov.id_proceso_wf
           	WHERE mov.id_movimiento = v_parametros.id_movimiento;
            
            --Obtiene el estado cancelado del WF
            select 
            te.id_tipo_estado
            into
            v_id_tipo_estado
            from wf.tproceso_wf pw 
            inner join wf.ttipo_proceso tp on pw.id_tipo_proceso = tp.id_tipo_proceso
            inner join wf.ttipo_estado te on te.id_tipo_proceso = tp.id_tipo_proceso and te.codigo = 'cancelado'               
            where pw.id_proceso_wf = v_id_proceso_wf;
               
            --Se cancela el WF
            v_id_estado_actual =  wf.f_registra_estado_wf(v_id_tipo_estado, 
                                                           NULL, 
                                                           v_id_estado_wf, 
                                                           v_id_proceso_wf,
                                                           p_id_usuario,
                                                           null);
            
            --Cancela el movimiento
            update alm.tmovimiento set
            id_estado_wf =  v_id_estado_actual,
          	estado_mov = 'cancelado',
            id_usuario_mod=p_id_usuario,
            fecha_mod=now()
        	where id_movimiento = v_parametros.id_movimiento;

            v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento cancelado');
            v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);
            
            return v_respuesta;
    	end;
        
    /*********************************   
     #TRANSACCION:  'SAL_MOVREV_MOD'
     #DESCRIPCION:  Reversion de un movimiento
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        26-02-2013
    ***********************************/
    elseif (p_transaccion='SAL_MOVREV_MOD') then
    begin
      	--Revisar que sea el último movimiento finalizado.
        select mov.id_movimiento
        into v_id_movimiento
        from alm.tmovimiento mov
        where mov.estado_mov = 'finalizado'
        and mov.estado_reg = 'activo' 
        order by mov.fecha_mov desc limit 1;
        
        if (v_id_movimiento != v_parametros.id_movimiento) then
          raise exception '%', 'No se puede revertir el movimiento seleccionado. Para revertir un movimiento no deben existir movimiento finalizados despues de este.';
        end if;
        
        --se obtienen los datos del movimiento a revertir
        select mov.fecha_mov, movtip.tipo, movtip.nombre, mov.id_almacen_dest
        into v_fecha_mov, v_tipo_mov, v_tipo_mov_personalizado, v_id_almacen_dest
        from alm.tmovimiento mov 
        inner join alm.tmovimiento_tipo movtip on movtip.id_movimiento_tipo = mov.id_movimiento_tipo
        where mov.id_movimiento = v_parametros.id_movimiento;
        
        -- solo para salidas.
        if (v_tipo_mov = 'salida') then
        -- BUCLE de los detalle del movimiento
          FOR g_registros in (
                select 
                    movdet.id_item,
                    item.nombre as nombre_item,
                    movdet.id_movimiento_det,
                    movdet.cantidad as cantidad_item
                from alm.tmovimiento_det movdet
                inner join alm.titem item on item.id_item = movdet.id_item
                where movdet.estado_reg = 'activo'
                    and movdet.id_movimiento = v_parametros.id_movimiento
            ) LOOP 
              --se obtiene el tipo de valoracion 
                --obtener el codigo del metodo de valoracion
                select metval.codigo into v_codigo_valoracion
                from alm.talmacen_stock alstock
                inner join alm.tmetodo_val metval on metval.id_metodo_val = alstock.id_metodo_val
                where alstock.id_almacen = v_parametros.id_almacen
                  and alstock.id_item = g_registros.id_item
                    and alstock.estado_reg = 'activo';
                
                --se va recorriendo todos los detalles valorados del detalle_movimiento
              FOR g_registros_2 in (
                  select detval.cantidad, detval.id_mov_det_val_origen
                    from alm.tmovimiento_det_valorado detval
                    where detval.id_movimiento_det = g_registros.id_movimiento_det
                    order by detval.id_movimiento_det_valorado desc
                ) LOOP
                  IF (g_registros_2.id_mov_det_val_origen is not null) THEN
                        -- sumar la cantidad del ultimo detalle valorado al aux_saldo encontrado
                        update alm.tmovimiento_det_valorado set
                            id_usuario_mod = p_id_usuario,
                            fecha_mod = now(),
                            aux_saldo_fisico = aux_saldo_fisico + g_registros_2.cantidad
                        where id_movimiento_det_valorado = g_registros_2.id_mov_det_val_origen;
                    END IF;
                END LOOP;
                
                -- eliminar todos los det_valorados del detalle_movimiento
                delete from alm.tmovimiento_det_valorado detval
                where detval.id_movimiento_det = g_registros.id_movimiento_det;
                
                --Insertar un nuevo detalle_valorado con la cantidad del detalle_movimiento
                insert into alm.tmovimiento_det_valorado (
                    id_usuario_reg,
                    fecha_reg,
                    estado_reg,
                    id_movimiento_det,
                    cantidad
                ) VALUES (
                    p_id_usuario,
                    now(),
                    'activo',
                    g_registros.id_movimiento_det,
                    g_registros.cantidad_item
                );
            END LOOP;          
        end if;
        
        --Obtiene datos del WF
        SELECT
        mov.id_estado_wf, pw.id_tipo_proceso, pw.id_proceso_wf
        into
        v_id_estado_wf, v_id_tipo_proceso, v_id_proceso_wf
        FROM alm.tmovimiento mov
        inner join wf.tproceso_wf pw on pw.id_proceso_wf = mov.id_proceso_wf
        WHERE mov.id_movimiento = v_parametros.id_movimiento;
  
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
                v_id_depto,
                v_parametros.obs);
                      
         --Actualiza estado en el movimiento
         update alm.tmovimiento  m set 
         id_estado_wf = v_id_estado_actual,
         estado_mov = v_codigo_estado,
         id_usuario_mod = p_id_usuario,
         fecha_mod = now()
         where id_movimiento = v_parametros.id_movimiento;             
        
         v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento revertido');
         v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento',v_parametros.id_movimiento::varchar);
         return v_respuesta;
    end;
    
  /*********************************    
 	#TRANSACCION:  'ALM_ANTEMOV_IME'
 	#DESCRIPCION:	Transaccion utilizada  pasar a  estados anterior del movimiento
                    segun la operacion definida
 	#AUTOR:		GSS
 	#FECHA:		12-07-2013 12:12:51
	***********************************/

	elseif(p_transaccion='SAL_ANTEMOV_IME')then   
        begin
        
        --------------------------------------------------
        --REtrocede al estado inmediatamente anterior
        -------------------------------------------------
         IF  v_parametros.operacion = 'cambiar' THEN
               
               raise notice 'es_estado_wf %',v_parametros.id_estado_wf;
              
                      --recupera estado anterior segun Log del WF
                        SELECT  
                           ps_id_tipo_estado,
                           ps_id_funcionario,
                           ps_id_usuario_reg,
                           ps_id_depto,
                           ps_codigo_estado,
                           ps_id_estado_wf_ant
                        into
                           v_id_tipo_estado,
                           v_id_funcionario,
                           v_id_usuario_reg,
                           v_id_depto,
                           v_codigo_estado,
                           v_id_estado_wf_ant 
                        FROM wf.f_obtener_estado_ant_log_wf(v_parametros.id_estado_wf);
                        
                        --
                      select 
                           ew.id_proceso_wf 
                        into 
                           v_id_proceso_wf
                      from wf.testado_wf ew
                      where ew.id_estado_wf= v_id_estado_wf_ant;
                      
                      -- registra nuevo estado
                      
                      v_id_estado_actual = wf.f_registra_estado_wf(
                          v_id_tipo_estado, 
                          v_id_funcionario, 
                          v_parametros.id_estado_wf, 
                          v_id_proceso_wf, 
                          p_id_usuario,
                          v_id_depto,
                          v_parametros.obs);
                      
                      -- actualiza estado del movimiento
                        update alm.tmovimiento  m set 
                           id_estado_wf =  v_id_estado_actual,
                           estado_mov = v_codigo_estado,
                           id_usuario_mod=p_id_usuario,
                           fecha_mod=now()
                         where id_movimiento = v_parametros.id_movimiento;
                         
                        -- si hay mas de un estado disponible  preguntamos al usuario
                        v_respuesta = pxp.f_agrega_clave(v_respuesta,'mensaje','Se realizo el cambio de estado)'); 
                        v_respuesta = pxp.f_agrega_clave(v_respuesta,'operacion','cambio_exitoso');
                        
                              
                      --Devuelve la respuesta
                        return v_respuesta;
                        
           ----------------------------------------------------------------------
           -- PAra retornar al estado borrador de la solicitud de manera directa
           ---------------------------------------------------------------------
           ELSEIF  v_parametros.operacion = 'inicio' THEN
             
           SELECT
            mov.id_estado_wf,
            pw.id_tipo_proceso,
           	pw.id_proceso_wf
           into
            v_id_estado_wf,
            v_id_tipo_proceso,
            v_id_proceso_wf
             
           FROM alm.tmovimiento mov
           inner join wf.tproceso_wf pw on pw.id_proceso_wf = mov.id_proceso_wf
           WHERE  mov.id_movimiento = v_parametros.id_movimiento;
           
             raise notice 'BUSCAMOS EL INICIO PARA %',v_id_tipo_proceso;
             
            -- recuperamos el estado inicial segun tipo_proceso
             
             SELECT  
               ps_id_tipo_estado,
               ps_codigo_estado
             into
               v_id_tipo_estado,
               v_codigo_estado
             FROM wf.f_obtener_tipo_estado_inicial_del_tipo_proceso(v_id_tipo_proceso);
             
             --recupera el funcionario segun ultimo log borrador
             raise notice 'CODIGO ESTADO BUSCADO %',v_codigo_estado ;
             
             SELECT 
               ps_id_funcionario,
               ps_codigo_estado ,
               ps_id_depto
             into
              v_id_funcionario,
              v_codigo_estado,
              v_id_depto
                
             FROM wf.f_obtener_estado_segun_log_wf(v_id_estado_wf, v_id_tipo_estado);
            
              raise notice 'CODIGO ESTADO ENCONTRADO %',v_codigo_estado ;
             
             --registra estado borrador
              v_id_estado_actual = wf.f_registra_estado_wf(
                  v_id_tipo_estado, 
                  v_id_funcionario, 
                  v_parametros.id_estado_wf, 
                  v_id_proceso_wf, 
                  p_id_usuario,
                  v_id_depto,
                  v_parametros.obs);
                      
              -- actualiza estado en el movimiento
                update alm.tmovimiento  m set 
                   id_estado_wf =  v_id_estado_actual,
                   estado_mov = v_codigo_estado,
                   id_usuario_mod=p_id_usuario,
                   fecha_mod=now()
                 where id_movimiento = v_parametros.id_movimiento;             
            
               -- si hay mas de un estado disponible  preguntamos al usuario
                v_respuesta = pxp.f_agrega_clave(v_respuesta,'mensaje','Se regresoa borrador con exito)'); 
                v_respuesta = pxp.f_agrega_clave(v_respuesta,'operacion','cambio_exitoso');
                              
              --Devuelve la respuesta
                return v_respuesta;
              
           ELSE
           
           		raise exception 'Operacion no reconocida %',v_parametros.operacion;
           
           END IF;
       end;
       
         /*********************************    
 	#TRANSACCION:  'SAL_SIGEMOV_IME'
 	#DESCRIPCION:	funcion que controla el cambio al Siguiente estado del movimiento, integrado con el WF
 	#AUTOR:		GSS
 	#FECHA:		12-07-2013 12:12:51
	***********************************/

	elseif(p_transaccion='SAL_SIGEMOV_IME')then   
        begin
        
        --obtenermos datos basicos
          
          select
            m.id_proceso_wf,
            m.id_estado_wf,
            m.estado_mov,
            m.fecha_mov
          into           
            v_id_proceso_wf,
            v_id_estado_wf,
            v_codigo_estado,
            v_fecha_mov
            
          from alm.tmovimiento m
          where m.id_movimiento=v_parametros.id_movimiento;
          
           select 
            ew.id_tipo_estado ,
            te.pedir_obs
           into 
            v_id_tipo_estado,
            v_pedir_obs
          from wf.testado_wf ew
          inner join wf.ttipo_estado te on te.id_tipo_estado = ew.id_tipo_estado
          where ew.id_estado_wf = v_id_estado_wf;
          
         --------------------------------------------- 
         -- Verifica  los posibles estados sigueintes para que desde la interfza se tome la decision si es necesario
         --------------------------------------------------
          IF  v_parametros.operacion = 'verificar' THEN
          
              --buscamos siguiente estado correpondiente al proceso del WF
             
              ----- variables de retorno------
              
              v_num_estados=0;
              v_num_funcionarios=0;
              v_num_deptos=0;
              
              --------------------------------- 
              
             SELECT  
                 ps_id_tipo_estado,
                 ps_codigo_estado,
                 ps_disparador,
                 ps_regla,
                 ps_prioridad
              into
                va_id_tipo_estado,
                va_codigo_estado,
                va_disparador,
                va_regla,
                va_prioridad 
              FROM adq.f_obtener_sig_estado_sol_rec(v_parametros.id_movimiento, v_id_proceso_wf, v_id_tipo_estado); 
          
            
            v_num_estados= array_length(va_id_tipo_estado, 1);
     
             IF v_pedir_obs = 'no' THEN

                IF v_num_estados = 1 then
                      -- si solo hay un estado,  verificamos si tiene mas de un funcionario por este estado

                     SELECT 
                     *
                      into
                     v_num_funcionarios 
                     FROM wf.f_funcionario_wf_sel(
                         p_id_usuario, 
                         va_id_tipo_estado[1], 
                         v_fecha_mov::date,
                         v_id_estado_wf,
                         TRUE) AS (total bigint);
                                         raise exception 'fass b finish %',v_num_estados;             
                    IF v_num_funcionarios = 1 THEN
                    -- si solo es un funcionario, recuperamos el funcionario correspondiente
                         SELECT 
                             id_funcionario
                               into
                             v_id_funcionario_estado
                         FROM wf.f_funcionario_wf_sel(
                             p_id_usuario, 
                             va_id_tipo_estado[1], 
                             v_fecha_mov::date,
                             v_id_estado_wf,
                             FALSE) 
                             AS (id_funcionario integer,
                               desc_funcionario text,
                               desc_funcionario_cargo text,
                               prioridad integer);
                    END IF;    
                  
                  --verificamos el numero de deptos
                  
                    SELECT 
                    *
                    into
                      v_num_deptos 
                   FROM wf.f_depto_wf_sel(
                       p_id_usuario, 
                       va_id_tipo_estado[1], 
                       v_fecha_mov::date,
                       v_id_estado_wf,
                       TRUE) AS (total bigint);
                       
                  IF v_num_deptos = 1 THEN
                      -- si solo es un funcionario, recuperamos el funcionario correspondiente
                           SELECT 
                               id_depto
                                 into
                               v_id_depto_estado
                          FROM wf.f_depto_wf_sel(
                               p_id_usuario, 
                               va_id_tipo_estado[1], 
                               v_fecha_soli,
                               v_id_estado_wf,
                               FALSE) 
                               AS (id_depto integer,
                                 codigo_depto varchar,
                                 nombre_corto_depto varchar,
                                 nombre_depto varchar,
                                 prioridad integer);
                    END IF;
                  
                 END IF;

           END IF;

            -- si hay mas de un estado disponible  preguntamos al usuario
            v_respuesta = pxp.f_agrega_clave(v_respuesta,'mensaje','Verificacion para el siguiente estado)'); 
            v_respuesta = pxp.f_agrega_clave(v_respuesta,'estados', array_to_string(va_id_tipo_estado, ','));
            v_respuesta = pxp.f_agrega_clave(v_respuesta,'operacion','preguntar_todo');
            v_respuesta = pxp.f_agrega_clave(v_respuesta,'num_estados',v_num_estados::varchar);
            v_respuesta = pxp.f_agrega_clave(v_respuesta,'num_funcionarios',v_num_funcionarios::varchar);
            v_respuesta = pxp.f_agrega_clave(v_respuesta,'num_deptos',v_num_deptos::varchar);
            v_respuesta = pxp.f_agrega_clave(v_respuesta,'id_funcionario_estado',v_id_funcionario_estado::varchar);
            v_respuesta = pxp.f_agrega_clave(v_respuesta,'id_depto_estado',v_id_depto_estado::varchar);
            v_respuesta = pxp.f_agrega_clave(v_respuesta,'id_tipo_estado', va_id_tipo_estado[1]::varchar);
            
            
           ----------------------------------------
           --Se se solicita cambiar de estado a la solicitud
           ------------------------------------------
           ELSEIF  v_parametros.operacion = 'cambiar' THEN
            
            -- obtener datos tipo estado
            
            select
             te.codigo
            into
             v_codigo_estado_siguiente
            from wf.ttipo_estado te
            where te.id_tipo_estado = v_parametros.id_tipo_estado;
            
            IF  pxp.f_existe_parametro('p_tabla','id_depto') THEN
             
             v_id_depto = v_parametros.id_depto;
            
            END IF;            
            
            v_obs=v_parametros.obs;           
                        
             v_id_estado_actual =  wf.f_registra_estado_wf(v_parametros.id_tipo_estado, 
                                                           v_parametros.id_funcionario, 
                                                           v_id_estado_wf, 
                                                           v_id_proceso_wf,
                                                           p_id_usuario,
                                                           v_id_depto,
                                                           v_obs);
            
            
             -- actualiza estado en el movimiento
            
             update alm.tmovimiento  s set 
               id_estado_wf =  v_id_estado_actual,
               estado_mov = v_codigo_estado_siguiente,
               id_usuario_mod=p_id_usuario,
               fecha_mod=now()
               
             where id_movimiento= v_parametros.id_movimiento;
            
           -- si hay mas de un estado disponible  preguntamos al usuario
            v_respuesta = pxp.f_agrega_clave(v_respuesta,'mensaje','Se realizo el cambio de estado)'); 
            v_respuesta = pxp.f_agrega_clave(v_respuesta,'operacion','cambio_exitoso');
                    
          END IF;
        
          --Devuelve la respuesta
            return v_respuesta;
        
        end; 
        
	
  else
     raise exception 'Transaccion inexistente: %',p_transaccion;
  end if;
EXCEPTION
  WHEN OTHERS THEN
        v_respuesta='';
        v_respuesta = pxp.f_agrega_clave(v_respuesta,'mensaje',SQLERRM);
        v_respuesta = pxp.f_agrega_clave(v_respuesta,'codigo_error',SQLSTATE);
        v_respuesta = pxp.f_agrega_clave(v_respuesta,'procedimientos',v_nombre_funcion);
        raise exception '%',v_respuesta;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;