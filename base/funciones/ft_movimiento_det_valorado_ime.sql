--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.ft_movimiento_det_valorado_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Almacenes
 FUNCION: 		alm.ft_movimiento_det_valorado_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tmovimiento_det'
 AUTOR: 		Ariel Ayaviri Omonte
 FECHA:	        21-02-2013
 COMENTARIOS:	
***************************************************************************/

DECLARE
  v_nombre_funcion 		varchar;
  v_consulta			varchar;
  v_parametros  		record;
  v_respuesta 			varchar;
  v_id_movimiento_det_valorado	integer;
  v_tipo_movimiento		varchar;
  v_sum_ingresos		numeric;
  v_sum_salidas			numeric;
  v_existencias			numeric;
  v_id_almacen			integer;
  v_estado_mov			varchar;
  v_id_item				integer;
  
BEGIN
  v_nombre_funcion='alm.ft_movimiento_det_valorado_ime';
  v_parametros=pxp.f_get_record(p_tabla);
  /*********************************    
     #TRANSACCION:  'SAL_DETVAL_INS'
     #DESCRIPCION:  Insercion de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        21-02-2013
    ***********************************/
	if(p_transaccion='SAL_DETVAL_INS') then
    begin
    	
        insert into alm.tmovimiento_det_valorado(
            id_usuario_reg,
            fecha_reg,
            estado_reg,
            id_movimiento_det,
            cantidad,
            costo_unitario
        ) VALUES (
            p_id_usuario,
            now(),
            'activo',
            v_parametros.id_movimiento,
            v_parametros.cantidad_item,
            v_parametros.costo_unitario
        ) RETURNING id_movimiento_det_valorado into v_id_movimiento_det_valorado;
              				
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Valorado del Detalle de movimiento almacenado(a) con exito (id_movimiento_det'||v_id_movimiento_det||')');
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento_det',v_id_movimiento_det_valorado::varchar);
        return v_respuesta;
		
    end;
    /*********************************    
     #TRANSACCION:  'SAL_DETVAL_MOD'
     #DESCRIPCION:  Modificacion de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        21-02-2013
    ***********************************/
    elseif (p_transaccion='SAL_DETVAL_MOD') then
    begin
    	
    	select mov.estado_mov into v_estado_mov
        from alm.tmovimiento mov
        inner join alm.tmovimiento_det movdet on movdet.id_movimiento = mov.id_movimiento
        where movdet.id_movimiento_det = v_parametros.id_movimiento_det;
        
        if (v_estado_mov = 'cancelado' or v_estado_mov = 'finalizado') then
        	raise exception '%', 'El Valorado del detalle de movimiento actual no puede ser modificado';
        end if;
        
    	update alm.tmovimiento_det_valorado set
            id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            id_movimiento = v_parametros.id_movimiento,
            id_item = v_parametros.id_item,
            cantidad = v_parametros.cantidad_item,
            costo_unitario = v_parametros.costo_unitario,
            fecha_caducidad = v_parametros.fecha_caducidad
        where id_movimiento_det = v_parametros.id_movimiento_det;
        
        v_respuesta = pxp.f_agrega_clave(v_respuesta,'mensaje','Valorador del Detalle de movimiento modificado con exito');
        v_respuesta = pxp.f_agrega_clave(v_respuesta,'id_movimiento_det',v_parametros.id_movimiento_det_valorado::varchar);
            
        return v_respuesta;
    end;
    /*********************************    
     #TRANSACCION:  'SAL_DETVAL_ELI'
     #DESCRIPCION:  Eliminacion de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        21-02-2013
    ***********************************/
    elseif(p_transaccion='SAL_DETVAL_ELI')then
    begin
    	
    	select mov.estado_mov into v_estado_mov
        from alm.tmovimiento mov
        inner join alm.tmovimiento_det movdet on movdet.id_movimiento = mov.id_movimiento
        inner join alm.tmovimiento_det_valorado on detval.id_movimiento_det = movdet.id_movimiento_det
        where detval.id_movimiento_det_valorado = v_parametros.id_movimiento_det_valorado;
        
        if (v_estado_mov = 'cancelado' or v_estado_mov = 'finalizado') then
        	raise exception '%', 'El valorado del detalle de movimiento actual no puede ser eliminado';
        end if;
        
    	delete from alm.tmovimiento_det_valorado
        where id_movimiento_det_valorado = v_parametros.id_movimiento_det_valorado;
            
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Valorado del Detalle de movimiento eliminado correctamente');
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento_det',v_parametros.id_movimiento_det_valorado::varchar);
           
    	return v_respuesta;
    end;
    else 
    	raise exception 'Transaccion inexistente';
    end if;
EXCEPTION

	WHEN OTHERS THEN
		v_respuesta='';
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje',SQLERRM);
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'codigo_error',SQLSTATE);
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'procedimiento',v_nombre_funcion);
        raise exception '%',v_respuesta;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;