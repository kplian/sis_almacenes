<?php
/**
 *@package pXP
 *@file    Item.php
 *@author  Gonzalo Sarmiento
 *@date    21-09-2012
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.ItemReemplazo = Ext.extend(Phx.gridInterfaz, {
		constructor : function(config) {
			this.maestro = config.maestro;
			Phx.vista.ItemReemplazo.superclass.constructor.call(this, config);
			this.init();
			this.load({
				params : {
					start : 0,
					limit : 50,
					id_item : this.id_item
				}
			});
			this.Atributos[1].valorInicial = this.id_item;
		},
		Atributos : [{
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_item_reemplazo'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_item'
			},
			type : 'Field',
			form : true
		}, {
            config : {
                name : 'id_item_r',
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
                    fields : ['id_item', 'nombre', 'codigo', 'desc_clasificacion'],
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
                    return String.format('{0}', record.data['nombre']);
                }
            },
            type : 'TrigguerCombo',
            id_grupo : 0,
            filters : {
                pfiltro : 'nombre',
                type : 'string'
            },
            grid : true,
            form : true
        }, {
			config : {
				name : 'codigo',
				fieldLabel : 'Código',
				allowBlank : false,
				width : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'TextField',
			filters : {
				pfiltro : 'item.codigo',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'descripcion',
				fieldLabel : 'Descripción',
				allowBlank : true,
				width : '100%',
				gwidth : 150,
				maxLength : 1000
			},
			type : 'TextField',
			filters : {
				pfiltro : 'item.descripcion',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'palabras_clave',
				fieldLabel : 'Palabras clave',
				allowBlank : true,
				width : '100%',
				gwidth : 80,
				maxLength : 25
			},
			type : 'TextField',
			filters : {
				pfiltro : 'item.palabras_clave',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'codigo_fabrica',
				fieldLabel : 'Código de fábrica',
				allowBlank : true,
				width : '100%',
				gwidth : 100,
				maxLength : 10
			},
			type : 'TextField',
			filters : {
				pfiltro : 'item.codigo_fabrica',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'numero_serie',
				fieldLabel : 'No. de Serie',
				allowBlank : true,
				width : '100%',
				gwidth : 90,
				maxLength : 20
			},
			type : 'TextField',
			filters : {
				pfiltro : 'item.numero_serie',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'observaciones',
				fieldLabel : 'Observaciones',
				allowBlank : true,
				width : '100%',
				gwidth : 100,
				maxLength : 1000
			},
			type : 'TextArea',
			filters : {
				pfiltro : 'item.observaciones',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}],
		title : 'Item Reemplazo',
		ActSave : '../../sis_almacenes/control/ItemReemplazo/insertarItemReemplazo',
		ActDel : '../../sis_almacenes/control/ItemReemplazo/eliminarItemReemplazo',
		ActList : '../../sis_almacenes/control/ItemReemplazo/listarItemReemplazo',
		id_store : 'id_item_reemplazo',
		fields : [{
			name : 'id_item_reemplazo'
		}, {
			name : 'id_item'
		}, {
			name : 'id_item_r'
		}, {
			name : 'codigo',
			type : 'string'
		}, {
			name : 'nombre',
			type : 'string'
		}, {
			name : 'descripcion',
			type : 'string'
		}, {
			name : 'palabras_clave',
			type : 'string'
		}, {
			name : 'codigo_fabrica',
			type : 'string'
		}, {
			name : 'observaciones',
			type : 'string'
		}, {
			name : 'numero_serie',
			type : 'string'
		}],
		sortInfo : {
			field : 'id_item_reemplazo',
			direction : 'ASC'
		},
		bdel : true,
		bsave : false,
		fwidth : 400,
		fheight : 200
	}); 
</script>