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
Phx.vista.KardexItemAlmacenero = {
    require:'../../../sis_almacenes/vista/vista_reportes/KardexItem.php',
	requireclase:'Phx.vista.KardexItem',
	title:'Kardex X Item',
	nombreVista: 'KardexItemAlmacenero',	
	
   onSubmit: function(){
			if (this.form.getForm().isValid()) {
				var data={};
				data.fecha_ini=this.getComponente('fecha_ini').getValue();
				data.item=this.getComponente('id_item').getRawValue();
				data.fecha_fin=this.getComponente('fecha_fin').getValue();
				data.id_item=this.getComponente('id_item').getValue();
				data.all_alm=this.getComponente('all_alm').getValue();
				data.id_almacen=this.getComponente('id_almacen').getValue();
				data.mostrar_costos = 'no';
				Phx.CP.loadWindows('../../../sis_almacenes/vista/vista_reportes/repKardexItem.php', 'Kardex por Item: '+this.desc_item, {
						width : '90%',
						height : '80%'
					}, data	, this.idContenedor, 'repKardexItem')
			}
		}
   
	
};
</script>
