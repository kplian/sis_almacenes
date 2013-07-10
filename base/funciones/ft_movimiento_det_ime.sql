CREATE OR REPLACE FUNCTION alm.ft_movimiento_det_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Almacenes
 FUNCION: 		alm.ft_movimiento_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tmovimiento_det'
 AUTOR: 		Gonzalo Sarmiento
 FECHA:	        02-10-2012
 COMENTARIOS:	
***************************************************************************/

DECLARE
  v_nombre_funcion 		varchar;
  v_consulta			varchar;
  v_parametros  		record;
  v_respuesta 			varchar;
  v_id_movimiento_det	integer;
  v_tipo_movimiento		varchar;
  v_sum_ingresos		numeric;
  v_sum_salidas			numeric;
  v_existencias			numeric;
  v_id_almacen			integer;
  v_estado_mov			varchar;
  
BEGIN
  v_nombre_funcion='alm.ft_movimiento_det_ime';
  v_parametros=pxp.f_get_record(p_tabla);
  
  /*********************************    
     #TRANSACCION:  'SAL_MOVDET_INS'
     #DESCRIPCION:  Insercion de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        21-02-2013
    ***********************************/
	if(p_transaccion='SAL_MOVDET_INS') then
    begin
    	select mov.estado_mov into v_estado_mov
        from alm.tmovimiento mov
        where mov.id_movimiento = v_parametros.id_movimiento;
        
        if (v_estado_mov = 'cancelado' or v_estado_mov = 'finalizado') then
        	raise exception '%', 'No se pueden hacer modificaciones a las depencias del movimiento actual';
        end if;
    	
    	--revisar q tipo de movimiento es: ingreso o salida
    	select movtip.tipo, mov.id_almacen into v_tipo_movimiento, v_id_almacen
        from alm.tmovimiento_tipo movtip
        inner join alm.tmovimiento mov on mov.id_movimiento_tipo = movtip.id_movimiento_tipo
        where mov.id_movimiento = v_parametros.id_movimiento;
        
        --si es salida, revisas las existencias, ingresos - salidas
        /*
        if (v_tipo_movimiento = 'salida') then
        	v_existencias = alm.f_get_saldo_fisico_item(v_parametros.id_item, v_id_almacen);
            
            if (v_existencias < v_parametros.cantidad_item) then
            	raise exception '%', 'No existen suficientes unidades de este item en el almacen seleccionado';
            end if;
        end if;
        */
        
		insert into alm.tmovimiento_det(
            id_usuario_reg,
            fecha_reg,
            estado_reg,
            id_movimiento,
            id_item,
            cantidad,
            cantidad_solicitada,
            costo_unitario,
            fecha_caducidad
        ) VALUES (
            p_id_usuario,
            now(),
            'activo',
            v_parametros.id_movimiento,
            v_parametros.id_item,
            v_parametros.cantidad_item,
            coalesce(v_parametros.cantidad_solicitada,v_parametros.cantidad_item),
            v_parametros.costo_unitario,
            v_parametros.fecha_caducidad
        ) RETURNING id_movimiento_det into v_id_movimiento_det;
        
        insert into alm.tmovimiento_det_valorado (
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
            v_id_movimiento_det,
            v_parametros.cantidad_item,
            v_parametros.costo_unitario
        );
        
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Detalle de movimiento almacenado(a) con exito (id_movimiento_det'||v_id_movimiento_det||')');
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento_det',v_id_movimiento_det::varchar);
        return v_respuesta;
		
    end;
    /*********************************    
     #TRANSACCION:  'SAL_MOVDET_MOD'
     #DESCRIPCION:  Modificacion de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        21-02-2013
    ***********************************/
    elseif (p_transaccion='SAL_MOVDET_MOD') then
    begin
    	
    	select mov.estado_mov into v_estado_mov
        from alm.tmovimiento mov
        where mov.id_movimiento = v_parametros.id_movimiento;
        
        if (v_estado_mov = 'cancelado' or v_estado_mov = 'finalizado') then
        	raise exception '%', 'El detalle de movimiento actual no puede ser modificado';
        end if;
        
    	update alm.tmovimiento_det set
            id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            id_movimiento = v_parametros.id_movimiento,
            id_item = v_parametros.id_item,
            cantidad = v_parametros.cantidad_item,
            cantidad_solicitada = coalesce(v_parametros.cantidad_solicitada,v_parametros.cantidad_item),
            costo_unitario = v_parametros.costo_unitario,
            fecha_caducidad = v_parametros.fecha_caducidad
        where id_movimiento_det = v_parametros.id_movimiento_det;
        
        update alm.tmovimiento_det_valorado set
        	id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            cantidad = v_parametros.cantidad_item,
            costo_unitario = v_parametros.costo_unitario
        where id_movimiento_det = v_parametros.id_movimiento_det;
        
        v_respuesta = pxp.f_agrega_clave(v_respuesta,'mensaje','Detalle de movimiento modificado con exito');
        v_respuesta = pxp.f_agrega_clave(v_respuesta,'id_movimiento_det',v_parametros.id_movimiento_det::varchar);
            
        return v_respuesta;
    end;
    /*********************************    
     #TRANSACCION:  'SAL_MOVDET_ELI'
     #DESCRIPCION:  Eliminacion de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        21-02-2013
    ***********************************/
    elseif(p_transaccion='SAL_MOVDET_ELI')then
    begin
    	
    	select mov.estado_mov into v_estado_mov
        from alm.tmovimiento mov
        inner join alm.tmovimiento_det movdet on movdet.id_movimiento = mov.id_movimiento
        where movdet.id_movimiento_det = v_parametros.id_movimiento_det;
        
        if (v_estado_mov = 'cancelado' or v_estado_mov = 'finalizado') then
        	raise exception '%', 'El detalle de movimiento actual no puede ser eliminado';
        end if;
        
        delete from alm.tmovimiento_det_valorado detval
        where detval.id_movimiento_det = v_parametros.id_movimiento_det;
        
    	delete from alm.tmovimiento_det
        where id_movimiento_det = v_parametros.id_movimiento_det;
            
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Detalle de movimiento eliminado correctamente');
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento_det',v_parametros.id_movimiento_det::varchar);
           
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
