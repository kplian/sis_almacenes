<?php
/**
*@package pXP
*@file gen-MovimientoTipoItem.php
*@author  (admin)
*@date 21-08-2013 14:31:37
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.MovimientoTipoItem=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.MovimientoTipoItem.superclass.constructor.call(this,config);
		this.init();
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		
		if(Phx.CP.getPagina(this.idContenedorPadre)){
	      	var dataMaestro=Phx.CP.getPagina(this.idContenedorPadre).getSelectedData();
		 	if(dataMaestro){
		 	 	this.onEnablePanel(this,dataMaestro)
			}
		}
		
		//Crear ventana para registro de datos
		this.createWindow();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_movimiento_tipo_item'
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
				name: 'codigo_item',
				fieldLabel: 'Código Item',
				allowBlank: true,
				anchor: '100%',
				gwidth: 120,
				minChars: 2
			},
			type: 'TextField',
			id_grupo: 0,
			filters: {pfiltro: 'ite.codigo',type: 'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_item',
				fieldLabel: 'Item',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_item']);
				}
			},
			type: 'TextField',
			id_grupo: 0,
			filters: {pfiltro: 'ite.nombre',type: 'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'codigo_clasif',
				fieldLabel: 'Código Clasificación',
				allowBlank: true,
				anchor: '100%',
				gwidth: 120,
				minChars: 2
			},
			type: 'TextField',
			id_grupo: 0,
			filters: {pfiltro: 'clas.codigo',type: 'string'},
			grid: true,
			form: true
		},
		{
			config: {
				name: 'id_clasificacion',
				fieldLabel: 'Clasificación',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				minChars: 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_clasif']);
				}
			},
			type: 'TextField',
			id_grupo: 0,
			filters: {pfiltro: 'clas.nombre',type: 'string'},
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
				filters:{pfiltro:'timite.estado_reg',type:'string'},
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
				filters:{pfiltro:'timite.fecha_reg',type:'date'},
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
				filters:{pfiltro:'timite.fecha_mod',type:'date'},
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
	title:'Tipo Movimiento/Item',
	ActSave:'../../sis_almacenes/control/MovimientoTipoItem/insertarMovimientoTipoItem',
	ActDel:'../../sis_almacenes/control/MovimientoTipoItem/eliminarMovimientoTipoItem',
	ActList:'../../sis_almacenes/control/MovimientoTipoItem/listarMovimientoTipoItem',
	id_store:'id_movimiento_tipo_item',
	fields: [
		{name:'id_movimiento_tipo_item', type: 'numeric'},
		{name:'id_item', type: 'numeric'},
		{name:'id_movimiento_tipo', type: 'numeric'},
		{name:'id_clasificacion', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'codigo_item', type: 'string'},
		{name:'codigo_clasif', type: 'string'},
		{name:'desc_item', type: 'string'},
		{name:'desc_clasif', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_movimiento_tipo_item',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	id_clasificacion:'',
	clasificacion:'',
	id_items:'',
	loadValoresIniciales:function(){
		Phx.vista.MovimientoTipoItem.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_movimiento_tipo').setValue(this.maestro.id_movimiento_tipo);		
	},
	onReloadPage:function(m){
		this.maestro=m;						
		this.store.baseParams={id_movimiento_tipo:this.maestro.id_movimiento_tipo};
		this.load({params:{start:0, limit:this.tam_pag}});			
	},
	createWindow: function() {
			this.formNew = new Ext.form.FormPanel({
				baseCls: 'x-plain-' + this.idContenedor,
				bodyStyle: 'padding:10 20px 10;',
				autoDestroy: true,
				border: false,
				layout: 'form',
				items: [new Ext.ux.AwesomeCombo({
					name: 'id_item_cmb',
					fieldLabel: 'Item',
					allowBlank: true,
					emptyText: 'Elija un Item...',
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
					tpl : '<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p><p>Clasif.: {desc_clasificacion}</p></div></tpl>',
					hiddenName : 'id_item_cmb',
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
					enableMultiSelect : true
				}), {
					xtype: 'textarea',
					name: 'id_clasificacion_cmb',
					fieldLabel: 'Clasificación',
					allowBlank: true,
					width:250,
					anchor: '100%',
					readonly: true
				}]
			});

			this.id_items = this.formNew.getForm().findField('id_item_cmb');
			this.clasificacion = this.formNew.getForm().findField('id_clasificacion_cmb');
			
			this.id_items.store.on('exception', this.conexionFailure, this)
			this.clasificacion.on('focus',this.viewClasif,this);


			this.winNew = new Ext.Window({
				title: 'Nuevo',
				collapsible: true,
				maximizable: true,
				autoDestroy: true,
				width: 450,
				height: 250,
				layout: 'fit',
				plain: true,
				bodyStyle: 'padding:5px;',
				buttonAlign: 'center',
				items: this.formNew,
				modal: true,
				closeAction: 'hide',
				buttons: [{
					text: 'Guardar',
					handler: this.onGuardar,
					scope: this

				}, {
					text: 'Cancelar',
					handler: function() {
						this.winNew.hide()
					},
					scope: this
				}]
			});

		},
		onGuardar: function(){
			if(this.formNew.getForm().isValid()){
				Phx.CP.loadingShow();
				Ext.Ajax.request({
					url: '../../sis_almacenes/control/MovimientoTipoItem/insertarMovimientoTipoItem',
					params: {
						id_items : this.id_items.getValue(),
						id_clasificaciones : this.id_clasificacion,
						id_movimiento_tipo: this.maestro.id_movimiento_tipo
					},
					success: function(resp){
						Phx.CP.loadingHide();
						var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
						if (reg.ROOT.error) {
							alert("ERROR no esperado")
						} else {
							this.winNew.hide();
							this.reload();
						}
					},
					failure: this.conexionFailure,
					timeout: this.timeout,
					scope: this
				});
			}
			
		},
		viewClasif: function(){
			var data;
			Phx.CP.loadWindows('../../../sis_almacenes/vista/clasificacion/BuscarClasificacion.php',
						'Clasificación',
						{
							width:'60%',
							height:'70%'
					    },
					    data,
					    this.idContenedor,
					    'BuscarClasificacion'
				);
		},
		onButtonNew: function(){
			this.clasificacion.setValue('');
			this.id_items.reset();
			this.winNew.show();
		},
		bedit: false
})
</script>
		
		