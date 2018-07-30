CREATE OR REPLACE FUNCTION alm.f_existencias_almacen_sel (
  p_id_almacen integer,
  p_fecha_hasta date,
  p_condicion varchar,
  p_filtro varchar
)
RETURNS SETOF record AS
$body$
/**************************************************************************
SISTEMA DE ALMACENES
***************************************************************************
 SCRIPT: 		kalm.f_existencias_almacen_sel
 DESCRIPCIÓN: 	Función para listar las existencias de los materiales
 AUTOR: 		RCM
 FECHA:			02/01/2013
 COMENTARIOS:	
***************************************************************************
 HISTORIA DE MODIFICACIONES:

 DESCRIPCIÓN:
 AUTOR:       
 FECHA:      

***************************************************************************/
--------------------------
-- CUERPO DE LA FUNCIÓN --
--------------------------

DECLARE

	v_nombre_funcion   	text;
	v_resp				varchar;
	v_consulta 			varchar;
    v_rec 				record;

BEGIN
    
	v_nombre_funcion = 'alm.f_existencias_almacen_sel';  
    
    v_consulta:='
	        	select 
				itm.id_item,
				itm.codigo,
				case when itm.codigo like ''3.4.1%'' then itm.descripcion
		    	when itm.codigo like ''3.4.2%'' then itm.descripcion
            	else itm.nombre end as nombre,
				umed.codigo unidad_medida,
				(alm.f_get_codigo_clasificacion_rec(itm.id_clasificacion,''padres'') || '' - ''||cla.nombre)::varchar clasificacion,
				alm.f_get_saldo_fisico_item(itm.id_item, '||p_id_almacen||', date('''|| p_fecha_hasta||''')) cantidad,
				alm.f_get_saldo_valorado_item(itm.id_item, '||p_id_almacen||', date('''||p_fecha_hasta||''')) costo,
                almsto.cantidad_min,
                almsto.cantidad_alerta_amarilla,
                almsto.cantidad_alerta_roja                
				from alm.titem itm
				inner join param.tunidad_medida umed on umed.id_unidad_medida = itm.id_unidad_medida
                inner join alm.talmacen_stock almsto on almsto.id_item = itm.id_item and 
                							almsto.estado_reg = ''activo'' and  almsto.id_almacen = ' || p_id_almacen ||'               								
				inner join alm.tclasificacion cla on cla.id_clasificacion = itm.id_clasificacion ' ||
				p_condicion||'itm.codigo is not null and ';
			
    v_consulta:=v_consulta||p_filtro;
    v_consulta:=v_consulta||' order by alm.f_get_codigo_clasificacion_rec(itm.id_clasificacion,''padres'')';
    
    for v_rec in execute(v_consulta) loop
    	return next v_rec;
    end loop;
    
    return; 



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
COST 100 ROWS 1000;