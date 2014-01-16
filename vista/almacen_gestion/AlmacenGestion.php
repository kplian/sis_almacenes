<?php
/**
*@package pXP
*@file AlmacenGestion.php
*@author  RCM
*@date 31-12-2013 14:15:09
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.AlmacenGestion=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config;
    	//llama al constructor de la clase padre
		Phx.vista.AlmacenGestion.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag, id_almacen : this.maestro.id_almacen}})
		
		this.Atributos[1].valorInicial = this.maestro.id_almacen;
		
		//Botones
		this.addButton('btnAbrirCerrar', {
			text : 'Abrir',
			iconCls : 'bassign',
			disabled : true,
			handler : this.onBtnAbrirCerrar,
			tooltip : '<b>Apertura/Cierre de Gestión</b>'
		});
		
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_almacen_gestion'
			},
			type:'Field',
			form:true 
		},
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
	       		    name:'id_gestion',
	   				origen:'GESTION',
	   				tinit:false,
	   				fieldLabel: 'Gestión',
	   			    gwidth: 120,
	   			    anchor: '100%',
		   			renderer: function (value, p, record){return String.format('{0}', record.data['desc_gestion']);},
		   			gdisplayField: 'desc_gestion'
			},
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{	
		        pfiltro:'gest.gestion',
				type:'string'
			},
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
				maxLength:-5
			},
			type:'TextField',
			filters:{pfiltro:'almges.estado',type:'string'},
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
			filters:{pfiltro:'almges.estado_reg',type:'string'},
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
			filters:{pfiltro:'almges.fecha_reg',type:'date'},
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
			filters:{pfiltro:'almges.fecha_mod',type:'date'},
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
	title:'Gestión Almacenes',
	ActSave:'../../sis_almacenes/control/AlmacenGestion/insertarAlmacenGestion',
	ActDel:'../../sis_almacenes/control/AlmacenGestion/eliminarAlmacenGestion',
	ActList:'../../sis_almacenes/control/AlmacenGestion/listarAlmacenGestion',
	id_store:'id_almacen_gestion',
	fields: [
		{name:'id_almacen_gestion', type: 'numeric'},
		{name:'id_almacen', type: 'numeric'},
		{name:'id_gestion', type: 'numeric'},
		{name:'estado', type: 'string'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_gestion', type: 'string'}
		
	],
	sortInfo:{
		field: 'id_almacen_gestion',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	south:{
		  url:'../../../sis_almacenes/vista/almacen_gestion_log/AlmacenGestionLog.php',
		  title:'Histórico Gestión', 
		  height:'50%',
		  cls:'AlmacenGestionLog'
	},
	onBtnAbrirCerrar: function() {
		var rec = this.sm.getSelected();
		var data = rec.data;
		var global = this;
		Ext.Msg.confirm('Confirmación', '¿Está seguro de '+this.defAccion(data.estado,'boton')+' la gestión '+data.desc_gestion+'?<br><br>'+this.defAccion(data.estado,'texto'), function(btn) {
			if (btn == "yes") {
				Phx.CP.loadingShow();
				Ext.Ajax.request({
					url : '../../sis_almacenes/control/AlmacenGestion/accionesGestion',
					params : {
						id_almacen_gestion: data.id_almacen_gestion
					},
					success : function(resp){
						var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
						var mensaje=reg.ROOT.datos.mensaje_vista;
						var titulo='Acción realizada';
						if(reg.ROOT.datos.error_logico=='si'){
							mensaje = mensaje+'<br><br>Se abrirá la ventana con el detalle de los movimientos pendientes.';
							titulo='Acción NO realizada'; 
						} 
						
						Phx.CP.loadingHide();
						Ext.Msg.show({
						   title:titulo,
						   msg: mensaje,
						   buttons: Ext.Msg.OK,
						   fn: function(){
								//Abre la ventana de movimientos con los ids recibidos si es que hubo algún error lógico						
								if(reg.ROOT.datos.error_logico=='si') {
									data.ids=reg.ROOT.datos.ids;
									Phx.CP.loadWindows('../../../sis_almacenes/vista/movimiento/MovimientoReq.php', 'Movimientos Pendientes', {
										modal : true,
										width : '70%',
										height : '90%',
									}, data, this.idContenedor, 'MovimientoReq');
								}  else{
									this.reload();
								} 	
						  },
						   icon: Ext.MessageBox.WARNING,
						   scope: this
						});
						
						 
					},
					failure : global.conexionFailure,
					timeout : global.timeout,
					scope : global
				});
			}
		});
	},
	
	defAccion: function(pEstado, pTipo){
		var resp;
		if(pEstado=='abierto'){
			if(pTipo=='boton'){
				resp='Cerrar';	
			} else {
				resp='NOTA: Se generará el(los) Inventario(s) Final(es) con los saldos hasta el 31 de diciembre';
			}
			
		} else if(pEstado=='cerrado'){
			if(pTipo=='boton'){
				resp='Reabrir';
			} else {
				resp='NOTA: Se eliminará(n) el(los) Inventario(s) Final(es) generado(s) siempre y cuando esté(n) en Borrador, caso contrario la acción no podrá ser realizada';
			}
			
		} else{
			
			if(pTipo=='boton'){
				resp='Abrir';
			} else {
				resp='NOTA: Se generará el(los) Inventario(s) Inicial(es) en base a lo(s) Inventario(s) Final(es) de la gestión anterior';
			}
		}
		return resp;
	},
	preparaMenu : function(tb) {
		Phx.vista.AlmacenGestion.superclass.preparaMenu.call(this, tb);
		//Obtiene los datos del registro seleccionado
		var rec = this.sm.getSelected();
		var data = rec.data;
		
		//Habilita el boton de apertura/cierre
		this.getBoton('btnAbrirCerrar').enable();
		
		//Cambia el icono en función del estado
		if (data.estado == 'abierto') {
			this.getBoton('btnAbrirCerrar').setIconClass('btag_accept');
		} else {
			this.getBoton('btnAbrirCerrar').setIconClass('btag_deny');
		}
		//Define el texto del boton
		this.getBoton('btnAbrirCerrar').setText(this.defAccion(data.estado,'boton'));
	},
	
	liberaMenu : function() {
		Phx.vista.AlmacenGestion.superclass.liberaMenu.call(this);
		this.getBoton('btnAbrirCerrar').disable();
	}
	
})
</script>
		
		