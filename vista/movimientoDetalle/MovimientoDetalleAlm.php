<?php
/**
*@package pXP
*@file MovimientoDetalleAlm.php
*@author  Gonzalo Sarmiento Sejas
*@date 09-07-2013 10:22:05
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.MovimientoDetalleAlm = {
    bedit:true,
    bnew:false,
    bsave:true,
    bdel:false,
	require:'../../../sis_almacenes/vista/movimientoDetalle/MovimientoDetalle.php',
	requireclase:'Phx.vista.MovimientoDetalle',
	title:'Movimiento',
	nombreVista: 'movimientoDetalleAlm',
	
	constructor: function(config) {
	    
	    this.maestro=config.maestro;
     Phx.vista.MovimientoDetalleAlm.superclass.constructor.call(this,config);
        
    },
	onReloadPage:function(m){
       this.maestro=m;
       this.store.baseParams={id_movimiento:this.maestro.id_movimiento};
       this.load({params:{start:0, limit:this.tam_pag}});        
       
    },
    
    onButtonEdit : function() {
							Phx.vista.MovimientoDetalleAlm.superclass.onButtonEdit.call(this);
							if (this.maestro.tipo == 'ingreso') {
								this.getComponente('costo_unitario').enable();
								this.getComponente('costo_unitario').setVisible(true);
								this.getComponente('fecha_caducidad').enable();
								this.getComponente('fecha_caducidad').setVisible(true);
								this.getComponente('cantidad_solicitada').setVisible(true);
								this.getComponente('cantidad_solicitada').disable();
							} else {
								this.getComponente('costo_unitario').disable();
								this.getComponente('costo_unitario').setVisible(false);
								this.getComponente('fecha_caducidad').setVisible(false);
								this.getComponente('cantidad_solicitada').setVisible(true);
								this.getComponente('cantidad_solicitada').disable();
							}
							this.getComponente('observaciones').setVisible(true);
							this.getComponente('id_item').disable();
							this.getComponente('cantidad_item').setVisible(true);
				},
    
    east : false
  
};
</script>
