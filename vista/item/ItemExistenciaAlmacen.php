<?php
/**
*@package pXP
*@file ItemExistenciaAlmacen
*@author  rcm
*@date 01/08/2013
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ItemExistenciaAlmacen=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.ItemExistenciaAlmacen.superclass.constructor.call(this,config);
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		this.init();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_almacen'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_item'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'a.codigo',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'almacen',
				fieldLabel: 'Almacén',
				allowBlank: false,
				anchor: '100%',
				gwidth: 100,
				maxLength:100
			},
			type:'TextField',
			filters:{pfiltro:'a.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'cantidad',
				fieldLabel: 'Cantidad',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				maxLength:2000
			},
			type:'NumberField',
			filters:{pfiltro:'s.cantidad',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		}
	],
	title:'Existencia de Materiales por Almacén',
	ActList:'../../sis_almacenes/control/Item/listarItemExistenciaAlmacen',
	id_store:'id_almacen',
	loadValoresIniciales:function(){
		Phx.vista.ItemExistenciaAlmacen.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_item').setValue(this.maestro.id_item);		
	},
	tam_pag:50,
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_item:this.maestro.id_item};
		if(this.maestro.id_item){
			this.load({params:{
			start:0,
			limit:this.tam_pag
			}});	
		} else{
			this.store.removeAll(false);
		}
					
	},
	fields: [
		{name:'id_almacen', type: 'numeric'},
		{name:'id_item', type: 'numeric'},
		{name:'codigo', type: 'string'},
		{name:'almacen', type: 'string'},
		{name:'cantidad', type: 'numeric'}
	],
	sortInfo:{
		field: 'id_almacen',
		direction: 'ASC'
	},
	bdel:false,
	bsave:false,
	bedit:false,
	benew:false,
	fwidht: 450
})
</script>
		
		