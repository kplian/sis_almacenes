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
	Phx.vista.PeriodoAlmacenes = {
		require : '../../../sis_parametros/vista/periodo_subsistema/PeriodoSubsistema.php',
		requireclase : 'Phx.vista.PeriodoSubsistema',
		title : 'Periodo Almacenes',
		codigoSubsistema : 'ALM',
		constructor : function(config) {
			Phx.vista.PeriodoAlmacenes.superclass.constructor.call(this, config);
			this.init();
		}
	}; 
</script>
