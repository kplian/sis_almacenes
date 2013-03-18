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
				tooltip : '<b>Finalizar Registro Orden Inventario</b><br/>Finaliza el registro de la Orden de Inventario para su posterior ejecución.'
			});
			
			this.addButton('btnFinRevision', {
                text : '',
                iconCls : 'bend',
                disabled : true,
                handler : this.onBtnFinRevision,
                tooltip : '<b>Finalizar Registro Orden Inventario</b><br/>Finaliza el registro de la Orden de Inventario para su posterior ejecución.'
            });
		},
		preparaMenu : function(n) {
			var tb = Phx.vista.OrdenInventario.superclass.preparaMenu.call(this);
			var data = this.getSelectedData();
			if (data.estado == 'borrador') {
				this.getBoton('btnFinRegistro').enable();
				this.getBoton('btnFinRevision').disable();
			} else if (data.estado == 'revision') {
			    this.getBoton('btnFinRegistro').disable();
                this.getBoton('btnFinRevision').enable();
			} else {
				this.getBoton('btnFinRegistro').disable();
				this.getBoton('btnFinRevision').disable();
			}
			return tb;
		},
		liberaMenu : function() {
			var tb = Phx.vista.OrdenInventario.superclass.liberaMenu.call(this);
			this.getBoton('btnFinRegistro').disable();
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
                        url : '../../sis_almacenes/control/Inventario/finalizarRevisionInventario',
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
			Phx.vista.OrdenInventario.superclass.onButtonNew.call(this);
			this.getComponente('id_almacen').enable();
			this.getComponente('id_usuario_resp').enable();
			this.getComponente('completo').enable();
			this.getComponente('fecha_inv_planif').enable();
			this.getComponente('observaciones').enable();
		},
		onButtonEdit : function() {
			Phx.vista.OrdenInventario.superclass.onButtonEdit.call(this);
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
		}
	}; 
</script>
