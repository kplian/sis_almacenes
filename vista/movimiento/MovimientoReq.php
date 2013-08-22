<?php
/**
*@package pXP
*@file MovimientoReq.php
*@author  Gonzalo Sarmiento Sejas
*@date 05-07-2013 10:22:05
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.MovimientoReq = {
	require:'../../../sis_almacenes/vista/movimiento/Movimiento.php',
	requireclase:'Phx.vista.Movimiento',
	title:'Movimiento',	
	nombreVista: 'movimientoReq',
	
	constructor: function(config) {
    		Phx.vista.MovimientoReq.superclass.constructor.call(this,config);
    		this.addButton('fin_requerimiento',{text:'Finalizar',iconCls: 'badelante',disabled:true,handler:this.fin_requerimiento,tooltip: '<b>Finalizar</b>'});
            
      this.iniciarEventos();
      
						this.store.baseParams={tipo_interfaz:this.nombreVista};
					 this.load({params:{start:0, limit:this.tam_pag}});
		
	},
    
    iniciarEventos:function(){
        
        this.cmpFechaMov = this.getComponente('fecha_mov');
        this.cmpIdGestion = this.getComponente('id_gestion');
        
        //inicio de eventos 
        this.cmpFechaMov.on('change',function(f){
        	
             this.obtenerGestion(this.cmpFechaMov);
             
             },this);        
      
    },
         
    onButtonNew:function(){
       Phx.vista.MovimientoReq.superclass.onButtonNew.call(this); 
              
       //this.Cmp.fecha_mov.setValue(new Date());
       this.Cmp.fecha_mov.fireEvent('change');      
           
    },
    
    onFinalizarSol:function(){
           var d= this.sm.getSelected().data;
              Phx.CP.loadingShow(); 
              Ext.Ajax.request({
               url:'../../sis_almacenes/control/Movimiento/finalizarMovimiento',
               params:{id_movimiento:d.id_movimiento,operacion:'finalizarRegistro'
               ,id_almacen:d.id_almacen
               },
               success:this.successFinSol,
               failure: this.conexionFailure,
               timeout:this.timeout,
               scope:this
           }); 
           
     },
        successFinSol:function(resp){
            
            Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if(!reg.ROOT.error){
                
                this.reload();
               
            }else{
                
                alert('ocurrio un error durante el proceso')
            }
           
            
        },
    
    
    fin_requerimiento:function()
        {                   
            var d= this.sm.getSelected().data;
           
            Phx.CP.loadingShow();            
            Ext.Ajax.request({
                url:'../../sis_almacenes/control/Movimiento/finalizarMovimiento',
                params:{id_movimiento:d.id_movimiento, id_almacen:d.id_almacen,operacion:'verificar'},
                success:this.onFinalizarSol,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });     
        },
     
     obtenerGestion:function(x){
     	if(Ext.isDate(x.getValue())){
	         var fecha = x.getValue().dateFormat(x.format);
	            Phx.CP.loadingShow();
	            Ext.Ajax.request({
	                    url:'../../sis_parametros/control/Gestion/obtenerGestionByFecha',
	                    params:{fecha:fecha},
	                    success:this.successGestion,
	                    failure: this.conexionFailure,
	                    timeout:this.timeout,
	                    scope:this
	             });
		}
	}, 
        
    successGestion:function(resp){
       Phx.CP.loadingHide();
            var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
            if(!reg.ROOT.error){
                
                this.cmpIdGestion.setValue(reg.ROOT.datos.id_gestion);
               
            }else{
                
                alert('ocurrio al obtener la gestion')
            } 
    },
    
	 preparaMenu:function(n){
      var data = this.getSelectedData();
      var tb =this.tbar;
      Phx.vista.MovimientoReq.superclass.preparaMenu.call(this,n);
          if(data['estado_mov']== 'borrador' || data['estado_mov']=='Borrador'){
             this.getBoton('fin_requerimiento').enable();
           }
          else{
               this.getBoton('fin_requerimiento').disable();
               this.getBoton('edit').disable();
               this.getBoton('del').disable();  
          }
        return tb 
     }, 
     liberaMenu:function(){
        var tb = Phx.vista.MovimientoReq.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('fin_requerimiento').disable();
           
        }
        
       return tb
    }
};
</script>
