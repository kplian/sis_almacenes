--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.ft_metodo_val_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_metodo_val_ime
 DESCRIPCION:    Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones) de la tabla 'alm.tmovimiento'
 AUTOR:          Ariel Ayaviri Omonte
 FECHA:          14-02-2013
 COMENTARIOS:   
************************************************************************/
DECLARE
  v_nombre_funcion 				varchar;  
  v_parametros					record;
  v_id_metodo_val				integer;
  v_respuesta					varchar;
  v_consulta					varchar;
  v_detalle						record;
  v_num_mov						varchar;

BEGIN
  v_nombre_funcion='alm.ft_metodo_val_ime';
  v_parametros=pxp.f_get_record(p_tabla);
  
  
  /*********************************   
     #TRANSACCION:  'SAL_MEVAL_INS'
     #DESCRIPCION:  Insercion de datos
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        14-02-2013
    ***********************************/
  if(p_transaccion='SAL_MEVAL_INS')then
  	begin
    
		insert into alm.tmetodo_val (
        	id_usuario_reg,
            fecha_reg,
            estado_reg,
            codigo,
            nombre,
            descripcion
        ) values (
        	p_id_usuario,
            now(),
            'activo', 
            v_parametros.codigo,
            v_parametros.nombre,
            v_parametros.descripcion
        ) RETURNING id_metodo_val into v_id_metodo_val;

        v_respuesta =pxp.f_agrega_clave(v_respuesta, 'mensaje','Método de valoracion almacenado correctamente');
        v_respuesta =pxp.f_agrega_clave(v_respuesta, 'id_metodo_val', v_id_metodo_val::varchar);

        return v_respuesta;
    end;
  /*********************************   
     #TRANSACCION:  'SAL_MEVAL_MOD'
     #DESCRIPCION:  Modificacion de datos
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        14-02-2013
    ***********************************/    	 
        		
	elseif(p_transaccion='SAL_MEVAL_MOD')then
	begin
    	update alm.tmetodo_val set
        	id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            codigo = v_parametros.codigo,
            nombre = v_parametros.nombre,
            descripcion = v_parametros.descripcion
        where id_metodo_val = v_parametros.id_metodo_val;
        
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento Tipo modificado con exito');
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_metodo_val', v_parametros.id_metodo_val::varchar);
        return v_respuesta;
    end;
  /*********************************
     #TRANSACCION:  'SAL_MEVAL_ELI'
     #DESCRIPCION:  Eliminacion de datos
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        14-02-2013
    ***********************************/
	elseif(p_transaccion='SAL_MEVAL_ELI')then
  	begin
    	delete from alm.tmetodo_val
        where id_metodo_val = v_parametros.id_metodo_val;

        v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje','Movimiento Tipo eliminado');
        v_respuesta=pxp.f_agrega_clave(v_respuesta,'id_metodo_val', v_parametros.id_metodo_val::varchar);

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