<?php
/**
 *@package pXP
 *@file AlmacenStock.php
 *@author  Gonzalo Sarmiento
 *@date 01-10-2012
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
    Phx.vista.AlmacenStock = Ext.extend(Phx.gridInterfaz, {

        constructor : function(config) {
            this.maestro = config.maestro;
            Phx.vista.AlmacenStock.superclass.constructor.call(this, config);
            this.init();
            this.grid.getTopToolbar().disable();
            this.grid.getBottomToolbar().disable();
            this.store.removeAll();
            this.getComponente('id_item').on('select', function(comp, object, c) {
                this.getComponente('codigo_unidad').setValue(object.data.codigo_unidad);
            }, this);
        },
        Atributos : [{
            config : {
                name : 'id_almacen_stock',
                labelSeparator : '',
                inputType : 'hidden'
            },
            type : 'Field',
            form : true
        }, {
            config : {
                name : 'id_almacen',
                labelSeparator : '',
                inputType : 'hidden',
            },
            type : 'Field',
            form : true
        }, {
            config : {
                name : 'id_item',
                fieldLabel : 'Item',
                allowBlank : false,
                emptyText : 'Item...',
                store : new Ext.data.JsonStore({
                    url : '../../sis_almacenes/control/Item/listarItemNotBase',
                    id : 'id_item',
                    root : 'datos',
                    sortInfo : {
                        field : 'nombre',
                        direction : 'ASC'
                    },
                    totalProperty : 'total',
                    fields : ['id_item', 'nombre', 'codigo', 'desc_clasificacion', 'codigo_unidad'],
                    remoteSort : true,
                    baseParams : {
                        par_filtro : 'item.nombre#item.codigo#cla.nombre'
                    }
                }),
                valueField : 'id_item',
                displayField : 'nombre',
                gdisplayField : 'desc_item',
                tpl : '<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p><p>Clasif.: {desc_clasificacion}</p></div></tpl>',
                hiddenName : 'id_item',
                forceSelection : true,
                typeAhead : false,
                triggerAction : 'all',
                lazyRender : true,
                mode : 'remote',
                pageSize : 10,
                queryDelay : 1000,
                anchor : '100%',
                gwidth : 100,
                minChars : 2,
                turl : '../../../sis_almacenes/vista/item/BuscarItem.php',
                tasignacion : true,
                tname : 'id_item',
                ttitle : 'Items',
                tdata : {},
                tcls : 'BuscarItem',
                pid : this.idContenedor,
                renderer : function(value, p, record) {
                    return String.format('{0}', record.data['desc_item']);
                }
            },
            type : 'TrigguerCombo',
            id_grupo : 0,
            filters : {
                pfiltro : 'item.nombre',
                type : 'string'
            },
            grid : true,
            form : true
        }, {
            config : {
                name : 'codigo_unidad',
                fieldLabel : 'Unidad de Medida',
                allowBlank : true,
                anchor : '100%',
                gwidth : 100,
                maxLength : 10,
                disabled : true
            },
            type : 'TextField',
            id_grupo : 1,
            grid : false,
            form : true
        }, {
            config : {
                name : 'cantidad_min',
                fieldLabel : 'Cantidad minima',
                allowBlank : false,
                anchor : '100%',
                gwidth : 100,
                maxLength : 10
            },
            type : 'NumberField',
            filters : {
                pfiltro : 'almitem.cantidad_min',
                type : 'numeric'
            },
            id_grupo : 1,
            grid : true,
            form : true
        }, {
            config : {
                name : 'cantidad_alerta_roja',
                fieldLabel : 'Cant. alerta roja',
                allowBlank : false,
                anchor : '100%',
                gwidth : 100,
                maxLength : 10
            },
            type : 'NumberField',
            filters : {
                pfiltro : 'almitem.cantidad_alerta_roja',
                type : 'numeric'
            },
            id_grupo : 1,
            grid : true,
            form : true
        }, {
            config : {
                name : 'cantidad_alerta_amarilla',
                fieldLabel : 'Cant. alerta amarilla',
                allowBlank : false,
                anchor : '100%',
                gwidth : 100,
                maxLength : 10
            },
            type : 'NumberField',
            filters : {
                pfiltro : 'almitem.cantidad_alerta_amarilla',
                type : 'numeric'
            },
            id_grupo : 1,
            grid : true,
            form : true
        }, {
            config : {
                name : 'id_metodo_val',
                fieldLabel : 'Método Valoración',
                allowBlank : false,
                emptyText : 'Método...',
                store : new Ext.data.JsonStore({
                    url : '../../sis_almacenes/control/MetodoVal/listarMetodoVal',
                    id : 'id_metodo_val',
                    root : 'datos',
                    sortInfo : {
                        field : 'nombre',
                        direction : 'ASC'
                    },
                    totalProperty : 'total',
                    fields : ['id_metodo_val', 'codigo', 'nombre'],
                    remoteSort : true,
                    baseParams : {
                        par_filtro : 'meval.codigo#meval.nombre'
                    }
                }),
                valueField : 'id_metodo_val',
                displayField : 'codigo',
                gdisplayField : 'codigo_metodo_val',
                tpl : '<tpl for="."><div class="x-combo-list-item"><p>Código: {codigo}</p><p>Nombre: {nombre}</p></div></tpl>',
                hiddenName : 'id_item',
                forceSelection : true,
                typeAhead : false,
                triggerAction : 'all',
                lazyRender : true,
                mode : 'remote',
                pageSize : 10,
                queryDelay : 1000,
                anchor : '100%',
                gwidth : 100,
                minChars : 2,
                renderer : function(value, p, record) {
                    return String.format('{0}', record.data['codigo_metodo_val']);
                }
            },
            type : 'ComboBox',
            id_grupo : 0,
            filters : {
                pfiltro : 'meval.codigo',
                type : 'string'
            },
            grid : true,
            form : true
        }, {
            config : {
                name : 'estado_reg',
                fieldLabel : 'Estado Reg.',
                anchor : '80%',
                gwidth : 80
            },
            type : 'TextField',
            filters : {
                pfiltro : 'almitem.estado_reg',
                type : 'string'
            },
            id_grupo : 1,
            grid : true,
            form : false
        }, {
            config : {
                name : 'usr_reg',
                fieldLabel : 'Usuario reg.',
                anchor : '80%',
                gwidth : 100,
            },
            type : 'TextField',
            id_grupo : 1,
            filters : {
                pfiltro : 'usu1.cuenta',
                type : 'string'
            },
            grid : true,
            form : false
        }, {
            config : {
                name : 'fecha_reg',
                fieldLabel : 'Fecha creación',
                anchor : '80%',
                gwidth : 100,
                renderer : function(value, p, record) {
                    return value ? value.dateFormat('d/m/Y h:i:s') : ''
                }
            },
            type : 'DateField',
            filters : {
                pfiltro : 'almitem.fecha_reg',
                type : 'date'
            },
            id_grupo : 1,
            grid : true,
            form : false
        }, {
            config : {
                name : 'usr_mod',
                fieldLabel : 'Usuario mod.',
                anchor : '80%',
                gwidth : 100,
            },
            type : 'TextField',
            id_grupo : 1,
            filters : {
                pfiltro : 'usu1.cuenta',
                type : 'string'
            },
            grid : true,
            form : false
        }, {
            config : {
                name : 'fecha_mod',
                fieldLabel : 'Fecha Modif.',
                anchor : '80%',
                gwidth : 90,
                renderer : function(value, p, record) {
                    return value ? value.dateFormat('d/m/Y h:i:s') : ''
                }
            },
            type : 'DateField',
            filters : {
                pfiltro : 'almitem.fecha_mod',
                type : 'date'
            },
            id_grupo : 1,
            grid : true,
            form : false
        }],
        title : 'Item por Almacen',
        ActSave : '../../sis_almacenes/control/AlmacenStock/insertarAlmacenItem',
        ActDel : '../../sis_almacenes/control/AlmacenStock/eliminarAlmacenItem',
        ActList : '../../sis_almacenes/control/AlmacenStock/listarAlmacenItem',
        id_store : 'id_almacen_stock',
        fields : [{
            name : 'id_almacen_stock',
            type : 'numeric'
        }, {
            name : 'id_almacen',
            type : 'numeric'
        }, {
            name : 'id_item',
            type : 'numeric'
        }, {
            name : 'desc_item',
            type : 'string'
        }, {
            name : 'estado_reg',
            type : 'string'
        }, {
            name : 'cantidad_min',
            type : 'numeric'
        }, {
            name : 'cantidad_alerta_amarilla',
            type : 'numeric'
        }, {
            name : 'cantidad_alerta_roja',
            type : 'numeric'
        }, {
            name : 'id_metodo_val',
            type : 'numeric'
        }, {
            name : 'codigo_metodo_val',
            type : 'string'
        }, {
            name : 'codigo_unidad',
            type : 'string'
        }, {
            name : 'usr_reg',
            type : 'string'
        }, {
            name : 'fecha_reg',
            type : 'date',
            dateFormat : 'Y-m-d H:i:s.u'
        }, {
            name : 'usr_mod',
            type : 'string'
        }, {
            name : 'fecha_mod',
            type : 'date',
            dateFormat : 'Y-m-d H:i:s.u'
        }],
        sortInfo : {
            field : 'id_almacen_stock',
            direction : 'ASC'
        },
        bdel : true,
        bsave : false,
        fwidth : 420,
        fheight : 350,
        onReloadPage : function(m) {
            this.maestro = m;
            this.Atributos[1].valorInicial = this.maestro.id_almacen;
            if (m.id != 'id') {
                this.store.baseParams = {
                    id_almacen : this.maestro.id_almacen
                };
                this.load({
                    params : {
                        start : 0,
                        limit : 50
                    }
                })
            } else {
                this.grid.getTopToolbar().disable();
                this.grid.getBottomToolbar().disable();
                this.store.removeAll();
            }
        }
    })
</script>

