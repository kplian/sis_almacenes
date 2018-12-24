CREATE OR REPLACE FUNCTION alm.f_fun_inicio_movimiento_wf (
  p_id_usuario integer,
  p_id_usuario_ai integer,
  p_usuario_ai varchar,
  p_id_estado_wf integer,
  p_id_proceso_wf integer,
  p_codigo_estado varchar
)
RETURNS boolean AS
$body$
/*
*
*  Autor:   RAC
*  DESC:    funcion que actualiza los estados despues del registro de un retroceso en el plan de pago
*  Fecha:   10/06/2013
*
*/

DECLARE

	v_nombre_funcion   	text;
    v_resp    			varchar;
    v_mensaje 			varchar;
    
    v_registros 		record;
    v_regitros_ewf		record;
    v_monto_ejecutar_mo  numeric;
    v_id_uo	integer;
    v_id_usuario_excepcion	integer;
    v_resp_doc   boolean;
    v_id_usuario_firma	integer;
   
	
    
BEGIN

	 v_nombre_funcion = 'alm.f_fun_inicio_movimiento_wf';
         
     
     
     
        
    -- actualiza estado en la solicitud
    update alm.tmovimiento   set 
       id_estado_wf =  p_id_estado_wf,
       estado_mov = p_codigo_estado,
       id_usuario_mod=p_id_usuario,
       id_usuario_ai = p_id_usuario_ai,
       usuario_ai = p_usuario_ai,
       fecha_mod=now()
                   
    where id_proceso_wf = p_id_proceso_wf;
   
   

RETURN   TRUE;



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