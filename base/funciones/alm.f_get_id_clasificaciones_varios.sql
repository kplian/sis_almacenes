CREATE OR REPLACE FUNCTION alm.f_get_id_clasificaciones_varios (
  p_id_clasificacion varchar,
  p_padres_hijos varchar = 'hijos'::character varying
)
RETURNS varchar AS
$body$
/*
Autor: RCM
Fecha: 19/07/2013
*/
DECLARE

	v_ids varchar;
	v_sql varchar;

BEGIN

  if p_id_clasificacion is null then
      return '(null)';
  end if;
  
  create temp table tclasificaciones(
  	ids varchar
  ) on commit drop;


  if p_padres_hijos = 'padres' then
  		
        v_sql = 'insert into tclasificaciones
        	WITH RECURSIVE t(id,id_fk,nombre,n) AS (
              SELECT l.id_clasificacion,l.id_clasificacion_fk, l.nombre,1
              FROM alm.tclasificacion l
              WHERE l.id_clasificacion in ('||p_id_clasificacion||')
              UNION ALL
              SELECT l.id_clasificacion,l.id_clasificacion_fk, l.nombre,n+1
              FROM alm.tclasificacion l, t
              WHERE l.id_clasificacion = t.id_fk
          )
          SELECT (pxp.list(id::text))::varchar
          FROM t;';
          
    
    else
      v_sql = 'insert into tclasificaciones
      	WITH RECURSIVE t(id,id_fk,nombre,n) AS (
            SELECT l.id_clasificacion,l.id_clasificacion_fk, l.nombre,1
            FROM alm.tclasificacion l
            WHERE l.id_clasificacion in ('||p_id_clasificacion||')
            UNION ALL
            SELECT l.id_clasificacion,l.id_clasificacion_fk, l.nombre,n+1
            FROM alm.tclasificacion l, t
            WHERE l.id_clasificacion_fk = t.id
        )
        SELECT (pxp.list(id::text))::varchar
        FROM t;';
    
    end if;
    execute(v_sql);
    
    select ids into v_ids from tclasificaciones;
    
    return v_ids;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;