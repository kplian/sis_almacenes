<?php
/**
*@package pXP
*@file gen-MovimientoTipoAlmacen.php
*@author  (admin)
*@date 13-07-2016 19:37:32
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.MovimientoTipoAlmacen=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.MovimientoTipoAlmacen.superclass.constructor.call(this,config);
		this.init();
		
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		
		if(Phx.CP.getPagina(this.idContenedorPadre)){
	      	var dataMaestro=Phx.CP.getPagina(this.idContenedorPadre).getSelectedData();
		 	if(dataMaestro){
		 	 	this.onEnablePanel(this,dataMaestro)
			}
		}
		
		//this.load({params:{start:0, limit:this.tam_pag}})
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_movimiento_tipo_almacen'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_movimiento_tipo'
			},
			type:'Field',
			form:true 
		},
		{
			config: {
				name: 'id_almacen',
				fieldLabel: 'Almacen',
				allowBlank: false,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_almacenes/control/Almacen/listarAlmacen',
					id: 'id_almacen',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_almacen', 'nombre', 'codigo'],
					remoteSort: true,
					baseParams: {par_filtro: 'alm.nombre#alm.codigo'}
				}),
				valueField: 'id_almacen',
				displayField: 'nombre',
				gdisplayField: 'codigo',
				hiddenName: 'id_almacen',
				forceSelection: true,
				typeAhead: false,
				triggerAction: 'all',
				lazyRender: true,
				mode: 'remote',
				pageSize: 15,
				queryDelay: 1000,
				anchor: '100%',
				gwidth: 150,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre']);
				}
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'al.nombre',type: 'string'},
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
				filters:{pfiltro:'tpmovalm.estado_reg',type:'string'},
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
				type:'Field',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
			},
				type:'TextField',
				filters:{pfiltro:'tpmovalm.usuario_ai',type:'string'},
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
				filters:{pfiltro:'tpmovalm.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'tpmovalm.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
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
				filters:{pfiltro:'tpmovalm.fecha_mod',type:'date'},
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
				type:'Field',
				filters:{pfiltro:'usu2.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Almacen',
	ActSave:'../../sis_almacenes/control/MovimientoTipoAlmacen/insertarMovimientoTipoAlmacen',
	ActDel:'../../sis_almacenes/control/MovimientoTipoAlmacen/eliminarMovimientoTipoAlmacen',
	ActList:'../../sis_almacenes/control/MovimientoTipoAlmacen/listarMovimientoTipoAlmacen',
	id_store:'id_movimiento_tipo_almacen',
	fields: [
		{name:'id_movimiento_tipo_almacen', type: 'numeric'},
		{name:'id_movimiento_tipo', type: 'numeric'},
		{name:'id_almacen', type: 'numeric'},
		{name:'nombre', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_movimiento_tipo_almacen',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	loadValoresIniciales:function(){
		Phx.vista.MovimientoTipoAlmacen.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_movimiento_tipo').setValue(this.maestro.id_movimiento_tipo);		
	},
	
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_movimiento_tipo:this.maestro.id_movimiento_tipo};
		this.load({params:{start:0, limit:this.tam_pag}});			
	}
	
	}
)
</script>
		
		