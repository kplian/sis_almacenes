<?php
/**
 * @package pxP
 * @file    Clasificacion.php
 * @author  Gonzalo Sarmiento
 * @date    21-09-2012
 * @description Archivo con la interfaz de usuario que permite la ejecucion de las funcionales del sistema
 */
header("content-type:text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.Clasificacion=Ext.extend(Phx.arbInterfaz, {
        constructor:function(config) {
            this.maestro=config.maestro;
            Phx.vista.Clasificacion.superclass.constructor.call(this,config);
            this.init();
            this.tbar.items.get('b-new-'+this.idContenedor).disable();
        },
        Atributos:[
        {
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_clasificacion'
            },
            type:'Field',
            form:true 
        },
        {
            config:{
                labelSeparator:'',
                inputType:'hidden',
                name: 'id_clasificacion_fk'
            },
            type:'Field',
            form:true
        },
        {
            config:{
                name: 'codigo',
                fieldLabel: 'Codigo',
                allowBlank: false,
                anchor: '100%',
                maxLength:4
            },
            type:'TextField',           
            filters:{pfiltro:'cla.codigo',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'nombre',
                fieldLabel: 'Nombre',
                allowBlank: false,
                anchor: '100%',
                gwidth: 100,
                maxLength:25
            },
            type:'TextField',
            filters:{pfiltro:'cla.nombre',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
        {
            config:{
                name: 'descripcion',
                fieldLabel: 'Descripcion',
                allowBlank: true,
                anchor: '100%',
                gwidth: 100,
                maxLength:100
            },
            type:'TextField',
            filters:{pfiltro:'cla.descripcion',type:'string'},
            id_grupo:1,
            grid:true,
            form:true
        },
    ],
    title:'Clasificacion',
    ActSave:'../../sis_almacenes/control/Clasificacion/insertarClasificacion',
    ActDel:'../../sis_almacenes/control/Clasificacion/eliminarClasificacion',
    ActList:'../../sis_almacenes/control/Clasificacion/listarClasificacionArb',
    id_store:'id_clasificacion',
    textRoot:'Clasificaciones',
    id_nodo:'id_clasificacion',
    id_nodo_p:'id_clasificacion_fk',
    onButtonNew: function() {
        var nodo = this.sm.getSelectedNode();           
        Phx.vista.Clasificacion.superclass.onButtonNew.call(this);
    },
    fields: [
        {name: 'id', type: 'numeric'},
        {name: 'tipo_meta', type: 'string'},
        {name:'id_clasificacion', type: 'numeric'},
        {name:'id_clasificacion_fk', type: 'numeric'},
        {name:'codigo', type: 'string'},
        {name:'nombre', type: 'string'},
        {name:'descripcion', type: 'string'}
    ],
    sortInfo:{
        field: 'id_clasificacion',
        direction: 'ASC'
    },
    bdel: true,
    bsave: false,
    bexcel: true,
    bexcel: false,
    rootVisible: true,
    fwidth: 420,
    fheight: 250,
    preparaMenu: function(n) {
        Phx.vista.Clasificacion.superclass.preparaMenu.call(this,n);
        if(n.attributes.tipo_nodo == 'raiz' || n.attributes.tipo_nodo == 'hijo') {
            this.getBoton('new').enable();
            this.getBoton('edit').enable();
            this.getBoton('del').enable();
        } else if (n.attributes.tipo_nodo == undefined) {
            this.getBoton('new').enable();
            this.getBoton('edit').disable();
            this.getBoton('del').disable();
        } else {
            this.getBoton('new').disable();
            this.getBoton('edit').disable();
            this.getBoton('del').disable();
        }    },
    getNombrePadre:function(n) {
        var direc;
        var padre = n.parentNode;
        if(padre) {
            if(padre.attributes.id != 'id') {
               direc = n.attributes.nombre +' - '+ this.getNombrePadre(padre);
               return direc;
            } else {
                return n.attributes.nombre;
            }
        }
        else {
            return undefined;
        }
    },
    south: {
        url:'../../../sis_almacenes/vista/item/Item.php',
        title: 'Materiales',
        height: 300,
        cls: 'Item'
    }
});
</script>       
        