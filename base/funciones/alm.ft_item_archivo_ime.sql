--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.ft_item_archivo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		SISTEMA DE ALMACENES
 FUNCION: 		alm.ft_item_archivo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.titem_archivo'
 AUTOR: 		Ariel Ayaviri Omonte
 FECHA:	        15-02-2013
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
	v_id_item_archivo		integer;
			    
BEGIN

    v_nombre_funcion = 'alm.ft_item_archivo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_ITMARCH_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:			Ariel Ayaviri Omonte
 	#FECHA:			06-02-2013
	***********************************/

	if (p_transaccion='SAL_ITMARCH_INS') then
        begin
        	insert into alm.titem_archivo (
                id_usuario_reg,
                fecha_reg,
                estado_reg,
                id_item,
                nombre,
                descripcion
            ) values (
                p_id_usuario,
                now(),
                'activo',
                v_parametros.id_item,
                v_parametros.nombre,
                v_parametros.descripcion
			) RETURNING id_item_archivo into v_id_item_archivo;
               
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo de Item almacenado(a) con exito (id_item_archivo'||v_id_item_archivo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_item_archivo',v_id_item_archivo::varchar);

            --Devuelve la respuesta
            return v_resp;
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_ITMARCH_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:			Ariel Ayaviri Omonte
 	#FECHA:			06-02-2013
	***********************************/

	elsif(p_transaccion='SAL_ITMARCH_MOD')then

		begin
			update alm.titem_archivo set
            	id_usuario_mod = p_id_usuario,
                fecha_mod = now(),
                id_item = v_parametros.id_item,
                nombre = v_parametros.nombre,
                descripcion = v_parametros.descripcion
			where id_item_archivo = v_parametros.id_item_archivo;
            
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo de Item modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_item_archivo',v_parametros.id_item_archivo::varchar);
            
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_ITMARCH_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:			Ariel Ayaviri Omonte
 	#FECHA:			06-02-2013
	***********************************/

	elsif(p_transaccion='SAL_ITMARCH_ELI')then

		begin
			delete from alm.titem_archivo
            where id_item_archivo = v_parametros.id_item_archivo;
               
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo de Item eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_item_archivo',v_parametros.id_item_archivo::varchar);
              
            return v_resp;

		end;
        
    /*********************************    
 	#TRANSACCION:  'SAL_UPARCH_MOD'
 	#DESCRIPCION:	Upload de archivo
 	#AUTOR:			Ariel Ayaviri Omonte
 	#FECHA:			06-02-2013
	***********************************/
    elsif(p_transaccion='SAL_UPARCH_MOD')then
     	begin
        	update alm.titem_archivo set
                archivo = v_parametros.archivo,
                extension = v_parametros.extension
            where id_item_archivo = v_parametros.id_item_archivo;
            
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Archivo modificado con exito '||v_parametros.id_item_archivo); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_item_archivo',v_parametros.id_item_archivo::varchar);
            
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