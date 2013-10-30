CREATE OR REPLACE FUNCTION alm.f_generar_cbtes (
  p_id_usuario integer,
  p_codigo_plantilla varchar,
  p_id_movimiento integer,
  p_parametros public.hstore
)
RETURNS integer AS
$body$
/*
Autor: RCM
Fecha: 21/10/2013
Descripción: Generación de comprobantes de almacén a partir de una PLantilla de Comprobante, y empleando el generador
			de Comprobantes de PXP
*/

DECLARE

	v_resp 		varchar;
    v_resp_cbte integer;

BEGIN
	-------------------
	--(1) VALIDACIONES
    -------------------
    --Plantilla no Nula
    if p_codigo_plantilla is null then
       	raise exception 'La Plantilla de Comprobante no puede ser nula';
    end if;
    --Existencia de la plantilla
    if not exists(select 1 from conta.tplantilla_comprobante
    			where codigo = p_codigo_plantilla) then
    	raise exception 'Plantilla de Comprobante inexistente (%)',p_codigo_plantilla;
    end if;
    
    ----------------------------------------------
    --(2) GENERACION DE COMPR0BANTE POR PLANTILLA
    ----------------------------------------------
    if p_codigo_plantilla = 'INGALM' then  --INGRESO A ALMACEN
    
        --Verificación de existencia del movimiento
        if not exists(select 1 from alm.tmovimiento
        			where id_movimiento = p_id_movimiento) then
    		raise exception 'Movimiento nulo o Inexistente';
        end if;
        --Verifica que sea un ingreso
        if exists(select 1 from alm.tmovimiento mov
        			inner join alm.tmovimiento_tipo mtip
                    on mtip.id_movimiento_tipo = mov.id_movimiento_tipo
        			where id_movimiento = p_id_movimiento
                    and mtip.tipo = 'ingreso') then
        	--Generación de Ingreso a Almacén
            
        	v_resp_cbte = conta.f_gen_comprobante (p_id_movimiento,p_codigo_plantilla,p_id_usuario);

            v_resp = 'Comprobante generado';
		else
        	v_resp = 'No es un ingreso, nada que hacer';
        end if;
        
        
    elsif p_codigo_plantilla = 'SALALM' then
    
    	--Verificación de existencia del movimiento
        if not exists(select 1 from alm.tmovimiento_grupo
        			where id_movimiento_grupo = p_id_movimiento) then
    		raise exception 'Registro inexistente';
        end if;

        --Generación de Ingreso a Almacén
        v_resp_cbte = conta.f_gen_comprobante (p_id_movimiento,p_codigo_plantilla,p_id_usuario);
		
		v_resp = 'Comprobante generado';
		
    else
    	raise exception 'No implementado la generación para la Plantilla %',p_codigo_plantilla;
    end if;

	--Respuesta
    return v_resp_cbte;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;