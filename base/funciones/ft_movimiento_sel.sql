CREATE OR REPLACE FUNCTION alm.ft_movimiento_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/***************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_movimiento_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.tmovimiento'
 AUTOR:          Gonzalo Sarmiento
 FECHA:          02-10-2012
 COMENTARIOS:   
***************************************************************************/

DECLARE
  v_nombre_funcion	varchar;
  v_consulta 		varchar;
  v_parametros 		record;
  v_respuesta		varchar;
  v_fecha_ini		date;
  v_fecha_fin		date;
  v_periodo_subsistema_estado varchar;
  v_filtro 			varchar;
BEGIN
  v_nombre_funcion='alm.ft_movimiento_sel';
  v_parametros=pxp.f_get_record(p_tabla);
  
  /*********************************   
     #TRANSACCION:  'SAL_MOV_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        02-12-2012
    ***********************************/
  
	if(p_transaccion='SAL_MOV_SEL')then
  	begin
    
    	v_filtro='';	
    
        IF  lower(v_parametros.tipo_interfaz)='movimientoalm' THEN
            raise notice '%', 'entra';
            v_filtro = ' (lower(mov.estado_mov)!=''borrador''  and lower(mov.estado_mov)!=''vbrpm'' and lower(mov.estado_mov)!=''finalizado'' and lower(mov.estado_mov)!=''cancelado'' and lower(mov.estado_mov)!=''pendiente'') and';
                
        END IF;
        
        IF  lower(v_parametros.tipo_interfaz)='movimientovb' THEN
            raise notice '%', 'entra';
            v_filtro = ' (lower(mov.estado_mov)!=''borrador'' and lower(mov.estado_mov)!=''finalizado'' and lower(mov.estado_mov)!=''cancelado'' and lower(mov.estado_mov)!=''vbarea'') and ';
                
        END IF;		
        
    	v_consulta:='
        	SELECT
            	mov.id_movimiento,
                movtip.tipo as tipo,
            	mov.id_movimiento_tipo,
                movtip.nombre as nombre_movimiento_tipo,
            	mov.id_funcionario,
                person_fun.nombre_completo1::varchar as nombre_funcionario,
            	mov.id_proveedor,
                (case 
                	when mov.id_proveedor is not null and pro.id_institucion is not null then
                    	inst.nombre 
                    when mov.id_proveedor is not null and pro.id_persona is not null then 
                    	person.nombre_completo1
            		else 
                    	''''
                end)::varchar as nombre_proveedor,
                mov.id_almacen,
                almo.nombre as nombre_almacen,
            	mov.id_almacen_dest,
                almd.nombre as nombre_almacen_destino,
            	mov.fecha_mov,
            	mov.codigo,
            	mov.descripcion,
            	mov.observaciones,
                mov.id_movimiento_origen,
                movorig.codigo as codigo_origen,
                mov.id_estado_wf,
            	mov.estado_mov,
            	usu1.cuenta as usr_reg,
            	mov.fecha_reg,
            	usu2.cuenta as usr_mod,
            	mov.fecha_mod
            FROM alm.tmovimiento mov
            INNER JOIN alm.tmovimiento_tipo movtip on movtip.id_movimiento_tipo = mov.id_movimiento_tipo
            LEFT JOIN orga.tfuncionario fun on fun.id_funcionario = mov.id_funcionario
            LEFT JOIN segu.vpersona person_fun on person_fun.id_persona = fun.id_persona
            LEFT JOIN param.vproveedor pro on pro.id_proveedor = mov.id_proveedor
            LEFT JOIN segu.vpersona person on person.id_persona = pro.id_persona
            LEFT JOIN param.tinstitucion inst on inst.id_institucion = pro.id_institucion
            INNER JOIN alm.talmacen almo on almo.id_almacen = mov.id_almacen
            LEFT JOIN alm.talmacen almd on almd.id_almacen = mov.id_almacen_dest
            LEFT JOIN alm.tmovimiento movorig on movorig.id_movimiento = mov.id_movimiento_origen
            INNER JOIN segu.tusuario usu1 on usu1.id_usuario = movtip.id_usuario_reg
            LEFT JOIN segu.tusuario usu2 on usu2.id_usuario = movtip.id_usuario_mod
			WHERE mov.estado_reg = ''activo'' and ';

        v_consulta:=v_consulta||v_filtro;
    	v_consulta:=v_consulta||v_parametros.filtro;
        v_consulta:=v_consulta||' order by '||v_parametros.ordenacion||' '||v_parametros.dir_ordenacion||' limit '||v_parametros.cantidad||' offset '||v_parametros.puntero;
        return v_consulta;
    end;
  /*********************************   
     #TRANSACCION:  'SAL_MOV_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        24-09-2012
    ***********************************/
  elsif(p_transaccion='SAL_MOV_CONT')then
    begin
    	v_consulta:='
        	select count(mov.id_movimiento)
        	FROM alm.tmovimiento mov
            INNER JOIN alm.tmovimiento_tipo movtip on movtip.id_movimiento_tipo = mov.id_movimiento_tipo
            LEFT JOIN orga.tfuncionario fun on fun.id_funcionario = mov.id_funcionario
            LEFT JOIN segu.vpersona person_fun on person_fun.id_persona = fun.id_persona
            LEFT JOIN param.vproveedor pro on pro.id_proveedor = mov.id_proveedor
            LEFT JOIN segu.vpersona person on person.id_persona = pro.id_persona
            LEFT JOIN param.tinstitucion inst on inst.id_institucion = pro.id_institucion
            INNER JOIN alm.talmacen almo on almo.id_almacen = mov.id_almacen
            LEFT JOIN alm.talmacen almd on almd.id_almacen = mov.id_almacen_dest
            LEFT JOIN alm.tmovimiento movorig on movorig.id_movimiento = mov.id_movimiento_origen
            INNER JOIN segu.tusuario usu1 on usu1.id_usuario = movtip.id_usuario_reg
            LEFT JOIN segu.tusuario usu2 on usu2.id_usuario = movtip.id_usuario_mod
			WHERE mov.estado_reg = ''activo'' and ';
        v_consulta:= v_consulta||v_parametros.filtro;
        return v_consulta;
     end;
     
  /*********************************   
     #TRANSACCION:  'SAL_MOVREPORT_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        28-02-2013
    ***********************************/
  
	elseif(p_transaccion='SAL_MOVREPORT_SEL')then
  	begin
    	v_consulta:='
        	select 
            	item.codigo, 
                item.nombre, 
                umed.codigo as unidad_medida,
                item.id_clasificacion,
                cla.nombre as nombre_clasificacion,
                detval.cantidad, 
                detval.costo_unitario, 
                detval.cantidad * detval.costo_unitario as costo_total
            from alm.tmovimiento_det_valorado detval
            inner join alm.tmovimiento_det movdet on movdet.id_movimiento_det = detval.id_movimiento_det
            inner join alm.titem item on item.id_item = movdet.id_item
            inner join param.tunidad_medida umed on umed.id_unidad_medida = item.id_unidad_medida
            left join alm.tclasificacion cla on cla.id_clasificacion = item.id_clasificacion
            where movdet.estado_reg = ''activo'' and ';
            
    	v_consulta:=v_consulta||v_parametros.filtro;
        v_consulta:=v_consulta||' order by '||v_parametros.ordenacion||' '||v_parametros.dir_ordenacion||' limit '||v_parametros.cantidad||' offset '||v_parametros.puntero;
        return v_consulta;
    end;
    
  /*********************************   
     #TRANSACCION:  'SAL_MOVREPORT_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        28-02-2013
    ***********************************/
  elsif(p_transaccion='SAL_MOVREPORT_CONT')then
    begin
    	v_consulta:='
        	select count(detval.id_movimiento)
        	from alm.tmovimiento_det_valorado detval
            inner join alm.tmovimiento_det movdet on movdet.id_movimiento_det = detval.id_movimiento_det
            inner join alm.titem item on item.id_item = movdet.id_item
            inner join param.tunidad_medida umed on umed.id_unidad_medida = item.id_unidad_medida
            left join alm.tclasificacion cla on cla.id_clasificacion = item.id_clasificacion
            where movdet.estado_reg = ''activo'' and ';
        v_consulta:= v_consulta||v_parametros.filtro;
        return v_consulta;
     end;
     
  /*********************************   
     #TRANSACCION:  'SAL_MOVPENPER_SEL'
     #DESCRIPCION:  Consulta de datos
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        19-03-2013
    ***********************************/
	elseif(p_transaccion='SAL_MOVPENPER_SEL')then
  	begin
    	select peri.fecha_ini, peri.fecha_fin into v_fecha_ini, v_fecha_fin
        from param.tperiodo_subsistema pesu
        inner join param.tperiodo peri on peri.id_periodo = pesu.id_periodo
        where pesu.id_periodo_subsistema = v_parametros.id_periodo_subsistema;
        
        v_consulta:='
        	SELECT
            	mov.id_movimiento,
                mov.estado_mov
            FROM alm.tmovimiento mov
            WHERE mov.estado_reg = ''activo'' 
            	and mov.estado_mov = ''borrador'' 
                and mov.fecha_mov between ''' || v_fecha_ini || ''' and ''' || v_fecha_fin ||''' ;';
        return v_consulta;
    end;
	/*********************************   
     #TRANSACCION:  'SAL_MOVPENPER_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        19-03-2013
    ***********************************/
	elsif(p_transaccion='SAL_MOVPENPER_CONT')then
    begin
    	select peri.fecha_ini, peri.fecha_fin, pesu.estado into v_fecha_ini, v_fecha_fin, v_periodo_subsistema_estado
        from param.tperiodo_subsistema pesu
        inner join param.tperiodo peri on peri.id_periodo = pesu.id_periodo
        where pesu.id_periodo_subsistema = v_parametros.id_periodo_subsistema;

        if (v_periodo_subsistema_estado = 'abierto') then
		v_consulta:='
			SELECT count(mov.id_movimiento)
		    FROM alm.tmovimiento mov
		    WHERE mov.estado_reg = ''activo'' 
			and mov.estado_mov = ''borrador'' 
			and mov.fecha_mov between ''' || v_fecha_ini || ''' and ''' || v_fecha_fin ||''' ;';
	else 
		v_consulta:='SELECT count(null);';
	end if;
	return v_consulta;
     end;
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