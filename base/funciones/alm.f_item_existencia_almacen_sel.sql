CREATE OR REPLACE FUNCTION alm.f_item_existencia_almacen_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:   SISTEMA DE GESTION DE ALMACENES
 FUNCION:     alm.f_get_item_existencia_almacen
 DESCRIPCION:   Función que a partir de un id_item y una fecha lista los almacenes
 			y la cantidad donde hayan existencia del item solicitado

 AUTOR:     RCM
 FECHA:     01/08/2013	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
	v_fecha				date;
			    
BEGIN

	v_nombre_funcion = 'alm.f_item_existencia_almacen_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_ITMALM_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:			rcm
 	#FECHA:			01/08/2013
	***********************************/

	if(p_transaccion='SAL_ITMALM_SEL')then
     				
    	begin
    		if not exists(select 1 from alm.titem
    					where id_item = v_parametros.id_item) then
    			raise exception 'Material/Producto inexistente';
            end if;
            
            if pxp.f_existe_parametro(p_tabla,'fecha') then
            	if v_parametros.fecha is null then
            		v_fecha = now();
            	else
            		v_fecha = v_parametros.fecha;
            	end if;
            else
            	v_fecha = now();
            end if;

            v_consulta:='
            with saldos as
            (select
            mov.id_almacen, mdet.id_item, mdet.cantidad
            from alm.tmovimiento mov
            inner join alm.tmovimiento_det mdet
            on mdet.id_movimiento = mov.id_movimiento
            inner join alm.tmovimiento_tipo mtipo
            on mtipo.id_movimiento_tipo = mov.id_movimiento_tipo
            where mov.estado_mov = ''finalizado''
            and mtipo.tipo = ''ingreso''
            and date_trunc(''day'',mov.fecha_mov) <= ''' || v_fecha || '''
            and mdet.id_item = ' || v_parametros.id_item || '
            union all
            select
            mov.id_almacen,mdet.id_item, -mdet.cantidad
            from alm.tmovimiento mov
            inner join alm.tmovimiento_det mdet
            on mdet.id_movimiento = mov.id_movimiento
            inner join alm.tmovimiento_tipo mtipo
            on mtipo.id_movimiento_tipo = mov.id_movimiento_tipo
            where mov.estado_mov = ''finalizado''
            and mtipo.tipo = ''salida''
            and date_trunc(''day'',mov.fecha_mov) <=  ''' || v_fecha || '''
            and mdet.id_item = ' || v_parametros.id_item || ')
            select
            s.id_almacen, s.id_item, sum(s.cantidad),
            a.codigo,a.nombre as almacen
            from saldos s
            inner join alm.talmacen a
            on a.id_almacen = s.id_almacen
            group by s.id_almacen, s.id_item,a.codigo,a.nombre
            having sum(s.cantidad)>0
            order by id_item';

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_ITMALM_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:			rcm
 	#FECHA:			01/08/2013
	***********************************/

	elsif(p_transaccion='SAL_ITMALM_CONT')then

		begin
			if not exists(select 1 from alm.titem
    					where id_item = v_parametros.id_item) then
    			raise exception 'Material/Producto inexistente';
            end if;
            
            if pxp.f_existe_parametro(p_tabla,'fecha') then
            	if v_parametros.fecha is null then
            		v_fecha = now();
            	else
            		v_fecha = v_parametros.fecha;
            	end if;
            else
            	v_fecha = now();
            end if;

            v_consulta:='
            with saldos as
            (select
            mov.id_almacen, mdet.id_item, mdet.cantidad
            from alm.tmovimiento mov
            inner join alm.tmovimiento_det mdet
            on mdet.id_movimiento = mov.id_movimiento
            inner join alm.tmovimiento_tipo mtipo
            on mtipo.id_movimiento_tipo = mov.id_movimiento_tipo
            where mov.estado_mov = ''finalizado''
            and mtipo.tipo = ''ingreso''
            and date_trunc(''day'',mov.fecha_mov) <= ''' || v_fecha || '''
            and mdet.id_item = ' || v_parametros.id_item || '
            union all
            select
            mov.id_almacen,mdet.id_item, -mdet.cantidad
            from alm.tmovimiento mov
            inner join alm.tmovimiento_det mdet
            on mdet.id_movimiento = mov.id_movimiento
            inner join alm.tmovimiento_tipo mtipo
            on mtipo.id_movimiento_tipo = mov.id_movimiento_tipo
            where mov.estado_mov = ''finalizado''
            and mtipo.tipo = ''salida''
            and date_trunc(''day'',mov.fecha_mov) <=  ''' || v_fecha || '''
            and mdet.id_item = ' || v_parametros.id_item || ')
            select
            count(distinct s.id_almacen)
            from saldos s
            inner join alm.talmacen a
            on a.id_almacen = s.id_almacen';

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