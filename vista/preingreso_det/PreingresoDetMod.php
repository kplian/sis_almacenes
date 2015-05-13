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
Phx.vista.PreingresoDetMod=Ext.extend(Phx.gridInterfaz,{
	
	estado: 'mod',

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.PreingresoDetMod.superclass.constructor.call(this,config);
		this.grid.getTopToolbar().disable();
		this.grid.getBottomToolbar().disable();
		this.grid.addListener('cellclick', this.oncellclick,this);
		this.init();
		
		//Se agrega el botón para adicionar todos
		this.addButton('btnAgTodos', {
				text : 'Quitar Todos',
				iconCls : 'bleft-all',
				disabled : true,
				handler : this.quitarTodos,
				tooltip : '<b>Quitar Todos</b><br/>Quita todos los items del preingreso.'
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
                name: 'quitar',
                fieldLabel: 'Quitar',
                allowBlank: true,
                anchor: '80%',
                gwidth: 50,
                scope: this,
                renderer:function (value, p, record, rowIndex, colIndex){  
					return "<div style='text-align:center'><img border='0' style='-webkit-user-select:auto;cursor:pointer;' title='Agregar' src = '../../../lib/imagenes/icono_awesome/awe_left_arrow.png' align='center' width='30' height='30'></div>";
                }
            },
            type:'Checkbox',
            id_grupo:1,
            grid:true,
            form:false
        },
		{
            config:{
                name: 'agregar',
                fieldLabel: 'Incluido',
                allowBlank: true,
                anchor: '80%',
                gwidth: 50,
                scope: this,
                renderer:function (value, p, record, rowIndex, colIndex){  
					return "<div style='text-align:center'><img border='0' style='-webkit-user-select:auto;cursor:pointer;' title='Agregar' src = '../../../lib/imagenes/icono_awesome/awe_ok.png' align='center' width='30' height='30'></div>";
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
				maxLength:200
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
			grid : true,
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
			grid: true,
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
			grid: true,
			form: true
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
			form : false
		},
		{
			config:{
				name: 'descripcion',
				fieldLabel: 'Descripción',
				allowBlank: true,
				anchor: '100%',
				gwidth: 300,
				maxLength:2000
			},
			type:'TextArea',
			filters:{pfiltro:'sdet.descripcion',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config: {
				name: 'sw_generar',
				fieldLabel: 'Generar',
				anchor: '100%',
				tinit: false,
				allowBlank: true,
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
			form: false
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
	title:'Preingreso',
	ActSave:'../../sis_almacenes/control/PreingresoDet/insertarPreingresoDetPreparacion',
	ActDel:'../../sis_almacenes/control/PreingresoDet/eliminarPreingresoDetPreparacion',
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
	bnew:true,
	bedit:true,
	/*preparaMenu:function(n){
	    
	       Phx.vista.PreingresoDetMod.superclass.preparaMenu.call(this,n);
	       if(this.maestro.estado=='borrador'){
	           this.getBoton('edit').enable();
	       }
	       else{
	           this.getBoton('edit').disable();
	       }
      
	},*/
	
	
	loadValoresIniciales:function(){
		Phx.vista.PreingresoDetMod.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_preingreso').setValue(this.maestro.id_preingreso);
	},
	onReloadPage:function(m){
		this.maestro=m;	
		Ext.apply(this.store.baseParams,{id_preingreso:this.maestro.id_preingreso,estado: this.estado});
		this.load({params:{start:0, limit:this.tam_pag}});
		this.preparaComponentes(this.maestro)
	},
	onButtonEdit: function (){
		//Prepara los componentes en función de si el preingreso es para Almacén o para Activos Fijos
		Phx.vista.PreingresoDetMod.superclass.onButtonEdit.call(this);
		this.preparaComponentes(this.maestro)
	},
	preparaComponentes: function(pMaestro){
		var codSis;
		
		if(pMaestro.tipo=='activo_fijo'){
			//Setea store del departamento
			codSis='AF';
			Ext.apply(this.Cmp.id_depto.store.baseParams,{codigo_subsistema:codSis});
			
			
			//Habilita componentes
			this.Cmp.id_clasificacion.enable();
            this.mostrarComponente(this.Cmp.id_clasificacion);
            this.Cmp.id_depto.enable();
            this.mostrarComponente(this.Cmp.id_depto);
            this.mostrarColumna(6);
            this.mostrarColumna(7);
			
			//Deshabilita componentes
			this.Cmp.id_almacen.disable();
            this.ocultarComponente(this.Cmp.id_almacen);
            this.Cmp.id_item.disable();
            this.ocultarComponente(this.Cmp.id_item);
            this.ocultarColumna(4);
            this.ocultarColumna(5);
			
		} else if(pMaestro.tipo=='almacen'){
			//Setea store del departamento
			codSis='ALM';
			Ext.apply(this.Cmp.id_depto.store.baseParams,{codigo_subsistema:codSis});
			
			//Habilita componentes
			this.Cmp.id_almacen.enable();
            this.mostrarComponente(this.Cmp.id_almacen);
            this.Cmp.id_item.enable();
            this.mostrarComponente(this.Cmp.id_item);
            this.mostrarColumna(4);
            this.mostrarColumna(5);
			
			//Deshabilita componentes
			this.Cmp.id_clasificacion.disable();
            this.ocultarComponente(this.Cmp.id_clasificacion);
            this.Cmp.id_depto.disable();
            this.ocultarComponente(this.Cmp.id_depto);
            this.ocultarColumna(6);
            this.ocultarColumna(7);
            
        } else {
			//Setea store del departamento
			codSis='error';
			Ext.apply(this.Cmp.id_depto.store.baseParams,{codigo_subsistema:codSis});
			this.ocultarColumna(4);
			this.ocultarColumna(5);
            this.ocultarColumna(6);
			this.ocultarColumna(7);
		}
	},
	
	aplicarFiltro: function(){
		this.store.baseParams.estado=this.estado;
        this.load(); 
	},
	
	quitarTodos: function(){
		Ext.Msg.show({
		   title:'Confirmación',
		   msg: '¿Está seguro de quitar todos los items del Preingreso?',
		   buttons: Ext.Msg.YESNO,
		   fn: function(a,b,c){
		   		if(a=='yes'){
		   			var myPanel = Phx.CP.getPagina(this.idContenedorPadre);
					Phx.CP.loadingShow();
					Ext.Ajax.request({
						url: '../../sis_almacenes/control/PreingresoDet/quitaPreingresoAll',
						params: {
							id_preingreso: this.maestro.id_preingreso
						},
						success: function(a,b,c){
							Phx.CP.loadingHide();
							this.reload();
							//Carga datos del panel derecho
							myPanel.onReloadPage(this.maestro);
							delete myPanel;
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
	
	successDel:function(resp){
		Phx.CP.loadingHide();
		this.reload();
		
		//Recarga al padre
		var myPanel = Phx.CP.getPagina(this.idContenedorPadre);
		myPanel.onReloadPage(this.maestro);
		delete myPanel;
	},
	
	oncellclick : function(grid, rowIndex, columnIndex, e) {
		
	    var record = this.store.getAt(rowIndex),
	        fieldName = grid.getColumnModel().getDataIndex(columnIndex); // Get field name
	        
	    if (fieldName == 'quitar') {
	    	
			var myPanel = Phx.CP.getPagina(this.idContenedorPadre);
			
	    	Phx.CP.loadingShow();
				Ext.Ajax.request({
					url : '../../sis_almacenes/control/PreingresoDet/eliminarPreingresoDetPreparacion',
					params : {
						id_preingreso_det:	record.data.id_preingreso_det,
						data: record
					},
					success : function(a,b,c){
						Phx.CP.loadingHide();
						this.reload();
						//Carga datos del panel derecho
						myPanel.onReloadPage(this.maestro);
						delete myPanel;
					},
					failure : this.conexionFailure,
					timeout : this.timeout,
					scope : this
				});
	    } 
		
	}
	
	
})
</script>
		
		