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
    	this.addButton('ini_estado',{argument: {operacion: 'inicio'},text:'Dev. a Borrador',iconCls: 'batras',disabled:true,handler:this.retroceder,tooltip: '<b>Retorna Movimiento al estado borrador</b>'});
	    this.addButton('ant_estado',{argument: {operacion: 'anterior'},text:'Anterior',iconCls: 'batras',disabled:true,handler:this.retroceder,tooltip: '<b>Pasar al Anterior Estado</b>'});
    	this.addButton('sig_estado',{text:'Finalizar',iconCls: 'badelante',disabled:true,handler:this.fin_requerimiento,tooltip: '<b>Finalizar Registro</b>'});
		this.getBoton('btnRevertir').hide();
	    this.getBoton('btnCancelar').hide();
	    this.store.baseParams={tipo_interfaz:this.nombreVista};
	    this.load({params:{start:0, limit:this.tam_pag}});
	    
	    //Creación de ventana para workflow
		this.crearVentanaWF();
	},
    
    sigEstado:function(){                   
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
    
    antEstado:function(res,eve) {
        //Oculta y deshablita controles
        this.cmbTipoEstWF.hide();
        this.cmbTipoEstWF.disable();
        
        this.cmbFunWF.hide();
        this.cmbFunWF.disable();

        //Muestra y habilita el campo de observaciones
        this.txtObs.show();
        this.txtObs.allowBlank=false;
        this.txtObs.setValue('');
        this.sw_estado =res.argument.estado;
        
        //Oculta botones de cancelar y muestra la ventana                   
    	this.winWF.buttons[1].hide();
        this.winWF.buttons[0].show();
        this.winWF.show();
	},
	
	onWF: function(){
		if(this.sw_estado=='inicio'){
			
		} else if(this.sw_estado=='inicio'){
			
		} else {
			Phx.vista.MovimientoVb.superclass.onWF.call(this);
		} 
	},
        
	antEstadoSubmmit:function(res){
        var d= this.sm.getSelected().data;
       
        Phx.CP.loadingShow();
        var operacion = 'cambiar';
        operacion=  this.sw_estado == 'inicio'?'inicio':operacion; 
        
        Ext.Ajax.request({
            // form:this.form.getForm().getEl(),
            url:'../../sis_almacenes/control/Movimiento/anteriorEstadoMovimiento',
            params:{id_movimiento:d.id_movimiento, 
                    id_estado_wf:d.id_estado_wf, 
                    operacion: operacion,
                    obs:this.cmpObs.getValue()},
            success:this.successSinc,
            failure: this.conexionFailure,
            timeout:this.timeout,
            scope:this
        });  
        
        
	}, 
       
	successSinc:function(resp){
        Phx.CP.loadingHide();
        var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
        if(!reg.ROOT.error){
            
          
           if (reg.ROOT.datos.operacion=='preguntar_todo'){
               if(reg.ROOT.datos.num_estados==1 && reg.ROOT.datos.num_funcionarios==1){
                   //directamente mandamos los datos
                   Phx.CP.loadingShow();
                   var d= this.sm.getSelected().data;
                   Ext.Ajax.request({
                    // form:this.form.getForm().getEl(),
                    url:'../../sis_almacenes/control/Movimiento/siguienteEstadoMovimiento',
                    params:{id_movimiento:d.id_movimiento,
                        operacion:'cambiar',
                        id_tipo_estado:reg.ROOT.datos.id_tipo_estado,
                        id_funcionario:reg.ROOT.datos.id_funcionario_estado,
                        id_depto:reg.ROOT.datos.id_depto_estado,
                        //id_solicitud:d.id_solicitud,
                        obs:this.cmpObs.getValue(),
                        instruc_rpc:this.cmbIntrucRPC.getValue()
                        },
                    success:this.successSinc,
                    failure: this.conexionFailure,
                    timeout:this.timeout,
                    scope:this
                }); 
             }
               else{
                 this.cmbTipoEstado.store.baseParams.estados= reg.ROOT.datos.estados;
                 this.cmbTipoEstado.modificado=true;
             
                 console.log(resp)
                  if(resp.argument.data.estado=='vbrpc'){
                    this.cmbIntrucRPC.show();
                    this.cmbIntrucRPC.enable();
                 }
                 else{
                     this.cmbIntrucRPC.hide();
                     this.cmbIntrucRPC.disable(); 
                     
                 }
                 
                 this.cmpObs.setValue('');
                 this.cmbFuncionarioWf.disable();
                 this.wEstado.buttons[1].hide();
                 this.wEstado.buttons[0].show();
                 this.wEstado.show();  
              }
               
           }
           
            if (reg.ROOT.datos.operacion=='cambio_exitoso'){
            
              this.reload();
              this.wEstado.hide();
            
            }
 
        } else{
            
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
            this.getBoton('ini_estado').enable();            
            this.getBoton('ant_estado').enable();
            this.getBoton('sig_estado').enable();
        }
       
        return tb 
     }, 
     liberaMenu:function(){
        var tb = Phx.vista.MovimientoAlm.superclass.liberaMenu.call(this);
        if(tb){        	
            this.getBoton('ini_estado').disable();
            this.getBoton('ant_estado').disable();
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
	},
	retroceder: function(resp){
		console.log(resp)
		var d= this.sm.getSelected().data;
		Phx.CP.loadingShow(); 
		Ext.Ajax.request({
			url:'../../sis_almacenes/control/Movimiento/finalizarMovimiento',
		  	params:{
		  		id_movimiento:d.id_movimiento,
		  		operacion:resp.argument.operacion,
		  		//id_funcionario_wf:data.wf_id_funcionario,
		  		//id_tipo_estado: data.wf_id_tipo_estado,
		  		id_almacen: d.id_almacen,
		  		obs: this.txtObs.getValue()
		      },
		      success:this.successFinSol,
		      failure: this.conexionFailure,
		      timeout:this.timeout,
		      scope:this
		});
		
	}
         
         
};
</script>
