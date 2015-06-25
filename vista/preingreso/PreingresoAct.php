<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  (fprudencio)
*@date 20-09-2011 10:22:05
*@description Interfaz de preingreso en activos fijos
*
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PreingresoAct = {
    
    require:'../../../sis_almacenes/vista/preingreso/Preingreso.php',
    requireclase:'Phx.vista.Preingreso',
    title:'Preingreso de Activos Fijos',
    nombreVista: 'preingresoAct',
    
    constructor: function(config) {
       Phx.vista.PreingresoAct.superclass.constructor.call(this,config);
       this.store.baseParams={tipo_interfaz:this.nombreVista};
       this.load({params:{start:0, limit:this.tam_pag}});
       
       this.addButton('btnIngreso',{
			text:'Generar Alta Activos Fijos',
	        iconCls: 'badelante',
	        disabled: true,
	        handler: this.onIngreso,
	        tooltip: '<b>Alta Activo Sfijos</b><br/><b>Generación del alta de Activo Fijo</b>'
	   });
    },
    
    preparaMenu:function(n){
		var rec = this.getSelectedData();
      	var tb =this.tbar;
      	Phx.vista.PreingresoAct.superclass.preparaMenu.call(this,n);
      
      	if(rec.estado=='borrador'){
      		this.getBoton('btnIngreso').enable();
      	} else if(rec.estado=='cancelado'||rec.estado=='finalizado'){
      		this.getBoton('btnIngreso').disable();
      	} else {
      		this.getBoton('btnIngreso').disable();
      	}
	},
	
	liberaMenu:function(){
		var tb = Phx.vista.PreingresoAct.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('btnIngreso').disable();
         }
        return tb
   }
    
};
</script>
