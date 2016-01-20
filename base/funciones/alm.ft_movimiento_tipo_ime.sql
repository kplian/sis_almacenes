--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.ft_movimiento_tipo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_movimiento_tipo_ime
 DESCRIPCION:    Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones) de la tabla 'alm.tmovimiento'
 AUTOR:          Gonzalo Sarmiento
 FECHA:          03-10-2012
 COMENTARIOS:   
************************************************************************/
DECLARE
  v_nombre_funcion 				varchar;  
  v_parametros					record;
  v_id_movimiento_tipo			integer;
  v_respuesta					varchar;
  v_consulta					varchar;
  v_detalle						record;
  v_num_mov						varchar;

BEGIN
  v_nombre_funcion='alm.ft_movimiento_tipo_ime';
  v_parametros=pxp.f_get_record(p_tabla);
  
  
  /*********************************   
     #TRANSACCION:  'SAL_MOVTIP_INS'
     #DESCRIPCION:  Insercion de datos
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        13-02-2013
    ***********************************/
  if(p_transaccion='SAL_MOVTIP_INS')then
  	begin
    
		insert into alm.tmovimiento_tipo (
        	id_usuario_reg,
            fecha_reg,
            estado_reg,
            codigo,
            nombre,
            tipo,
            id_proceso_macro
        ) values (
        	p_id_usuario,
            now(),
            'activo', 
            v_parametros.codigo,
            v_parametros.nombre,
            v_parametros.tipo,
            v_parametros.id_proceso_macro
        ) RETURNING id_movimiento_tipo into v_id_movimiento_tipo;

        v_respuesta =pxp.f_agrega_clave(v_respuesta, 'mensaje','Movimiento tipo almacenado correctamente');
        v_respuesta =pxp.f_agrega_clave(v_respuesta, 'id_movimiento_tipo', v_id_movimiento_tipo::varchar);

        return v_respuesta;
    end;
  /*********************************   
     #TRANSACCION:  'SAL_MOVTIP_MOD'
     #DESCRIPCION:  Modificacion de datos
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        13-02-2013
    ***********************************/    	 
        		
	elseif(p_transaccion='SAL_MOVTIP_MOD')then
	begin
    	update alm.tmovimiento_tipo set
        	id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            codigo = v_parametros.codigo,
            nombre = v_parametros.nombre,
            tipo = v_parametros.tipo,
            id_proceso_macro = v_parametros.id_proceso_macro
        where id_movimiento_tipo = v_parametros.id_movimiento_tipo;
        
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento Tipo modificado con exito');
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento_tipo', v_parametros.id_movimiento_tipo::varchar);
        return v_respuesta;
    end;
  /*********************************
     #TRANSACCION:  'SAL_MOVTIP_ELI'
     #DESCRIPCION:  Eliminacion de datos
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        13-02-2013
    ***********************************/
	elseif(p_transaccion='SAL_MOVTIP_ELI')then
  	begin
    	delete from alm.tmovimiento_tipo
        where id_movimiento_tipo = v_parametros.id_movimiento_tipo;

        v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento Tipo eliminado');
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_movimiento_tipo', v_parametros.id_movimiento_tipo::varchar);

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