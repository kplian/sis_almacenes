CREATE OR REPLACE FUNCTION alm.ft_rep_kardex_item_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS SETOF record AS
$body$
/*
Fecha: 04/07/2013
Autor: RCM
Prop�sito: Devolver el kardex de un item de uno o varios almacenes en un periodo de tiempo
*/
DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
	v_saldo_fis			numeric;
    v_saldo_val			numeric;
    v_saldo_fis_ant		numeric;
    v_saldo_val_ant		numeric;
    v_rec				record;
    /*a_cad_alm			varchar[];
    a_id_alm			integer[];
    v_tam 				integer;
    v_i					integer;*/
    

BEGIN

	v_nombre_funcion = 'alm.ft_rep_kardex_item_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_RKARIT_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:			rcm
 	#FECHA:			04/07/2013
	***********************************/

	if(p_transaccion='SAL_RKARIT_SEL')then
     				
    	begin

            --1. Crear tabla temporal con un solo mes, que adelante sera complementada con mas campos para mas meses si es el caso
            create temp table tt_rep_kardex_item(
              id serial,
              fecha timestamp,
              nro_mov varchar,
              almacen varchar,
              motivo varchar,
              ingreso numeric,
              salida numeric,
              saldo numeric,
              costo_unitario numeric,
              ingreso_val numeric,
              salida_val numeric,
              saldo_val numeric,
              id_movimiento integer
            ) on commit drop;
            
            --2. Carga el saldo anterior
			/*a_cad_alm= string_to_array(v_parametros.id_almacen,',');
            v_tam = coalesce(array_length(a_cad_alm, 1),0);

            for v_i in 1..v_tam loop
            	a_id_alm[v_i]=a_cad_alm[v_i]::integer;
            end loop;*/
            
            --raise exception ' %   %   %',v_parametros.id_item,v_parametros.id_almacen,v_parametros.fecha_ini-1;
            
            v_saldo_fis_ant = alm.f_get_saldo_item(v_parametros.id_item,v_parametros.id_almacen,v_parametros.fecha_ini-1);
            v_saldo_val_ant = alm.f_get_saldo_item_val(v_parametros.id_item,v_parametros.id_almacen,v_parametros.fecha_ini-1);
            
            --raise exception '%   %',v_saldo_fis_ant,v_saldo_val_ant;
            
            insert into tt_rep_kardex_item(
            fecha,almacen,ingreso,salida,saldo,ingreso_val,salida_val,saldo_val
            ) values(
            v_parametros.fecha_ini-1,'Saldo Anterior',v_saldo_fis_ant,0,v_saldo_fis_ant,v_saldo_val_ant,0,v_saldo_val_ant
            );

			--3.Carga los datos en la table temporal
            v_consulta = '
            insert into tt_rep_kardex_item(
            fecha,nro_mov,almacen,motivo,ingreso,salida,
            ingreso_val,salida_val,costo_unitario,id_movimiento
            )
            select
            mov.fecha_mov as fecha,
            mov.codigo as nro_mov,
            alma.codigo as almacen,
            mtipo.nombre as motivo,
            case mtipo.tipo
                when ''ingreso'' then sum(mdval.cantidad)
                else 0
            end as ingreso,
            case mtipo.tipo
                when ''salida'' then sum(mdval.cantidad)
                else 0
            end as salida,
            case mtipo.tipo
                when ''ingreso'' then coalesce(sum(mdval.cantidad),0) * coalesce(mdval.costo_unitario,0)
                else 0
            end as ingreso_val,
            case mtipo.tipo
                when ''salida'' then coalesce(sum(mdval.cantidad),0) * coalesce(mdval.costo_unitario,0)
                else 0
            end as salida_val,
            case mtipo.tipo
                when ''ingreso'' then coalesce(mdval.costo_unitario,0)
                when ''salida'' then coalesce(mdval.costo_unitario,0)
                else 0
            end as costo_unitario,
            mov.id_movimiento
            from alm.tmovimiento mov
            inner join alm.tmovimiento_det mdet
            on mdet.id_movimiento = mov.id_movimiento
            inner join alm.tmovimiento_det_valorado mdval
            on mdval.id_movimiento_det = mdet.id_movimiento_det
            inner join alm.titem item
            on item.id_item = mdet.id_item
            inner join alm.talmacen alma
            on alma.id_almacen = mov.id_almacen
            inner join alm.tmovimiento_tipo mtipo
            on mtipo.id_movimiento_tipo = mov.id_movimiento_tipo
            where mov.estado_mov = ''finalizado''
            and mdet.cantidad > 0';
            
            if coalesce(v_parametros.id_almacen,'') != '' then
            	v_consulta = v_consulta || ' and mov.id_almacen in ('||v_parametros.id_almacen||')';
            end if;
            
            v_consulta = v_consulta || '
            and date_trunc(''day'',mov.fecha_mov) between ''' || v_parametros.fecha_ini||''' and ''' || v_parametros.fecha_fin ||'''
            and mdet.id_item = ' || v_parametros.id_item ||'
            group by mov.fecha_mov, mov.codigo, alma.codigo, mtipo.nombre, mov.id_movimiento, mtipo.tipo,mdval.costo_unitario';
            
            raise notice 'RRR: %',v_consulta;
            
            execute(v_consulta);
            
            --4.Calculo de saldos
            v_saldo_fis=0;
            v_saldo_val=0;
            for v_rec in (select * from tt_rep_kardex_item) loop
				v_saldo_fis = v_saldo_fis + coalesce(v_rec.ingreso,0) - coalesce(v_rec.salida,0);
                v_saldo_val = v_saldo_val + coalesce(v_rec.ingreso_val,0) - coalesce(v_rec.salida_val,0);
                
                update tt_rep_kardex_item set
                saldo = v_saldo_fis,
                saldo_val = v_saldo_val
                where id = v_rec.id;
            end loop;

            --5.Resultado
            for v_rec in (select
            			fecha,nro_mov,almacen,motivo,
                        round(ingreso,6),
                        round(salida,6),
                        round(saldo,6),
              			round(costo_unitario,6),
                        round(ingreso_val,6),
                        round(salida_val,6),
              			round(saldo_val,6),
                        id_movimiento
                        from tt_rep_kardex_item
                        order by fecha, nro_mov) loop
                return next v_rec;
            end loop;

        	return;

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
COST 100 ROWS 1000;