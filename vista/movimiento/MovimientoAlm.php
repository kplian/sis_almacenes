<?php
/**
*@package pXP
*@file MovimientoAlm.php
*@author  Gonzalo Sarmiento
*@date 10-07-2013 10:22:05
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.MovimientoAlm = {
    bedit:false,
    bnew:false,
    bsave:false,
    bdel:false,
	require:'../../../sis_almacenes/vista/movimiento/Movimiento.php',
	requireclase:'Phx.vista.Movimiento',
	title:'Movimiento',
	nombreVista: 'movimientoAlm',
	
	constructor: function(config) {
	    
	    this.maestro=config.maestro;
        
    	Phx.vista.MovimientoAlm.superclass.constructor.call(this,config);
    	
    	this.addButton('sig_estado',{text:'Finalizar',iconCls: 'badelante',disabled:true,handler:this.sigEstado,tooltip: '<b>Finalizar Registro</b>'});
     
     this.getBoton('btnRevertir').hide();
     this.getBoton('btnCancelar').hide();
        
     this.store.baseParams={tipo_interfaz:this.nombreVista};
     this.load({params:{start:0, limit:this.tam_pag}});
		
	},
    
    sigEstado:function()
        {                   
            var d= this.sm.getSelected().data;
           
            Phx.CP.loadingShow();
            
            Ext.Ajax.request({
                url:'../../sis_almacenes/control/Movimiento/finalizarMovimiento',
                params:{id_movimiento:d.id_movimiento,
                							 id_almacen:d.id_almacen, 
                							 fecha_mov:d.fecha_mov,
                        operacion:'finalizarMovimiento'},
                success:this.successSinc,
                argument:{data:d},
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });     
        },
       
       successSinc:function(resp){
            
            Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if(!reg.ROOT.error){
                
               this.reload();
                
            }else{
                
                alert('ocurrio un error durante el proceso')
            }
           
            
        },
     
  preparaMenu:function(n){
      var data = this.getSelectedData();
      var tb =this.tbar;
      Phx.vista.MovimientoAlm.superclass.preparaMenu.call(this,n);  
          
        if(data.estado =='aprobado' ){ 
            this.getBoton('sig_estado').disable();
        }
        if(data.estado =='proceso'){
            this.getBoton('sig_estado').disable();
        }
        
        if(data.estado !='aprobado' && data.estado !='proceso' ){                
            this.getBoton('sig_estado').enable();            
        }
       
        return tb 
     }, 
     liberaMenu:function(){
        var tb = Phx.vista.MovimientoAlm.superclass.liberaMenu.call(this);
        if(tb){        	
            this.getBoton('sig_estado').disable();
        }
        return tb
    },
    
    south:
          { 
          url:'../../../sis_almacenes/vista/movimientoDetalle/MovimientoDetalleAlm.php',
          title:'Detalle', 
          height:'50%',
          cls:'MovimientoDetalleAlm'
         }
};
</script>
