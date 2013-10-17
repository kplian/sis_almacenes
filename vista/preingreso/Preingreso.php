<?php
/**
*@package pXP
*@file gen-Preingreso.php
*@author  (admin)
*@date 03-10-2013 20:16:25
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Preingreso=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Preingreso.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}});
		
		 this.addButton('btnIngreso',{
                    text :'Ingreso',
                    iconCls : 'bchecklist',
                    disabled: true,
                    handler : this.onIngreso,
                    tooltip : '<b>Ingreso</b><br/><b>Generación del Ingreso a Almacén o Activo Fijo</b>'
         });
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_preingreso'
			},
			type:'Field',
			form:true 
		},
		{
			config: {
				name: 'id_cotizacion',
				fieldLabel: 'Cotización',
				allowBlank: false,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['numero_oc']);
				},
				disabled:true,
				gwidth:180
			},
			type: 'Field',
			id_grupo: 0,
			filters: {pfiltro: 'cot.numero_oc',type: 'string'},
			grid: true,
			form: true
		},
		{
			config:{
				name: 'estado',
				fieldLabel: 'Estado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'preing.estado',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config: {
				name: 'tipo',
				fieldLabel: 'Tipo',
				anchor: '100%',
				tinit: true,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'tipo',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'ALM',
						catalogo_tipo:'tpreingreso__tipo'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['tipo']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'preing.tipo',type:'string'},
			grid: true,
			form: true
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
				gdisplayField : 'codigo_almacen',
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
					return String.format('{0}', record.data['codigo_almacen']);
				}
			},
			type : 'ComboBox',
			id_grupo : 0,
			filters : {
				pfiltro : 'alm.codigo',
				type : 'string'
			},
			grid : true,
			form : true
		},
		{
   			config:{
   				name:'id_depto',
   				hiddenName: 'id_depto',
   				url: '../../sis_parametros/control/Depto/listarDeptoFiltradoXUsuario',
   				origen:'DEPTO',
   				allowBlank:false,
   				fieldLabel: 'Depto',
   				gdisplayField:'codigo_depto',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
   				width:250,
		        gwidth:180,
   				baseParams:{estado:'activo',codigo_subsistema:'ALM'},//parametros adicionales que se le pasan al store
      			renderer:function (value, p, record){return String.format('{0}', record.data['codigo_depto']);}
   			},
   			//type:'TrigguerCombo',
   			type:'ComboRec',
   			id_grupo:0,
   			filters:{pfiltro:'dep.codigo',type:'string'},
   		    grid:true,
   			form:true
       	},
       	{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripción',
				allowBlank: true,
				anchor: '80%',
				gwidth: 250,
				maxLength:1000
			},
				type:'TextField',
				filters:{pfiltro:'preing.descripcion',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
       	{
            config:{
                name:'id_moneda',
                origen:'MONEDA',
                allowBlank:false,
                fieldLabel:'Moneda',
                gdisplayField:'codigo_moneda',//mapea al store del grid
                gwidth:50,
                renderer:function (value, p, record){return String.format('{0}', record.data['codigo_moneda']);},
                disabled:true,
                gwidth:'150'
             },
            type:'ComboRec',
            id_grupo:1,
            filters:{   
                pfiltro:'mon.codigo',
                type:'string'
            },
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
			filters:{pfiltro:'preing.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config: {
				name: 'id_estado_wf',
				fieldLabel: 'id_estado_wf',
				inputType:'hidden'
			},
			type: 'Field',
			form: true
		},
		{
			config: {
				name: 'id_proceso_wf',
				fieldLabel: 'id_proceso_wf',
				inputType:'hidden'
			},
			type: 'Field',
			form: true
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
				filters:{pfiltro:'preing.fecha_reg',type:'date'},
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
				filters:{pfiltro:'preing.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'Preingreso',
	ActSave:'../../sis_almacenes/control/Preingreso/insertarPreingreso',
	ActDel:'../../sis_almacenes/control/Preingreso/eliminarPreingreso',
	ActList:'../../sis_almacenes/control/Preingreso/listarPreingreso',
	id_store:'id_preingreso',
	fields: [
		{name:'id_preingreso', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_cotizacion', type: 'numeric'},
		{name:'id_almacen', type: 'numeric'},
		{name:'id_depto', type: 'numeric'},
		{name:'id_estado_wf', type: 'numeric'},
		{name:'id_proceso_wf', type: 'numeric'},
		{name:'estado', type: 'string'},
		{name:'id_moneda', type: 'numeric'},
		{name:'tipo', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'numero_oc', type: 'string'},
		{name:'codigo_almacen', type: 'string'},
		{name:'codigo_depto', type: 'string'},
		{name:'codigo_moneda', type: 'string'},
		{name:'descripcion', type: 'string'}
	],
	sortInfo:{
		field: 'id_preingreso',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	bnew:false,
	south:{
		  url:'../../../sis_almacenes/vista/preingreso_det/PreingresoDet.php',
		  title:'Detalle Preingreso', 
		  height:'50%',	//altura de la ventana hijo
		  cls:'PreingresoDet'
	},
	onIngreso:function(){
        var rec = this.sm.getSelected();
        if(rec.data){
        	var aux;
        	aux='Almacenes';
        	if(rec.data.tipo=='activo_fijo'){
				aux='Activos Fijos';        		
        	} 
        	Ext.Msg.confirm('Confirmación','¿Está seguro de generar el Ingreso a '+aux+'?', 
			function(btn) {
				if (btn == "yes") {
					Phx.CP.loadingShow();
		            Ext.Ajax.request({
		                url:'../../sis_almacenes/control/Preingreso/generarIngreso',
			                params:{id_preingreso:rec.data.id_preingreso},
			                success:this.successSinc,
			                failure: this.conexionFailure,
			                timeout:this.timeout,
			                scope:this
			            });
					}
				},this);
  
            } else{
            	Ext.Msg.alert('Mensaje','Seleccione un registro y vuelva a intentarlo');
        }
   },
	preparaMenu:function(n){
    	var rec = this.getSelectedData();
      	var tb =this.tbar;
      	Phx.vista.Preingreso.superclass.preparaMenu.call(this,n);
      
      	if(rec.estado=='borrador'){
      		this.getBoton('btnIngreso').enable();
      	}
      	else {
      		this.getBoton('btnIngreso').disable();
      	}
          
           
	},
	liberaMenu:function(){
        var tb = Phx.vista.Preingreso.superclass.liberaMenu.call(this);
        if(tb){
            this.getBoton('btnIngreso').disable();
         }
       return tb
    }
	
})
</script>
		
		