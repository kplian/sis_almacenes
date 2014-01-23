CREATE OR REPLACE FUNCTION alm.ft_movimiento_grupo_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Sistema de Almacenes
 FUNCION: 		alm.ft_movimiento_grupo_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'alm.tmovimiento_grupo'
 AUTOR: 		 (admin)
 FECHA:	        18-10-2013 21:26:04
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
	v_id_movimiento_grupo	integer;
	v_result				varchar;
	v_plantilla_cbte		varchar;
	v_rec					record;
	v_id_int_comprobante	integer;
			    
BEGIN

    v_nombre_funcion = 'alm.ft_movimiento_grupo_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'SAL_MOVGRU_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-10-2013 21:26:04
	***********************************/

	if(p_transaccion='SAL_MOVGRU_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into alm.tmovimiento_grupo(
			id_int_comprobante,
			descripcion,
			id_almacen,
			fecha_ini,
			estado,
			fecha_fin,
			estado_reg,
			id_usuario_reg,
			fecha_reg,
			fecha_mod,
			id_usuario_mod,
			id_depto_conta
          	) values(
			v_parametros.id_int_comprobante,
			v_parametros.descripcion,
			v_parametros.id_almacen,
			v_parametros.fecha_ini,
			'borrador',
			v_parametros.fecha_fin,
			'activo',
			p_id_usuario,
			now(),
			null,
			null,
			v_parametros.id_depto_conta
							
			)RETURNING id_movimiento_grupo into v_id_movimiento_grupo;
			
			--Inserta los movimientos en el detalle
			insert into alm.tmovimiento_grupo_det (
				id_usuario_reg,
				fecha_reg,
				estado_reg,
				id_movimiento_grupo,
				id_movimiento
			)
			select
			p_id_usuario,
			now(),
			'activo',
			v_id_movimiento_grupo,
			mov.id_movimiento
			from alm.tmovimiento mov
			inner join alm.tmovimiento_tipo mtip
			on mtip.id_movimiento_tipo = mov.id_movimiento_tipo
			where mtip.tipo = 'salida'
			and mov.estado_mov = 'finalizado'
			and mov.fecha_mov between v_parametros.fecha_ini and v_parametros.fecha_fin
			and mov.id_almacen = v_parametros.id_almacen
			and mov.id_int_comprobante is null;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupo Movimientos almacenado(a) con exito (id_movimiento_grupo'||v_id_movimiento_grupo||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento_grupo',v_id_movimiento_grupo::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'SAL_MOVGRU_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-10-2013 21:26:04
	***********************************/

	elsif(p_transaccion='SAL_MOVGRU_MOD')then

		begin
			--Sentencia de la modificacion
			update alm.tmovimiento_grupo set
			id_int_comprobante = v_parametros.id_int_comprobante,
			descripcion = v_parametros.descripcion,
			id_almacen = v_parametros.id_almacen,
			fecha_ini = v_parametros.fecha_ini,
			fecha_fin = v_parametros.fecha_fin,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_depto_conta = v_parametros.id_depto_conta
			where id_movimiento_grupo=v_parametros.id_movimiento_grupo;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupo Movimientos modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento_grupo',v_parametros.id_movimiento_grupo::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'SAL_MOVGRU_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-10-2013 21:26:04
	***********************************/

	elsif(p_transaccion='SAL_MOVGRU_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from alm.tmovimiento_grupo
            where id_movimiento_grupo=v_parametros.id_movimiento_grupo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupo Movimientos eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento_grupo',v_parametros.id_movimiento_grupo::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
		
	/*********************************    
 	#TRANSACCION:  'SAL_MOVGRU_GEN'
 	#DESCRIPCION:	Generación de comprobante 
 	#AUTOR:			rcm	
 	#FECHA:			29/10/2013
	***********************************/

	elsif(p_transaccion='SAL_MOVGRU_GEN')then

		begin
			if not exists(select 1 from alm.tmovimiento_grupo
						where id_movimiento_grupo = v_parametros.id_movimiento_grupo) then
				raise exception 'Registro no encontrado';
			end if;
			if exists(select 1 from alm.tmovimiento_grupo
						where id_movimiento_grupo = v_parametros.id_movimiento_grupo
						and estado != 'borrador') then
				raise exception 'El Registro debería estar en estado Borrador';
			end if;
			
			--DEfine la plantilla del comprobante
			v_plantilla_cbte = 'SALALM';

			v_id_int_comprobante = alm.f_generar_cbtes(p_id_usuario,v_plantilla_cbte,v_parametros.id_movimiento_grupo::integer,hstore(v_parametros));
            
            --Cambio de estado del registro
            update alm.tmovimiento_grupo set
            estado = 'finalizado',
            id_usuario_mod = p_id_usuario,
            fecha_mod = now(),
            id_int_comprobante = v_id_int_comprobante
            where id_movimiento_grupo = v_parametros.id_movimiento_grupo;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Grupo Movimientos eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_movimiento_grupo',v_parametros.id_movimiento_grupo::varchar);
              
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