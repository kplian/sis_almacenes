CREATE OR REPLACE FUNCTION alm.f_get_codigo_clasificacion_rec (
  p_id_clasificacion integer,
  p_padres_hijos varchar = 'hijos'::character varying
)
RETURNS varchar AS
$body$
DECLARE

	v_ids varchar;
    v_rec record;
    v_loc varchar;

BEGIN

	--Obtencion de los IDS
    v_ids = alm.f_get_id_clasificaciones (p_id_clasificacion,p_padres_hijos);
    v_loc='';
    
    for v_rec in execute('select *
    					from alm.tclasificacion
                        where id_clasificacion in ('||v_ids||')
                        order by id_clasificacion') loop
    	v_loc = v_loc || '.'|| coalesce(v_rec.codigo,'S/C');
    
    end loop;
    
    v_loc = substr(v_loc,2,length(v_loc));
    
    return v_loc;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;