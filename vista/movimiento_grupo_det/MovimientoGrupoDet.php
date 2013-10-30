<?php
/**
*@package pXP
*@file gen-MovimientoGrupoDet.php
*@author  (admin)
*@date 18-10-2013 21:26:09
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.MovimientoGrupoDet=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.MovimientoGrupoDet.superclass.constructor.call(this,config);
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
					name: 'id_movimiento_grupo_det'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_movimiento_grupo'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					fieldLabel: 'Salida',
					name: 'id_movimiento',
					renderer : function(value, p, record) {
						return String.format('{0}', record.data['nro_mov']);
					},
					gwidth:200
			},
			type:'Field',
			grid:true,
			form:true 
		},
		{
			//configuracion del componente
			config:{
					fieldLabel: 'Fecha',
					name: 'fecha_mov',
					format: 'd/m/Y', 
					renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
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
				filters:{pfiltro:'mogrde.estado_reg',type:'string'},
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
				filters:{pfiltro:'mogrde.fecha_reg',type:'date'},
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
				filters:{pfiltro:'mogrde.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Detalle',
	ActSave:'../../sis_almacenes/control/MovimientoGrupoDet/insertarMovimientoGrupoDet',
	ActDel:'../../sis_almacenes/control/MovimientoGrupoDet/eliminarMovimientoGrupoDet',
	ActList:'../../sis_almacenes/control/MovimientoGrupoDet/listarMovimientoGrupoDet',
	id_store:'id_movimiento_grupo_det',
	fields: [
		{name:'id_movimiento_grupo_det', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_movimiento', type: 'numeric'},
		{name:'id_movimiento_grupo', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'nro_mov', type: 'string'},
		{name:'fecha_mov', type: 'date',dateFormat:'Y-m-d H:i:s'}
	],
	sortInfo:{
		field: 'id_movimiento_grupo_det',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
	bnew:false,
	bedit:false,
	loadValoresIniciales:function(){
		Phx.vista.MovimientoGrupoDet.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_movimiento_grupo').setValue(this.maestro.id_movimiento_grupo);		
	},
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_movimiento_grupo:this.maestro.id_movimiento_grupo};
		this.load({params:{start:0, limit:this.tam_pag}});			
	}
})
</script>
		
		