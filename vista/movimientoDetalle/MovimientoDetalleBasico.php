<?php
/**
*@package pXP
*@file MovimientoReq.php
*@author  Gonzalo Sarmiento Sejas
*@date 05-07-2013 10:22:05
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.MovimientoDetalleBasico= {
	require:'../../../sis_almacenes/vista/movimientoDetalle/MovimientoDetalle.php',
	requireclase:'Phx.vista.MovimientoDetalle',
	title:'Movimiento',	
	nombreVista: 'movimientoDetalleBasico',
	
	constructor: function(config) {
		this.Atributos[this.getIndAtributo('costo_unitario')].grid=false; 
        this.Atributos[this.getIndAtributo('costo_total')].grid=false; 
		this.maestro = config;
    	Phx.vista.MovimientoDetalleBasico.superclass.constructor.call(this,config);
    	
		
		
	},
	east : undefined
    
    

};
</script>
