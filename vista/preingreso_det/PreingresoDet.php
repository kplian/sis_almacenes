<?php
/**
*@package pXP
*@file gen-PreingresoDet.php
*@author  (admin)
*@date 07-10-2013 17:46:04
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.PreingresoDet=Ext.extend(Phx.gridInterfaz,{
	
	estado: 'orig',

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.PreingresoDet.superclass.constructor.call(this,config);
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		this.grid.addListener('cellclick', this.oncellclick,this);
		this.init();
		
		//Se agrega el botón para adicionar todos
		this.addButton('btnAgTodos', {
				text : 'Agregar Todos',
				iconCls : 'bright-all',
				disabled : true,
				handler : this.agregarTodos,
				tooltip : '<b>Agregar Todos</b><br/>Agrega todos los items para el preingreso.'
			});
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_preingreso_det'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_preingreso'
			},
			type:'Field',
			form:true 
		},
		{
            config:{
                name: 'agregar',
                fieldLabel: 'Agregar',
                allowBlank: true,
                anchor: '80%',
                gwidth: 50,
                scope: this,
                renderer:function (value, p, record, rowIndex, colIndex){  
					return "<div style='text-align:center'><img border='0' style='-webkit-user-select:auto;cursor:pointer;' title='Agregar' src = '../../../lib/imagenes/icono_awesome/awe_rigth_arrow.png' align='center' width='30' height='30'></div>";
                }
            },
            type:'Checkbox',
            id_grupo:1,
            grid:true,
            form:false
        },
		{
			config:{
				name: 'cantidad_det',
				fieldLabel: 'Cantidad',
				allowBlank: true,
				anchor: '80%',
				gwidth: 55,
				maxLength:200,
				disabled:true
			},
			type:'NumberField',
			filters:{pfiltro:'predet.cantidad_det',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'precio_compra',
				fieldLabel: 'Costo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 75,
				maxLength:1179650
			},
			type:'NumberField',
			filters:{pfiltro:'predet.precio_compra',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config : {
				name : 'id_cotizacion_det',
				fieldLabel : 'Concepto Gasto',
				allowBlank : false,
				emptyText : 'Elija un Concepto...',
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
				valueField : 'id_cotizacion_det',
				displayField : 'desc_ingas',
				gdisplayField : 'desc_ingas',
				tpl : '<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p><p>Clasif.: {desc_clasificacion}</p></div></tpl>',
				hiddenName : 'id_cotizacion_det',
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
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['desc_ingas']);
				},
				resizable: true
			},
			type : 'ComboBox',
			id_grupo : 0,
			filters : {
				pfiltro : 'ingas.desc_ingas',
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
				gwidth: 300,
				maxLength:2000,
				disabled:true
			},
			type:'TextArea',
			filters:{pfiltro:'sdet.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
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
			grid : false,
			form : true
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
				pfiltro : 'alm.codigo',
				type : 'string'
			},
			grid : false,
			form : true
		},
		{
			config: {
				name: 'id_clasificacion',
				fieldLabel: 'Clasificación',
				allowBlank: true,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_activos_fijos/control/Clasificacion/listarClasificacion',
					id: 'id_clasificacion',
					root: 'datos',
					sortInfo: {
						field: 'clas.codigo',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_clasificacion', 'descripcion', 'codigo'],
					remoteSort: true,
					baseParams: {par_filtro: 'clas.descripcion#clas.codigo', tipo: 'subtipo'}
				}),
				valueField: 'id_clasificacion',
				displayField: 'descripcion',
				gdisplayField: 'desc_clasificacion',
				hiddenName: 'id_clasificacion',
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
					return String.format('{0}', record.data['desc_clasificacion']);
				},
				tpl:'<tpl for="."><div class="x-combo-list-item"><p>Código: {codigo}</p><p>Descripción: {descripcion}</p></div></tpl>',
			},
			type: 'ComboBox',
			id_grupo: 0,
			filters: {pfiltro: 'cla.nombre',type: 'string'},
			grid: false,
			form: true
		},
		{
			config: {
				name: 'id_depto',
				fieldLabel: 'Depto.',
				allowBlank: false,
				emptyText: 'Elija una opción...',
				store: new Ext.data.JsonStore({
					url: '../../sis_parametros/control/Depto/listarDeptoFiltradoDeptoUsuario',
					id: 'id_',
					root: 'datos',
					sortInfo: {
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_depto', 'codigo', 'nombre'],
					remoteSort: true,
					baseParams: {par_filtro: 'DEPPTO.nombre#DEPPTO.codigo'}
				}),
				valueField: 'id_depto',
				displayField: 'nombre',
				gdisplayField: 'desc_depto',
				hiddenName: 'id_depto',
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
					return String.format('{0}', record.data['desc_depto']);
				},
				listWidth:300
			},
			type: 'ComboBox',
			id_grupo: 5,
			filters: {pfiltro: 'depto.nombre',type: 'string'},
			grid: false,
			form: true
		},
		{
			config: {
				name: 'sw_generar',
				fieldLabel: 'Generar',
				anchor: '100%',
				tinit: false,
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'sw_generar',
				gwidth: 100,
				baseParams:{
						cod_subsistema:'PARAM',
						catalogo_tipo:'tgral__bandera_min'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['sw_generar']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			filters:{pfiltro:'predet.sw_generar',type:'string'},
			grid: false,
			form: true
		},
		{
			config:{
				name: 'observaciones',
				fieldLabel: 'Observaciones',
				allowBlank: true,
				anchor: '100%',
				gwidth: 200,
				maxLength:1000
			},
			type:'TextArea',
			filters:{pfiltro:'predet.observaciones',type:'string'},
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
			filters:{pfiltro:'predet.estado_reg',type:'string'},
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
			filters:{pfiltro:'predet.fecha_reg',type:'date'},
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
			filters:{pfiltro:'predet.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	tam_pag:50,	
	title:'Adquisiciones',
	ActSave:'../../sis_almacenes/control/PreingresoDet/insertarPreingresoDet',
	ActDel:'../../sis_almacenes/control/PreingresoDet/eliminarPreingresoDet',
	ActList:'../../sis_almacenes/control/PreingresoDet/listarPreingresoDet',
	id_store:'id_preingreso_det',
	fields: [
		{name:'id_preingreso_det', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_preingreso', type: 'numeric'},
		{name:'id_cotizacion_det', type: 'numeric'},
		{name:'id_item', type: 'numeric'},
		{name:'id_almacen', type: 'numeric'},
		{name:'cantidad_det', type: 'numeric'},
		{name:'precio_compra', type: 'numeric'},
		{name:'id_depto', type: 'numeric'},
		{name:'id_clasificacion', type: 'numeric'},
		{name:'sw_generar', type: 'string'},
		{name:'observaciones', type: 'string'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'desc_almacen', type: 'string'},
		{name:'desc_depto', type: 'string'},
		{name:'desc_item', type: 'string'},
		{name:'desc_clasificacion', type: 'string'},
		{name:'desc_ingas', type: 'string'},
		{name:'descripcion', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'tipo', type: 'string'}
	],
	sortInfo:{
		field: 'id_preingreso_det',
		direction: 'ASC'
	},
	bdel:false,
	bsave:false,
	bnew:false,
	bedit:false,
	/*preparaMenu:function(n){
	    
	       Phx.vista.PreingresoDet.superclass.preparaMenu.call(this,n);
	       if(this.maestro.estado=='borrador'){
	           this.getBoton('edit').enable();
	       }
	       else{
	           this.getBoton('edit').disable();
	       }
      
	},*/
	
	
	loadValoresIniciales:function(){
		Phx.vista.PreingresoDet.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_preingreso').setValue(this.maestro.id_preingreso);
	},
	onReloadPage:function(m){
		this.maestro=m;	
		Ext.apply(this.store.baseParams,{id_preingreso:this.maestro.id_preingreso,estado: this.estado});
		this.load({params:{start:0, limit:this.tam_pag}});
	},
	onButtonEdit: function (){
		//Prepara los componentes en función de si el preingreso es para Almacén o para Activos Fijos
		Phx.vista.PreingresoDet.superclass.onButtonEdit.call(this);
		this.preparaComponentes(this.maestro)
	},
	preparaComponentes: function(pMaestro){
		var codSis;
		//Oculta concepto de gasto
		this.Cmp.id_cotizacion_det.disable();
		
		if(pMaestro.tipo=='activo_fijo'){
			//Setea store del departamento
			codSis='AF';
			Ext.apply(this.Cmp.id_depto.store.baseParams,{codigo_subsistema:codSis});
			
			
			//Habilita componentes
			this.Cmp.id_clasificacion.enable();
            this.mostrarComponente(this.Cmp.id_clasificacion);
            this.Cmp.id_depto.enable();
            this.mostrarComponente(this.Cmp.id_depto);
			
			
			//Deshabilita componentes
			this.Cmp.id_almacen.disable();
            this.ocultarComponente(this.Cmp.id_almacen);
            this.Cmp.id_item.disable();
            this.ocultarComponente(this.Cmp.id_item);
			
		} else if(pMaestro.tipo=='almacen'){
			//Setea store del departamento
			codSis='ALM';
			Ext.apply(this.Cmp.id_depto.store.baseParams,{codigo_subsistema:codSis});
			console.log(this.Cmp.id_almacen)
			
			//Habilita componentes
			this.Cmp.id_almacen.enable();
            this.mostrarComponente(this.Cmp.id_almacen);
            this.Cmp.id_item.enable();
            this.mostrarComponente(this.Cmp.id_item);
			
			//Deshabilita componentes
			this.Cmp.id_clasificacion.disable();
            this.ocultarComponente(this.Cmp.id_clasificacion);
            this.Cmp.id_depto.disable();
            this.ocultarComponente(this.Cmp.id_depto);
            
        } else {
			//Setea store del departamento
			codSis='error';
			Ext.apply(this.Cmp.id_depto.store.baseParams,{codigo_subsistema:codSis});
		}
	},
   east: {
		url : '../../../sis_almacenes/vista/preingreso_det/PreingresoDetMod.php',
		title : 'Preingreso',
		width : '50%',
		cls : 'PreingresoDetMod'
	}, 
	
	aplicarFiltro: function(){
		this.store.baseParams.estado=this.estado;
        this.load(); 
	},
	
	oncellclick : function(grid, rowIndex, columnIndex, e) {
		
	    var record = this.store.getAt(rowIndex),
	        fieldName = grid.getColumnModel().getDataIndex(columnIndex); // Get field name
	        
	    if (fieldName == 'agregar') {
	    	
			var myPanelEast = Phx.CP.getPagina(this.idContenedor+'-east');
			
	    	Phx.CP.loadingShow();
				Ext.Ajax.request({
					url : '../../sis_almacenes/control/PreingresoDet/preparaPreingreso',
					params : {
						id_preingreso_det:	record.data.id_preingreso_det,
						data: record
					},
					success : function(a,b,c){
						Phx.CP.loadingHide();
						this.reload();
						//Carga datos del panel derecho
						myPanelEast.onReloadPage(this.maestro);
						delete myPanelEast;
					},
					failure : this.conexionFailure,
					timeout : this.timeout,
					scope : this
				});
	    } 
		
	},
	
	agregarTodos: function(){
		Ext.Msg.show({
		   title:'Confirmación',
		   msg: '¿Está seguro de agregar todos los items al Preingreso?',
		   buttons: Ext.Msg.YESNO,
		   fn: function(a,b,c){
		   		if(a=='yes'){
		   			var myPanelEast = Phx.CP.getPagina(this.idContenedor+'-east');
					Phx.CP.loadingShow();
					Ext.Ajax.request({
						url: '../../sis_almacenes/control/PreingresoDet/preparaPreingresoAll',
						params: {
							id_preingreso: this.maestro.id_preingreso
						},
						success: function(a,b,c){
							Phx.CP.loadingHide();
							this.reload();
							//Carga datos del panel derecho
							myPanelEast.onReloadPage(this.maestro);
							delete myPanelEast;
						},
						failure: this.conexionFailure,
						timeout: this.timeout,
						scope: this
					});	
		   		}
		   },
		   icon: Ext.MessageBox.QUESTION,
		   scope: this
		});

	},
	
	DisableSelect: function(n) {
        this.liberaMenu(n)
   	},
   
   	EnableSelect: function(n,extra) {
		var data = this.getSelectedData();
        Ext.apply(data,extra);
       	this.preparaMenu(n);
    }
	
	
})
</script>
		
		