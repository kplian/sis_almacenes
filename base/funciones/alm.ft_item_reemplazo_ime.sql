CREATE OR REPLACE FUNCTION alm.ft_item_reemplazo_ime (
    p_administrador integer,
    p_id_usuario integer,
    p_tabla varchar,
    p_transaccion varchar
)
RETURNS varchar AS
$body$
/*************************************************************
SISTEMA:            Almacenes
FUNCION:            alm.ft_item_reemplazo_ime
DESCRIPCION:        Función que gestiona las operaciones básicas (inserciones, modificaciones, eliminaciones) de la tabla 'alm.item'
AUTOR:              Ariel Ayaviri Omonte
FECHA:              06/02/2013
COMENTARIOS:
*************************************************************
HISTORIAL DE MODIFICACIONES:
DESCRIPCION:
AUTOR:
FECHA:
*************************************************************/
DECLARE
    v_nro_requerimiento integer;
    v_parametros        record;
    v_resp              varchar;
    v_nombre_funcion    text;
    v_mensaje_error     text;
    v_id_item_reemplazo integer;
BEGIN
    v_nombre_funcion = 'alm.ft_item_reemplazo_ime';
    v_parametros = pxp.f_get_record(p_tabla);
    /*********************************
    #TRANSACCIÓN:   'SAL_ITMREE_INS'
    #DESCRIPCIÓN:   Inserción de registros
    #AUTOR:         Ariel Ayaviri Omonte
    #FECHA:         06/02/2013
    *********************************/
    IF(p_transaccion='SAL_ITMREE_INS')THEN
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
            --Definición de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Item de reemplazo almacenado con exito (id_item_reemplazo' || v_id_item_reemplazo || ')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_item_reemplazo',v_id_item_reemplazo::varchar);
            --Devuelve la respuesta
            return v_resp;
        end;
    /*********************************
    #TRANSACCIÓN:   'SAL_ITMREE_MOD'
    #DESCRIPCIÓN:   Modificación de registros
    #AUTOR:         Ariel Ayaviri Omonte
    #FECHA:         06/02/2013
    *********************************/
    elsif(p_transaccion='SAL_ITMREE_MOD')THEN
        begin
            update alm.titem_reemplazo set
                id_usuario_mod = p_id_usuario,
                fecha_mod = now(),
                id_item = v_parametros.id_item,
                id_item_r = v_parametros.id_item_r
            where id_item_reemplazo = v_parametros.id_item_reemplazo;
            --Definición de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Item de reemplazo modificado');
            v_resp = pxp.f_agrega_clave(v_resp,'id_item_reemplazo',v_parametros.id_item_reemplazo::varchar);
            --Devuelve la respuesta
            return v_resp;
        end;
    /*********************************
    #TRANSACCIÓN:   'SAL_ITMREE_ELI'
    #DESCRIPCIÓN:   Modificación de registros
    #AUTOR:         Ariel Ayaviri Omonte
    #FECHA:         06/02/2013
    *********************************/
    elsif(p_transaccion='SAL_ITMREE_ELI')THEN
        begin
            delete from alm.titem_reemplazo
            where id_item_reemplazo = v_parametros.id_item_reemplazo;
            --Definición de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Item de reemplazo eliminado');
            v_resp = pxp.f_agrega_clave(v_resp,'id_item_reemplazo',v_parametros.id_item_reemplazo::varchar);
            --Devuelve la respuesta
            return v_resp;
        end;
    else
        raise exception 'Transacción inexistente: %', p_transaccion;
    end if;
EXCEPTION
    WHEN OTHERS THEN
        v_resp = '';
        v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
        v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
        v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
        raise exception '%', v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;