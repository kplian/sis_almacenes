<?php
/**
*@package pXP
*@file gen-SalidaGrupo.php
*@author  (admin)
*@date 17-10-2013 18:50:00
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.SalidaGrupo=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.SalidaGrupo.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
		
		this.addButton('btnFinalizar', {
				text : 'Finalizar',
				iconCls : 'bchecklist',
				disabled : true,
				handler : this.onBtnFinalizar,
				tooltip : '<b>Finalizar Solicitud</b>'
		});
		
		this.addButton('btnRetroceder', {
				text : 'Retroceder',
				iconCls : 'bchecklist',
				disabled : true,
				handler : this.onBtnRetroceder,
				tooltip : '<b>RetrocederSolicitud</b>'
		});
	},
			
	Atributos:[
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
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_movimiento_tipo'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'fecha',
				fieldLabel: 'Fecha',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
			},
			type:'DateField',
			filters:{pfiltro:'salgru.fecha',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config : {
				name : 'id_almacen',
				fieldLabel : 'Almacén',
				allowBlank : false,
				emptyText : 'Almacén...',
				store : new Ext.data.JsonStore({
					url : '../../sis_almacenes/control/Almacen/listarAlmacen',
					id : 'id_almacen',
					root : 'datos',
					sortInfo : {
						field : 'nombre',
						direction : 'ASC'
					},
					totalProperty : 'total',
					fields : ['id_almacen', 'nombre'],
					remoteSort : true,
					baseParams : {
						par_filtro : 'alm.nombre'
					}
				}),
				valueField : 'id_almacen',
				displayField : 'nombre',
				gdisplayField : 'nombre_almacen',
				hiddenName : 'id_almacen',
				forceSelection : true,
				typeAhead : false,
				triggerAction : 'all',
				lazyRender : true,
				mode : 'remote',
				pageSize : 10,
				queryDelay : 1000,
				anchor : '100%',
				gwidth : 150,
				minChars : 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_almacen']);
				}
			},
			type : 'ComboBox',
			id_grupo : 0,
			filters : {
				pfiltro : 'alm.nombre#alm.codigo',
				type : 'string'
			},
			grid : true,
			form : true
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripción',
				allowBlank: true,
				anchor: '100%',
				gwidth: 100,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'salgru.descripcion',type:'string'},
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
			filters:{pfiltro:'salgru.observaciones',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado',
				fieldLabel: 'Estado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:15
			},
			type:'TextField',
			filters:{pfiltro:'salgru.estado',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
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
			filters:{pfiltro:'salgru.estado_reg',type:'string'},
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
			filters:{pfiltro:'salgru.fecha_reg',type:'date'},
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
			filters:{pfiltro:'salgru.fecha_mod',type:'date'},
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
	title:'Salida Múltiple',
	ActSave:'../../sis_almacenes/control/SalidaGrupo/insertarSalidaGrupo',
	ActDel:'../../sis_almacenes/control/SalidaGrupo/eliminarSalidaGrupo',
	ActList:'../../sis_almacenes/control/SalidaGrupo/listarSalidaGrupo',
	id_store:'id_salida_grupo',
	fields: [
		{name:'id_salida_grupo', type: 'numeric'},
		{name:'id_movimiento_tipo', type: 'numeric'},
		{name:'id_almacen', type: 'numeric'},
		{name:'descripcion', type: 'string'},
		{name:'fecha', type: 'date',dateFormat:'Y-m-d'},
		{name:'observaciones', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_almacen', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_salida_grupo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	onBtnFinalizar : function() {
		var rec = this.sm.getSelected();
		var data = rec.data;
		var global = this;
		Ext.Msg.confirm('Confirmación', '¿Está seguro de Finalizar la Solicitud?', function(btn) {
			if (btn == "yes") {
				Phx.CP.loadingShow();
				Ext.Ajax.request({
					url : '../../sis_almacenes/control/SalidaGrupo/finalizarSalidaGrupo',
					params : {
						id_salida_grupo : data.id_salida_grupo
					},
					success : global.successSave,
					failure : global.conexionFailure,
					timeout : global.timeout,
					scope : global
				});
			}
		});
	},
	onBtnRetroceder : function() {
		var rec = this.sm.getSelected();
		var data = rec.data;
		var global = this;
		Ext.Msg.confirm('Confirmación', '¿Está seguro de Retroceder la Solicitud?', function(btn) {
			if (btn == "yes") {
				Phx.CP.loadingShow();
				Ext.Ajax.request({
					url : '../../sis_almacenes/control/SalidaGrupo/retrocederSalidaGrupo',
					params : {
						id_salida_grupo : data.id_salida_grupo
					},
					success : global.successSave,
					failure : global.conexionFailure,
					timeout : global.timeout,
					scope : global
				});
			}
		});
	},
	preparaMenu : function(n) {
		var tb = Phx.vista.SalidaGrupo.superclass.preparaMenu.call(this);
		var data = this.getSelectedData();
		console.log(data)
		if (data.estado == 'finalizado') {				
			this.getBoton('btnFinalizar').disable();
			this.getBoton('btnRetroceder').enable();
		} else{
			this.getBoton('btnFinalizar').enable();
			this.getBoton('btnRetroceder').disable();
		}
		return tb;
	},
	liberaMenu : function() {
		var tb = Phx.vista.SalidaGrupo.superclass.liberaMenu.call(this);
		this.getBoton('btnFinalizar').disable();
		this.getBoton('btnRetroceder').disable();
		return tb;
	},
	south: {
		url : '../../../sis_almacenes/vista/salida_grupo_item/SalidaGrupoItem.php',
		title : 'Detalle de Items',
		height : '50%',
		cls : 'SalidaGrupoItem'
	}
	
})
</script>
		
		