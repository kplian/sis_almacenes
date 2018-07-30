<?php
/**
*@package pXP
*@file PreingresoActV2
*@author  RCM
*@date 08/08/2017
*@description Interfaz de preingreso, segunda versión, que genera el registro en el sistema de activos fijos de pxp (sis_kactivos_fijos)
*
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PreingresoActV2 = {
    require:'../../../sis_almacenes/vista/preingreso/Preingreso.php',
    requireclase:'Phx.vista.Preingreso',
    title:'Preingreso de Activos Fijos',
    nombreVista: 'preingresoActV2',
    gruposBarraTareas:[
        {name:'borrador',title:'<h1 align="center"><i class="fa fa-thumbs-o-down"></i>Para Registro</h1>',grupo:0,height:0},
        {name:'registrado',title:'<h1 align="center"><i class="fa fa-eye"></i>Para Alta</h1>',grupo:1,height:0},
        {name:'finalizado',title:'<h1 align="center"><i class="fa fa-thumbs-o-up"></i>Finalizados</h1>',grupo:2,height:0}
    ],
    
    actualizarSegunTab: function(name, indice){
    	if(this.finCons){
    		 this.store.baseParams.pes_estado = name;
    	     this.load({params:{start:0, limit:this.tam_pag}});
    	   }
    },
    
    constructor: function(config) {
       Phx.vista.PreingresoActV2.superclass.constructor.call(this,config);
       this.store.baseParams={tipo_interfaz:this.nombreVista};
       //primera carga
	     this.store.baseParams.pes_estado = 'borrador';
       this.load({params:{start:0, limit:this.tam_pag}});
       this.finCons = true;
       this.addButton('btnRevertir',{
	   				grupo:[0],
                    text :'Cancelar Preingreso',
                    iconCls : 'batras',
                    disabled: true,
                    handler : this.onRevertir,
                    tooltip : '<b>Cancelar Preingreso</b><br/><b>Cancela el Preingreso generado</b>'
         });
       
       this.addButton('btnIngreso',{
       		grupo:[0],
			    text:'Registrar Activos Fijos',
	        iconCls: 'badelante',
	        disabled: true,
	        handler: this.onIngreso,
	        tooltip: '<b>Registro Activo fijos</b><br/><b>Registrar Activo Fijo</b>'
	   });
	   
	   this.addButton('btnAlta',{
	   		grupo:[1],
			text:'Generar Alta de Activos Fijos',
	        iconCls: 'badelante',
	        disabled: true,
	        handler: this.onIngreso,
	        tooltip: '<b>Alta Activos Fijos</b><br/><b>Generación del alta de Activo Fijo</b>'
	   });

     //this.EnableSelect();
	   
	   
    },
    
    preparaMenu:function(n){
		var rec = this.getSelectedData();
      	var tb =this.tbar;
      	Phx.vista.PreingresoActV2.superclass.preparaMenu.call(this,n);
      
      	if(rec.estado=='borrador'){
      		this.getBoton('btnIngreso').enable();
      		this.getBoton('btnRevertir').enable();
      		this.getBoton('btnAlta').disable();
      	} else if(rec.estado=='cancelado'||rec.estado=='finalizado'){
      		this.getBoton('btnIngreso').disable();
      		this.getBoton('btnAlta').disable();
      		this.getBoton('btnRevertir').disable();
      	} else {
      		this.getBoton('btnAlta').enable();
      		this.getBoton('btnIngreso').disable();
      	}
	},
	
	liberaMenu:function(){
		var tb = Phx.vista.PreingresoActV2.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('btnIngreso').disable();
            this.getBoton('btnAlta').disable();
            this.getBoton('btnRevertir').disable();
         }
        return tb
   },
   south:{
          url:'../../../sis_almacenes/vista/preingreso_det/PreingresoDetActV2.php',
          title:'Adquisiciones', 
          height:'50%', //altura de la ventana hijo
          cls:'PreingresoDetActV2'
    }
    
};
</script>
