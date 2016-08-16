CREATE OR REPLACE FUNCTION alm.ft_preingreso_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   Sistema de Almacenes
 FUNCION:     alm.ft_preingreso_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tpreingreso'
 AUTOR:      (admin)
 FECHA:         07-10-2013 16:56:43
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

  v_nombre_funcion = 'alm.ft_preingreso_sel';
    v_parametros = pxp.f_get_record(p_tabla);

  /*********************************    
  #TRANSACCION:  'SAL_PREING_SEL'
  #DESCRIPCION: Consulta de datos
  #AUTOR:   admin 
  #FECHA:   07-10-2013 16:56:43
  ***********************************/

  if(p_transaccion='SAL_PREING_SEL')then
            
      begin
        --Sentencia de la consulta
      v_consulta:='select
            preing.id_preingreso,
            preing.estado_reg,
            preing.id_cotizacion,
            preing.id_almacen,
            preing.id_depto,
            preing.id_estado_wf,
            preing.id_proceso_wf,
            preing.estado,
            preing.id_moneda,
            preing.tipo,
            sol.justificacion::varchar as descripcion,
            preing.id_usuario_reg,
            preing.fecha_reg,
            preing.id_usuario_mod,
            preing.fecha_mod,
            usu1.cuenta as usr_reg,
            usu2.cuenta as usr_mod,
                        alm.codigo as codigo_almacen,
                        depto.codigo as codigo_depto,
                        mon.codigo codigo_moneda,
                        cot.numero_oc,
                        pw.nro_tramite,
                        fun.desc_funcionario1,
                        pro.desc_proveedor,
                        comp.c31,
                        pp.fecha_conformidad
            from alm.tpreingreso preing
            inner join segu.tusuario usu1 on usu1.id_usuario = preing.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = preing.id_usuario_mod
                        left join alm.talmacen alm on alm.id_almacen = preing.id_almacen
                        left join param.tdepto depto on depto.id_depto = preing.id_depto
                        inner join param.tmoneda mon on mon.id_moneda = preing.id_moneda
                        inner join adq.tcotizacion cot on cot.id_cotizacion = preing.id_cotizacion
                        inner join wf.tproceso_wf pw on pw.id_proceso_wf = cot.id_proceso_wf
                        inner join adq.tproceso_compra pcom on pcom.id_proceso_compra = cot.id_proceso_compra
                        inner join adq.tsolicitud sol on sol.id_solicitud = pcom.id_solicitud
                        inner join orga.vfuncionario fun on fun.id_funcionario = sol.id_funcionario
                        inner join param.vproveedor pro on pro.id_proveedor = cot.id_proveedor
                        left join tes.tobligacion_pago op on op.id_obligacion_pago = cot.id_obligacion_pago 
                        	and op.estado_reg = ''activo'' and op.estado != ''anulado''
                        left join tes.tplan_pago pp on pp.id_obligacion_pago = op.id_obligacion_pago 
                        	and pp.estado_reg = ''activo'' and pp.estado != ''anulado'' and pp.nro_cuota = 1
                        left join sci.tint_comprobante comp on pp.id_int_comprobante = comp.id_int_comprobante
                        left join tes.tplan_pago pago on pago.id_plan_pago_fk = pp.id_plan_pago
                        
                where preing.estado != ''cancelado'' and ';
      
      --Definicion de la respuesta
      v_consulta:=v_consulta||v_parametros.filtro;
      v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

      --Devuelve la respuesta
      return v_consulta;
            
    end;

  /*********************************    
  #TRANSACCION:  'SAL_PREING_CONT'
  #DESCRIPCION: Conteo de registros
  #AUTOR:   admin 
  #FECHA:   07-10-2013 16:56:43
  ***********************************/

  elsif(p_transaccion='SAL_PREING_CONT')then

    begin
      --Sentencia de la consulta de conteo de registros
      v_consulta:='select count(id_preingreso)
              from alm.tpreingreso preing
            inner join segu.tusuario usu1 on usu1.id_usuario = preing.id_usuario_reg
            left join segu.tusuario usu2 on usu2.id_usuario = preing.id_usuario_mod
                        left join alm.talmacen alm on alm.id_almacen = preing.id_almacen
                        left join param.tdepto depto on depto.id_depto = preing.id_depto
                        inner join param.tmoneda mon on mon.id_moneda = preing.id_moneda
                        inner join adq.tcotizacion cot on cot.id_cotizacion = preing.id_cotizacion
                        inner join wf.tproceso_wf pw on pw.id_proceso_wf = cot.id_proceso_wf
                        inner join adq.tproceso_compra pcom on pcom.id_proceso_compra = cot.id_proceso_compra
                        inner join adq.tsolicitud sol on sol.id_solicitud = pcom.id_solicitud
                        inner join orga.vfuncionario fun on fun.id_funcionario = sol.id_funcionario
                        inner join param.vproveedor pro on pro.id_proveedor = cot.id_proveedor
                        left join tes.tobligacion_pago op on op.id_obligacion_pago = cot.id_obligacion_pago 
                        	and op.estado_reg = ''activo'' and op.estado != ''anulado''
                        left join tes.tplan_pago pp on pp.id_obligacion_pago = op.id_obligacion_pago 
                        	and pp.estado_reg = ''activo'' and pp.estado != ''anulado'' and pp.nro_cuota = 1
                        left join sci.tint_comprobante comp on pp.id_int_comprobante = comp.id_int_comprobante
                        where preing.estado != ''cancelado'' and ';
      
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