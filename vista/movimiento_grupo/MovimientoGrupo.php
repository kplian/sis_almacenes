<?php
/**
*@package pXP
*@file gen-MovimientoGrupo.php
*@author  (admin)
*@date 18-10-2013 21:26:04
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.MovimientoGrupo=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.MovimientoGrupo.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}})
		
		this.addButton('btnGenCbte', {
				text : 'Generar Comprobante',
				iconCls : 'bchecklist',
				disabled : true,
				handler : this.onBtnGenCbte,
				tooltip : '<b>Generar Comprobante periódico</b>'
			});
	},
			
	Atributos:[
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
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_int_comprobante'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'fecha_ini',
				id:'fecha_ini'+this.idContenedor,
				fieldLabel: 'Fecha Ini',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				format: 'd/m/Y', 
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
				vtype: 'daterange',
				endDateField: 'fecha_fin'+this.idContenedor
			},
			type:'DateField',
			filters:{pfiltro:'movgru.fecha_ini',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'fecha_fin',
				id:'fecha_fin'+this.idContenedor,
				fieldLabel: 'Fecha Fin',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				format: 'd/m/Y', 
				renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''},
				vtype: 'daterange',
				startDateField: 'fecha_ini'+this.idContenedor
			},
			type:'DateField',
			filters:{pfiltro:'movgru.fecha_fin',type:'date'},
			id_grupo:1,
			grid:true,
			form:true
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
			filters:{pfiltro:'movgru.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config : {
				name : 'id_almacen',
				fieldLabel : 'Almacén',
				allowBlank : false,
				emptyText : 'Almacen...',
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
				gdisplayField : 'desc_almacen',
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
				pfiltro : 'alm.nombre',
				type : 'string'
			},
			grid : true,
			form : true
		},
		{
			config : {
				name : 'id_depto_conta',
				fieldLabel : 'Depto. Conta.',
				allowBlank : false,
				emptyText : 'Departamento Contable...',
				store : new Ext.data.JsonStore({
					url : '../../sis_parametros/control/Depto/listarDepto',
					id : 'id_depto',
					root : 'datos',
					sortInfo : {
						field : 'nombre',
						direction : 'ASC'
					},
					totalProperty : 'total',
					fields : ['id_depto', 'nombre', 'codigo'],
					remoteSort : true,
					baseParams : {
						par_filtro : 'DEPPTO.nombre#DEPPTO.codigo',
						codigo_subsistema: 'CONTA'
					}
				}),
				valueField : 'id_depto',
				displayField : 'nombre',
				gdisplayField : 'nombre_depto',
				tpl : '<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p></div></tpl>',
				hiddenName : 'id_departamento',
				forceSelection : true,
				typeAhead : false,
				triggerAction : 'all',
				lazyRender : true,
				mode : 'remote',
				pageSize : 10,
				queryDelay : 1000,
				anchor : '100%',
				gwidth : 100,
				minChars : 2,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre_depto']);
				}
			},
			type : 'ComboBox',
			id_grupo : 0,
			filters : {
				pfiltro : 'dpto.nombre',
				type : 'string'
			},
			grid : true,
			form : true
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
			filters:{pfiltro:'movgru.estado',type:'string'},
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
				filters:{pfiltro:'movgru.estado_reg',type:'string'},
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
				filters:{pfiltro:'movgru.fecha_reg',type:'date'},
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
				filters:{pfiltro:'movgru.fecha_mod',type:'date'},
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
	title:'Grupo Movimientos',
	ActSave:'../../sis_almacenes/control/MovimientoGrupo/insertarMovimientoGrupo',
	ActDel:'../../sis_almacenes/control/MovimientoGrupo/eliminarMovimientoGrupo',
	ActList:'../../sis_almacenes/control/MovimientoGrupo/listarMovimientoGrupo',
	id_store:'id_movimiento_grupo',
	fields: [
		{name:'id_movimiento_grupo', type: 'numeric'},
		{name:'id_int_comprobante', type: 'numeric'},
		{name:'descripcion', type: 'string'},
		{name:'id_almacen', type: 'numeric'},
		{name:'fecha_ini', type: 'date',dateFormat:'Y-m-d'},
		{name:'estado', type: 'string'},
		{name:'fecha_fin', type: 'date',dateFormat:'Y-m-d'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_almacen', type: 'string'},
		{name:'nro_cbte', type: 'string'},
		{name:'id_depto_conta', type: 'numeric'},
		{name:'nombre_depto', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_movimiento_grupo',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	onBtnGenCbte: function(){
		var rec = this.sm.getSelected();
		var data = rec.data;
		var global = this;
		Ext.Msg.confirm('Confirmación', '¿Está seguro de Generar el Comprobante?', function(btn) {
			if (btn == "yes") {
				Phx.CP.loadingShow();
				Ext.Ajax.request({
					url : '../../sis_almacenes/control/MovimientoGrupo/generarCbte',
					params : {
						id_movimiento_grupo : data.id_movimiento_grupo
					},
					success : global.successSave,
					failure : global.conexionFailure,
					timeout : global.timeout,
					scope : global
				});
			}
		});
	},
	south: {
		url : '../../../sis_almacenes/vista/movimiento_grupo_det/MovimientoGrupoDet.php',
		title : 'Detalle de Items',
		height : '50%',
		cls : 'MovimientoGrupoDet'
	},
	preparaMenu : function(n) {
			var tb = Phx.vista.MovimientoGrupo.superclass.preparaMenu.call(this);
			var data = this.getSelectedData();

			if (data.estado == 'borrador') {				
				this.getBoton('btnGenCbte').enable();
				this.getBoton('edit').enable();
				this.getBoton('del').enable();
			} else {
				this.getBoton('btnGenCbte').disable();
				this.getBoton('edit').disable();
				this.getBoton('del').disable();
			}

			return tb;
		},
		liberaMenu : function() {
			var tb = Phx.vista.MovimientoGrupo.superclass.liberaMenu.call(this);
			this.getBoton('btnGenCbte').disable();
			return tb;
		}
	
})
</script>
		
		