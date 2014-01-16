CREATE FUNCTION f_tri_talmacen_gestion (
)
RETURNS trigger AS
$body$
/*
Autor: RCM
Fecha: 02/01/2013
Descripción: Verifica que al eliminar un registro no tenga movimientos en su gestión
*/

DECLARE

	v_gestion integer;

BEGIN

	if TG_OP = 'DELETE' then

    	select ges.gestion
        into v_gestion
        from alm.talmacen_gestion ages
        inner join param.tgestion ges
        on ges.id_gestion = ages.id_gestion
        where ages.id_almacen_gestion = OLD.id_almacen_gestion;

    	if exists(select 1 from alm.tmovimiento
        		where to_char(fecha_mov,'yyyy')=v_gestion::varchar ) then
			raise exception 'No se puede eliminar la Gestión porque existen movimientos registrados';
        end if;
    
    end if;

    return NULL;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER;