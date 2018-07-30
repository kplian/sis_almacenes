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
Phx.vista.GenerarReporteExistenciasAlmacenero = {
    require:'../../../sis_almacenes/vista/vista_reportes/GenerarReporteExistencias.php',
	requireclase:'Phx.vista.GenerarReporteExistencias',
	title:'Reporte Existencias',
	nombreVista: 'GenerarReporteExistenciasAlmacenero',
	
	constructor: function(config) {	
		Phx.vista.GenerarReporteExistenciasAlmacenero.superclass.constructor.call(this,config);		
   },
   agregarArgsExtraSubmit: function(){
   		Phx.vista.GenerarReporteExistenciasAlmacenero.superclass.agregarArgsExtraSubmit.call(this);
		this.argumentExtraSubmit.mostrar_costos = 'no';
		
	}
   
	
};
</script>
