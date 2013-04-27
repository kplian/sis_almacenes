--------------- SQL ---------------

CREATE OR REPLACE FUNCTION alm.ft_item_reemplazo_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:        Almacenes
 FUNCION:        alm.ft_item_reemplazo_sel
 DESCRIPCION:    Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'alm.titem'
 AUTOR:          Ariel Ayaviri Omonte
 FECHA:          06-02-2013
 COMENTARIOS:   
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:   
 AUTOR:           
 FECHA:       
***************************************************************************/

DECLARE

    v_consulta            varchar;
    v_parametros          record;
    v_nombre_funcion       text;
    v_resp                varchar;
    v_where varchar;
               
BEGIN

    v_nombre_funcion = 'alm.ft_item_reemplazo_sel';
    v_parametros = pxp.f_get_record(p_tabla);

    /*********************************   
     #TRANSACCION:  'SAL_ITMREE_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        06-02-2016
    ***********************************/

    if(p_transaccion='SAL_ITMREE_SEL')then
                    
        begin
            --Sentencia de la consulta
            v_consulta:='
            	select
                	itree.id_item_reemplazo,
                    itree.id_item,
                    item.id_item as id_item_r,
                    item.nombre,
                    item.codigo,
                    item.descripcion,
                    item.palabras_clave,
                    item.codigo_fabrica,
                    item.observaciones,
                    item.numero_serie                       
                from alm.titem_reemplazo itree 
                inner join alm.titem item on item.id_item = itree.id_item_r
                where item.estado_reg = ''activo'' and itree.id_item = ' ||v_parametros.id_item || ' and ';
           
            --Definicion de la respuesta
            v_consulta:=v_consulta||v_parametros.filtro;
            v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;
			
            --Devuelve la respuesta
            return v_consulta;
                       
        end;
    
	/*********************************   
     #TRANSACCION:  'SAL_ITMREE_CONT'
     #DESCRIPCION:  Conteo de registros
     #AUTOR:        Ariel Ayaviri Omonte
     #FECHA:        06-02-2013
    ***********************************/

    elsif(p_transaccion='SAL_ITMREE_CONT')then

        begin
            --Sentencia de la consulta de conteo de registros
            v_consulta:='
            	select count(item.id_item)
                from alm.titem_reemplazo itree 
                inner join alm.titem item on item.id_item = itree.id_item_r
                where item.estado_reg = ''activo'' and itree.id_item = ' ||v_parametros.id_item || ' and ';
           
            --Definicion de la respuesta           
            v_consulta:=v_consulta||v_parametros.filtro;

            --Devuelve la respuesta
            return v_consulta;

        end;       
    else
                        
        raise exception 'Transaccion inexistente';
                            
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