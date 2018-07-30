CREATE FUNCTION alm.ftmp_mig_comibol (
  p_id_movimiento INTEGER
)
RETURNS varchar AS
$body$
/*
Autor: RCM
Fecha: 03/03/2016
Proposito: FUncion que genera el detalle para el movimiento inicial COMIBOL
*/
DECLARE

	v_rec record;
    v_id_movimiento_det integer;

BEGIN

	for v_rec in (select * from alm.tmp_mig_comibol a
    			 inner join alm.titem b on b.codigo = a.codigo1||'.'||a.codigo2||'.'||a.codigo3||'.'||a.codigo4
    			 where a.lugar = 'LP') loop
                 
    	insert into alm.tmovimiento_det(
            id_usuario_reg,
            fecha_reg,
            estado_reg,
            id_movimiento,
            id_item,
            cantidad,
            cantidad_solicitada,
            costo_unitario
        ) VALUES (
            1,
            now(),
            'activo',
            p_id_movimiento,
            v_rec.id_item,
            v_rec.cantidad,
            v_rec.cantidad,
            v_rec.importe/v_rec.cantidad
        ) RETURNING id_movimiento_det into v_id_movimiento_det;
        
        insert into alm.tmovimiento_det_valorado (
            id_usuario_reg,
            fecha_reg,
            estado_reg,
            id_movimiento_det,
            cantidad,
            costo_unitario,
            aux_saldo_fisico
        ) VALUES (
            1,
            now(),
            'activo',
            v_id_movimiento_det,
            v_rec.cantidad,
            v_rec.importe/v_rec.cantidad,
            v_rec.cantidad
        );
    end loop;
    
    return 'done';
    			
    



END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER;