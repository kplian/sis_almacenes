<?php
/**
 *@package pXP
 *@file    KardexItem.php
 *@author  RCM
 *@date    06/07/2013
 *@description Archivo con la interfaz para generación de reporte
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.KardexItem = Ext.extend(Phx.frmInterfaz, {
		Atributos : [
		{
			config : {
				name : 'fecha_ini',
				fieldLabel : 'Fecha Desde',
				allowBlank : false,
				gwidth : 100,
				format : 'd/m/Y',
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type : 'DateField',
			id_grupo : 0,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'fecha_fin',
				fieldLabel : 'Fecha Hasta',
				allowBlank : false,
				gwidth : 100,
				format : 'd/m/Y',
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type : 'DateField',
			id_grupo : 0,
			grid : true,
			form : true
		},
		{
			config: {
				name: 'id_almacen',
				fieldLabel: 'Almacen',
				allowBlank: false,
				emptyText: 'Almacen...',
				store: new Ext.data.JsonStore({
					url: '../../sis_almacenes/control/Almacen/listarAlmacen',
					id: 'id_almacen',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_almacen', 'nombre'],
					remoteSort: true,
					baseParams: {
						par_filtro: 'alm.nombre'
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
			grid : true,
			form : true
		},  {
			config : {
				name : 'all_alm',
				fieldLabel : 'Todos los Almacenes',
				allowBlank : false,
				triggerAction : 'all',
				lazyRender : true,
				mode : 'local',
				store : new Ext.data.ArrayStore({
					fields : ['codigo', 'nombre'],
					data : [['si', 'Si'], ['no', 'No']]
				}),
				anchor : '50%',
				valueField : 'codigo',
				displayField : 'nombre'
			},
			type : 'ComboBox',
			id_grupo : 1,
			form : true
		}, {
			config : {
				name : 'id_items',
				fieldLabel : 'Item',
				allowBlank : false,
				emptyText : 'Items...',
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
				//hiddenValue: 'id_item',
				displayField : 'nombre',
				gdisplayField : 'nombre_item',
				//tpl : '<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p><p>Clasif.: {desc_clasificacion}</p></div></tpl>',
				hiddenName : 'id_items',
				forceSelection : true,
				typeAhead : false,
				triggerAction : 'all',
				lazyRender : true,
				mode : 'remote',
				pageSize : 10,
				queryDelay : 1000,
				anchor : '100%',
				gwidth : 250,
				minChars : 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre_item']);
				},
				enableMultiSelect : true
			},
			type : 'AwesomeCombo',
			id_grupo : 0,
			grid : false,
			form : true
		}],
		title : 'Kardex x Item',
		ActSave : '../../sis_almacenes/control/Reportes/reporteKardex',
		topBar : true,
		botones : false,
		labelSubmit : 'Generar',
		tooltipSubmit : '<b>Generar Reporte de Kardex x Item</b>',

		constructor : function(config) {
			Phx.vista.KardexItem.superclass.constructor.call(this, config);
			this.init();
			
			this.getComponente('all_alm').on('select', function(e, component, index) {
			    if (e.value == 'si') {
                    this.getComponente('id_almacen').disable();
                } else {
                    this.getComponente('id_almacen').enable();
                }
			}, this);
			
			this.getComponente('all_alm').setValue('si');
			this.getComponente('id_almacen').disable();		},
		tipo : 'reporte',
		clsSubmit : 'bprint',
		Grupos : [{
			layout : 'column',
			items : [{
				xtype : 'fieldset',
				layout : 'form',
				border : true,
				title : 'Generar Reporte',
				bodyStyle : 'padding:0 10px 0;',
				columnWidth : '300px',
				items : [],
				id_grupo : 0,
				collapsible : true
			}]
		}],

	})
</script>