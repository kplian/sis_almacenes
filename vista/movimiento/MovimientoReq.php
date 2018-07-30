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
		this.maestro = config;
    	Phx.vista.MovimientoReq.superclass.constructor.call(this,config);
    	//Botón de finalización
    	this.addButton('fin_requerimiento',{text:'Finalizar',iconCls: 'badelante',disabled:true,handler:this.fin_requerimiento,tooltip: '<b>Finalizar</b>'});
		//Creación de ventana para workflow
		this.crearVentanaWF();
    	
	    this.iniciarEventos();
		this.store.baseParams={tipo_interfaz:this.nombreVista};
		//this.load({params:{start:0, limit:this.tam_pag,ids:this.ids}});
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
    
    /*fin_requerimiento: function(){                   
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
	},*/
	/*onFinalizarSol:function(resp){
		Phx.CP.loadingHide();
        var d= this.sm.getSelected().data;
        var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
        var swWin=0;
        var swFun=0;
        var swEst=0;
		//console.log(reg)
        //Se verifica la respuesta de la verificación
        if(!reg.ROOT.error){
        	var data=reg.ROOT.datos;
        	if(data.wf_cant_estados>1){
	       		swWin=1;
	       		swEst=1;
	       		swFun=1;
	       	}
        	if(data.wf_cant_funcionarios>1){
				swWin=1;
				swFun=1;
	       	} 
	       	//Verifica si hay que desplegar el formulario de WF
	       	if(swWin){
	       		//Habilita/Deshabilita los combos
	       		this.cmbTipoEstWF.disable();
	       		this.cmbFunWF.disable();
	       		if(swEst){
	       			this.cmbTipoEstWF.enable();		
	       		}
	       		if(swFun){
	       			this.cmbFunWF.enable();		
	       		}
	       		//Setea parámetros del store de Estados
	       		Ext.apply(this.cmbTipoEstWF.store.baseParams,{id_tipo_proceso: data.id_tipo_proceso, id_tipo_estado_padre: data.id_tipo_estado_padre});
	       		////Setea parámetros del store de funcionarios
	       		Ext.apply(this.cmbFunWF.store.baseParams,{id_estado_wf: data.id_estado_wf, fecha: data.fecha});

	       		//Muestra la ventana
	       		this.winWF.show();
	       	} else{
	       		//Se hace la llamda directa porque el WF no tiene bifurcaciones
	       		Phx.CP.loadingShow(); 
				Ext.Ajax.request({
					url:'../../sis_almacenes/control/Movimiento/finalizarMovimiento',
				  	params:{
				  		id_movimiento:d.id_movimiento,
				  		operacion:'siguiente',
				  		id_funcionario_wf:data.wf_id_funcionario,
				  		id_tipo_estado: data.wf_id_tipo_estado,
				  		id_almacen: d.id_almacen
				      },
				      success:this.successFinSol,
				      failure: this.conexionFailure,
				      timeout:this.timeout,
				      scope:this
				});
	       		
	       	}
        	
        	
    	} else{
            
            alert('ocurrio un error durante el proceso')
        }
    },*/
    /*successFinSol:function(resp){
        Phx.CP.loadingHide();
        var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
        if(!reg.ROOT.error){
            this.reload();
        }else{
            alert('Ocurrió un error durante el proceso')
        }
	},*/
     
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
	    Phx.vista.MovimientoReq.superclass.preparaMenu.call(this,n);
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
        var tb = Phx.vista.MovimientoReq.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('fin_requerimiento').disable();
           
        }
        
       return tb;
   },
   
	/*crearVentanaWF: function(){
		//Creación del formulario
   		this.formWF = new Ext.form.FormPanel({
            baseCls: 'x-plain',
            autoDestroy: true,
            layout: 'form',
            items: [{
                        xtype: 'combo',
                        name: 'id_tipo_estado',
                          hiddenName: 'id_tipo_estado',
                        fieldLabel: 'Siguiente Estado',
                        listWidth:280,
                        allowBlank: false,
                        emptyText:'Elija el estado siguiente',
                        store:new Ext.data.JsonStore(
                        {
                            url: '../../sis_workflow/control/TipoEstado/listarEstadoSiguiente',
                            id: 'id_tipo_estado',
                            root:'datos',
                            sortInfo:{
                                field:'tipes.codigo',
                                direction:'ASC'
                            },
                            totalProperty:'total',
                            fields: ['id_tipo_estado','codigo_estado','nombre_estado','tipo_asignacion'],
                            // turn on remote sorting
                            remoteSort: true,
                            baseParams:{par_filtro:'tipes.nombre_estado#tipes.codigo'}
                        }),
                        valueField: 'id_tipo_estado',
                        displayField: 'codigo_estado',
                        forceSelection:true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender:true,
                        mode:'remote',
                        pageSize:50,
                        queryDelay:500,
                        width:210,
                        gwidth:220,
                         listWidth:'280',
                        minChars:2,
                        tpl: '<tpl for="."><div class="x-combo-list-item"><p>{codigo_estado}</p>Prioridad: <strong>{nombre_estado}</strong> </div></tpl>'
                    
                    },
                    {
                        xtype: 'combo',
                        name: 'id_funcionario_wf',
                        hiddenName: 'id_funcionario_wf',
                        fieldLabel: 'Funcionario Resp.',
                        allowBlank: false,
                        emptyText:'Elija un funcionario',
                        listWidth:280,
                        store:new Ext.data.JsonStore(
                        {
                            url: '../../sis_workflow/control/TipoEstado/listarFuncionarioWf',
                            id: 'id_funcionario',
                            root:'datos',
                            sortInfo:{
                                field:'prioridad',
                                direction:'ASC'
                            },
                            totalProperty:'total',
                            fields: ['id_funcionario','desc_funcionario','prioridad'],
                            // turn on remote sorting
                            remoteSort: true,
                            baseParams:{par_filtro:'fun.desc_funcionario1'}
                        }),
                        valueField: 'id_funcionario',
                        displayField: 'desc_funcionario',
                        forceSelection:true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender:true,
                        mode:'remote',
                        pageSize:50,
                        queryDelay:500,
                        width:210,
                        gwidth:220,
                         listWidth:'280',
                        minChars:2,
                        tpl: '<tpl for="."><div class="x-combo-list-item"><p>{desc_funcionario}</p>Prioridad: <strong>{prioridad}</strong> </div></tpl>'
                    
                    }]
        });
        
        //Eventos
        this.cmbFunWF =this.formWF.getForm().findField('id_funcionario_wf');
        this.cmbTipoEstWF =this.formWF.getForm().findField('id_tipo_estado');
        this.cmbFunWF.store.on('exception', this.conexionFailure);
        this.cmbTipoEstWF.store.on('exception', this.conexionFailure);
        this.cmbTipoEstWF.on('select',function(cmp,rec,ind){
        	if(rec.data.tipo_asignacion=='ninguno'){
        		this.cmbFunWF.allowBlank=true;
        		this.cmbFunWF.setValue('');
        		this.cmbFunWF.disable();
        	} else{
        		this.cmbFunWF.enable();
        		this.cmbFunWF.allowBlank=false;
	            Ext.apply(this.cmbFunWF.store.baseParams,{id_tipo_estado: this.cmbTipoEstWF.getValue()});
	            this.cmbFunWF.modificado=true;	
        	}
            
        },this);
        
        //Creación de la ventna
         this.winWF = new Ext.Window({
            title: 'Workflow',
            collapsible: true,
            maximizable: true,
            autoDestroy: true,
            width: 350,
            height: 200,
            layout: 'fit',
            plain: true,
            bodyStyle: 'padding:5px;',
            buttonAlign: 'center',
            items: this.formWF,
            modal:true,
            closeAction: 'hide',
            buttons: [{
                text: 'Guardar',
                handler:this.onWF,
                scope:this
                
            },{
                text: 'Cancelar',
                handler:function(){this.winWF.hide()},
                scope:this
            }]
        });
   	}*/
};
</script>
