CREATE OR REPLACE FUNCTION alm.ft_movimiento_tipo_item_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_movimiento_tipo_item_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tmovimiento_tipo_item'
 AUTOR: 		 (admin)
 FECHA:	        21-08-2013 14:31:37
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
	v_id_movimiento_tipo_item	integer;
	v_sql					varchar;
		    
BEGIN

    v_nombre_funcion = 'alm.ft_movimiento_tipo_item_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_TIMITE_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		21-08-2013 14:31:37
	***********************************/

	if(p_transaccion='SAL_TIMITE_INS')then
					
        begin
        
--        raise exception 'id_items: %   id_clasificaciones: %   id_movimiento_tipo: %',v_parametros.id_items,v_parametros.id_clasificaciones,v_parametros.id_movimiento_tipo;

        	--Inserción de los Items
        	if coalesce(v_parametros.id_items,'') != '' then
                v_sql = '
                        insert into alm.tmovimiento_tipo_item(
                        id_item,id_movimiento_tipo,estado_reg, id_usuario_reg, fecha_reg)
                        select
                        ite.id_item,' || v_parametros.id_movimiento_tipo ||', ''activo'','||p_id_usuario||',now()
                        from alm.titem ite
                        where ite.id_item = ANY(ARRAY['||v_parametros.id_items||'])
                        and id_item not in (select id_item
                                            from alm.tmovimiento_tipo_item
                                            where id_movimiento_tipo = ' || v_parametros.id_movimiento_tipo ||')';

				 raise notice '%',v_sql;	            								
                execute(v_sql);
            end if;
        	
        	--Inserción de las clasificaciones
            if coalesce(v_parametros.id_clasificaciones,'') != '' then
                v_sql = '
                        insert into alm.tmovimiento_tipo_item(
                        id_clasificacion,id_movimiento_tipo,estado_reg, id_usuario_reg, fecha_reg)
                        select
                        cla.id_clasificacion,' || v_parametros.id_movimiento_tipo ||', ''activo'','||p_id_usuario||',now()
                        from alm.tclasificacion cla
                        where cla.id_clasificacion = ANY(ARRAY['||v_parametros.id_clasificaciones||'])
                        and id_clasificacion not in (select id_clasificacion
                                            from alm.tmovimiento_tipo_item
                                            where id_movimiento_tipo = ' || v_parametros.id_movimiento_tipo ||')';
                raise notice '%',v_sql;		
                execute(v_sql);
            end if;
        
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Items/Clasificaciones registradas'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento_tipo',v_parametros.id_movimiento_tipo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_TIMITE_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		21-08-2013 14:31:37
	***********************************/

	elsif(p_transaccion='SAL_TIMITE_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from alm.tmovimiento_tipo_item
            where id_movimiento_tipo_item=v_parametros.id_movimiento_tipo_item;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Movimiento/Item eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento_tipo_item',v_parametros.id_movimiento_tipo_item::varchar);
              
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