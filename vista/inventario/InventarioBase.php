<?php
/**
 *@package pXP
 *@file gen-Inventario.php
 *@author  Ariel Ayaviri Omonte
 *@date 15-03-2013 15:36:09
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.InventarioBase = Ext.extend(Phx.gridInterfaz, {

        constructor : function(config) {
            this.maestro = config.maestro;
            Phx.vista.InventarioBase.superclass.constructor.call(this, config);
            this.init();
            
            // this.load({
                // params : {
                    // start : 0,
                    // limit : this.tamPag
                // }
            // });
        },
        tamPag : 50,
        Atributos : [{
            config : {
                labelSeparator : '',
                inputType : 'hidden',
                name : 'id_inventario'
            },
            type : 'Field',
            form : true
        }, {
            config : {
                name : 'estado_reg',
                fieldLabel : 'Estado Reg.',
                allowBlank : true,
                anchor : '100%',
                gwidth : 100,
                maxLength : 10
            },
            type : 'TextField',
            filters : {
                pfiltro : 'inv.estado_reg',
                type : 'string'
            },
            id_grupo : 1,
            grid : true,
            form : false
        }, {
            config : {
                name : 'id_almacen',
                fieldLabel : 'Almacén',
                allowBlank : false,
                emptyText : 'Almacen...',
                store : new Ext.data.JsonStore({
                    url : '../../sis_almacenes/control/Almacen/listarAlmacen',
                    id : 'id_almacen',
                    root : 'datos',
                    sortInfo : {
                        field : 'nombre',
                        direction : 'ASC'
                    },
                    totalProperty : 'total',
                    fields : ['id_almacen', 'nombre'],
                    remoteSort : true,
                    baseParams : {
                        par_filtro : 'alm.nombre'
                    }
                }),
                valueField : 'id_almacen',
                displayField : 'nombre',
                gdisplayField : 'nombre_almacen',
                hiddenName : 'id_almacen',
                forceSelection : true,
                typeAhead : false,
                triggerAction : 'all',
                lazyRender : true,
                mode : 'remote',
                pageSize : 10,
                queryDelay : 1000,
                anchor : '100%',
                gwidth : 150,
                minChars : 2,
                renderer : function(value, p, record) {
                    return String.format('{0}', record.data['nombre_almacen']);
                }
            },
            type : 'ComboBox',
            id_grupo : 0,
            filters : {
                pfiltro : 'almo.nombre',
                type : 'string'
            },
            grid : true,
            form : true
        }, {
            config : {
                name : 'id_usuario_resp',
                fieldLabel : 'Usuario',
                allowBlank : false,
                emptyText : 'Usuario...',
                store : new Ext.data.JsonStore({
                    url : '../../sis_seguridad/control/Usuario/listarUsuario',
                    id : 'id_usuario',
                    root : 'datos',
                    sortInfo : {
                        field : 'cuenta',
                        direction : 'ASC'
                    },
                    totalProperty : 'total',
                    fields : ['id_usuario', 'cuenta', 'desc_person'],
                    remoteSort : true,
                    baseParams : {
                        par_filtro : 'USUARI.cuenta#PERSON.nombre_completo2'
                    }
                }),
                tpl : '<tpl for="."><div class="x-combo-list-item"><p>Cuenta: {cuenta}</p><p>Nombre: {desc_person}</p></div></tpl>',
                valueField : 'id_usuario',
                displayField : 'cuenta',
                gdisplayField : 'nombre_usuario',
                hiddenName : 'id_usuario_resp',
                forceSelection : true,
                typeAhead : true,
                triggerAction : 'all',
                lazyRender : true,
                mode : 'remote',
                pageSize : 10,
                queryDelay : 1000,
                anchor : '100%',
                minChars : 2,
                renderer : function(value, p, record) {
                    return String.format('{0}', record.data['nombre_usuario']);
                },
            },
            type : 'ComboBox',
            id_grupo : 0,
            filters : {
                pfiltro : 'usuinv.cuenta',
                type : 'string'
            },
            grid : true,
            form : true
        }, {
            config : {
                name : 'completo',
                fieldLabel : 'Completo',
                allowBlank : false,
                triggerAction : 'all',
                lazyRender : true,
                mode : 'local',
                store : new Ext.data.ArrayStore({
                    fields : ['codigo', 'nombre'],
                    data : [['si', 'Si'], ['no', 'No']]
                }),
                anchor : '100%',
                valueField : 'codigo',
                displayField : 'nombre',
                gwidth : 70
            },
            type : 'ComboBox',
            id_grupo : 1,
            form : true,
            grid : true
        }, {
            config : {
                name : 'fecha_inv_planif',
                fieldLabel : 'Fecha Planif.',
                allowBlank : true,
                gwidth : 100,
                format : 'd/m/Y',
                renderer : function(value, p, record) {
                    return value ? value.dateFormat('d/m/Y H:i:s') : ''
                }
            },
            type : 'DateField',
            filters : {
                pfiltro : 'inv.fecha_inv_planif',
                type : 'date'
            },
            id_grupo : 1,
            grid : true,
            form : true
        }, {
            config : {
                name : 'fecha_inv_ejec',
                fieldLabel : 'Fecha Ejec.',
                allowBlank : true,
                gwidth : 100,
                format : 'd/m/Y',
                renderer : function(value, p, record) {
                    return value ? value.dateFormat('d/m/Y H:i:s') : ''
                }
            },
            type : 'DateField',
            filters : {
                pfiltro : 'inv.fecha_inv_ejec',
                type : 'date'
            },
            id_grupo : 1,
            grid : true,
            form : true
        }, {
            config : {
                name : 'observaciones',
                fieldLabel : 'Observaciones',
                allowBlank : true,
                anchor : '100%',
                gwidth : 100,
                maxLength : 1000
            },
            type : 'TextArea',
            filters : {
                pfiltro : 'inv.observaciones',
                type : 'string'
            },
            id_grupo : 1,
            grid : true,
            form : true
        }, {
            config : {
                name : 'fecha_reg',
                fieldLabel : 'Fecha creación',
                allowBlank : true,
                anchor : '80%',
                gwidth : 100,
                format : 'd/m/Y',
                renderer : function(value, p, record) {
                    return value ? value.dateFormat('d/m/Y H:i:s') : ''
                }
            },
            type : 'DateField',
            filters : {
                pfiltro : 'inv.fecha_reg',
                type : 'date'
            },
            id_grupo : 1,
            grid : true,
            form : false
        }, {
            config : {
                name : 'usr_reg',
                fieldLabel : 'Creado por',
                allowBlank : true,
                anchor : '80%',
                gwidth : 100,
                maxLength : 4
            },
            type : 'NumberField',
            filters : {
                pfiltro : 'usu1.cuenta',
                type : 'string'
            },
            id_grupo : 1,
            grid : true,
            form : false
        }, {
            config : {
                name : 'fecha_mod',
                fieldLabel : 'Fecha Modif.',
                allowBlank : true,
                anchor : '80%',
                gwidth : 100,
                format : 'd/m/Y',
                renderer : function(value, p, record) {
                    return value ? value.dateFormat('d/m/Y H:i:s') : ''
                }
            },
            type : 'DateField',
            filters : {
                pfiltro : 'inv.fecha_mod',
                type : 'date'
            },
            id_grupo : 1,
            grid : true,
            form : false
        }, {
            config : {
                name : 'usr_mod',
                fieldLabel : 'Modificado por',
                allowBlank : true,
                anchor : '80%',
                gwidth : 100,
                maxLength : 4
            },
            type : 'NumberField',
            filters : {
                pfiltro : 'usu2.cuenta',
                type : 'string'
            },
            id_grupo : 1,
            grid : true,
            form : false
        }],
        title : 'InventarioBase',
        ActSave : '../../sis_almacenes/control/Inventario/insertarInventario',
        ActDel : '../../sis_almacenes/control/Inventario/eliminarInventario',
        ActList : '../../sis_almacenes/control/Inventario/listarInventario',
        id_store : 'id_inventario',
        fields : [{
            name : 'id_inventario',
            type : 'numeric'
        }, {
            name : 'estado_reg',
            type : 'string'
        }, {
            name : 'id_almacen',
            type : 'numeric'
        }, {
            name : 'nombre_almacen',
            type : 'string'
        }, {
            name : 'fecha_inv_planif',
            type : 'date',
            dateFormat : 'Y-m-d H:i:s.u'
        }, {
            name : 'estado',
            type : 'string'
        }, {
            name : 'observaciones',
            type : 'string'
        }, {
            name : 'fecha_inv_ejec',
            type : 'date',
            dateFormat : 'Y-m-d H:i:s.u'
        }, {
            name : 'completo',
            type : 'string'
        }, {
            name : 'id_usuario_resp',
            type : 'numeric'
        }, {
            name : 'nombre_usuario',
            type : 'string'
        }, {
            name : 'fecha_reg',
            type : 'date',
            dateFormat : 'Y-m-d H:i:s.u'
        }, {
            name : 'id_usuario_reg',
            type : 'numeric'
        }, {
            name : 'fecha_mod',
            type : 'date',
            dateFormat : 'Y-m-d H:i:s.u'
        }, {
            name : 'id_usuario_mod',
            type : 'numeric'
        }, {
            name : 'usr_reg',
            type : 'string'
        }, {
            name : 'usr_mod',
            type : 'string'
        }],
        sortInfo : {
            field : 'id_inventario',
            direction : 'ASC'
        },
        bsave : false,
        fwidth : 420,
        fheight : 380
    })
</script>