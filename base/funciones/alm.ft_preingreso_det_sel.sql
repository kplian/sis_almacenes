CREATE OR REPLACE FUNCTION alm.ft_preingreso_det_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   Sistema de Almacenes
 FUNCION:     alm.ft_preingreso_det_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tpreingreso_det'
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

  v_consulta        varchar;
  v_parametros      record;
  v_nombre_funcion    text;
  v_resp        varchar;
          
BEGIN

  v_nombre_funcion = 'alm.ft_preingreso_det_sel';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'SAL_PREDET_SEL'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   admin 
  #FECHA:   07-10-2013 17:46:04
  ***********************************/

  if(p_transaccion='SAL_PREDET_SEL')then
            
      begin
        --Sentencia de la consulta
      v_consulta:='select
            predet.id_preingreso_det,
            predet.estado_reg,
            predet.id_preingreso,
            predet.id_cotizacion_det,
            predet.id_item,
            predet.id_almacen,
            predet.cantidad_det,
            predet.precio_compra,
            predet.id_depto,
            predet.id_clasificacion,
            predet.sw_generar,
            predet.observaciones,
            predet.id_usuario_reg,
            predet.fecha_reg,
            predet.id_usuario_mod,
            predet.fecha_mod,
            usu1.cuenta as usr_reg,
            usu2.cuenta as usr_mod,
                        alm.codigo || '' - '' || alm.nombre as desc_almacen,
                        depto.codigo || '' - '' || depto.nombre as desc_depto,
                        ite.codigo || '' - '' || ite.nombre as desc_item,
                        clas.codigo || '' - '' || clas.descripcion as desc_clasificacion,
                        ingas.desc_ingas,                        
                        predet.estado,
                        pre.tipo,
                        predet.nombre,
                        predet.descripcion,
                        predet.precio_compra_87,
                        predet.id_lugar,
                        lug.nombre as nombre_lugar,
                        predet.ubicacion,
                        predet.c31,
                        predet.fecha_conformidad
                        
            from alm.tpreingreso_det predet
            inner join segu.tusuario usu1 on usu1.id_usuario = predet.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = predet.id_usuario_mod
                        left join adq.tcotizacion_det cdet on cdet.id_cotizacion_det = predet.id_cotizacion_det
                        left join adq.tsolicitud_det sdet on sdet.id_solicitud_det = cdet.id_solicitud_det
                        left join param.tconcepto_ingas ingas on ingas.id_concepto_ingas = sdet.id_concepto_ingas
                        left join alm.talmacen alm on alm.id_almacen = predet.id_almacen
                        left join param.tdepto depto on depto.id_depto = predet.id_depto
                        left join alm.titem ite on ite.id_item = predet.id_item
                        left join af.tclasificacion clas on clas.id_clasificacion = predet.id_clasificacion
                        left join param.tlugar lug on lug.id_lugar = predet.id_lugar
                        inner join alm.tpreingreso pre on pre.id_preingreso = predet.id_preingreso
                where  ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'SAL_PREDET_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:   admin 
  #FECHA:   07-10-2013 17:46:04
  ***********************************/

  elsif(p_transaccion='SAL_PREDET_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(id_preingreso_det)
              from alm.tpreingreso_det predet
            inner join segu.tusuario usu1 on usu1.id_usuario = predet.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = predet.id_usuario_mod
                        left join adq.tcotizacion_det cdet on cdet.id_cotizacion_det = predet.id_cotizacion_det
                        left join adq.tsolicitud_det sdet on sdet.id_solicitud_det = cdet.id_solicitud_det
                        left join param.tconcepto_ingas ingas on ingas.id_concepto_ingas = sdet.id_concepto_ingas
                        left join alm.talmacen alm on alm.id_almacen = predet.id_almacen
                        left join param.tdepto depto on depto.id_depto = predet.id_depto
                        left join alm.titem ite on ite.id_item = predet.id_item
                        left join af.tclasificacion clas on clas.id_clasificacion = predet.id_clasificacion
                        left join param.tlugar lug on lug.id_lugar = predet.id_lugar
                        inner join alm.tpreingreso pre on pre.id_preingreso = predet.id_preingreso
              where ';
      
      --Definicion de la respuesta        
      v_consulta:=v_consulta||v_parametros.filtro;

      --Devuelve la respuesta
      return v_consulta;

    end;
          
  else
               
    raise exception 'Transaccion inexistente';
                   
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