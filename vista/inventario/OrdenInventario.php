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
	require:'../../../sis_almacenes/vista/inventario/InventarioBase.php',
	requireclase:'Phx.vista.InventarioBase',
	title:'Órdenes de Inventario',
	nombreVista: 'ordenInventario',
	bdel: true,
	bedit: true,
	bnew: true,
	constructor: function(config) {
		Phx.vista.OrdenInventario.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:50}});
		this.getComponente('fecha_inv_ejec').disable();
	}
};
</script>
