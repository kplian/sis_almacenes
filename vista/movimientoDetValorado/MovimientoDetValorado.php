<?php
/**
 *@package pXP
 *@file AlmacenStock.php
 *@author Ariel Ayaviri Omonte
 *@date 20-02-2013
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.MovimientoDetValorado = Ext.extend(Phx.gridInterfaz, {
		constructor : function(config) {
			this.maestro = config.maestro;
			Phx.vista.MovimientoDetValorado.superclass.constructor.call(this, config);
			this.init();
			this.grid.getTopToolbar().disable();
			this.grid.getBottomToolbar().disable();
			this.store.removeAll();
		},
		Atributos : [{
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_movimiento_det_valorado'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				name : 'id_movimiento_det',
				labelSeparator : '',
				inputType : 'hidden',
			},
			type : 'Field',
			form : true
		}, {
			config : {
				name : 'cantidad_item',
				fieldLabel : 'Cantidad',
				allowBlank : false,
				anchor : '100%',
				gwidth : 100,
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
				gwidth : 100,
				maxLength : 10
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
		ActSave : '../../sis_almacenes/control/MovimientoDetValorado/insertarMovimientoDetValorado',
		ActDel : '../../sis_almacenes/control/MovimientoDetValorado/eliminarMovimientoDetValorado',
		ActList : '../../sis_almacenes/control/MovimientoDetValorado/listarMovimientoDetValorado',
		id_store : 'id_movimiento_det_valorado',
		fields : [{
			name : 'id_movimiento_det_valorado',
			type : 'numeric'
		}, {
			name : 'id_movimiento_det',
			type : 'numeric'
		}, {
			name : 'cantidad_item',
			type : 'numeric'
		}, {
			name : 'costo_unitario',
			type : 'numeric'
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
			field : 'id_movimiento_det_valorado',
			direction : 'ASC'
		},
		bsave : false,
		fwidth : 420,
		fheight : 280,
		onReloadPage : function(m) {
			this.maestro = m;
			this.Atributos[1].valorInicial = this.maestro.id_movimiento_det;
			
			if (this.maestro.estado_mov == 'finalizado' || this.maestro.estado_mov == 'cancelado') {
				this.getBoton('edit').hide();
				this.getBoton('del').hide();
				this.getBoton('new').hide();
			} else {
			    if (this.maestro.tipo =='salida') {
                    this.getBoton('new').hide();
                } else {
                    this.getBoton('new').show();
                } 
				this.getBoton('edit').show();
				this.getBoton('del').show();
			}
			if (m.id != 'id') {
				this.store.baseParams = {
					id_movimiento_det : this.maestro.id_movimiento_det
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
		successSave : function(resp) {
			this.store.rejectChanges();
			Phx.CP.loadingHide();
			if (resp.argument && resp.argument.news) {
				if (resp.argument.def == 'reset') {
					this.form.getForm().reset();
				}

				this.loadValoresIniciales()
			} else {
				this.window.hide();
			}
			this.sm.clearSelections();
			Phx.CP.getPagina(this.idContenedorPadre).reload();
		},
		successDel : function(resp) {
			Phx.CP.loadingHide();
			Phx.CP.getPagina(this.idContenedorPadre).reload();
		},
		onButtonEdit : function() {
            Phx.vista.MovimientoDetValorado.superclass.onButtonEdit.call(this);
            if (this.maestro.tipo == 'ingreso') {
                this.getComponente('costo_unitario').setVisible(true);
            } else {
                this.getComponente('costo_unitario').setVisible(false);
            }
        },
        onButtonNew : function() {
            Phx.vista.MovimientoDetValorado.superclass.onButtonNew.call(this);
            if (this.maestro.tipo == 'ingreso') {
                this.getComponente('costo_unitario').setVisible(true);
            } else {
                this.getComponente('costo_unitario').setVisible(false);
            }
        }
	})
</script>

