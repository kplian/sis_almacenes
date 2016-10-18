----------------------------- SQL ---------------------------------
CREATE OR REPLACE FUNCTION alm.ft_movimiento_tipo_almacen_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_movimiento_tipo_almacen_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tmovimiento_tipo_almacen'
 AUTOR: 		Gonzalo Sarmiento Sejas
 FECHA:	        13-07-2016 19:37:32
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_movimiento_tipo_almacen	integer;
			    
BEGIN

    v_nombre_funcion = 'alm.ft_movimiento_tipo_almacen_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_TPMOVALM_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas
 	#FECHA:		13-07-2016 19:37:32
	***********************************/

	if(p_transaccion='SAL_TPMOVALM_INS')then
					
        begin
        	IF EXISTS (SELECT 1
            	FROM alm.tmovimiento_tipo_almacen
                WHERE id_movimiento_tipo=v_parametros.id_movimiento_tipo
                and id_almacen=v_parametros.id_almacen) THEN
            	
                raise exception 'El almacen ya esta relacionado al Tipo de Movimiento';
                
            END IF;
                
        	--Sentencia de la insercion
        	insert into alm.tmovimiento_tipo_almacen(
			id_movimiento_tipo,
			id_almacen,
			estado_reg,
			id_usuario_reg,
			usuario_ai,
			fecha_reg,
			id_usuario_ai,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.id_movimiento_tipo,
			v_parametros.id_almacen,
			'activo',
			p_id_usuario,
			v_parametros._nombre_usuario_ai,
			now(),
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_movimiento_tipo_almacen into v_id_movimiento_tipo_almacen;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Almacen almacenado(a) con exito (id_movimiento_tipo_almacen'||v_id_movimiento_tipo_almacen||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento_tipo_almacen',v_id_movimiento_tipo_almacen::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_TPMOVALM_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas
 	#FECHA:		13-07-2016 19:37:32
	***********************************/

	elsif(p_transaccion='SAL_TPMOVALM_MOD')then

		begin
			--Sentencia de la modificacion
			update alm.tmovimiento_tipo_almacen set
			id_movimiento_tipo = v_parametros.id_movimiento_tipo,
			id_almacen = v_parametros.id_almacen,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_movimiento_tipo_almacen=v_parametros.id_movimiento_tipo_almacen;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Almacen modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento_tipo_almacen',v_parametros.id_movimiento_tipo_almacen::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_TPMOVALM_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		Gonzalo Sarmiento Sejas
 	#FECHA:		13-07-2016 19:37:32
	***********************************/

	elsif(p_transaccion='SAL_TPMOVALM_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from alm.tmovimiento_tipo_almacen
            where id_movimiento_tipo_almacen=v_parametros.id_movimiento_tipo_almacen;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Almacen eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento_tipo_almacen',v_parametros.id_movimiento_tipo_almacen::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

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