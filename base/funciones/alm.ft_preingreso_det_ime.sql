CREATE OR REPLACE FUNCTION alm.ft_preingreso_det_ime (
    p_administrador integer,
    p_id_usuario integer,
    p_tabla varchar,
    p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   Sistema de Almacenes
 FUNCION:     alm.ft_preingreso_det_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tpreingreso_det'
 AUTOR:      (admin)
 FECHA:         07-10-2013 17:46:04
 COMENTARIOS:
***************************************************************************
 ISSUE      SIS     EMPRESA  FECHA        AUTOR       DESCRIPCION
 #ETR-4195  KAF     ETR      09/06/2021   RCM         Actualización de bandera 'generado' para no incluirlo posteriormente para altas parciales
***************************************************************************
* /

DECLARE

    v_nro_requerimiento     integer;
    v_parametros            record;
    v_id_requerimiento      integer;
    v_resp                  varchar;
    v_nombre_funcion        text;
    v_mensaje_error         text;
    v_id_preingreso_det     integer;
    v_id_item_clasif_ingas  integer;
    v_id_concepto_ingas     integer;
    v_result                varchar;
    v_i                     integer;

BEGIN

    v_nombre_funcion = 'alm.ft_preingreso_det_ime';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************
    #TRANSACCION:  'SAL_PREDET_INS'
    #DESCRIPCION: Insercion de registros
    #AUTOR:   admin
    #FECHA:   07-10-2013 17:46:04
    ***********************************/

    if(p_transaccion='SAL_PREDET_INS')then

        begin
            --Sentencia de la insercion
            insert into alm.tpreingreso_det(
            estado_reg,
            id_preingreso,
            id_cotizacion_det,
            id_item,
            id_almacen,
            cantidad_det,
            precio_compra,
            id_depto,
            id_clasificacion,
            sw_generar,
            observaciones,
            id_usuario_reg,
            fecha_reg,
            id_usuario_mod,
            fecha_mod,
            nombre,
            descripcion,
            precio_compra_87,
            id_lugar,
            ubicacion,
            c31,
            fecha_conformidad,
            fecha_compra,
            id_centro_costo,
            id_ubicacion,
            id_grupo,
            id_grupo_clasif,
            nro_serie,
            marca,
            vida_util
            ) values(
            'activo',
            v_parametros.id_preingreso,
            v_parametros.id_cotizacion_det,
            v_parametros.id_item,
            v_parametros.id_almacen,
            v_parametros.cantidad_det,
            v_parametros.precio_compra,
            v_parametros.id_depto,
            v_parametros.id_clasificacion,
            v_parametros.sw_generar,
            v_parametros.observaciones,
            p_id_usuario,
            now(),
            null,
            null,
            v_parametros.nombre,
            v_parametros.descripcion,
            v_parametros.precio_compra_87,
            v_parametros.id_lugar,
            v_parametros.ubicacion,
            v_parametros.c31,
            v_parametros.fecha_conformidad,
            v_parametros.fecha_compra,
            v_parametros.id_centro_costo,
            v_parametros.id_ubicacion,
            v_parametros.id_grupo,
            v_parametros.id_grupo_clasif,
            v_parametros.nro_serie,
            v_parametros.marca,
            v_parametros.vida_util
            )RETURNING id_preingreso_det into v_id_preingreso_det;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle Preingreso almacenado(a) con exito (id_preingreso_det'||v_id_preingreso_det||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_preingreso_det',v_id_preingreso_det::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************
    #TRANSACCION:  'SAL_PREDET_MOD'
    #DESCRIPCION: Modificacion de registros
    #AUTOR:   admin
    #FECHA:   07-10-2013 17:46:04
    ***********************************/

    elsif(p_transaccion='SAL_PREDET_MOD')then

        begin

            --Inicio #ETR-4195
            IF EXISTS (SELECT 1
                    FROM alm.tpreingreso_det
                    WHERE id_preingreso_det = v_parametros.id_preingreso_det
                    AND generado = 'si') THEN
                RAISE EXCEPTION 'Este registro ya fue activado/ingresado y no es posible modificarlo';
            END IF;
            --Fin #ETR-4195

            --Sentencia de la modificacion
            update alm.tpreingreso_det set
            id_item             = v_parametros.id_item,
            id_almacen          = v_parametros.id_almacen,
            precio_compra       = v_parametros.precio_compra,
            cantidad_det        = v_parametros.cantidad_det,
            id_depto            = v_parametros.id_depto,
            id_clasificacion    = v_parametros.id_clasificacion,
            observaciones       = v_parametros.observaciones,
            id_usuario_mod      = p_id_usuario,
            fecha_mod           = now(),
            nombre              = v_parametros.nombre,
            descripcion         = v_parametros.descripcion,
            precio_compra_87    = v_parametros.precio_compra_87,
            id_lugar            = v_parametros.id_lugar,
            ubicacion           = v_parametros.ubicacion,
            c31                 = v_parametros.c31,
            fecha_conformidad   = v_parametros.fecha_conformidad,
            fecha_compra        = v_parametros.fecha_compra,
            id_centro_costo     = v_parametros.id_centro_costo,
            id_ubicacion        = v_parametros.id_ubicacion,
            id_grupo            = v_parametros.id_grupo,
            id_grupo_clasif     = v_parametros.id_grupo_clasif,
            nro_serie           = v_parametros.nro_serie,
            marca               = v_parametros.marca,
            vida_util           = v_parametros.vida_util
            where id_preingreso_det = v_parametros.id_preingreso_det;

            ---------------------------------------------------------------
            --Actualizar la tabla de conceptos de gasto item clasificacion
            ---------------------------------------------------------------
            --Obtener datos
            select ingas.id_concepto_ingas
            into v_id_concepto_ingas
            from alm.tpreingreso_det pdet
            inner join adq.tcotizacion_det cdet on cdet.id_cotizacion_det = pdet.id_cotizacion_det
            inner join adq.tsolicitud_det sdet on sdet.id_solicitud_det = cdet.id_solicitud_det
            inner join param.tconcepto_ingas ingas on ingas.id_concepto_ingas = sdet.id_concepto_ingas
            where pdet.id_preingreso_det=v_parametros.id_preingreso_det;

            --Verifica si ya existe el registro de la relación
            if v_parametros.id_item is not null then

                select id_item_clasif_ingas
                into v_id_item_clasif_ingas
                from alm.titem_clasif_ingas
                where id_concepto_ingas = v_id_concepto_ingas
                and id_item = v_parametros.id_item
                and id_clasificacion is null;

            elsif v_parametros.id_clasificacion is not null then

                select id_item_clasif_ingas
                into v_id_item_clasif_ingas
                from alm.titem_clasif_ingas
                where id_concepto_ingas = v_id_concepto_ingas
                and id_item is null
                and id_clasificacion = v_parametros.id_clasificacion;

            else
              --raise exception 'No puede almacenarse tabla de aprendizaje de los Conceptos de Gasto porque el Item o Clasificación son nulos';
            end if;


            if v_parametros.id_item is not null or v_parametros.id_clasificacion is not null then

                if v_id_item_clasif_ingas is not null then
                    --Actualiza el contado
                    update alm.titem_clasif_ingas set
                    contador = contador + 1
                    where id_item_clasif_ingas = v_id_item_clasif_ingas;
                else
                    --Registra la nueva relación
                    INSERT INTO alm.titem_clasif_ingas(
                    id_usuario_reg,
                    id_usuario_mod,
                    fecha_reg,
                    fecha_mod,
                    estado_reg,
                    id_concepto_ingas,
                    id_item,
                    id_clasificacion,
                    contador
                    ) VALUES (
                    p_id_usuario,
                    NULL,
                    now(),
                    NULL,
                    'activo',
                    v_id_concepto_ingas,
                    v_parametros.id_item,
                    v_parametros.id_clasificacion,
                    1
                    );

                end if;
            end if;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle Preingreso modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_preingreso_det',v_parametros.id_preingreso_det::varchar);

            --Devuelve la respuesta
            return v_resp;

        end;

    /*********************************
    #TRANSACCION:  'SAL_PREDET_ELI'
    #DESCRIPCION: Eliminacion de registros
    #AUTOR:   admin
    #FECHA:   07-10-2013 17:46:04
    ***********************************/

    elsif(p_transaccion='SAL_PREDET_ELI')then

        begin
            --Sentencia de la eliminacion
            delete from alm.tpreingreso_det
            where id_preingreso_det=v_parametros.id_preingreso_det;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle Preingreso eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_preingreso_det',v_parametros.id_preingreso_det::varchar);

            --Devuelve la respuesta
            return v_resp;
        end;

    /*********************************
    #TRANSACCION:  'SAL_PREPPRE_MOD'
    #DESCRIPCION: Preparación de preingreso
    #AUTOR:     RCM
    #FECHA:     03/05/2015
    ***********************************/

    elsif(p_transaccion='SAL_PREPPRE_MOD')then

        begin
            --Sentencia de la eliminacion
            update alm.tpreingreso_det set
            sw_generar = 'si',
            estado = 'mod'
            where id_preingreso_det=v_parametros.id_preingreso_det;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Preingreso preparado');
            v_resp = pxp.f_agrega_clave(v_resp,'id_preingreso_det',v_parametros.id_preingreso_det::varchar);

            --Devuelve la respuesta
            return v_resp;
        end;

    /*********************************
    #TRANSACCION:  'SAL_PREPPRE_INS'
    #DESCRIPCION: Inserción de nuevo registro en la Preparación de preingreso
    #AUTOR:     RCM
    #FECHA:     03/05/2015
    ***********************************/

    elsif(p_transaccion='SAL_PREPPRE_INS')then

    begin

        insert into alm.tpreingreso_det(
        estado_reg,
        id_preingreso,
        id_item,
        id_almacen,
        cantidad_det,
        precio_compra,
        id_depto,
        id_clasificacion,
        observaciones,
        id_usuario_reg,
        fecha_reg,
        id_usuario_mod,
        fecha_mod,
        sw_generar,
        estado,
        vida_util
        ) values(
        'activo',
        v_parametros.id_preingreso,
        v_parametros.id_item,
        v_parametros.id_almacen,
        v_parametros.cantidad_det,
        v_parametros.precio_compra,
        v_parametros.id_depto,
        v_parametros.id_clasificacion,
        v_parametros.observaciones,
        p_id_usuario,
        now(),
        null,
        null,
        'si',
        'mod',
        v_parametros.vida_util
        )RETURNING id_preingreso_det into v_id_preingreso_det;

        --Definicion de la respuesta
        v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle Preingreso almacenado(a) con exito (id_preingreso_det'||v_id_preingreso_det||')');
        v_resp = pxp.f_agrega_clave(v_resp,'id_preingreso_det',v_id_preingreso_det::varchar);

        --Devuelve la respuesta
        return v_resp;

    end;

    /*********************************
    #TRANSACCION:  'SAL_PREDETPRE_ELI'
    #DESCRIPCION: Eliminacion de registros en la preparación
    #AUTOR:     RCM
    #FECHA:     04/05/2015
    ***********************************/

    elsif(p_transaccion='SAL_PREDETPRE_ELI')then

        begin
            --Inicio #ETR-4195
            IF EXISTS (SELECT 1
                    FROM alm.tpreingreso_det
                    WHERE id_preingreso_det = v_parametros.id_preingreso_det
                    AND generado = 'si') THEN
                RAISE EXCEPTION 'Este registro ya fue activado/ingresado y no es posible modificarlo';
            END IF;
            --Fin #ETR-4195

            --Sentencia de la eliminacion
            update alm.tpreingreso_det set
            estado = 'orig',
            sw_generar = 'no'
            where id_preingreso_det=v_parametros.id_preingreso_det;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Detalle Preingreso eliminado(a) de la preparación');
            v_resp = pxp.f_agrega_clave(v_resp,'id_preingreso_det',v_parametros.id_preingreso_det::varchar);

            --Devuelve la respuesta
            return v_resp;
        end;

    /*********************************
    #TRANSACCION:  'SAL_PREPPREALL_MOD'
    #DESCRIPCION: Preparación de preingreso, agrega todos los items
    #AUTOR:     RCM
    #FECHA:     06/05/2015
    ***********************************/

    elsif(p_transaccion='SAL_PREPPREALL_MOD')then

        begin
            --Sentencia de la eliminacion
            update alm.tpreingreso_det set
            sw_generar = 'si',
            estado = 'mod'
            where id_preingreso=v_parametros.id_preingreso
            and generado <> 'si'; --#ETR-4195

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Preingreso preparado, agregados todos');
            v_resp = pxp.f_agrega_clave(v_resp,'id_preingreso',v_parametros.id_preingreso::varchar);

            --Devuelve la respuesta
            return v_resp;
        end;

    /*********************************
    #TRANSACCION:  'SAL_QUITAPREALL_MOD'
    #DESCRIPCION: Quita todos los items del preingreso
    #AUTOR:     RCM
    #FECHA:     09/05/2015
    ***********************************/

    elsif(p_transaccion='SAL_QUITAPREALL_MOD')then

        begin
            --Sentencia de la eliminacion
            update alm.tpreingreso_det set
            sw_generar = 'no',
            estado = 'orig'
            where id_preingreso=v_parametros.id_preingreso
            and generado <> 'si'; --#ETR-4195

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Items de preingreso quitados');
            v_resp = pxp.f_agrega_clave(v_resp,'id_preingreso',v_parametros.id_preingreso::varchar);

            --Devuelve la respuesta
            return v_resp;
        end;

    /*********************************
    #TRANSACCION:  'SAL_DESGL_MOD'
    #DESCRIPCION:   Desglosa el registro en función de la cantidad comprada
    #AUTOR:         RCM
    #FECHA:         23/07/2018
    ***********************************/

    elsif(p_transaccion='SAL_DESGL_MOD')then

        begin

            --Verifica la existencia del registro padre
            if not exists(select 1 from alm.tpreingreso_det
                        where id_preingreso_det = v_parametros.id_preingreso_det) then
                raise exception 'Registro para desglosar no encontrado';
            end if;

            --Inicio #ETR-4195
            IF EXISTS (SELECT 1
                    FROM alm.tpreingreso_det
                    WHERE id_preingreso_det = v_parametros.id_preingreso_det
                    AND generado = 'si') THEN
                RAISE EXCEPTION 'Este registro ya fue activado/ingresado y no es posible modificarlo';
            END IF;
            --Fin #ETR-4195

            --Se crean nuevos registros basados en el original en la cantidad definida
            if v_parametros.cantidad_det > 1 then

                for v_i in 1..v_parametros.cantidad_det::integer loop

                    insert into alm.tpreingreso_det(
                        id_usuario_reg,
                        fecha_reg,
                        estado_reg,
                        id_preingreso,
                        id_cotizacion_det,
                        id_item,
                        id_almacen,
                        cantidad_det,
                        precio_compra,
                        id_depto,
                        id_clasificacion,
                        sw_generar,
                        observaciones,
                        estado,
                        nombre,
                        descripcion,
                        precio_compra_87,
                        id_lugar,
                        ubicacion,
                        c31,
                        fecha_conformidad,
                        fecha_compra,
                        id_centro_costo,
                        id_ubicacion,
                        id_grupo,
                        id_grupo_clasif,
                        nro_serie,
                        marca,
                        tipo_reg,
                        generado,
                        id_preingreso_det_padre,
                        vida_util
                    )
                    select
                    p_id_usuario,
                    now(),
                    'activo',
                    id_preingreso,
                    id_cotizacion_det,
                    id_item,
                    id_almacen,
                    1,
                    precio_compra/v_parametros.cantidad_det,
                    id_depto,
                    id_clasificacion,
                    sw_generar,
                    observaciones,
                    estado,
                    nombre,
                    descripcion,
                    precio_compra_87/v_parametros.cantidad_det,
                    id_lugar,
                    ubicacion,
                    c31,
                    fecha_conformidad,
                    fecha_compra,
                    id_centro_costo,
                    id_ubicacion,
                    id_grupo,
                    id_grupo_clasif,
                    nro_serie,
                    marca,
                    'desglose',
                    'no',
                    v_parametros.id_preingreso_det,
                    vida_util
                    from alm.tpreingreso_det
                    where id_preingreso_det = v_parametros.id_preingreso_det;

                end loop;

            end if;


            --Inactiva el registro original
            update alm.tpreingreso_det set
            estado_reg = 'inactivo'
            where id_preingreso_det = v_parametros.id_preingreso_det;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Preingreso desglosado en la cantidad de: '||v_parametros.cantidad_det);
            v_resp = pxp.f_agrega_clave(v_resp,'id_preingreso_det',v_parametros.id_preingreso_det::varchar);

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