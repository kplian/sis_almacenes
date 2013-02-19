<?php
/**
 *@package PXP
 *@file Movimiento.php
 *@author  Ariel Ayaviri Omonte
 *@date 18-02-2013
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.Movimiento = Ext.extend(Phx.gridInterfaz, {

		constructor : function(config) {
			this.maestro = config.maestro;
			Phx.vista.Movimiento.superclass.constructor.call(this, config);
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
				name : 'id_movimiento',
				labelSeparator : '',
				inputType : 'hidden'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				name : 'id_movimiento_tipo',
				fieldLabel : 'Movimiento Tipo',
				allowBlank : false,
				emptyText : 'Movimiento Tipo...',
				store : new Ext.data.JsonStore({
					url : '../../sis_almacenes/control/MovimientoTipo/listarMovimientoTipo',
					id : 'id_movimiento_tipo',
					root : 'datos',
					sortInfo : {
						field : 'nombre',
						direction : 'ASC'
					},
					totalProperty : 'total',
					fields : ['id_movimiento_tipo', 'nombre', 'codigo'],
					remoteSort : true,
					baseParams : {
						par_filtro : 'movtip.nombre#movtip.codigo'
					}
				}),
				valueField : 'id_movimiento_tipo',
				displayField : 'nombre',
				gdisplayField : 'nombre_movimiento_tipo',
				tpl : '<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p></div></tpl>',
				hiddenName : 'id_movimiento_tipo',
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
					return String.format('{0}', record.data['nombre_movimiento_tipo']);
				}
			},
			type : 'ComboBox',
			id_grupo : 0,
			filters : {
				pfiltro : 'movtip.nombre',
				type : 'string'
			},
			grid : true,
			form : true
		}, {
			config : {
				name : 'id_funcionario',
				fieldLabel : 'Funcionario',
				allowBlank : false,
				emptyText : 'Funcionario...',
				store : new Ext.data.JsonStore({
					url : '../../sis_organigrama/control/Funcionario/listarFuncionario',
					id : 'id_funcionario',
					root : 'datos',
					sortInfo : {
						field : 'desc_person',
						direction : 'ASC'
					},
					totalProperty : 'total',
					fields : ['id_funcionario', 'desc_person'],
					remoteSort : true,
					baseParams : {
						par_filtro : 'person.nombre_completo1'
					}
				}),
				valueField : 'id_funcionario',
				displayField : 'desc_person',
				gdisplayField : 'nombre_funcionario',
				hiddenName : 'id_funcionario',
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
					return String.format('{0}', record.data['nombre_funcionario']);
				}
			},
			type : 'ComboBox',
			id_grupo : 0,
			filters : {
				pfiltro : 'person_fun.nombre_completo1',
				type : 'string'
			},
			grid : true,
			form : true
		}, {
			config : {
				name : 'id_proveedor',
				fieldLabel : 'Proveedor',
				allowBlank : true,
				emptyText : 'Proveedor...',
				store : new Ext.data.JsonStore({
					url : '../../sis_parametros/control/Proveedor/listarProveedorCombos',
					id : 'id_proveedor',
					root : 'datos',
					sortInfo : {
						field : 'desc_proveedor',
						direction : 'ASC'
					},
					fields : ['id_proveedor', 'desc_proveedor'],
					remoteSort : true,
					baseParams : {
						par_filtro : 'desc_proveedor'
					}
				}),
				valueField : 'id_proveedor',
				displayField : 'desc_proveedor',
				gdisplayField : 'nombre_proveedor',
				hiddenName : 'id_proveedor',
				forceSelection : true,
				typeAhead : true,
				triggerAction : 'all',
				lazyRender : true,
				mode : 'remote',
				pageSize : 10,
				queryDelay : 1000,
				anchor : '100%',
				enableMultiSelect : true,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre_proveedor']);
				}
			},
			type : 'ComboBox',
			id_grupo : 0,
			filters : {
				pfiltro : 'person.nombre_completo1',
				type : 'string'
			},
			grid : true,
			form : true
		}, {
			config : {
				name : 'id_almacen',
				fieldLabel : 'Almacen',
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
				gwidth : 100,
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
				name : 'id_almacen_dest',
				fieldLabel : 'Almacen Destino',
				allowBlank : true,
				emptyText : 'Almacen Destino...',
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
				gdisplayField : 'nombre_almacen_destino',
				hiddenName : 'id_almacen',
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
					return String.format('{0}', record.data['nombre_almacen_destino']);
				}
			},
			type : 'ComboBox',
			id_grupo : 0,
			filters : {
				pfiltro : 'almd.nombre',
				type : 'string'
			},
			grid : true,
			form : true
		}, {
			config : {
				name : 'fecha_mov',
				fieldLabel : 'Fecha Movimiento',
				allowBlank : false,
				gwidth : 100,
				format : 'Y-m-d',
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'mov.fecha_mov',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'codigo',
				fieldLabel : 'Codigo',
				allowBlank : true,
				anchor : '100%',
				gwidth : 100,
				maxLength : 30
			},
			type : 'TextField',
			filters : {
				pfiltro : 'mov.codigo',
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
				anchor : '100%',
				gwidth : 100,
				maxLength : 1000
			},
			type : 'TextArea',
			filters : {
				pfiltro : 'mov.descripcion',
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
				anchor : '100%',
				gwidth : 100,
				maxLength : 1000
			},
			type : 'TextArea',
			filters : {
				pfiltro : 'mov.observaciones',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'estado_mov',
				fieldLabel : 'Estado',
				allowBlank : false,
				anchor : '100%',
				gwidth : 100,
				maxLength : 10
			},
			type : 'TextField',
			filters : {
				pfiltro : 'mov.estado_mov',
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
				}			},
			type : 'DateField',
			filters : {
				pfiltro : 'mov.fecha_reg',
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
				pfiltro : 'mov.fecha_mod',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}],
		title : 'Movimientos',
		ActSave : '../../sis_almacenes/control/Movimiento/insertarMovimiento',
		ActDel : '../../sis_almacenes/control/Movimiento/eliminarMovimiento',
		ActList : '../../sis_almacenes/control/Movimiento/listarMovimiento',
		id_store : 'id_movimiento',
		fields : [{
			name : 'id_movimiento',
			type : 'numeric'
		}, {
			name : 'id_movimiento_tipo',
			type : 'numeric'
		}, {
			name : 'nombre_movimiento_tipo',
			type : 'string'
		}, {
			name : 'id_funcionario',
			type : 'numeric'
		}, {
			name : 'nombre_funcionario',
			type : 'string'
		}, {
			name : 'id_proveedor',
			type : 'numeric'
		}, {
			name : 'nombre_proveedor',
			type : 'string'
		}, {
			name : 'id_almacen',
			type : 'numeric'
		}, {
			name : 'nombre_almacen',
			type : 'string'
		}, {
			name : 'id_almacen_dest',
			type : 'numeric'
		}, {
			name : 'nombre_almacen_destino',
			type : 'string'
		}, {
			name : 'fecha_mov',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s'
		}, {
			name : 'codigo',
			type : 'string'
		}, {
			name : 'descripcion',
			type : 'string'
		}, {
			name : 'observaciones',
			type : 'string'
		}, {
			name : 'estado_mov',
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
			field : 'id_movimiento',
			direction : 'ASC'
		},
		bdel : true,
		bsave : false,
		fwidth : 420,
		fheight : 450
	})
</script>

