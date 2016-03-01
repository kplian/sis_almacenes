--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.f_codigo_clasificaciones_recursivo (
  v_id_clasificacion integer
)
RETURNS varchar AS
$body$
DECLARE
  v_codigo varchar;
  v_id_clasificacion_padre integer;
  v_codigo_acumulado varchar;
BEGIN
	SELECT
    	cla.codigo, cla.id_clasificacion_fk 
        into v_codigo, v_id_clasificacion_padre
    FROM alm.tclasificacion cla
    WHERE cla.id_clasificacion = v_id_clasificacion;
    
    IF(v_id_clasificacion_padre is null) THEN
    	RETURN v_codigo;
    ELSE
    	v_codigo_acumulado = alm.f_codigo_clasificaciones_recursivo(v_id_clasificacion_padre);
    	RETURN v_codigo_acumulado ||'.'|| v_codigo;
    END IF;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;