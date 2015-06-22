<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  (rarteaga)
*@date 20-09-2014 
*@description Interfaz de preingreso en almacenes
*
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PreingresoAlm = {
    
    require:'../../../sis_almacenes/vista/preingreso/Preingreso.php',
    requireclase:'Phx.vista.Preingreso',
    title:'Preingreso de Almacenes',
    nombreVista: 'preingresoAlm',
    
    constructor: function(config) {
       Phx.vista.PreingresoAlm.superclass.constructor.call(this,config);
       this.store.baseParams={tipo_interfaz:this.nombreVista};
       this.load({params:{start:0, limit:this.tam_pag}});
       
       this.addButton('btnIngreso',{
			text :'Generar Ingreso Almacén',
	        iconCls : 'badelante',
	        disabled: true,
	        handler : this.onIngreso,
	        tooltip : '<b>Ingreso</b><br/><b>Generación del Ingreso a Almacén</b>'
	   });
   },
   
    preparaMenu:function(n){
		var rec = this.getSelectedData();
      	var tb =this.tbar;
      	Phx.vista.PreingresoAlm.superclass.preparaMenu.call(this,n);
      
      	if(rec.estado=='borrador'){
      		this.getBoton('btnIngreso').enable();
      	} else if(rec.estado=='cancelado'||rec.estado=='finalizado'){
      		this.getBoton('btnIngreso').disable();
      	} else {
      		this.getBoton('btnIngreso').disable();
      	}
	},
	
	liberaMenu:function(){
		var tb = Phx.vista.PreingresoAlm.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('btnIngreso').disable();
         }
        return tb
   }
 
};
</script>
