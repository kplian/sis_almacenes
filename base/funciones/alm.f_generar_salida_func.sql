CREATE OR REPLACE FUNCTION alm.f_generar_salida_func (
  p_id_usuario integer,
  p_id_salida_grupo integer
)
RETURNS varchar AS
$body$
/*
Autor: RCM
Fecha: 17/10/2013
Descripción: Función que genera salidas para cada funcionario a partir de una salida grupal
*/
DECLARE

	v_rec record;
    v_rec_cab record;
    v_registros record;
    v_rec_det record;
    v_id_movimiento_tipo integer;
    v_id_gestion integer;
    v_id_movimiento integer;    
	v_id_movimiento_det integer;    

BEGIN

	--Verificación de existencia
	if not exists(select 1 from alm.tsalida_grupo
                where id_salida_grupo = p_id_salida_grupo) then
        raise exception 'Solicitud no encontrada';
    end if;
        
    --Verificación del estado
    if not exists(select 1 from alm.tsalida_grupo
                where id_salida_grupo = p_id_salida_grupo
                and estado = 'borrador') then
        raise exception 'La Solicitud debe estar en estado Borrador';
    end if;
    
    --Obtiene el movimiento tipo de Salida grupal
    select id_movimiento_tipo
    into v_id_movimiento_tipo
    from alm.tmovimiento_tipo a
    where a.codigo = 'SALGRU';
    
    if v_id_movimiento_tipo is null then
    	raise exception 'No se pueden generar las salidas porque no está definido su tipo de movimiento';
    end if;

    --Obtiene datos de la cabecera de la solicitud
    select 
    sgru.descripcion, sgru.fecha, sgru.id_almacen, sgru.observaciones
    into v_rec_cab
    from alm.tsalida_grupo sgru
    where sgru.id_salida_grupo = p_id_salida_grupo;
    
    --Obtiene la gestión actual
    select ges.id_gestion
    into v_id_gestion
    from param.tgestion ges
    where ges.gestion = to_char(v_rec_cab.fecha,'yyyy')::integer
    limit 1 offset 0;
                
    if v_id_gestion is null then
      raise exception 'No se tiene una gestion configurada para la fecha %',v_rec_cab.fecha; 
    end if;
    
    
    --Recorre todos los funcionarios distintos para generar una salida por cada funcionario
    for v_rec in (select distinct gfun.id_funcionario
    			from alm.tsalida_grupo_item git
                inner join alm.tsalida_grupo_fun gfun on gfun.id_salida_grupo_item = git.id_salida_grupo_item
                where git.id_salida_grupo = p_id_salida_grupo) loop
    	--Genera la cabecera de la salida
        select
        v_id_movimiento_tipo as id_movimiento_tipo,
        v_rec_cab.id_almacen as id_almacen,
        v_rec.id_funcionario as id_funcionario, 
        null,
        null,
        v_rec_cab.fecha as fecha_mov,
        v_rec_cab.descripcion as descripcion,
        v_rec_cab.observaciones as observaciones,
        null,
        v_id_gestion as id_gestion
        into v_registros;
        
        --Llama a la función de registro del movimiento
        v_id_movimiento = alm.f_insercion_movimiento(p_id_usuario,hstore(v_registros));
        
        --Genera el detalle
        for v_rec_det in (select 
                          git.id_item,
                          gfun.cantidad_sol,
                          coalesce(gfun.observaciones,git.observaciones) as observaciones
                          from alm.tsalida_grupo_item git
                          inner join alm.tsalida_grupo_fun gfun
                          on gfun.id_salida_grupo_item = git.id_salida_grupo_item
                          where git.id_salida_grupo = p_id_salida_grupo
                          and gfun.id_funcionario = v_rec.id_funcionario) loop
            insert into alm.tmovimiento_det(
                id_usuario_reg,
                fecha_reg,
                estado_reg,
                id_movimiento,
                id_item,
                cantidad,
                cantidad_solicitada,
                observaciones
            ) values (
                p_id_usuario,
                now(),
                'activo',
                v_id_movimiento,
                v_rec_det.id_item,
                v_rec_det.cantidad_sol,
                v_rec_det.cantidad_sol,
                v_rec_det.observaciones
            ) returning id_movimiento_det into v_id_movimiento_det;
    	                    
            insert into alm.tmovimiento_det_valorado (
                id_usuario_reg,
                fecha_reg,
                estado_reg,
                id_movimiento_det,
                cantidad
            ) values (
                p_id_usuario,
                now(),
                'activo',
                v_id_movimiento_det,
                v_rec_det.cantidad_sol
            );
        end loop;

        --Actualiza el id_salida_grupo
        update alm.tmovimiento set
        id_salida_grupo = p_id_salida_grupo
        where id_movimiento = v_id_movimiento;
        
    end loop;
    
    --Respuesta
    return 'Salidas generadas';
  
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;