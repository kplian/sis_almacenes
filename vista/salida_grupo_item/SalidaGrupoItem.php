<?php
/**
*@package pXP
*@file gen-SalidaGrupoItem.php
*@author  (admin)
*@date 17-10-2013 20:34:52
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.SalidaGrupoItem=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.SalidaGrupoItem.superclass.constructor.call(this,config);
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
					name: 'id_salida_grupo_item'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_salida_grupo'
			},
			type:'Field',
			form:true 
		},
		{
			config : {
				name : 'id_item',
				fieldLabel : 'Item',
				allowBlank : false,
				emptyText : 'Elija un Item...',
				store : new Ext.data.JsonStore({
					url : '../../sis_almacenes/control/Item/listarItemNotBase',
					id : 'id_item',
					root : 'datos',
					sortInfo : {
						field : 'nombre',
						direction : 'ASC'
					},
					totalProperty : 'total',
					fields : ['id_item', 'nombre', 'codigo', 'desc_clasificacion', 'codigo_unidad'],
					remoteSort : true,
					baseParams : {
						par_filtro : 'item.nombre#item.codigo#cla.nombre'
					}
				}),
				valueField : 'id_item',
				displayField : 'nombre',
				gdisplayField : 'desc_item',
				tpl : '<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p><p>Clasif.: {desc_clasificacion}</p></div></tpl>',
				hiddenName : 'id_item',
				forceSelection : true,
				typeAhead : false,
				triggerAction : 'all',
				lazyRender : true,
				mode : 'remote',
				pageSize : 10,
				queryDelay : 1000,
				anchor : '100%',
				gwidth : 250,
				minChars : 2,
				turl : '../../../sis_almacenes/vista/item/BuscarItem.php',
				tasignacion : true,
				tname : 'id_item',
				ttitle : 'Items',
				tdata : {},
				tcls : 'BuscarItem',
				pid : this.idContenedor,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_item']);
				},
				resizable: true
			},
			type : 'TrigguerCombo',
			id_grupo : 0,
			filters : {
				pfiltro : 'item.nombre',
				type : 'string'
			},
			grid : true,
			form : true
		},
				{
			config:{
				name: 'cantidad_sol',
				fieldLabel: 'Cantidad',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:9999
			},
			type:'NumberField',
			filters:{pfiltro:'sagrit.cantidad_sol',type:'numeric'},
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
			filters:{pfiltro:'sagrit.observaciones',type:'string'},
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
			filters:{pfiltro:'sagrit.estado_reg',type:'string'},
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
				filters:{pfiltro:'sagrit.fecha_reg',type:'date'},
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
				filters:{pfiltro:'sagrit.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Detalle',
	ActSave:'../../sis_almacenes/control/SalidaGrupoItem/insertarSalidaGrupoItem',
	ActDel:'../../sis_almacenes/control/SalidaGrupoItem/eliminarSalidaGrupoItem',
	ActList:'../../sis_almacenes/control/SalidaGrupoItem/listarSalidaGrupoItem',
	id_store:'id_salida_grupo_item',
	fields: [
		{name:'id_salida_grupo_item', type: 'numeric'},
		{name:'observaciones', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_item', type: 'numeric'},
		{name:'cantidad_sol', type: 'numeric'},
		{name:'id_salida_grupo', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_item', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_salida_grupo_item',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	loadValoresIniciales:function(){
		Phx.vista.SalidaGrupoItem.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_salida_grupo').setValue(this.maestro.id_salida_grupo);		
	},
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_salida_grupo:this.maestro.id_salida_grupo};
		this.load({params:{start:0, limit:this.tam_pag}});			
	},
	east: {
		url: '../../../sis_almacenes/vista/salida_grupo_fun/SalidaGrupoFun.php',
		title: 'Funcionario',
		width: '50%',
		cls: 'SalidaGrupoFun'
	}
})
</script>
		
		