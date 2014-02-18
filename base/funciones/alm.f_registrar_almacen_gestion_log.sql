CREATE OR REPLACE FUNCTION alm.f_registrar_almacen_gestion_log (
  p_id_usuario integer,
  p_id_almacen_gestion integer,
  p_accion varchar
)
RETURNS varchar AS
$body$
/*
Autor: RCM
Fecha: 31/12/2013
Descripción: Función que genera el registro del log de la gestión de almacén en función
de la acción determinada (abrir, cerrar)

Nota: Solo para la acción: reabrir, no se genera ningún movimiento, solamente elimina los invnetarios finales si es que no estan finalizados
*/
DECLARE

	v_resp		            varchar;
	v_nombre_funcion        text;
    v_estado				varchar;
    v_id_movimiento			integer;
    v_id_almacen_gestion_log integer;
    v_gestion				integer;
    v_id_almacen			integer;
    v_ids_ing				text;
    v_ids_sal				text;
    v_ids_ing_cont			bigint;
    v_ids_sal_cont			bigint;
    v_ids					text;
    v_bool_prim_gest		boolean;
    v_res_mov				varchar;
    v_id_gestion_ant		integer;
    v_id_almacen_gestion_ant integer;

BEGIN

	v_nombre_funcion = 'alm.f_registrar_almacen_gestion_log';
	v_resp='';  
    v_bool_prim_gest=false;  
    
	----------------------------------------
	--(1)DEFINICION DE ACCION Y VALIDACIONES
    ----------------------------------------
    --Obtención de la gestión
    select gest.gestion, almges.id_almacen
    into v_gestion, v_id_almacen
    from alm.talmacen_gestion almges
    inner join param.tgestion gest
    on gest.id_gestion = almges.id_gestion
    where id_almacen_gestion = p_id_almacen_gestion;
    
    if p_accion in ('abrir','reabrir') then
    	--Define la acción
    	v_estado='abierto';
        
        if p_accion = 'reabrir' then
        
        	--Verifica si ya existe una nueva gestión creada
            if exists(select 1
                    from param.tgestion ges
                    inner join alm.talmacen_gestion ages
                    on ages.id_gestion = ges.id_gestion
                    inner join alm.talmacen_gestion_log agesl
                    on agesl.id_almacen_gestion = ages.id_almacen_gestion
                    where ges.gestion = v_gestion+1) then
				raise exception 'No se puede reabrir la gestión % porque ya existe una nueva gestión creada(%). Si no tiene movimientos en esta nueva gestión, trate de eliminarla y vuelva a intentar para reabrir el %',v_gestion, v_gestion+1,v_gestion;
            end if;
            
            --Verifica que los inventarios finales del almacen gestión no estén finalizados
            if exists(select 1 from alm.talmacen_gestion ages
            		inner join alm.talmacen_gestion_log alog
                    on alog.id_almacen_gestion = ages.id_almacen_gestion
                    and alog.estado_reg = 'activo'
                    and alog.estado = 'cerrado'
                    inner join alm.tmovimiento mov
                    on mov.id_almacen_gestion_log = alog.id_almacen_gestion_log
            		where ages.id_almacen_gestion = p_id_almacen_gestion
                    and mov.estado_mov = 'finalizado') then
				raise exception 'La gestión % no puede ser reabierta porque su(s) Inventario(s) Final(es) ya fueron finalizados',v_gestion;
            end if;
            
            --Elimina los inventarios finales creados
            --Obtiene el log actual
            select id_almacen_gestion_log
            into v_id_almacen_gestion_log
            from alm.talmacen_gestion_log
            where id_almacen_gestion = p_id_almacen_gestion
            and estado_reg = 'activo'
            and estado = 'cerrado';
            
            delete from alm.tmovimiento
            where id_almacen_gestion_log = v_id_almacen_gestion_log;
        
        end if;
        
        --Encontrar la gestión anterior y verificar que la gestión anterior esté cerrada
        if exists (select 1
                    from param.tgestion ges
                    inner join alm.talmacen_gestion ages
                    on ages.id_gestion = ges.id_gestion
                    where ges.gestion = v_gestion-1) then
                    
        	if not exists(select 1
                    from param.tgestion ges
                    inner join alm.talmacen_gestion ages
                    on ages.id_gestion = ges.id_gestion
                    and ages.estado = 'cerrado'
                    where ges.gestion = v_gestion-1) then
                raise exception 'No se puede abrir la gestión % porque la % no está cerrada',v_gestion,v_gestion-1;
            end if;
            
            --Generar el (los) inventarios iniciales a partir de los finales de la anterior gestión
            select ges.id_gestion, ages.id_almacen_gestion
            into v_id_gestion_ant, v_id_almacen_gestion_ant
            from param.tgestion ges
            inner join alm.talmacen_gestion ages
            on ages.id_gestion = ges.id_gestion
            where ges.gestion = v_gestion-1;

            --Verificar que las salida(s) del cierre de la gestión anterior están finalizados
            if exists(select 1 from alm.talmacen_gestion_log alog
                        inner join alm.tmovimiento mov
                        on mov.id_almacen_gestion_log = alog.id_almacen_gestion_log
                        and mov.estado_mov != 'finalizado'
                        where alog.id_almacen_gestion = v_id_almacen_gestion_ant
                        and alog.estado_reg = 'activo') then
            
                select pxp.list(mov.id_movimiento::varchar)
                into v_ids
                from alm.talmacen_gestion_log alog
                inner join alm.tmovimiento mov
                on mov.id_almacen_gestion_log = alog.id_almacen_gestion_log
                and mov.estado_mov != 'finalizado'
                where alog.id_almacen_gestion = v_id_almacen_gestion_ant
                and alog.estado_reg = 'activo';
                
                v_resp = pxp.f_agrega_clave(v_resp,'mensaje','No se puede abrir la gestión porque las Salidas por Inventario Final de la gestión anterior no han sido Finalizadas'); 
                v_resp = pxp.f_agrega_clave(v_resp,'mensaje_vista','No se puede abrir la gestión porque las Salidas por Inventario Final de la gestión anterior no han sido Finalizadas'); 
                v_resp = pxp.f_agrega_clave(v_resp,'ids',v_ids);  
                v_resp = pxp.f_agrega_clave(v_resp,'error_logico','si'::varchar);
            
            end if;
        else
            v_bool_prim_gest=true;         
        end if;
        
    elsif p_accion = 'cerrar' then
    	--Define la acción
    	v_estado='cerrado';
        
        --Validación de existencia de ingresos pendientes de finalización
        select
        count(mov.id_movimiento)
        into v_ids_ing_cont
        from alm.tmovimiento mov
        inner join alm.tmovimiento_tipo mtip
        on mtip.id_movimiento_tipo = mov.id_movimiento_tipo
        where mov.id_almacen = v_id_almacen
        and mov.estado_mov not in ('finalizado','cancelado')
        and mtip.tipo = 'ingreso'
        and to_char(mov.fecha_mov,'yyyy') = v_gestion::varchar;
        
        if v_ids_ing_cont > 0 then
        	select
            pxp.list(mov.id_movimiento::varchar) as ids
            into v_ids_ing
            from alm.tmovimiento mov
            inner join alm.tmovimiento_tipo mtip
            on mtip.id_movimiento_tipo = mov.id_movimiento_tipo
            where mov.id_almacen = v_id_almacen
            and mov.estado_mov not in ('finalizado','cancelado')
            and mtip.tipo = 'ingreso'
            and to_char(mov.fecha_mov,'yyyy') = v_gestion::varchar;	
        end if;
        
        --Validación de existencia de salidas pendientes de finalización
        select
        count(mov.id_movimiento)
        into v_ids_sal_cont
        from alm.tmovimiento mov
        inner join alm.tmovimiento_tipo mtip
        on mtip.id_movimiento_tipo = mov.id_movimiento_tipo
        where mov.id_almacen = v_id_almacen
        and mov.estado_mov not in ('finalizado','cancelado')
        and mtip.tipo = 'salida'
        and to_char(mov.fecha_mov,'yyyy') = v_gestion::varchar;
        
        if v_ids_sal_cont > 0 then
        	select
            pxp.list(mov.id_movimiento::varchar) as ids
            into v_ids_sal
            from alm.tmovimiento mov
            inner join alm.tmovimiento_tipo mtip
            on mtip.id_movimiento_tipo = mov.id_movimiento_tipo
            where mov.id_almacen = v_id_almacen
            and mov.estado_mov not in ('finalizado','cancelado')
            and mtip.tipo = 'salida'
            and to_char(mov.fecha_mov,'yyyy') = v_gestion::varchar;	
        end if;
		
        --Prepara la salida si es que se encuentran movimientos sin finalizar
        if v_ids_ing_cont > 0 or v_ids_sal_cont > 0 then
        
        	if v_ids_ing_cont > 0 and v_ids_sal_cont > 0 then
            	v_ids = v_ids_ing ||','||v_ids_sal;
            elsif v_ids_ing_cont > 0  then
            	v_ids = v_ids_ing;
            elsif v_ids_sal_cont > 0  then
            	v_ids = v_ids_sal;
            end if;
            
            --habilitar para controlar movimientos pendientes
           	v_resp = pxp.f_agrega_clave(v_resp,'mensaje','No se pudo '||upper(p_Accion)||' el Almacén, aún existen ('||v_ids_ing_cont||')Ingresos y ('||v_ids_sal_cont||')Salidas pendientes. Finalice o anule los movimientos pendientes para realizar la acción.');
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje_vista','No se pudo '||upper(p_Accion)||' el Almacén, aún existen ('||v_ids_ing_cont||')Ingresos y ('||v_ids_sal_cont||')Salidas pendientes. Finalice o anule los movimientos pendientes para realizar la acción.');
            v_resp = pxp.f_agrega_clave(v_resp,'total_mov',(v_ids_ing_cont+v_ids_sal_cont)::varchar); 
            v_resp = pxp.f_agrega_clave(v_resp,'cant_ing',v_ids_ing_cont::varchar); 
            v_resp = pxp.f_agrega_clave(v_resp,'cant_sal',v_ids_sal_cont::varchar); 
            v_resp = pxp.f_agrega_clave(v_resp,'ids',v_ids::varchar); 
            v_resp = pxp.f_agrega_clave(v_resp,'error_logico','si'::varchar);

        else
			v_resp = '';
        end if;
    else
    	raise exception 'Acción inexistente';
    end if;
    
    -------------------
    --FIN VALIDACIONES
    -------------------
    
    
    -------------
    --ACCIONES
    -------------
    
    --Si no hay errores en las validaciones continúa con el proceso
    if v_resp = '' or v_bool_prim_gest then
    
        --------------------------------------------------------------
        --(2)INSERCIÓN DEL REGISTRO EN EL LOG DE GESTION DE ALMACENES
        --------------------------------------------------------------
        --Inactivación de todos los registros anteriores del log dependiendo de la acción
        update alm.talmacen_gestion_log set
        estado_reg = 'inactivo'
        where id_almacen_gestion = p_id_almacen_gestion
        and estado = v_estado;
        
        --Registro del log
        insert into alm.talmacen_gestion_log(
          id_usuario_reg,
          id_usuario_mod,
          fecha_reg,
          fecha_mod,
          estado_reg,
          id_almacen_gestion,
          estado
        ) VALUES (
          p_id_usuario,
          NULL,
          now(),
          NULL,
          'activo',
          p_id_almacen_gestion,
          v_estado
        ) returning id_almacen_gestion_log into v_id_almacen_gestion_log;
        
        -----------------------------------------------------------------------------------    
        --(3)GENERACIÓN DE MOVIMIENTOS (ingreso: inventario inicial, salida: inventario final
        -----------------------------------------------------------------------------------
        v_res_mov = alm.f_generar_mov_gestion(p_id_usuario,v_id_almacen_gestion_log,p_accion);
        
        --------------------------------
        --(4)GENERACIÓN DE COMPROBANTES
        --------------------------------
        
        ---------------------------------------------
        --(5)ACTUALIZACIÓN DE LA GESTIÓN DEL ALMACÉN
        ---------------------------------------------
        update alm.talmacen_gestion set
        estado = v_estado,
        id_usuario_mod = p_id_usuario,
        fecha_mod = now()
        where id_almacen_gestion = p_id_almacen_gestion;

	end if;
    
    --Respuesta
    return v_resp;
    
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