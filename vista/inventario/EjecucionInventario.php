<?php
/**
 *@package pXP
 *@file gen-SistemaDist.php
 *@author  (Ariel ayaviri Omonte)
 *@date 20-09-2011 10:22:05
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.EjecucionInventario = {
		require : '../../../sis_almacenes/vista/inventario/InventarioBase.php',
		requireclase : 'Phx.vista.InventarioBase',
		title : 'Ejecución de Inventario',
		nombreVista : 'EjecucionInventario',
		bdel : false,
		bedit : true,
		bnew : false,
		constructor : function(config) {
			Phx.vista.EjecucionInventario.superclass.constructor.call(this, config);
			this.init();
			this.load({
				params : {
					start : 0,
					limit : 50,
					nombreVista : this.nombreVista
				}
			});
			
			this.addButton('btnEjecucionInventario', {
				text : '',
				iconCls : 'bchecklist',
				disabled : true,
				handler : this.onBtnEjecucionInventario,
				tooltip : '<b>Comezar el Llenado de Inventario</b><br/>Habilita el registro del inventario seleccionado.'
			});
			
			this.addButton('btnFinEjecucionInventario', {
				text : '',
				iconCls : 'badelante',
				disabled : true,
				handler : this.onBtnFinEjecucionInventario,
				tooltip : '<b>Finalizar el llenado de Inventario</b><br/>Habilita el registro del inventario seleccionado.'
			});

			this.getComponente('')
		},
		preparaMenu : function(n) {
			var tb = Phx.vista.EjecucionInventario.superclass.preparaMenu.call(this);
			var data = this.getSelectedData();
			if (data.estado == 'pendiente_ejecucion') {
				this.getBoton('btnEjecucionInventario').enable();
				this.getBoton('btnFinEjecucionInventario').disable();
			} else {
				this.getBoton('btnEjecucionInventario').disable();
				this.getBoton('btnFinEjecucionInventario').enable();
			}
			return tb;
		},
		liberaMenu : function() {
			var tb = Phx.vista.EjecucionInventario.superclass.liberaMenu.call(this);
			this.getBoton('btnEjecucionInventario').disable();
			return tb;
		},
		onBtnEjecucionInventario : function() {
			var rec = this.sm.getSelected();
			var data = rec.data;
			var global = this;
			Ext.Msg.confirm('Confirmación', '¿Está seguro de comenzar el llenado del inventario seleccionado?', function(btn) {
				if (btn == "yes") {
					Ext.Ajax.request({
						url : '../../sis_almacenes/control/Inventario/iniciarEjecucionInventario',
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
		onBtnFinEjecucionInventario : function() {
            var rec = this.sm.getSelected();
            var data = rec.data;
            var global = this;
            Ext.Msg.confirm('Confirmación', '¿Está seguro de finalizar el llenado del inventario seleccionado?', function(btn) {
                if (btn == "yes") {
                    Ext.Ajax.request({
                        url : '../../sis_almacenes/control/Inventario/finalizarEjecucionInventario',
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
            this.getComponente('id_almacen').disable();
            this.getComponente('id_usuario_resp').disable();
            this.getComponente('completo').disable();
            this.getComponente('fecha_inv_planif').disable();
            this.getComponente('observaciones').disable();
        },
        onButtonEdit : function() {
            Phx.vista.OrdenInventario.superclass.onButtonEdit.call(this);
            var rec = this.sm.getSelected();
            this.getComponente('id_almacen').disable();
            this.getComponente('id_usuario_resp').disable();
            this.getComponente('completo').disable();
            this.getComponente('fecha_inv_planif').disable();
            this.getComponente('observaciones').disable();
            if (rec.data.estado == 'pendiente_ejecucion') {
                this.getComponente('fecha_inv_ejec').disable();
            } else if (rec.data.estado == 'ejecucion') {
                this.getComponente('fecha_inv_ejec').enable();
            }
        }
	}; 
</script>
