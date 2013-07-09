<?php
/**
 *@package pXP
 *@file AlmacenStock.php
 *@author  Gonzalo Sarmiento
 *@date 01-10-2012
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.MovimientoDetalle = Ext.extend(Phx.gridInterfaz, {
		constructor: function(config) {
			this.maestro = config.maestro;
			Phx.vista.MovimientoDetalle.superclass.constructor.call(this, config);
			this.init();
			this.grid.getTopToolbar().disable();
			this.grid.getBottomToolbar().disable();
			
			this.getComponente('id_item').on('select', function(comp, object, c) {
                this.getComponente('codigo_unidad').setValue(object.data.codigo_unidad);
            }, this);
            
		},
		Atributos : [{
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_movimiento_det'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				name : 'id_movimiento',
				labelSeparator : '',
				inputType : 'hidden',
			},
			type : 'Field',
			form : true
		}, {
			config : {
				name : 'codigo_item',
				fieldLabel : 'Código',
				allowBlank : true,
				anchor : '100%',
				gwidth : 120
			},
			type : 'TextField',
			filters : {
				pfiltro : 'item.codigo',
				type : 'string'
			},
			id_grupo : 0,
			grid : true,
			form : false
		}, {
			config : {
				name : 'id_item',
				fieldLabel : 'Item',
				allowBlank : false,
				emptyText : 'Elija un Item...',
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
				gwidth : 250,
				minChars : 2,
				turl : '../../../sis_almacenes/vista/item/BuscarItem.php',
				tasignacion : true,
				tname : 'id_item',
				ttitle : 'Items',
				tdata : {},
				tcls : 'BuscarItem',
				pid : this.idContenedor,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre_item']);
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
                name : 'cantidad_solicitada',
                fieldLabel : 'Cantidad Sol.',
                allowBlank : false,
                anchor : '100%',
                gwidth : 120,
                maxLength : 6
            },
            type : 'NumberField',
            filters : {
                pfiltro : 'movdet.cantidad_solicitada',
                type : 'numeric'
            },
            grid : true,
            form : true
        }, {
			config : {
				name : 'cantidad_item',
				fieldLabel : 'Cantidad Real',
				allowBlank : false,
				anchor : '100%',
				gwidth : 120,
				maxLength : 6
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'movdet.cantidad',
				type : 'numeric'
			},
			grid : true,
			form : true
		}, {
			config : {
				name : 'costo_unitario',
				fieldLabel : 'Costo unitario',
				allowBlank : false,
				anchor : '100%',
				gwidth : 130,
				maxLength : 10,
				allowNegative : false,
				decimalPrecision : 6
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'movdet.costo_unitario',
				type : 'numeric'
			},
			grid : true,
			form : true
		}, {
			config : {
				name : 'costo_total',
				fieldLabel : 'Costo Total',
				allowBlank : false,
				anchor : '100%',
				gwidth : 150,
				maxLength : 10,
				allowNegative : false,
				decimalPrecision : 6
			},
			type : 'NumberField',
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_caducidad',
				fieldLabel : 'Fecha de caducidad',
				allowBlank : true,
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y') : ''
				},
				format : 'Y-m-d',
				gwidth : 150
			},
			type : 'DateField',
			filters : {
				pfiltro : 'movdet.fecha_caducidad',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'usr_reg',
				fieldLabel : 'Usuario Reg.',
				gwidth : 100,
			},
			type : 'TextField',
			filters : {
				pfiltro : 'usu1.cuenta',
				type : 'string'
			},
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_reg',
				fieldLabel : 'Fecha registro',
				gwidth : 110,
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'movdet.fecha_reg',
				type : 'date'
			},
			grid : true,
			form : false
		}, {
			config : {
				name : 'usr_mod',
				fieldLabel : 'Usuario mod.',
				gwidth : 100,
			},
			type : 'TextField',
			filters : {
				pfiltro : 'usu2.cuenta',
				type : 'string'
			},
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_mod',
				fieldLabel : 'Fecha de modif.',
				gwidth : 110,
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'movdet.fecha_mod',
				type : 'date'
			},
			grid : true,
			form : false
		}],
		title : 'Detalle de Movimiento',
		ActSave : '../../sis_almacenes/control/MovimientoDetalle/insertarMovimientoDetalle',
		ActDel : '../../sis_almacenes/control/MovimientoDetalle/eliminarMovimientoDetalle',
		ActList : '../../sis_almacenes/control/MovimientoDetalle/listarMovimientoDetalle',
		id_store : 'id_movimiento_det',
		fields : [{
			name : 'id_movimiento_det',
			type : 'numeric'
		}, {
			name : 'id_movimiento',
			type : 'numeric'
		}, {
			name : 'id_item',
			type : 'numeric'
		}, {
			name : 'nombre_item',
			type : 'string'
		}, {
            name : 'codigo_unidad',
            type : 'string'
        }, {
			name : 'cantidad_item',
			type : 'numeric'
		}, {
			name : 'cantidad_solicitada',
			type : 'numeric'
		}, {
			name : 'costo_unitario',
			type : 'numeric'
		}, {
			name : 'fecha_caducidad',
			type : 'date',
			dateFormat : 'Y-m-d'
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
		}, 'codigo_item', 'costo_total'],
		sortInfo : {
			field : 'id_movimiento_det',
			direction : 'ASC'
		},
		bsave : false,
		fwidth : 420,
		fheight : 300,
		onReloadPage : function(m) {
			this.maestro = m;
			this.Atributos[1].valorInicial = this.maestro.id_movimiento;
			if (this.maestro.estado_mov == 'finalizado' || this.maestro.estado_mov == 'cancelado') {
				this.getBoton('edit').hide();
				this.getBoton('del').hide();
				this.getBoton('new').hide();
			} else {
				this.getBoton('edit').show();
				this.getBoton('del').show();
				this.getBoton('new').show();
			}
			if (m.id != 'id') {
				this.store.baseParams = {
					id_movimiento : this.maestro.id_movimiento
				};
				this.load({
					params : {
						start : 0,
						limit : 50
					}
				});
			} else {
				this.grid.getTopToolbar().disable();
				this.grid.getBottomToolbar().disable();
				this.store.removeAll();
			}
		},
		east : {
			url : '../../../sis_almacenes/vista/movimientoDetValorado/MovimientoDetValorado.php',
			title : 'Valoracion del Detalle',
			width : '20%',
			cls : 'MovimientoDetValorado'
		},
		onButtonEdit : function() {
			Phx.vista.MovimientoDetalle.superclass.onButtonEdit.call(this);
			if (this.maestro.tipo == 'ingreso') {
				this.getComponente('costo_unitario').enable();
				this.getComponente('costo_unitario').setVisible(true);
				this.getComponente('fecha_caducidad').setVisible(true);
				this.getComponente('cantidad_solicitada').setVisible(false);
				this.getComponente('cantidad_solicitada').disable();
			} else {
				this.getComponente('costo_unitario').disable();
				this.getComponente('costo_unitario').setVisible(false);
				this.getComponente('fecha_caducidad').setVisible(false);
				this.getComponente('cantidad_solicitada').setVisible(true);
				this.getComponente('cantidad_solicitada').enable();
			}
			this.getComponente('cantidad_item').setVisible(true);
		},
		onButtonNew : function() {
			Phx.vista.MovimientoDetalle.superclass.onButtonNew.call(this);
			if (this.maestro.tipo == 'ingreso') {
				this.getComponente('costo_unitario').enable();
				this.getComponente('costo_unitario').setVisible(true);
				this.getComponente('fecha_caducidad').setVisible(true);
				this.getComponente('cantidad_solicitada').setVisible(false);
				this.getComponente('cantidad_solicitada').disable();
			} else {
				this.getComponente('costo_unitario').disable();
				this.getComponente('costo_unitario').setVisible(false);
				this.getComponente('fecha_caducidad').setVisible(false);
				this.getComponente('cantidad_solicitada').setVisible(true);
				this.getComponente('cantidad_solicitada').enable();
			}
			this.getComponente('cantidad_item').setVisible(true);
		}
	})
</script>

