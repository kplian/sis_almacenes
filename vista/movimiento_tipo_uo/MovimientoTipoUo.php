<?php
/**
*@package pXP
*@file gen-MovimientoTipoUo.php
*@author  (admin)
*@date 22-08-2013 22:55:37
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.MovimientoTipoUo=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.MovimientoTipoUo.superclass.constructor.call(this,config);
		this.init();
		
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		
		if(Phx.CP.getPagina(this.idContenedorPadre)){
	      	var dataMaestro=Phx.CP.getPagina(this.idContenedorPadre).getSelectedData();
		 	if(dataMaestro){
		 	 	this.onEnablePanel(this,dataMaestro)
			}
		}
		
		//Obtencion de componentes
		this.uo=this.Cmp.uo;
		this.id_uo=this.Cmp.id_uo;
		this.id_estructura_uo=this.Cmp.id_estructura_uo;
		
		//Esconde componentes
		this.Cmp.id_uo.hide();
		
		//Eventos
		this.uo.on('focus',this.viewOrganigrama,this)

	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_movimiento_tipo_uo'
			},
			type:'Field',
			form:true 
		}, {
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_movimiento_tipo'
			},
			type:'Field',
			form:true 
		}, {
			config: {
				name: 'codigo',
				fieldLabel: 'Código',
				allowBlank: true,
				anchor: '100%',
				gwidth: 120,
				minChars: 2
			},
			type: 'TextField',
			id_grupo: 0,
			filters: {pfiltro: 'uo.codigo',type: 'string'},
			grid: true,
			form: false
		}, {
			config: {
				name: 'id_uo',
				fieldLabel: 'Cargo',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_uo']);
				}
			},
			type: 'TextField',
			id_grupo: 0,
			filters: {pfiltro: 'uo.nombre',type: 'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'uo',
				fieldLabel: 'Organigrama',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_uo']);
				}
			},
			type: 'TextArea',
			id_grupo: 0,
			filters: {pfiltro: 'uo.nombre',type: 'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_estructura_uo',
				labelSeparator:'',
				inputType:'hidden',
			},
			type: 'Field',
			grid: true,
			form: true
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
				filters:{pfiltro:'timvuo.estado_reg',type:'string'},
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
				filters:{pfiltro:'timvuo.fecha_reg',type:'date'},
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
				filters:{pfiltro:'timvuo.fecha_mod',type:'date'},
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
	title:'Tipo Movimiento/Organigrama',
	ActSave:'../../sis_almacenes/control/MovimientoTipoUo/insertarMovimientoTipoUo',
	ActDel:'../../sis_almacenes/control/MovimientoTipoUo/eliminarMovimientoTipoUo',
	ActList:'../../sis_almacenes/control/MovimientoTipoUo/listarMovimientoTipoUo',
	id_store:'id_movimiento_tipo_uo',
	fields: [
		{name:'id_movimiento_tipo_uo', type: 'numeric'},
		{name:'id_movimiento_tipo', type: 'numeric'},
		{name:'id_uo', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		'codigo',
		'desc_uo'
	],
	sortInfo:{
		field: 'id_movimiento_tipo_uo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
	id_uos:'',
	id_estructura_uo:'',
	uo:'',
	loadValoresIniciales:function(){
		Phx.vista.MovimientoTipoUo.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_movimiento_tipo').setValue(this.maestro.id_movimiento_tipo);		
	},
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_movimiento_tipo:this.maestro.id_movimiento_tipo};
		this.load({params:{start:0, limit:this.tam_pag}});			
	},
	viewOrganigrama: function(){
		var data;
		Phx.CP.loadWindows('../../../sis_organigrama/vista/estructura_uo/EstructuraUoCheck.php',
					'Organigrama',
					{
						width:'60%',
						height:'70%'
				    },
				    data,
				    this.idContenedor,
				    'EstructuraUoCheck'
			);
	},
	bedit: false
	
})
</script>
		
		