--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.f_generar_mov_gestion (
  p_id_usuario integer,
  p_id_almacen_gestion_log integer,
  p_accion varchar
)
RETURNS varchar AS
$body$
/*
Autor: RCM
Fecha: 15/01/2013
Descripción: Genera el(los) ingreso(s) o salida(s) para la acción requerida por gestión (apertura, cierre)
*/

DECLARE

	v_resp		            varchar;
	v_nombre_funcion        text;
    v_rec					record;
    v_rec_det				record;
    va_id_mov				integer[];
    v_id_almacen			integer;
    v_where					varchar;
    v_consulta				varchar;
    v_fecha_desde			date;
    v_fecha_hasta			date;
    v_gestion				integer;
    v_nivel					integer;
    v_max_nivel				integer;
    v_id_movimiento_tipo	integer;
    v_registros 			record;
    v_id_gestion			integer;
    v_id_funcionario		integer;
    v_id_movimiento_det		integer;
    v_sw_det				boolean;
    v_id_almacen_gestion_log integer;
    v_id_gestion_ant		integer;
    
BEGIN

	v_nombre_funcion = 'alm.f_generar_mov_gestion';
    
    --Verifica existencia del registro
    if not exists(select 1 from alm.talmacen_gestion_log
    			where id_almacen_gestion_log = p_id_almacen_gestion_log) then
		raise exception 'ID de Almacén Gestión inexistente';
    end if;
    
    --Obtiene el funcionario a partir del usuario
    select f.id_funcionario
    into v_id_funcionario
    from segu.tusuario u
    inner join orga.tfuncionario f
    on f.id_persona = u.id_persona
    where u.id_usuario = p_id_usuario;
    
    --Obtiene el id_almacen del almacen_gestion
    select ages.id_almacen, ges.gestion, ages.id_gestion
    into v_id_almacen, v_gestion, v_id_gestion
    from alm.talmacen_gestion_log alog
    inner join alm.talmacen_gestion ages on ages.id_almacen_gestion = alog.id_almacen_gestion
    inner join param.tgestion ges on ges.id_gestion = ages.id_gestion
    where alog.id_almacen_gestion_log = p_id_almacen_gestion_log;
    
    --Definición de las fechas
    v_fecha_desde = ('01-01-'||v_gestion::varchar)::date;
    v_fecha_hasta = ('31-12-'||v_gestion::varchar)::date;
   
	--Selector de acciones
    if p_accion = 'abrir' then
    	--Generar el (los) inventarios iniciales a partir de los finales de la anterior gestión
        select ges.id_gestion
        into v_id_gestion_ant
        from param.tgestion ges
        inner join alm.talmacen_gestion ages
        on ages.id_gestion = ges.id_gestion
        where ges.gestion = v_gestion-1;
        
        --Obtiene el tipo de movimiento para inventario inicial
        select id_movimiento_tipo
        into v_id_movimiento_tipo
        from alm.tmovimiento_tipo 
        where codigo = 'INVINI';
        
        if v_id_gestion_ant is not null then
        	--Obtiene el id del almacen log
            select alog.id_almacen_gestion_log
            into v_id_almacen_gestion_log
            from alm.talmacen_gestion ages
            inner join alm.talmacen_gestion_log alog
            on alog.id_almacen_gestion = ages.id_almacen_gestion
            and alog.estado_reg = 'activo'
            and alog.estado = 'cerrado'
            where ages.id_almacen = v_id_almacen
            and ages.id_gestion = v_id_gestion_ant
            and ages.estado = 'cerrado';
            
            --Verifica que los inventarios finales estén finalizados
            if exists(select 1 from alm.tmovimiento mov
            		where mov.id_almacen_gestion_log = v_id_almacen_gestion_log
            		and mov.estado_mov != 'finalizado') then
            	raise exception 'Existen salidas por inventario final de la gestión anterior no Finalizados.';
            end if;
            
            --Recorre los movimientos del log almacen
            v_sw_det = false;
            for v_rec in (select *
            			from alm.tmovimiento
                        where id_almacen_gestion_log = v_id_almacen_gestion_log
            			) loop
                        
                select
                v_id_movimiento_tipo as id_movimiento_tipo,--(p_parametros->'id_movimiento_tipo')::integer,
                v_id_almacen as id_almacen,--(p_parametros->'id_almacen')::integer,
                v_id_funcionario as id_funcionario,--v_parametros.id_funcionario, 
                NULL as id_proveedor,--v_parametros.id_proveedor,
                NULL as id_almacen_dest,--v_parametros-.id_almacen_dest,
                v_fecha_desde as fecha_mov,--(v_parametros.fecha_mov,
                'Ingreso por Inventario Inicial gestión '||v_gestion::varchar as descripcion,--v_parametros.descripcion,
                NULL as observaciones,--(p_parametros->'observaciones')::varchar,
                NULL as id_movimiento_origen,--(p_parametros->'id_movimiento_origen')::integer
                v_id_gestion as id_gestion --id_gestion
                into v_registros;       
                
                --Crea el movimiento
        		va_id_mov[1] = alm.f_insercion_movimiento(p_id_usuario,hstore(v_registros));
                
                update alm.tmovimiento set
                id_almacen_gestion_log = p_id_almacen_gestion_log
                where id_movimiento = va_id_mov[1];
                
                for v_rec_det in (select * from alm.tmovimiento_det
                				where id_movimiento = v_rec.id_movimiento
                			) loop
					--Registra el detalle del movimiento
                    insert into alm.tmovimiento_det(
                        id_usuario_reg,
                        fecha_reg,
                        estado_reg,
                        id_movimiento,
                        id_item,
                        cantidad,
                        cantidad_solicitada,
                        costo_unitario,
                        fecha_caducidad,
                        observaciones,
                        id_concepto_ingas
                    ) VALUES (
                        p_id_usuario,
                        now(),
                        'activo',
                        va_id_mov[1],
                        v_rec_det.id_item,
                        v_rec_det.cantidad,
                        v_rec_det.cantidad,
                        v_rec_det.costo_unitario,
                        NULL,
                        NULL,
                        NULL
                    ) RETURNING id_movimiento_det into v_id_movimiento_det;
                    
                    insert into alm.tmovimiento_det_valorado (
                        id_usuario_reg,
                        fecha_reg,
                        estado_reg,
                        id_movimiento_det,
                        cantidad,
                        costo_unitario,
                        aux_saldo_fisico
                    ) 
                    select 
                    p_id_usuario,
                        now(),
                        'activo',
                        v_id_movimiento_det,
                        a.cantidad,
                        a.costo_unitario,
                        a.cantidad
                    from alm.tmovimiento_det_valorado a
                    where id_movimiento_det = v_rec_det.id_movimiento_det;

                end loop;

            	v_sw_det = true;
            
            end loop;
            
            --No existe inventario final generado
            if not v_sw_det then

            end if;
        
        end if;
    
    elsif p_accion = 'cerrar' then
    	--Generar el (los) inventario(s) final(es)
        v_where = 'where ';
        
        --Creación de tabla temporal
        create temp table tt_detalle_existencias_item(
          id_item integer,
          cantidad numeric,
          costo_unit numeric,
          nivel integer
        ) on commit drop;
        
        v_consulta:='select 
            			id_item,
                        codigo,
                        nombre,
                        unidad_medida,
                        clasificacion,
                        cantidad,
                        costo
                        from alm.f_existencias_almacen_sel('||v_id_almacen||','''||v_fecha_hasta||''','''||v_where||''','''||' 0 = 0 '||''')
                        as (id_item integer,
                        codigo varchar,
                        nombre varchar,
                        unidad_medida varchar,
                        clasificacion varchar,
                        cantidad numeric,
                        costo numeric)
                        where cantidad > 0';  
                        
		for v_rec in execute(v_consulta) loop
        	v_nivel = 0;
            v_sw_det = false;
            
--            raise exception '%  %  %  %',v_rec.id_item,v_id_almacen,v_fecha_desde,v_fecha_hasta;
            
        	for v_rec_det in (select mval.*
            				from alm.tmovimiento_det mdet
                            inner join alm.tmovimiento_det_valorado mval
                            on mval.id_movimiento_det = mdet.id_movimiento_det
                            inner join alm.tmovimiento mov
                            on mov.id_movimiento = mdet.id_movimiento
                            inner join alm.tmovimiento_tipo mtipo
                            on mtipo.id_movimiento_tipo = mov.id_movimiento_tipo
                            where mdet.id_item = v_rec.id_item
                            and mov.id_almacen = v_id_almacen
                            and mtipo.tipo = 'ingreso'
                            and mval.aux_saldo_fisico > 0
                            and date_trunc('day',mov.fecha_mov) between v_fecha_desde and v_fecha_hasta) loop
                            
                --Incrementa el nivel
                v_nivel = v_nivel + 1;
                v_sw_det = true;
                
            	--Guarda el registro de la existencia el item  
				insert into tt_detalle_existencias_item
                values(
                v_rec.id_item,
                v_rec_det.aux_saldo_fisico,
                v_rec_det.costo_unitario,
                v_nivel
                );
			
            end loop;
            
            --Si es que no se encontró saldo en la variable auxiliar, se toma la existencia del item a la fecha
            if not v_sw_det then
            	--Guarda el registro de la existencia el item  
				insert into tt_detalle_existencias_item
                values(
                v_rec.id_item,
                v_rec.cantidad,
                round(v_rec.costo/v_rec.cantidad,2),
                1
                );
            end if;
        
        end loop;

        --------------------------------
        --Genera el (los) movimiento(s)
        --------------------------------
        --Obtiene la cantidad de movimientos a realizar
        select max(nivel)
        into v_max_nivel
        from tt_detalle_existencias_item;
        
        if coalesce(v_max_nivel,0) = 0 then
        	raise exception 'No se encontró saldo de ningún item';
        end if;
        
        --Obtiene el tipo de movimiento para inventario final
        select id_movimiento_tipo
        into v_id_movimiento_tipo
        from alm.tmovimiento_tipo 
        where codigo = 'INVFIN';
        
        if v_id_movimiento_tipo is null then
        	insert into alm.tmovimiento_tipo ("id_usuario_reg", "id_usuario_mod", "fecha_reg", "fecha_mod", "estado_reg", "codigo", "nombre", "tipo","read_only")
			values (1, NULL, now(), NULL, E'activo', E'INVFIN', E'Inventario Final', E'salida',true)
            returning id_movimiento_tipo into v_id_movimiento_tipo;
        end if;

        --Define los parámetros para generar el movimiento
        select
        v_id_movimiento_tipo as id_movimiento_tipo,--(p_parametros->'id_movimiento_tipo')::integer,
        v_id_almacen as id_almacen,--(p_parametros->'id_almacen')::integer,
        v_id_funcionario as id_funcionario,--v_parametros.id_funcionario, 
        NULL as id_proveedor,--v_parametros.id_proveedor,
        NULL as id_almacen_dest,--v_parametros-.id_almacen_dest,
        v_fecha_hasta as fecha_mov,--(v_parametros.fecha_mov,
        'Salida por Inventario Final gestión '||v_gestion::varchar as descripcion,--v_parametros.descripcion,
        NULL as observaciones,--(p_parametros->'observaciones')::varchar,
        NULL as id_movimiento_origen,--(p_parametros->'id_movimiento_origen')::integer
        v_id_gestion as id_gestion --id_gestion
        into v_registros;
         
        /*for i in 1..v_max_nivel loop
        	--Crea el movimiento
        	va_id_mov[i] = alm.f_insercion_movimiento(p_id_usuario,hstore(v_registros));
            --Asocia el movimiento al almacen_gestion_log
            update alm.tmovimiento set
            id_almacen_gestion_log = p_id_almacen_gestion_log
            where id_movimiento = va_id_mov[i];
        end loop;*/
        
        --Crea el movimiento
		va_id_mov[1] = alm.f_insercion_movimiento(p_id_usuario,hstore(v_registros));
        
        --Asocia el movimiento al almacen_gestion_log
        update alm.tmovimiento set
        id_almacen_gestion_log = p_id_almacen_gestion_log
        where id_movimiento = va_id_mov[1];
        
        --Guarda el detalle de los movimientos generados
        --for i in 1..v_max_nivel loop
        
        	for v_rec in (select
            			id_item, costo_unit, sum(cantidad) as cantidad
                        from tt_detalle_existencias_item
                        group by id_item,costo_unit) loop
                insert into alm.tmovimiento_det(
                    id_usuario_reg,
                    fecha_reg,
                    estado_reg,
                    id_movimiento,
                    id_item,
                    cantidad,
                    cantidad_solicitada,
                    costo_unitario,
                    fecha_caducidad,
                    observaciones,
                    id_concepto_ingas
                ) VALUES (
                    p_id_usuario,
                    now(),
                    'activo',
                    va_id_mov[1],
                    v_rec.id_item,
                    v_rec.cantidad,
                    v_rec.cantidad,
                    v_rec.costo_unit,
                    NULL,
                    NULL,
                    NULL
                ) RETURNING id_movimiento_det into v_id_movimiento_det;
                
                insert into alm.tmovimiento_det_valorado (
                    id_usuario_reg,
                    fecha_reg,
                    estado_reg,
                    id_movimiento_det,
                    cantidad,
                    costo_unitario,
                    aux_saldo_fisico
                ) VALUES (
                    p_id_usuario,
                    now(),
                    'activo',
                    v_id_movimiento_det,
                    v_rec.cantidad,
                    v_rec.costo_unit,
                    0
                );
            end loop;
        	 
        --end loop;
        
    elsif p_accion = 'reabrir' then
    	--Nada por hacer
        
    else
    	raise exception 'Acción inexistente';
    end if;
    
    return 'Hecho';

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