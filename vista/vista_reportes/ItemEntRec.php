<?php
/**
 *@package pXP
 *@file    ItemEntRec.php
 *@author  RCM
 *@date    07/08/2013
 *@description Reporte Material Entregado/Recibido
 */
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.ItemEntRec = Ext.extend(Phx.frmInterfaz, {
		Atributos : [
		{
			config : {
				name : 'fecha_ini',
				id:'fecha_ini_itemrec'+this.idContenedor,
				fieldLabel : 'Desde',
				allowBlank : false,
				gwidth : 100,
				format : 'd/m/Y',
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				},
				vtype: 'daterange',
				endDateField: 'fecha_fin_itemrec'+this.idContenedor
			},
			type : 'DateField',
			id_grupo : 0,
			grid : true,
			form : true
		},
		{
			config : {
				name : 'fecha_fin',
				id:'fecha_fin_itemrec'+this.idContenedor,
				fieldLabel : 'Hasta',
				allowBlank : false,
				gwidth : 100,
				format : 'd/m/Y',
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				},
				vtype: 'daterange',
				startDateField: 'fecha_ini_itemrec'+this.idContenedor
			},
			type : 'DateField',
			id_grupo : 0,
			grid : true,
			form : true
		},{
			config: {
				name: 'tipo_mov',
				fieldLabel: 'Criterio',
				anchor: '100%',
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'tipo_mov',
				gwidth: 100,
				tinit:false,
				baseParams:{
						cod_subsistema:'ALM',
						catalogo_tipo:'tmovimiento_tipo_tipo1'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['tipo_mov']);}
			},
			type: 'ComboRec',
			id_grupo: 0,
			grid: true,
			form: true
		},
		{
			config : {
				name : 'tipo_sol',
				fieldLabel : 'Solicitante',
				allowBlank : false,
				triggerAction : 'all',
				lazyRender : true,
				mode : 'local',
				store : new Ext.data.ArrayStore({
					fields : ['codigo', 'nombre'],
					data : [['func', 'Funcionario'], ['prov', 'Proveedor']]
				}),
				//anchor : 150,
				width:120,
				valueField : 'codigo',
				displayField : 'nombre'
			},
			type : 'ComboBox',
			id_grupo : 1,
			form : true
		},
		{
			config : {
				name : 'id_proveedor',
				fieldLabel : 'Proveedor',
				emptyText : 'Proveedor...',
				store : new Ext.data.JsonStore({
					url : '../../sis_parametros/control/Proveedor/listarProveedorCombos',
					id : 'id_proveedor',
					root : 'datos',
					sortInfo : {
						field : 'desc_proveedor',
						direction : 'ASC'
					},
					fields : ['id_proveedor', 'desc_proveedor'],
					remoteSort : true,
					baseParams : {
						par_filtro : 'desc_proveedor'
					}
				}),
				disabled : true,
				valueField : 'id_proveedor',
				displayField : 'desc_proveedor',
				gdisplayField : 'nombre_proveedor',
				hiddenName : 'id_proveedor',
				forceSelection : true,
				typeAhead : true,
				triggerAction : 'all',
				lazyRender : true,
				mode : 'remote',
				pageSize : 10,
				queryDelay : 1000,
				anchor : '99%',
				enableMultiSelect : true,
				renderer : function(value, p, record) {
					return String.format('{0}', record.data['nombre_proveedor']);
				}
			},
			type : 'ComboBox',
			id_grupo : 1,
			grid : true,
			form : true
		},
		{
			config: {
				name: 'all_funcionario',
				fieldLabel: 'Seleccionar Criterio',
				anchor: '100%',
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'all_funcionario',
				gwidth: 100,
				tinit:false,
				disabled:true,
				baseParams:{
						cod_subsistema:'ORGA',
						catalogo_tipo:'tfuncionario__opciones'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['all_funcionario']);}
			},
			type: 'ComboRec',
			id_grupo: 1,
			grid: true,
			form: true
		},{
			config : {
				name : 'id_funcionario',
				fieldLabel : 'Funcionario',
				allowBlank : true,
				emptyText : 'Funcionarios...',
				store : new Ext.data.JsonStore({
					url : '../../sis_organigrama/control/Funcionario/listarFuncionario',
					id : 'id_funcionario',
					root : 'datos',
					sortInfo : {
						field : 'desc_person',
						direction : 'ASC'
					},
					totalProperty : 'total',
					fields : ['id_funcionario', 'desc_person'],
					remoteSort : true,
					baseParams : {
						par_filtro : 'person.nombre_completo1'
					}
				}),
				valueField : 'id_funcionario',
				hiddenValue: 'id_funcionario',
				displayField : 'desc_person',
				gdisplayField : 'nombre_funcionario',
				tpl : '<tpl for="."><div class="x-combo-list-item"><p>Nombre: {desc_person}</p></div></tpl>',
				hiddenName : 'id_funcionario',
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
					return String.format('{0}', record.data['nombre_funcionario']);
				},
				enableMultiSelect : true
				/*,
				tpl: new Ext.XTemplate(
					'<tpl for="."><div class="awesomecombo-item {checked}">',
					'{[this.wordwrap(values.', this.displayField || 'field1', ')]}',
					'</div></tpl>', {
						compiled: true,
						wordwrap: function(value) {
							if (value.length > 45) {
								return (value.substr(0, 45) + '...');
							}
							return (value);
						}
					})*/
			},
			type : 'AwesomeCombo',
			id_grupo : 1,
			grid : false,
			form : true
		},{
			config: {
				name: 'uo',
				fieldLabel: 'Organigrama',
				anchor: '100%'
			},
			type: 'TextArea',
			id_grupo: 1,
			grid: true,
			form: true
		},
		{
			config : {
				name : 'id_estructura_uo',
				inputType:'hidden',
				labelSeparator:'',
			},
			type:'Field',
			form:true
		}, 
		{
			config : {
				name : 'id_uo',
				inputType:'hidden',
				labelSeparator:'',
			},
			type:'Field',
			form:true
		}, 
		  {
			config: {
				name: 'all_items',
				fieldLabel: 'Seleccionar Criterio',
				anchor: '100%',
				allowBlank: false,
				origen: 'CATALOGO',
				gdisplayField: 'all_items',
				gwidth: 100,
				tinit:false,
				baseParams:{
						cod_subsistema:'ALM',
						catalogo_tipo:'titem__opciones'
				},
				renderer:function (value, p, record){return String.format('{0}', record.data['all_items']);}
			},
			type: 'ComboRec',
			id_grupo: 2,
			grid: true,
			form: true
		}, 
		{
			config : {
				name : 'id_items',
				fieldLabel : 'Item',
				allowBlank : true,
				emptyText : 'Items...',
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
				//hiddenValue: 'id_item',
				displayField : 'nombre',
				gdisplayField : 'nombre_item',
				tpl : '<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p><p>Clasif.: {desc_clasificacion}</p></div></tpl>',
				hiddenName : 'id_items',
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
					return String.format('{0}', record.data['nombre_item']);
				},
				enableMultiSelect : true
			},
			type : 'AwesomeCombo',
			id_grupo : 2,
			grid : false,
			form : true
		},
		{
			config: {
				name: 'clasificacion',
				fieldLabel: 'Clasificación',
				anchor: '100%'
			},
			type: 'TextArea',
			id_grupo: 2,
			grid: true,
			form: true
		},
		{
			config : {
				name : 'id_clasificacion',
				inputType:'hidden',
				labelSeparator:'',
			},
			type:'Field',
			form:true
		},
		{
			config : {
				name : 'all_alm',
				fieldLabel : 'Todos los Almacenes',
				allowBlank : false,
				triggerAction : 'all',
				lazyRender : true,
				mode : 'local',
				store : new Ext.data.ArrayStore({
					fields : ['codigo', 'nombre'],
					data : [['si', 'Si'], ['no', 'No']]
				}),
				anchor : '50%',
				valueField : 'codigo',
				displayField : 'nombre'
			},
			type : 'ComboBox',
			id_grupo : 3,
			form : true
		},
		{
			config : {
				name : 'id_almacen',
				fieldLabel : 'Almacenes',
				allowBlank : true,
				emptyText : 'Almacenes...',
				store : new Ext.data.JsonStore({
					url : '../../sis_almacenes/control/Almacen/listarAlmacen',
					id : 'id_almacen',
					root : 'datos',
					sortInfo : {
						field : 'nombre',
						direction : 'ASC'
					},
					totalProperty : 'total',
					fields : ['id_almacen', 'nombre','codigo'],
					remoteSort : true,
					baseParams : {
						par_filtro: 'alm.nombre#alm.codigo'
					}
				}),
				valueField : 'id_almacen',
				//hiddenValue: 'id_item',
				displayField : 'nombre',
				gdisplayField : 'nombre',
				//tpl : '<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p><p>Clasif.: {desc_clasificacion}</p></div></tpl>',
				hiddenName : 'id_almacen',
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
					return String.format('{0}', record.data['nombre']);
				},
				enableMultiSelect : true
			},
			type : 'AwesomeCombo',
			id_grupo : 3,
			grid : false,
			form : true
		}],
		title : 'Generar Reporte',
		ActSave : '../../sis_almacenes/control/Reportes/listarItemEntRec',
		topBar : true,
		botones : false,
		labelSubmit : 'Imprimir',
		tooltipSubmit : '<b>Generar Reporte</b>',
		clasificacion : '',
		constructor : function(config) {
			Phx.vista.ItemEntRec.superclass.constructor.call(this, config);
			this.init();
			
			this.Cmp.all_items.on('select', function(e, component, index) {
			    if (e.value == 'Todos los Items') {
                    this.getComponente('id_items').disable();
                    this.getComponente('clasificacion').disable();
                    this.getComponente('id_items').allowBlank=true;
                    this.getComponente('clasificacion').allowBlank=true;
                    
                } else if(e.value == 'Seleccionar Items') {
                    this.getComponente('id_items').enable();
                    this.getComponente('clasificacion').disable();
                    this.getComponente('id_items').allowBlank=false;
                    this.getComponente('clasificacion').allowBlank=true;
                } else if(e.value == 'Por Clasificacion') {
                	this.getComponente('id_items').disable();
                    this.getComponente('clasificacion').enable();
                    this.getComponente('id_items').allowBlank=true;
                    this.getComponente('clasificacion').allowBlank=false;
                	
                } else{
                	this.getComponente('id_items').disable();
                    this.getComponente('clasificacion').disable();
                    this.getComponente('id_items').allowBlank=true;
                    this.getComponente('clasificacion').allowBlank=true;
                }
			}, this);
			
			this.Cmp.all_alm.on('select', function(e, component, index) {
				var cmbAlm = this.Cmp.id_almacen;
			    if (e.value == 'si') {
                    cmbAlm.disable();
                    cmbAlm.allowBlank=true;
                } else {
                    cmbAlm.enable();
                    cmbAlm.allowBlank=false;
                }
			}, this);
			
			this.Cmp.tipo_sol.on('select',function(e, component, index){
				if(e.value=='func'){
					this.Cmp.id_proveedor.disable();
					this.Cmp.all_funcionario.enable();
					this.Cmp.id_funcionario.disable();
					this.Cmp.uo.disable();
				} else{
					this.Cmp.id_proveedor.enable();
					this.Cmp.all_funcionario.disable()
					this.Cmp.id_funcionario.disable();
					this.Cmp.uo.disable();
				}
			},this);
			
			this.Cmp.all_funcionario.on('select',function(e, component, index){
				if(e.value=='Todos los Funcionarios'){
					this.Cmp.id_funcionario.disable();
					this.Cmp.uo.disable();
				} else if(e.value=='Seleccionar Funcionarios'){
					this.Cmp.id_funcionario.enable();
					this.Cmp.uo.disable();
				} else if(e.value=='Por Organigrama'){
					this.Cmp.id_funcionario.disable();
					this.Cmp.uo.enable();
				}
				
			},this);
			
			this.getComponente('id_items').disable();
			this.Cmp.clasificacion.on('focus',this.bntClasificacion,this);
			this.Cmp.clasificacion.setReadOnly(true);
			this.Cmp.uo.on('focus',this.btnUO,this);
			this.Cmp.uo.setReadOnly(true);
			
			//Obtencion de componentes
			this.uo=this.Cmp.uo;
			this.id_uo=this.Cmp.id_uo;
			this.id_estructura_uo=this.Cmp.id_estructura_uo;
			this.clasificacion = this.Cmp.clasificacion;
		},
		tipo : 'reporte',
		clsSubmit : 'bprint',
		Grupos : [{
			layout : 'column',
			items : [{
				xtype : 'fieldset',
				layout : 'form',
				border : true,
				title : 'Generar Reporte',
				bodyStyle : 'padding:0 10px 0;',
				columnWidth : '500px',
				items : [],
				id_grupo : 0,
				collapsible : false
			},{
				xtype : 'fieldset',
				layout : 'form',
				border : true,
				title : 'Seleccionar Solicitante',
				bodyStyle : 'padding:0 10px 0;',
				columnWidth : '500px',
				items : [],
				id_grupo : 1,
				collapsible : false
			},{
				xtype : 'fieldset',
				layout : 'form',
				border : true,
				title : 'Seleccionar Materiales',
				bodyStyle : 'padding:0 10px 0;',
				columnWidth : '500px',
				items : [],
				id_grupo : 2,
				collapsible : false
			},{
				xtype : 'fieldset',
				layout : 'form',
				border : true,
				title : 'Seleccionar Almacén',
				bodyStyle : 'padding:0 10px 0;',
				columnWidth : '500px',
				items : [],
				id_grupo : 3,
				collapsible : false
			}]
		}],
		bntClasificacion: function(){
			var data;
			//Valida que el combo de criterio sea por Clasificación
			if(this.Cmp.all_items.getValue()=='Por Clasificacion'){
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
			}
		},
		btnUO: function(){
			var data;
			//Valida que el combo de criterio sea por Clasificación
			if(this.Cmp.all_funcionario.getValue()=='Por Organigrama'){
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
			}
		},
		id_clasificacion:'',
		agregarArgsExtraSubmit: function(){
			//Inicializa el objeto de los argumentos extra
			this.argumentExtraSubmit={};
				//Añade los parámetros extra para mandar por submit
			this.argumentExtraSubmit.id_clasificacion=this.id_clasificacion;
		},
		onSubmit: function(){
			if (this.form.getForm().isValid()) {
				var data={};
				data.fecha_ini=this.Cmp.fecha_ini.getValue();
				data.fecha_fin=this.Cmp.fecha_fin.getValue();
				data.tipo_mov=this.Cmp.tipo_mov.getValue();
				data.tipo_sol=this.Cmp.tipo_sol.getValue();
				data.id_funcionario=this.Cmp.id_funcionario.getValue();
				data.id_proveedor=this.Cmp.id_proveedor.getValue();
				data.all_alm=this.Cmp.all_alm.getValue();
				data.id_items=this.Cmp.id_items.getValue();
				data.id_clasificacion=this.Cmp.id_clasificacion.getValue();
				data.all_items=this.Cmp.all_items.getValue();
				data.id_almacen=this.Cmp.id_almacen.getValue();
				data.all_funcionario=this.Cmp.all_funcionario.getValue();
				data.id_estructura_uo=this.Cmp.id_estructura_uo.getValue();
				
				console.log(data)
				Phx.CP.loadWindows('../../../sis_almacenes/vista/vista_reportes/repItemEntRec.php', 'Items Entregados/Recibidos', {
						width : '90%',
						height : '80%'
					}, data	, this.idContenedor, 'repItemEntRec')
			}
		}

})
</script>