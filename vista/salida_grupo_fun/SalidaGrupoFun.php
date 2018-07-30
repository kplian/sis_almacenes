<?php
/**
*@package pXP
*@file gen-SalidaGrupoFun.php
*@author  (admin)
*@date 18-10-2013 02:54:34
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.SalidaGrupoFun=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.SalidaGrupoFun.superclass.constructor.call(this,config);
		this.init();
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_salida_grupo_fun'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_salida_grupo_item'
			},
			type:'Field',
			form:true 
		},
		{
   			config:{
       		    name:'id_funcionario',
       		    hiddenName: 'id_funcionario',
   				origen:'FUNCIONARIOCAR',
   				fieldLabel:'Funcionario',
   				allowBlank:false,
                gwidth:200,
   				valueField: 'id_funcionario',
   			    gdisplayField: 'desc_funcionario1',
   			    baseParams: { es_combo_solicitud : 'si',fecha: new Date(), id_movimiento_tipo:0 },
      			renderer:function(value, p, record){return String.format('{0}', record.data['desc_funcionario1']);},
      			url:'../../sis_almacenes/control/Movimiento/listarFuncionarioMovimientoTipo'
       	     },
   			type:'ComboRec',//ComboRec
   			id_grupo:0,
   			filters:{pfiltro:'fun.desc_funcionario1',type:'string'},
   		    grid:true,
   			form:true
		},
		{
			config:{
				name: 'cantidad_sol',
				fieldLabel: 'Cantidad',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:1179650
			},
				type:'NumberField',
				filters:{pfiltro:'gritfu.cantidad_sol',type:'numeric'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'observaciones',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1000
			},
				type:'TextArea',
				filters:{pfiltro:'gritfu.observaciones',type:'string'},
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
				filters:{pfiltro:'gritfu.estado_reg',type:'string'},
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
				filters:{pfiltro:'gritfu.fecha_reg',type:'date'},
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
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'gritfu.fecha_mod',type:'date'},
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
	tam_pag:50,	
	title:'Por funcionario',
	ActSave:'../../sis_almacenes/control/SalidaGrupoFun/insertarSalidaGrupoFun',
	ActDel:'../../sis_almacenes/control/SalidaGrupoFun/eliminarSalidaGrupoFun',
	ActList:'../../sis_almacenes/control/SalidaGrupoFun/listarSalidaGrupoFun',
	id_store:'id_salida_grupo_fun',
	fields: [
		{name:'id_salida_grupo_fun', type: 'numeric'},
		{name:'id_funcionario', type: 'numeric'},
		{name:'id_salida_grupo_item', type: 'numeric'},
		{name:'cantidad_sol', type: 'numeric'},
		{name:'observaciones', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_funcionario1', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_salida_grupo_fun',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	loadValoresIniciales:function(){
		Phx.vista.SalidaGrupoFun.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_salida_grupo_item').setValue(this.maestro.id_salida_grupo_item);		
	},
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_salida_grupo_item:this.maestro.id_salida_grupo_item};
		this.load({params:{start:0, limit:this.tam_pag}});			
	}
})
</script>
		
		