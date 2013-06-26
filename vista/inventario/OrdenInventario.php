<?php
/**
 *@package pXP
 *@file gen-SistemaDist.php
 *@author  Ariel Ayaviri Omonte
 *@date 20-09-2011 10:22:05
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.OrdenInventario = {
		require : '../../../sis_almacenes/vista/inventario/InventarioBase.php',
		requireclase : 'Phx.vista.InventarioBase',
		title : 'Órdenes de Inventario',
		nombreVista : 'OrdenInventario',
		bdel : true,
		bedit : true,
		bnew : true,
		constructor : function(config) {
			Phx.vista.OrdenInventario.superclass.constructor.call(this, config);
			this.init();
			this.load({
				params : {
					start : 0,
					limit : 50,
					nombreVista : this.nombreVista
				}
			});
			this.getComponente('fecha_inv_ejec').disable();

			this.addButton('btnFinRegistro', {
				text : '',
				iconCls : 'badelante',
				disabled : true,
				handler : this.onBtnFinRegistro,
				tooltip : '<b>Finalizar Registro de Orden Inventario</b><br/>Finaliza el registro de la Orden de Inventario para su posterior ejecución.'
			});

			this.addButton('btnFinRevision', {
				text : '',
				iconCls : 'bend',
				disabled : true,
				handler : this.onBtnFinRevision,
				tooltip : '<b>Finalizar Revision de Orden Inventario</b><br/>Da por finalizada la revision de una Orden de Inventario.'
			});

			this.addButton('btnCorregirInventario', {
				text : '',
				iconCls : 'bundo',
				disabled : true,
				handler : this.onBtnCorregirInventario,
				tooltip : '<b>Devolver por Corrección</b><br/>Devuelve la Orden de Inventario para se corregida.'
			});

			console.log(this);
		},
		preparaMenu : function(n) {
			var tb = Phx.vista.OrdenInventario.superclass.preparaMenu.call(this);
			var data = this.getSelectedData();
			if (data.estado == 'borrador') {
				this.getBoton('btnFinRegistro').enable();
				this.getBoton('btnFinRevision').disable();
				this.getBoton('btnCorregirInventario').disable();
				this.getBoton('del').show();			} else if (data.estado == 'revision') {
				this.getBoton('btnFinRegistro').disable();
				this.getBoton('btnFinRevision').enable();
				this.getBoton('btnCorregirInventario').enable();				this.getBoton('del').hide();			} else {
				this.getBoton('btnFinRegistro').disable();
				this.getBoton('btnFinRevision').disable();
				this.getBoton('btnCorregirInventario').disable();
				this.getBoton('del').hide();			}
			return tb;
		},
		liberaMenu : function() {
			var tb = Phx.vista.OrdenInventario.superclass.liberaMenu.call(this);
			this.getBoton('btnFinRegistro').disable();
			this.getBoton('btnFinRevision').disable();
			this.getBoton('btnCorregirInventario').disable();
			return tb;
		},
		onBtnFinRegistro : function() {
			var rec = this.sm.getSelected();
			var data = rec.data;
			var global = this;
			Ext.Msg.confirm('Confirmación', '¿Está seguro de finalizar el Registro de la Orden de Inventario?', function(btn) {
				if (btn == "yes") {
					Ext.Ajax.request({
						url : '../../sis_almacenes/control/Inventario/finalizarRegistro',
						params : {
							'id_inventario' : data.id_inventario,
						},
						success : global.successSave,
						failure : global.conexionFailure,
						timeout : global.timeout,
						scope : global
					});
				}
			});
		},
		onBtnFinRevision : function() {
			var rec = this.sm.getSelected();
			var data = rec.data;
			var global = this;
			Ext.Msg.confirm('Confirmación', '¿Está seguro de finalizar la revision de la Orden de Inventario seleccionada?', function(btn) {
				if (btn == "yes") {

					Ext.Ajax.request({
						url : '../../sis_almacenes/control/Inventario/revisarDiferenciasInventario',
						params : {
							'id_inventario' : data.id_inventario,
						},
						success : global.successValidarDiferencias,
						failure : global.conexionFailure,
						timeout : global.timeout,
						scope : global
					});
				}
			});
		},
		successValidarDiferencias : function(resp, a) {
		    var rec = this.sm.getSelected();
            var data = rec.data;
            var global = this;
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			if (parseInt(reg.ROOT.datos.cant_diferencias) > 0) {
				Ext.Msg.confirm('Confirmación', 'El inventario seleccionado tiene diferencias entre los datos del sistema y los datos reales. \n ¿Desea proseguir con la finalización?', function(btn) {
					if (btn == "yes") {
						Ext.Ajax.request({
                            url : '../../sis_almacenes/control/Inventario/finalizarRevisionInventario',
                            params : {
                                'id_inventario' : data.id_inventario,
                            },
                            success : global.successSave,
                            failure : global.conexionFailure,
                            timeout : global.timeout,
                            scope : global
                        });
					} else if (btn == 'no') {
						Ext.Msg.confirm('Confirmación', '¿Desea registrar automáticamente los movimientos necesarios para igualar las diferencias?', function(btn) {
						    if (btn == "yes") {
						        Ext.Ajax.request({
                                    url : '../../sis_almacenes/control/Inventario/nivelarDiferenciasInventario',
                                    params : {
                                        'id_inventario' : data.id_inventario,
                                    },
                                    success : global.successSave,
                                    failure : global.conexionFailure,
                                    timeout : global.timeout,
                                    scope : global
                                });
						    }
						});					}
				});
			}
		},
		onBtnCorregirInventario : function() {
			var rec = this.sm.getSelected();
			var data = rec.data;
			var global = this;
			Ext.Msg.confirm('Confirmación', '¿Está seguro de devolver la Orden de Inventario para su corrección?', function(btn) {
				if (btn == "yes") {
					Ext.Ajax.request({
						url : '../../sis_almacenes/control/Inventario/corregirEjecucionInventario',
						params : {
							'id_inventario' : data.id_inventario,
						},
						success : global.successSave,
						failure : global.conexionFailure,
						timeout : global.timeout,
						scope : global
					});
				}
			});
		},
		onButtonNew : function() {
			this.getComponente('id_almacen').enable();
			this.getComponente('id_usuario_resp').disable();
			this.getComponente('completo').enable();
			this.getComponente('fecha_inv_planif').enable();
			this.getComponente('observaciones').enable();
			Phx.vista.OrdenInventario.superclass.onButtonNew.call(this);
		},
		onButtonEdit : function() {
			var rec = this.sm.getSelected();
			if (rec.data.estado == 'borrador') {
				this.getComponente('id_almacen').enable();
				this.getComponente('id_usuario_resp').enable();
				this.getComponente('completo').enable();
				this.getComponente('fecha_inv_planif').enable();
				this.getComponente('observaciones').enable();
			} else {
				this.getComponente('id_almacen').disable();
				this.getComponente('id_usuario_resp').disable();
				this.getComponente('completo').disable();
				this.getComponente('fecha_inv_planif').disable();
				this.getComponente('observaciones').disable();
			}
			Phx.vista.OrdenInventario.superclass.onButtonEdit.call(this);
		}
	}; 
</script>
