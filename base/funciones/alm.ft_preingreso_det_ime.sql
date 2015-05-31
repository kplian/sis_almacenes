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
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION: 
 AUTOR:     
 FECHA:   
***************************************************************************/

DECLARE

  v_nro_requerimiento     integer;
  v_parametros            record;
  v_id_requerimiento      integer;
  v_resp                varchar;
  v_nombre_funcion        text;
  v_mensaje_error         text;
  v_id_preingreso_det   integer;
    v_id_item_clasif_ingas  integer;
    v_id_concepto_ingas   integer;
    v_result        varchar;
          
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
      fecha_mod
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
      null
              
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
        
        --Sentencia de la modificacion
        update alm.tpreingreso_det set
        id_item = v_parametros.id_item,
        id_almacen = v_parametros.id_almacen,
        precio_compra = v_parametros.precio_compra,
        cantidad_det = v_parametros.cantidad_det,
        id_depto = v_parametros.id_depto,
        id_clasificacion = v_parametros.id_clasificacion,
        observaciones = v_parametros.observaciones,
        id_usuario_mod = p_id_usuario,
        fecha_mod = now()
        where id_preingreso_det=v_parametros.id_preingreso_det;
            
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
            estado
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
            'mod'
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
            where id_preingreso=v_parametros.id_preingreso;
               
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
            where id_preingreso=v_parametros.id_preingreso;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Items de preingreso quitados'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_preingreso',v_parametros.id_preingreso::varchar);
              
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