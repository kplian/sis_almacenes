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
   },
    
};
</script>
