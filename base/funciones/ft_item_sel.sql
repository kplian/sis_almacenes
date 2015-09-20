CREATE OR REPLACE FUNCTION alm.ft_item_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_item_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.titem'
 AUTOR:          Gonzalo Sarmiento
 FECHA:            20-09-2012
 COMENTARIOS:   
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:   
 AUTOR:           
 FECHA:       
***************************************************************************/

DECLARE

    v_consulta            	varchar;
    v_parametros          	record;
    v_nombre_funcion       	text;
    v_resp                	varchar;
    v_where 				varchar;
	v_resp_global			varchar;
	v_id_movimiento_tipo	integer;
	v_ids				varchar;
               
BEGIN

    v_nombre_funcion = 'alm.ft_item_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************   
     #TRANSACCION:  'SAL_ITEM_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        20-09-2012
    ***********************************/

    if(p_transaccion='SAL_ITEM_SEL')then
                    
        begin
            --Sentencia de la consulta
            v_consulta:='
            	select
                	item.id_item,
                    item.id_clasificacion,
                    item.nombre,
                    item.codigo,
                    item.descripcion,
                    item.palabras_clave,
                    item.codigo_fabrica,
                    item.observaciones,
                    item.numero_serie,
                    item.id_unidad_medida,
                	umed.codigo as codigo_unidad,
                	item.precio_ref,
                	item.id_moneda,
                	mon.codigo as desc_moneda
                from alm.titem item
                inner join param.tunidad_medida umed on umed.id_unidad_medida = item.id_unidad_medida
                left join param.tmoneda mon on mon.id_moneda = item.id_moneda
                where item.estado_reg = ''activo'' and ';
           
        	if (v_parametros.ordenacion = 'codigo') then
            	v_parametros.ordenacion = 'num_por_clasificacion';
            end if;
        
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			
            --Devuelve la respuesta
            return v_consulta;
                       
        end;
    /*********************************   
     #TRANSACCION:  'SAL_ITEM_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        20-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_ITEM_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='
            	select count(item.id_item)
                from alm.titem item
                inner join param.tunidad_medida umed on umed.id_unidad_medida = item.id_unidad_medida
                left join param.tmoneda mon on mon.id_moneda = item.id_moneda
                where item.estado_reg = ''activo'' and ';
           
            --Definicion de la respuesta           
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            return v_consulta;

        end;  
    /*********************************   
     #TRANSACCION:  'SAL_ARB_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        20-09-2012
    ***********************************/     
            
    elseif(p_transaccion='SAL_ARB_SEL')then
    	begin
        	if(v_parametros.id_clasificacion = '%') then
                v_where := ' it.id_clasificacion is NULL';    
            else
                v_where := ' it.id_clasificacion = '||v_parametros.id_clasificacion;
            end if;
            
            /******************/
            --RCM 18/10/2103: Verificación de si se debe filtrar los items por tipo de movimiento, solo para los casos que envien el parametro id_movimiento
            if pxp.f_existe_parametro(p_tabla,'id_movimiento') then
            	
                v_resp_global = pxp.f_get_variable_global('alm_filtrar_item_tipomov');
            	if v_resp_global = 'si' then
            		--Verifica que sea una salida y si es asi obtiene el id_movimiento_tipo
            		select
            		movt.id_movimiento_tipo
            		into v_id_movimiento_tipo
            		from alm.tmovimiento mov
            		inner join alm.tmovimiento_tipo movt
            		on movt.id_movimieov.id_movimiento_tipo
            		where id_movimiento = v_paramento_tipo = mtros.id_movimiento
            		and tipo  ='salida';
					
            		if coalesce(v_id_movimiento_tipo,0)!=0 then
            			--Obtener los id_clasificacion
            			v_ids='';
            			select (pxp.list(id_clasificacion::text))::varchar
            			into v_ids
        				from alm.tmovimiento_tipo_item
            			where id_clasificacion is not null
            			and id_movimiento_tipo = v_id_movimiento_tipo;
            			
            			--Obtener los Ids recursivamente
            			v_ids=alm.f_get_id_clasificaciones_varios(v_ids);

						--Definir la consulta            		
            			if v_ids!='null' then
                                               
            				--Condición de Items y Clasificación
            				v_where = v_where || ' and (
            								(it.id_item in (select id_item
            											from alm.tmovimiento_tipo_item
            											where id_item is not null
            											and id_movimiento_tipo = '||v_id_movimiento_tipo||')
            								) or
            								(
            									it.id_clasificacion in ('|| v_ids||')
            								)
            							) ';

            			else
            				--Condición solo de Items
            				v_where = v_where || ' and it.id_item in (select id_item
            											from alm.tmovimiento_tipo_item
            											where id_item is not null
            											and id_movimiento_tipo = '||v_id_movimiento_tipo||') ';
            			end if;
            											 
            		end if;
            		
            	end if;
            end if;
			--FIN RCM
            
            
            /**************/
        	v_consulta:='
            	select
					it.id_item,
                    it.nombre,
                    it.codigo,
                    it.id_clasificacion as id_clasificacion_fk,
                    (COALESCE(it.id_clasificacion,0)::varchar||''_''||it.id_item::varchar)::varchar as id_clasificacion,
                    case
                        when (it.codigo is not null and it.codigo <> '''') then
                        	''item_codificado''::varchar
                        ELSE
                            ''item''::varchar
                    END as tipo_nodo
                from alm.titem it
                inner join segu.tusuario usu1 on usu1.id_usuario = it.id_usuario_reg
                left join segu.tusuario usu2 on usu2.id_usuario = it.id_usuario_mod
                where it.estado_reg = ''activo'' 
                and '|| v_where ||' order by it.num_por_clasificacion ';
                
                

            --Devuelve la respuesta
        	return v_consulta;
        end;
	
    /*********************************   
     #TRANSACCION:  'SAL_ITEMNOTBASE_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        20-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_ITEMNOTBASE_SEL')then
                    
        begin
            
            v_where = '';
            --RCM 21/08/2103: Verificación de si se debe filtrar los items por tipo de movimiento, solo para los casos que envien el parametro id_movimiento
            if pxp.f_existe_parametro(p_tabla,'id_movimiento') then
            	v_resp_global = pxp.f_get_variable_global('alm_filtrar_item_tipomov');
            	if v_resp_global = 'si' then
            		--Verifica que sea una salida y si es asi obtiene el id_movimiento_tipo
            		select
            		movt.id_movimiento_tipo
            		into v_id_movimiento_tipo
            		from alm.tmovimiento mov
            		inner join alm.tmovimiento_tipo movt
            		on movt.id_movimiento_tipo = mov.id_movimiento_tipo
            		where id_movimiento = v_parametros.id_movimiento
            		and tipo in ('ingreso','salida');

            		if coalesce(v_id_movimiento_tipo,0)!=0 then
            			--Obtener los id_clasificacion
            			v_ids='';
            			select (pxp.list(id_clasificacion::text))::varchar
            			into v_ids
        				from alm.tmovimiento_tipo_item
            			where id_clasificacion is not null
            			and id_movimiento_tipo = v_id_movimiento_tipo;
            			
            			--Obtener los Ids recursivamente
            			v_ids=alm.f_get_id_clasificaciones_varios(v_ids);

						--Definir la consulta            		
            			if v_ids!='null' then
                                               
            				--Condición de Items y Clasificación
            				v_where = ' (
            								(item.id_item in (select id_item
            											from alm.tmovimiento_tipo_item
            											where id_item is not null
            											and id_movimiento_tipo = '||v_id_movimiento_tipo||')
            								) or
            								(
            									item.id_clasificacion in ('|| v_ids||')
            								)
            							) and ';

            			else
            				--Condición solo de Items
            				v_where = ' item.id_item in (select id_item
            											from alm.tmovimiento_tipo_item
            											where id_item is not null
            											and id_movimiento_tipo = '||v_id_movimiento_tipo||') and ';
            			end if;
            											 
            		end if;
            		
            	end if;
            end if;
            
			--Consulta
            v_consulta:='
            	select
                	item.id_item,
                    item.id_clasificacion,
                    cla.nombre as desc_clasificacion,
                    item.nombre,
                    item.codigo,
                    item.descripcion,
                    item.palabras_clave,
                    item.codigo_fabrica,
                    item.observaciones,
                    item.numero_serie,
                    umed.codigo as codigo_unidad,
                    item.precio_ref
                from alm.titem item
                inner join alm.tclasificacion cla on item.id_clasificacion = cla.id_clasificacion
                inner join param.tunidad_medida umed on umed.id_unidad_medida = item.id_unidad_medida
                where item.estado_reg = ''activo'' and ';
                
               v_consulta = v_consulta || v_where;
           
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			
            raise notice '%',v_consulta;
            --Devuelve la respuesta
            return v_consulta;
            
        end;
    
    /*********************************   
     #TRANSACCION:  'SAL_ITEMNOTBASE_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Gonzalo Sarmiento   
     #FECHA:        20-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_ITEMNOTBASE_CONT')then

        begin
        
        	v_where = '';
            --RCM 21/08/2103: Verificación de si se debe filtrar los items por tipo de movimiento, solo para los casos que envien el parametro id_movimiento
            if pxp.f_existe_parametro(p_tabla,'id_movimiento') then
            	v_resp_global = pxp.f_get_variable_global('alm_filtrar_item_tipomov');
            	if v_resp_global = 'si' then
            		--Verifica que sea una salida y si es asi obtiene el id_movimiento_tipo
            		select
            		movt.id_movimiento_tipo
            		into v_id_movimiento_tipo
            		from alm.tmovimiento mov
            		inner join alm.tmovimiento_tipo movt
            		on movt.id_movimiento_tipo = mov.id_movimiento_tipo
            		where id_movimiento = v_parametros.id_movimiento
            		and tipo = 'salida';

            		if coalesce(v_id_movimiento_tipo,0)!=0 then
            			--Obtener los id_clasificacion
            			v_ids='';
            			select (pxp.list(id_clasificacion::text))::varchar
            			into v_ids
        				from alm.tmovimiento_tipo_item
            			where id_clasificacion is not null
            			and id_movimiento_tipo = v_id_movimiento_tipo;
            			
            			--Obtener los Ids recursivamente
            			v_ids=alm.f_get_id_clasificaciones_varios(v_ids);

						--Definir la consulta            		
            			if v_ids!='null' then
                                               
            				--Condición de Items y Clasificación
            				v_where = ' (
            								(item.id_item in (select id_item
            											from alm.tmovimiento_tipo_item
            											where id_item is not null
            											and id_movimiento_tipo = '||v_id_movimiento_tipo||')
            								) or
            								(
            									item.id_clasificacion in ('|| v_ids||')
            								)
            							) and ';

            			else
            				--Condición solo de Items
            				v_where = ' item.id_item in (select id_item
            											from alm.tmovimiento_tipo_item
            											where id_item is not null
            											and id_movimiento_tipo = '||v_id_movimiento_tipo||') and ';
            			end if;
            											 
            		end if;
            		
            	end if;
            end if;
            
            --Sentencia de la consulta de conteo de registros
            v_consulta:='
            	select count(item.id_item)
                from alm.titem item
                inner join alm.tclasificacion cla on item.id_clasificacion = cla.id_clasificacion
                inner join param.tunidad_medida umed on umed.id_unidad_medida = item.id_unidad_medida
                where item.estado_reg = ''activo'' and ';
                
            v_consulta = v_consulta || v_where;
           
            --Definicion de la respuesta           
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            return v_consulta;

        end;  
    
    /*********************************   
     #TRANSACCION:  'SAL_ITMSRCHARB_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        20-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_ITMSRCHARB_SEL')then
                    
        begin
            --Sentencia de la consulta
            v_consulta:='
            	select 
                	it.id_item id, 
                	case 
                        when (it.id_clasificacion is null) then
                            ''''::varchar
                        else 
                           array_to_string(alm.f_get_ruta_clasificacion(it.id_clasificacion), '','') ::varchar
                    end as ruta
				from alm.titem it
                where it.estado_reg = ''activo'' and it.nombre ilike ''%' || v_parametros.text_search || '%'' ';
           
            return v_consulta;
                       
        end;
    
    /*********************************   
     #TRANSACCION:  'SAL_ITMSRCHARB_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        20-09-2012
    ***********************************/

    elsif(p_transaccion='SAL_ITMSRCHARB_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='
            	select count(it.id_item)
                from alm.titem it
                where it.estado_reg = ''activo'' and it.nombre ilike ''%' || v_parametros.text_search || '%'' ';
           
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