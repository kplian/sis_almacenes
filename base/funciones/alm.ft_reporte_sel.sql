-- Function: alm.ft_reporte_sel(integer, integer, character varying, character varying)

-- DROP FUNCTION alm.ft_reporte_sel(integer, integer, character varying, character varying);

CREATE OR REPLACE FUNCTION alm.ft_reporte_sel(p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
  RETURNS character varying AS
$BODY$
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
				
				v_where = 'where itm.id_clasificacion in (' ||v_ids||') and ';
			else
				raise exception 'Error desconocido';
			end if;
			
			--Verifica si se debe incluir los items que tengan existencias iguales a cero a la fecha
			if(v_parametros.saldo_cero = 'no') then
				v_where = v_where || ' (alm.f_get_saldo_fisico_item(id_item, '||v_parametros.id_almacen||', date('''|| v_parametros.fecha_hasta||'''))) > 0 and ';
			end if;
	
	    	v_consulta:='
	        	select 
				itm.id_item,
				itm.codigo,
				itm.nombre,
				umed.codigo unidad_medida,
				(alm.f_get_codigo_clasificacion_rec(itm.id_clasificacion,''padres'') || '' - ''||cla.nombre)::varchar clasificacion,
				alm.f_get_saldo_fisico_item(id_item, '||v_parametros.id_almacen||', date('''|| v_parametros.fecha_hasta||''')) cantidad,
				alm.f_get_saldo_valorado_item(id_item, '||v_parametros.id_almacen||', date('''||v_parametros.fecha_hasta||''')) costo
				from alm.titem itm
				inner join param.tunidad_medida umed on umed.id_unidad_medida = itm.id_unidad_medida
				inner join alm.tclasificacion cla on cla.id_clasificacion = itm.id_clasificacion ' ||
				v_where||'itm.codigo is not null and ';
                
			
			v_consulta:=v_consulta||v_parametros.filtro;
	        v_consulta:=v_consulta||' order by alm.f_get_codigo_clasificacion_rec(itm.id_clasificacion,''padres'')'||' '||v_parametros.dir_ordenacion||' limit '||v_parametros.cantidad||' offset '||v_parametros.puntero;        	
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
  end if;
EXCEPTION
  WHEN OTHERS THEN
    v_respuesta='';
    v_respuesta=pxp.f_agrega_clave(v_respuesta,'mensaje',SQLERRM);
    v_respuesta=pxp.f_agrega_clave(v_respuesta,'codigo_error',SQLSTATE);
    v_respuesta=pxp.f_agrega_clave(v_respuesta,'procedimiento',v_nombre_funcion);
    raise exception '%',v_respuesta;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION alm.ft_reporte_sel(integer, integer, character varying, character varying)
  OWNER TO postgres;
