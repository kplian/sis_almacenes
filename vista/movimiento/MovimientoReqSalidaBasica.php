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
Phx.vista.MovimientoReqSalidaBasica= {
	require:'../../../sis_almacenes/vista/movimiento/Movimiento.php',
	requireclase:'Phx.vista.Movimiento',
	title:'Movimiento',	
	nombreVista: 'movimientoReqSalida',
	
	constructor: function(config) {
		this.maestro = config;
		
    	Phx.vista.MovimientoReqSalidaBasica.superclass.constructor.call(this,config);
    	this.Cmp.id_almacen.store.baseParams.solo_almaceneros = 'si';
    	//Botón de finalización
    	this.addButton('fin_requerimiento',{text:'Finalizar',iconCls: 'badelante',disabled:true,handler:this.fin_requerimiento,tooltip: '<b>Finalizar</b>'});
		//Creación de ventana para workflow
		this.crearVentanaWF();
    	
	    this.iniciarEventos();
		this.store.baseParams={tipo_interfaz:this.nombreVista};
		this.load({params:{start:0, limit:this.tam_pag,ids:this.ids, cmb_tipo_movimiento:'salida'}});
		
		//Setea el tipo de movimiento a salida
		this.Cmp.tipo.setValue('salida');
		this.Cmp.tipo.disable();
		this.cmbMovimientoTipo.disable();
		
	},
	
	generaReporte: function(){
        	var rec = this.sm.getSelected();
					Phx.CP.loadingShow();
					Ext.Ajax.request({
						url : '../../sis_almacenes/control/Movimiento/generarReporteMovimiento',
						params : {
							'id_movimiento' : rec.data.id_movimiento,
							'costos': 'no' 
						},
						success : this.successExport,
						failure : this.conexionFailure,
						timeout : this.timeout,
						scope : this
					});
        	
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
       Phx.vista.MovimientoReqSalidaBasica.superclass.onButtonNew.call(this); 
              
       //this.Cmp.fecha_mov.setValue(new Date());
        this.Cmp.fecha_mov.fireEvent('change');
       //Setea el tipo de movimiento a salida
		this.Cmp.tipo.setValue('salida');
		this.Cmp.tipo.disable();
		
		this.setFiltroMovTipo('salida');      
           
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
                alert('Ocurrió al obtener la gestion')
            } 
    },
	preparaMenu:function(n){
		var data = this.getSelectedData();
	    var tb =this.tbar;
	    Phx.vista.MovimientoReqSalidaBasica.superclass.preparaMenu.call(this,n);
        if(data['estado_mov']== 'borrador' || data['estado_mov']=='Borrador'){
           this.getBoton('fin_requerimiento').enable();
         }
        else{
             this.getBoton('fin_requerimiento').disable();
             this.getBoton('edit').disable();
             this.getBoton('del').disable();  
        }
        return tb;
     }, 
     liberaMenu:function(){
	        var tb = Phx.vista.MovimientoReqSalidaBasica.superclass.liberaMenu.call(this);
	        if(tb){
	            this.getBoton('fin_requerimiento').disable();
	           
	        }
	        
	       return tb;
	   },
     
     south : {
			url : '../../../sis_almacenes/vista/movimientoDetalle/MovimientoDetalleBasico.php',
			title : 'Detalle de Movimiento',
			height : '50%',
			cls : 'MovimientoDetalleBasico'
		},

};
</script>
