<?php
/**
*@package pXP
*@file gen-Periodo.php
*@author  (admin)
*@date 19-06-2013 08:33:57
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PeriodoAlm=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.PeriodoAlm.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}});
		
		//Adición de botones en la barra de herramientas
		this.addButton('btnAbrir',{
				text: 'Abrir',
				iconCls: 'bchecklist',
				disabled: true,
				handler: this.abrirPeriodo,
				tooltip: '<b>Abrir Período</b><br/>Apertura del Período seleccionado'
			}
		);
		this.addButton('btnCerrar',{
				text: 'Cerrar',
				iconCls: 'bchecklist',
				disabled: true,
				handler: this.cerrarPeriodo,
				tooltip: '<b>Cerrar Período</b><br/>Cierre del Período seleccionado'
			}
		);
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_periodo'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'periodo',
				fieldLabel: 'Período',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'almper.periodo',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_ini',
				fieldLabel: 'Fecha Inicio',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'almper.fecha_ini',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_fin',
				fieldLabel: 'Fecha Fin',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'almper.fecha_fin',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'almper.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu1.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'almper.fecha_reg',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'almper.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'Períodos',
	ActSave:'../../sis_almacenes/control/Periodo/insertarPeriodo',
	ActDel:'../../sis_almacenes/control/Periodo/eliminarPeriodo',
	ActList:'../../sis_almacenes/control/Periodo/listarPeriodo',
	id_store:'id_periodo',
	fields: [
		{name:'id_periodo', type: 'numeric'},
		{name:'fecha_fin', type: 'date',dateFormat:'Y-m-d'},
		{name:'fecha_ini', type: 'date',dateFormat:'Y-m-d'},
		{name:'estado_reg', type: 'string'},
		{name:'periodo', type: 'date',dateFormat:'Y-m-d'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_periodo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	abrirPeriodo: function(){
		var rec=this.sm.getSelected();
		if(rec){
			Ext.Msg.confirm('Confirmación','¿Está seguro de Abrir el Período?',function(btn){
				if(btn=='yes'){
					this.modificarPeriodo('abierto');
				}
			}, this)
		} else{
			Ext.Msg.alert('Alerta','Seleccione un registro y vuelva a intentarlo');
		}
		
	},
	cerrarPeriodo: function(){
		var rec=this.sm.getSelected();
		if(rec){
			Ext.Msg.confirm('Confirmación','¿Está seguro de Cerrar el Período?',function(btn){
				if(btn=='yes'){
					this.modificarPeriodo('cerrado');
				}
			}, this)
		} else{
			Ext.Msg.alert('Alerta','Seleccione un registro y vuelva a intentarlo');
		}
		
	},
	modificarPeriodo: function(pNuevoEstado){
		var rec=this.sm.getSelected();
		Ext.Ajax.request({
			url:'../../sis_almacenes/control/Periodo/AbrirCerrarPeriodo',
			params:{
				id_periodo: rec.data.id_periodo,
				nuevo_estado: pNuevoEstado
				},
			success: function(n){
				this.reload();
			},
			failure: this.conexionFailure,
			timeout: this.timeout,
			scope:this
		});
	},
	preparaMenu: function(n) {
		var tb = Phx.vista.PeriodoAlm.superclass.preparaMenu.call(this);
	  	var data = this.getSelectedData();
	  	
	  	//Habilitación de botones
	  	if(data.estado_reg=='activo'||data.estado_reg=='cerrado'){
	  		//Habilitar boton de Abrir
	  		this.getBoton('btnAbrir').enable();
	  		this.getBoton('btnCerrar').disable();
	  		if(data.estado_reg=='cerrado'){
	  			this.getBoton('btnAbrir').setText('Re-Abrir');
	  		} else{
	  			this.getBoton('btnAbrir').setText('Abrir');
	  		}
	  	} else if(data.estado_reg=='abierto'){
	  		//Habilitar Botón Cerrar
	  		this.getBoton('btnAbrir').disable();
	  		this.getBoton('btnCerrar').enable();
	  		this.getBoton('btnAbrir').setText('Abrir');
	  	} else{
	  		//Deshabilitar todo
	  		this.getBoton('btnAbrir').disable();
	  		this.getBoton('btnCerrar').disable();
	  		this.getBoton('btnAbrir').setText('Abrir');
	  	}
	  	
	  	//Modificación de textos de botones
	  	
	  	
  		return tb;
	},
	liberaMenu: function() {
		var tb = Phx.vista.PeriodoAlm.superclass.liberaMenu.call(this);
		this.getBoton('btnAbrir').disable();
	  	this.getBoton('btnCerrar').disable();
		return tb;
	}
})
</script>
		
		