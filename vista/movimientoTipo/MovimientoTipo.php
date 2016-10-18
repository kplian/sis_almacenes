<?php
/**
 * @package pxP
 * @file 	Almacen.php
 * @author 	Gonzalo Sarmiento
 * @date	21-09-2012
 * @description	Archivo con la interfaz de usuario que permite la ejecucion de las funcionales del sistema
 */
header("content-type:text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.MovimientoTipo = Ext.extend(Phx.gridInterfaz, {
		constructor : function(config) {
			this.maestro = config.maestro;
			Phx.vista.MovimientoTipo.superclass.constructor.call(this, config);
			this.init();
			this.load({
				params : {
					start : 0,
					limit : 50
				}
			});
		},
		Atributos : [{
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_movimiento_tipo'
			},
			type : 'Field',
			form : true
		},
		{
			config : {
				name : 'codigo',
				fieldLabel : 'Código',
				allowBlank : false,
				anchor : '100%',
				gwidth : 100,
				maxLength : 10
			},
			type : 'TextField',
			filters : {
				pfiltro : 'movtip.codigo',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'nombre',
				fieldLabel : 'Nombre Movimiento',
				allowBlank : false,
				anchor : '100%',
				gwidth : 250,
				maxLength : 50
			},
			type : 'TextField',
			filters : {
				pfiltro : 'movtip.nombre',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'tipo',
				fieldLabel : 'Tipo',
				anchor : '100%',
				tinit : true,
				allowBlank : false,
				origen : 'CATALOGO',
				gdisplayField : 'tipo',
				gwidth : 100,
				baseParams : {
					cod_subsistema : 'ALM',
					catalogo_tipo : 'tmovimiento_tipo_tipo'
				}
			},
			type : 'ComboRec',
			id_grupo : 0,
			filters : {
				pfiltro : 'movtip.tipo',
				type : 'string'
			},
			grid : true,
			form : true
		},
		{
			config: {
				name: 'id_proceso_macro',
				fieldLabel: 'Proceso',
				typeAhead: false,
				forceSelection: false,
				 hiddenName: 'id_proceso_macro',
				allowBlank: false,
				emptyText: 'Lista de Procesos...',
				store: new Ext.data.JsonStore({
					url: '../../sis_workflow/control/ProcesoMacro/listarProcesoMacro',
					id: 'id_proceso_macro',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_proceso_macro', 'nombre', 'codigo'],
					// turn on remote sorting
					remoteSort: true,
					baseParams: {par_filtro: 'promac.nombre#promac.codigo',codigo_subsistema:'ALM'}
				}),
				valueField: 'id_proceso_macro',
				displayField: 'nombre',
				gdisplayField: 'desc_proceso_macro',
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 20,
				queryDelay: 200,
				listWidth:280,
				minChars: 2,
				gwidth: 170,
				renderer: function(value, p, record) {
					return String.format('{0}', record.data['desc_proceso_macro']);
				},
				tpl: '<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p>Codigo: <strong>{codigo}</strong> </div></tpl>'
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {
				pfiltro: 'pm.nombre',
				type: 'string'
			},
			grid: true,
			form: true
		}, 
		{
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
				name : 'fecha_reg',
				fieldLabel : 'Fecha creación',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'movtip.fecha_reg',
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
		}, {
			config : {
				name : 'fecha_mod',
				fieldLabel : 'Fecha Modif.',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'movtip.fecha_mod',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}],
		title : 'Tipo Movimiento',
		ActSave : '../../sis_almacenes/control/MovimientoTipo/insertarMovimientoTipo',
		ActDel : '../../sis_almacenes/control/MovimientoTipo/eliminarMovimientoTipo',
		ActList : '../../sis_almacenes/control/MovimientoTipo/listarMovimientoTipo',
		id_store : 'id_movimiento_tipo',
		fields : [{
			name : 'id_movimiento_tipo'
		}, {
			name : 'codigo',
			type : 'string'
		}, {
			name : 'nombre',
			type : 'string'
		}, {
			name : 'tipo',
			type : 'string'
		}, {
			}, {
			name : 'id_proceso_macro',
			type : 'integer'
		}, {
			}, {
			name : 'desc_proceso_macro',
			type : 'string'
		}, {
			name : 'fecha_reg',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s.u'
		}, {
			name : 'fecha_mod',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s.u'
		}, {
			name : 'usr_reg',
			type : 'string'
		}, {
			name : 'usr_mod',
			type : 'string'
		}, {
            name : 'read_only',
            type : 'boolean'
        }],
		sortInfo : {
			field : 'id_movimiento_tipo',
			direction : 'ASC'
		},
		bdel : true,
		fwidth : 420,
		fheight : 230,
		preparaMenu : function(n) {
			var tb = Phx.vista.MovimientoTipo.superclass.preparaMenu.call(this);
			var data = this.getSelectedData();
			if (data.read_only == true) {
			    this.getBoton('edit').setDisabled(true);
                this.getBoton('del').setDisabled(true);
			}
			return tb;
		},
		tabsouth:[{
			url : '../../../sis_almacenes/vista/movimiento_tipo_item/MovimientoTipoItem.php',
			title : 'Items/Clasificación',
			height : '40%',
			cls : 'MovimientoTipoItem'
		},{
			url : '../../../sis_almacenes/vista/movimiento_tipo_uo/MovimientoTipoUo.php',
			title : 'Cargos permitidos',
			height : '40%',
			cls : 'MovimientoTipoUo'
		},{
			url : '../../../sis_almacenes/vista/movimiento_tipo_almacen/MovimientoTipoAlmacen.php',
			title : 'Almacenes permitidos',
			height : '40%',
			cls : 'MovimientoTipoAlmacen'
		}]
		
		
		
	}); 
</script>