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
Phx.vista.MovimientoDetalleVb = {
    bedit:false,
    bnew:false,
    bsave:false,
    bdel:false,
	require:'../../../sis_almacenes/vista/movimientoDetalle/MovimientoDetalle.php',
	requireclase:'Phx.vista.MovimientoDetalle',
	title:'MovimientoVb',
	nombreVista: 'movimientoDetalleVb',
	
	constructor: function(config) {
	    
	    this.maestro=config.maestro;
     Phx.vista.MovimientoDetalleVb.superclass.constructor.call(this,config);
        
    },
	onReloadPage:function(m){
       this.maestro=m;
       this.store.baseParams={id_movimiento:this.maestro.id_movimiento};
       this.load({params:{start:0, limit:this.tam_pag}});        
       
    },
        
    east : false
  
};
</script>
