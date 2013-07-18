<?php
/**
 * @package pxP
 * @file    BuscarClasificacion.php
 * @author  Gonzalo Sarmiento Sejas
 * @date    16-07-2013
 * @description Archivo con la interfaz de usuario que permite la ejecucion de las funcionales del sistema
 */
header("content-type:text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.BuscarClasificacion = Ext.extend(Phx.arbInterfaz, {
        constructor : function(config) {
            this.maestro = config.maestro;
            Phx.vista.BuscarClasificacion.superclass.constructor.call(this, config);
           
            this.init();          
        },
        title : 'Buscador de Clasificacion',
        ActList : '../../sis_almacenes/control/Clasificacion/listarClasificacionArb',
        //ActSearch : '../../sis_almacenes/control/Item/buscarClasificacionArb',
        id_store : 'id_clasificacion',
        baseParams : {clasificacion:true},                
        textRoot : 'Clasificaciones',
        id_nodo : 'id_clasificacion',
        id_nodo_p : 'id_clasificacion_fk',
        enableDD : false,
        bnew : false,
        bsave : false,
        bedit : false,
        bdel : false,
        rootVisible : true,
        fwidth : 420,
        fheight : 300,
        fields : [{
            name : 'id',
            type : 'numeric'
        }, {
            name : 'tipo_meta',
            type : 'string'
        }, {
            name : 'id_clasificacion',
            type : 'numeric'
        }, {
            name : 'id_clasificacion_fk',
            type : 'numeric'
        }, {
            name : 'codigo',
            type : 'string'
        }, {
            name : 'nombre',
            type : 'string'
        }, {
            name : 'descripcion',
            type : 'string'
        }],
        sortInfo : {
            field : 'id_clasificacion',
            direction : 'ASC'
        }        
        
    }); 
</script>
