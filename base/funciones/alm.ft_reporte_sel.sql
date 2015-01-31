CREATE OR REPLACE FUNCTION alm.ft_reporte_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/***************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_reporte_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros para los reportes del sistema de almacenes
 AUTOR:          Ariel Ayaviri Omonte
 FECHA:          29-04-2013
 COMENTARIOS:   
***************************************************************************/

DECLARE
  v_nombre_funcion	varchar;
  v_consulta 		varchar;
  v_parametros 		record;
  v_respuesta		varchar;
  v_id_items		varchar[];
  v_where			varchar;
  v_ids				varchar;
BEGIN
 
	v_nombre_funcion='alm.ft_reporte_sel';
  	v_parametros=pxp.f_get_record(p_tabla);
  
  	/*********************************   
     #TRANSACCION:  'SAL_REPEXIST_SEL'
     #DESCRIPCION:  Retorna las existencias de n items de un almacen.
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        29-04-2013
    ***********************************/
  
	if(p_transaccion='SAL_REPEXIST_SEL') then
		begin
		
			if (v_parametros.all_items = 'Todos los Items') then
				v_where = 'where ';
			elsif (v_parametros.all_items = 'Seleccionar Items') then
				v_where = 'where itm.id_item = ANY(ARRAY['||v_parametros.id_items||']) and ';
			elsif (v_parametros.all_items = 'Por Clasificacion') then
				--Obtener los IDs de todas las clasificaciones
				v_ids=alm.f_get_id_clasificaciones_varios(v_parametros.id_clasificacion);
				
                IF (v_ids = '') THEN
                
                   v_ids = '0';
                
                END IF;
                
				v_where = 'where itm.id_clasificacion in (' ||v_ids||') and ';
			else
				raise exception 'Error desconocido';
			end if;
			
			--Verifica si se debe incluir los items que tengan existencias iguales a cero a la fecha
			if (v_parametros.alertas != 'todos') THEN
            	if(v_parametros.alertas = 'cantidad_minima') then
                    v_where = v_where || ' (alm.f_get_saldo_fisico_item(itm.id_item, '||v_parametros.id_almacen||', date('''''|| v_parametros.fecha_hasta||'''''))) < almsto.cantidad_min and ';
                elsif(v_parametros.alertas = 'cantidad_amarilla') then
                    v_where = v_where || ' (alm.f_get_saldo_fisico_item(itm.id_item, '||v_parametros.id_almacen||', date('''''|| v_parametros.fecha_hasta||'''''))) < almsto.cantidad_alerta_amarilla and ';
                elsif(v_parametros.alertas = 'cantidad_roja') then
                    v_where = v_where || ' (alm.f_get_saldo_fisico_item(itm.id_item, '||v_parametros.id_almacen||', date('''''|| v_parametros.fecha_hasta||'''''))) < almsto.cantidad_alerta_roja and ';
                end if;
            else
                if(v_parametros.saldo_cero = 'no') then
                    v_where = v_where || ' (alm.f_get_saldo_fisico_item(itm.id_item, '||v_parametros.id_almacen||', date('''''|| v_parametros.fecha_hasta||'''''))) > 0 and ';
                end if;
            end if;
	
	    	v_consulta:='select 
            			id_item,
                        codigo,
                        nombre,
                        unidad_medida,
                        clasificacion,
                        cantidad,
                        costo,
                        cantidad_min,
                        cantidad_alerta_roja,
                        cantidad_alerta_amarilla
                        from alm.f_existencias_almacen_sel('||v_parametros.id_almacen||','''||v_parametros.fecha_hasta||''','''||v_where||''','''||v_parametros.filtro||''')
                        as (id_item integer,
                        codigo varchar,
                        nombre varchar,
                        unidad_medida varchar,
                        clasificacion varchar,
                        cantidad numeric,
                        costo numeric,
                        cantidad_min numeric,
                        cantidad_alerta_roja numeric,
                        cantidad_alerta_amarilla numeric)';        	
                        
                        raise notice '%',v_consulta;

	        return v_consulta;	
	    end;
  	/*********************************   
     #TRANSACCION:  'SAL_REPEXIST_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        29-04-2013
    ***********************************/
	elsif(p_transaccion='SAL_REPEXIST_CONT')then
    
        begin
        if (v_parametros.all_items = 'si') then
            v_where = 'where ';
        else
             IF v_parametros.id_items='' THEN
                 v_parametros.id_items='0';
             END IF;
        
        
            v_where = 'where itm.id_item = ANY(ARRAY['||v_parametros.id_items||']) and ';
        end if;

            v_consulta:='
                select count(itm.id_item)
                from alm.titem itm
            inner join param.tunidad_medida umed on umed.id_unidad_medida = itm.id_unidad_medida
            inner join alm.tclasificacion cla on cla.id_clasificacion = itm.id_clasificacion ' || v_where;
    	
        v_consulta:=v_consulta||v_parametros.filtro;
            return v_consulta;
         end;
         
	/*********************************   
     #TRANSACCION:  'SAL_REITEN_SEL'
     #DESCRIPCION:  Retorna listado de los materiales entregados/recibidos
     #AUTOR:        RCM
     #FECHA:        13/08/2013
    ***********************************/
  
	elsif(p_transaccion='SAL_REITEN_SEL') then
		begin
           
            --Fecha
            if v_parametros.fecha_ini is not null and v_parametros.fecha_fin is not null then
				v_where = ' and date_trunc(''day'',mov.fecha_mov) between ''' ||v_parametros.fecha_ini||''' and ''' || v_parametros.fecha_fin || '''';
            else
            	raise exception 'Fechas no definidas';
            end if;
            
        	--Tipo de Movimiento
			if v_parametros.tipo_mov = 'ingreso' then
				v_where = ' and mtipo.tipo = ''ingreso''';
			elsif v_parametros.tipo_mov = 'salida' then
				v_where = ' and mtipo.tipo = ''salida''';
			end if;
            
            --Solicitante
            if v_parametros.tipo_sol = 'func' then
                if v_parametros.all_funcionario = 'Seleccionar Funcionarios' then
	            	v_where = v_where || ' and fun.id_funcionario = ANY(ARRAY['||v_parametros.id_funcionario||'])';
	            elsif v_parametros.all_funcionario = 'Por Organigrama' then
	            	--Obtener los IDs de todos los organigramas
					v_ids=orga.f_get_id_uo(v_parametros.id_estructura_uo);
					v_where = v_where || ' and uofun.id_uo in (' ||v_ids||')';
				end if;
                
            elsif v_parametros.tipo_sol = 'prov' then
            	if coalesce(v_parametros.id_proveedor,'') != '' then
            		v_where = v_where || ' and prov.id_proveedor in (' || v_parametros.id_proveedor || ')';
                end if;
            end if;
            
            --Items
            if v_parametros.all_items = 'Seleccionar Items' then
            	v_where = v_where || ' and item.id_item = ANY(ARRAY['||v_parametros.id_items||'])';
            elsif v_parametros.all_items = 'Por Clasificacion' then
            	--Obtener los IDs de todas las clasificaciones
				v_ids=alm.f_get_id_clasificaciones_varios(v_parametros.id_clasificacion);
				v_where = v_where || ' and item.id_clasificacion in (' ||v_ids||')';
			end if;
            
            --Almacenes
            if v_parametros.all_alm = 'no' then
            	v_where = v_where || ' and mov.id_almacen in('||v_parametros.id_almacen||')';
            end if;
            
	    	v_consulta:='
	        	select
                mval.id_movimiento_det_valorado ,mov.fecha_mov::date, item.codigo, item.nombre, mval.cantidad,
                mval.costo_unitario, mval.cantidad*mval.costo_unitario as costo_total,fun.desc_funcionario1,
                prov.desc_proveedor,mov.codigo as mov_codigo, mtipo.nombre as tipo_nombre, mtipo.tipo,
                alm.nombre as desc_almacen
                from alm.tmovimiento_det mdet
                inner join alm.tmovimiento_det_valorado mval
                on mval.id_movimiento_det = mdet.id_movimiento_det
                inner join alm.tmovimiento mov
                on mov.id_movimiento = mdet.id_movimiento
                inner join alm.tmovimiento_tipo mtipo
                on mtipo.id_movimiento_tipo = mov.id_movimiento_tipo
                inner join alm.titem item
                on item.id_item = mdet.id_item
                left join orga.vfuncionario fun
                on fun.id_funcionario = mov.id_funcionario
                left join param.vproveedor prov
                on prov.id_proveedor = mov.id_proveedor
                inner join alm.talmacen alm
                on alm.id_almacen = mov.id_almacen
                left join orga.tuo_funcionario uofun
                on uofun.id_funcionario = fun.id_funcionario
                and uofun.fecha_asignacion <= '''||v_parametros.fecha_fin || '''
                left join orga.tuo_funcionario uofun1
                on uofun1.id_funcionario = fun.id_funcionario
                and '''||v_parametros.fecha_fin || ''' BETWEEN uofun1.fecha_asignacion and uofun1.fecha_finalizacion
                where mval.cantidad > 0
                and mov.estado_mov = ''finalizado'' and ';
                
				v_consulta:=v_consulta||v_parametros.filtro;
                v_consulta = v_consulta || v_where;
				v_consulta:=v_consulta||' order by '||v_parametros.ordenacion||' '||v_parametros.dir_ordenacion ||' limit '||v_parametros.cantidad||' offset '||v_parametros.puntero;
                raise notice '%',v_consulta;
	        return v_consulta;	
	    end;
        
    /*********************************   
     #TRANSACCION:  'SAL_REITEN_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        RCM
     #FECHA:        13/08/2013
    ***********************************/
	elsif(p_transaccion='SAL_REITEN_CONT')then
    
        begin
        	--Fecha
            if v_parametros.fecha_ini is not null and v_parametros.fecha_fin is not null then
				v_where = ' and date_trunc(''day'',mov.fecha_mov) between ''' ||v_parametros.fecha_ini||''' and ''' || v_parametros.fecha_fin || '''';
            else
            	raise exception 'Fechas no definidas';
            end if;
            
        	--Tipo de Movimiento
			if v_parametros.tipo_mov = 'ingreso' then
				v_where = ' and mtipo.tipo = ''ingreso''';
			elsif v_parametros.tipo_mov = 'salida' then
				v_where = ' and mtipo.tipo = ''salida''';
			end if;
            
            --Solicitante
            if v_parametros.tipo_sol = 'func' then
                if v_parametros.all_funcionario = 'Seleccionar Funcionarios' then
	            	v_where = v_where || ' and fun.id_funcionario = ANY(ARRAY['||v_parametros.id_funcionario||'])';
	            elsif v_parametros.all_funcionario = 'Por Organigrama' then
	            	--Obtener los IDs de todos los organigramas
					v_ids=orga.f_get_id_uo(v_parametros.id_estructura_uo);
					v_where = v_where || ' and uofun.id_uo in (' ||v_ids||')';
				end if;
                
            elsif v_parametros.tipo_sol = 'prov' then
            	if coalesce(v_parametros.id_proveedor,'') != '' then
            		v_where = v_where || ' and prov.id_proveedor in (' || v_parametros.id_proveedor || ')';
                end if;
            end if;
            
            --Items
            if v_parametros.all_items = 'Seleccionar Items' then
            	v_where = v_where || ' and item.id_item = ANY(ARRAY['||v_parametros.id_items||'])';
            elsif v_parametros.all_items = 'Por Clasificacion' then
            	--Obtener los IDs de todas las clasificaciones
				v_ids=alm.f_get_id_clasificaciones_varios(v_parametros.id_clasificacion);
				v_where = v_where || ' and item.id_clasificacion in (' ||v_ids||')';
			end if;
            
            --Almacenes
            if v_parametros.all_alm = 'no' then
            	v_where = v_where || ' and mov.id_almacen in('||v_parametros.id_almacen||')';
            end if;
	
	    	v_consulta:='
	        	select
               	count(mval.id_movimiento_det_valorado)
                from alm.tmovimiento_det mdet
                inner join alm.tmovimiento_det_valorado mval
                on mval.id_movimiento_det = mdet.id_movimiento_det
                inner join alm.tmovimiento mov
                on mov.id_movimiento = mdet.id_movimiento
                inner join alm.tmovimiento_tipo mtipo
                on mtipo.id_movimiento_tipo = mov.id_movimiento_tipo
                inner join alm.titem item
                on item.id_item = mdet.id_item
                left join orga.vfuncionario fun
                on fun.id_funcionario = mov.id_funcionario
                left join param.vproveedor prov
                on prov.id_proveedor = mov.id_proveedor
                inner join alm.talmacen alm
                on alm.id_almacen = mov.id_almacen
                left join orga.tuo_funcionario uofun
                on uofun.id_funcionario = fun.id_funcionario
                and uofun.fecha_asignacion <= '''||v_parametros.fecha_fin || '''
                left join orga.tuo_funcionario uofun1
                on uofun1.id_funcionario = fun.id_funcionario
                and '''||v_parametros.fecha_fin || ''' BETWEEN uofun1.fecha_asignacion and uofun1.fecha_finalizacion
                where mval.cantidad > 0
                and mov.estado_mov = ''finalizado'' and ';
                
			v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta = v_consulta || v_where;

			return v_consulta;
         end;
     
	else
  		raise exception 'Transacción inexistente';	
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