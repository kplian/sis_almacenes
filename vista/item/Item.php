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
	Phx.vista.Item = Ext.extend(Phx.gridInterfaz, {
		constructor : function(config) {
			this.maestro = config.maestro;
			Phx.vista.Item.superclass.constructor.call(this, config);
			this.init();
			this.load({
				params : {
					start : 0,
					limit : 50
				}
			})
		},
		Atributos : [{
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_item'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				name : 'id_clasificacion',
				fieldLabel : 'Clasificación',
				allowBlank : true,
				emptyText : 'Clasificación...',
				store : new Ext.data.JsonStore({
					url : '../../sis_almacenes/control/Clasificacion/listarClasificacion',
					id : 'id_clasificacion',
					root : 'datos',
					sortInfo : {
						field : 'nombre',
						direction : 'ASC'
					},
					totalProperty : 'total',
					fields : ['id_clasificacion', 'nombre', 'codigo_largo'],
					remoteSort : true,
					baseParams : {
						par_filtro : 'codigo_largo'
					}
				}),
				valueField : 'id_clasificacion',
				displayField : 'nombre',
				gdisplayField : 'desc_clasificacion', //dibuja el campo extra de la consulta al hacer un inner join con orra tabla
				forceSelection : true,
				typeAhead : false,
				triggerAction : 'all',
				lazyRender : true,
				mode : 'remote',
				pageSize : 10,
				queryDelay : 1000,
				anchor : '100%',
				gwidth : 110,
				minChars : 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_clasificacion']);
				}
			},
			type : 'ComboBox',
			id_grupo : 0,
			filters : {
				pfiltro : 'cla.nombre',
				type : 'string'
			},
			grid : true,
			form : true
		}, {
			config : {
				name : 'codigo_largo',
				fieldLabel : 'Código Clasificación',
				allowBlank : false,
				width : '100%',
				gwidth : 110,
				maxLength : 50,
				disabled : true,
				inputType : 'hidden',
			},
			type : 'TextField',
			filters : {
				pfiltro : 'cla.codigo_largo',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'nombre',
				fieldLabel : 'Nombre',
				allowBlank : false,
				width : '100%',
				gwidth : 100,
				maxLength : 25
			},
			type : 'TextField',
			filters : {
				pfiltro : 'item.nombre',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'codigo',
				fieldLabel : 'Código',
				allowBlank : false,
				width : '100%',
				gwidth : 100,
				maxLength : 20
			},
			type : 'TextField',
			filters : {
				pfiltro : 'item.codigo',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'descripcion',
				fieldLabel : 'Descripción',
				allowBlank : true,
				width : '100%',
				gwidth : 100,
				maxLength : 100
			},
			type : 'TextField',
			filters : {
				pfiltro : 'item.descripcion',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
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
			form : true
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
			form : true
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
            form : true
        }, {
			config : {
				name : 'observaciones',
				fieldLabel : 'Observaciones',
				allowBlank : true,
				width : '100%',
				gwidth : 100,
				maxLength : 200
			},
			type : 'TextArea',
			filters : {
				pfiltro : 'item.observaciones',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}],
		title : 'Item',
		ActSave : '../../sis_almacenes/control/Item/insertarItem',
		ActDel : '../../sis_almacenes/control/Item/eliminarItem',
		ActList : '../../sis_almacenes/control/Item/listarItem',
		id_store : 'id_item',
		fields : [{
			name : 'id_item'
		}, {
            name : 'id_clasificacion'
        }, {
			name : 'desc_clasificacion',
			type : 'string'
		}, {
			name : 'codigo_largo',
			type : 'string'
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
			field : 'id_item',
			direction : 'ASC'
		},
		bdel : true,
		bsave : false,
		fwidth : 400,
	})
</script>
