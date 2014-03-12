<?php
/**
*@package pXP
*@file gen-SistemaDist.php
*@author  (fprudencio)
*@date 20-09-2011 10:22:05
*@description Archivo con la interfaz de usuario que permite 
*dar el visto a solicitudes de compra
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
       
        
    },
   
    
   
    
};
</script>
