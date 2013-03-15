<?php
/**
 *@package pXP
 *@file gen-SistemaDist.php
 *@author  (fprudencio)
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
		nombreVista : 'ordenInventario',
		bdel : true,
		bedit : true,
		bnew : true,
		constructor : function(config) {
			Phx.vista.OrdenInventario.superclass.constructor.call(this, config);
			this.init();
			this.load({
				params : {
					start : 0,
					limit : 50
				}
			});
			this.getComponente('fecha_inv_ejec').disable();

			this.addButton('btnFinRegistro', {
				text : '',
				iconCls : 'bok',
				disabled : true,
				handler : this.onBtnFinRegistro,
				tooltip : '<b>Finalizar Registro Orden Inventario</b><br/>Finaliza el registro de la Orden de Inventario para su posterior ejecución.'
			});
		},
		preparaMenu : function(n) {
			var tb = Phx.vista.OrdenInventario.superclass.preparaMenu.call(this);
			var data = this.getSelectedData();
			if (data.estado == 'borrador') {
				this.getBoton('btnFinRegistro').enable();
			} else {
				this.getBoton('btnFinRegistro').disable();
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
		}
	}; 
</script>
