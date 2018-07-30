--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.ft_item_reemplazo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_item_reemplazo_ime
 DESCRIPCION:    Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones) de la tabla 'alm.titem'
 AUTOR:          Ariel Ayaviri Omonte
 FECHA:          06-02-2013
 COMENTARIOS:   
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:   
 AUTOR:           
 FECHA:       
***************************************************************************/

DECLARE

    v_nro_requerimiento        integer;
    v_parametros               record;
    v_resp                    varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_item_reemplazo		integer;
               
BEGIN

    v_nombre_funcion = 'alm.ft_item_reemplazo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************   
     #TRANSACCION:  'SAL_ITMREE_INS'
     #DESCRIPCION:  Insercion de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        06-02-2013
    ***********************************/

    if(p_transaccion='SAL_ITMREE_INS')then
                   
        begin
            insert into alm.titem_reemplazo(
            	id_usuario_reg,
                fecha_reg,
                estado_reg,
                id_item,
                id_item_r
            ) values (
                p_id_usuario,
                now(),
                'activo',
                v_parametros.id_item,
                v_parametros.id_item_r
            ) RETURNING id_item_reemplazo into v_id_item_reemplazo;
              
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Item de reemplazo almacenado(a) con exito (id_item_reemplazo'||v_id_item_reemplazo||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_item_reemplazo',v_id_item_reemplazo::varchar);

            --Devuelve la respuesta
            return v_resp;
        end;

    /*********************************   
     #TRANSACCION:  'SAL_ITMREE_MOD'
     #DESCRIPCION:  Modificacion de registros
     #AUTOR:        Ariel Ayaviri Omonte 
     #FECHA:        06-02-2013
    ***********************************/

    elsif(p_transaccion='SAL_ITMREE_MOD')then

        begin
        	update alm.titem_reemplazo set
            	id_usuario_mod = p_id_usuario,
                fecha_mod = now(),
                id_item = v_parametros.id_item,
                id_item_r = v_parametros.id_item_r
            where id_item_reemplazo = v_parametros.id_item_reemplazo;
              
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Item de reemplazo modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_item_reemplazo',v_parametros.id_item_reemplazo::VARCHAR);
              
            --Devuelve la respuesta
            return v_resp;
        end;

    /*********************************   
     #TRANSACCION:  'SAL_ITMREE_ELI'
     #DESCRIPCION:  Eliminacion de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        06-02-2013
    ***********************************/

    elsif(p_transaccion='SAL_ITMREE_ELI')then

        begin
            delete from alm.titem_reemplazo
            where id_item_reemplazo = v_parametros.id_item_reemplazo;
              
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Item de reemplazo eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_item_reemplazo',v_parametros.id_item_reemplazo::varchar);
             
            --Devuelve la respuesta
            return v_resp;

        end;
        
    else
        raise exception 'Transaccion inexistente: %',p_transaccion;
    end if;

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