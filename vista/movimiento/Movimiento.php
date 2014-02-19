<?php
/**
 *@package PXP
 *@file Movimiento.php
 *@author  Ariel Ayaviri Omonte
 *@date 18-02-2013
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.Movimiento = Ext.extend(Phx.gridInterfaz, {
		tam_pag:50,

		constructor : function(config) {
			this.maestro = config.maestro;
			this.initButtons=[this.cmbMovimientoTipo];
			Phx.vista.Movimiento.superclass.constructor.call(this, config);
			this.init();
			//this.load({params:{start:0, limit:this.tam_pag}})

			//Eventos
			this.Cmp.tipo.on('select', this.onTipoSelect, this);
			this.Cmp.id_movimiento_tipo.on('select', this.onMovimientoTipoSelect, this);
			this.Cmp.solicitante.on('select', this.onSolicitanteSelect, this);
			this.cmbMovimientoTipo.on('select', function(){
			    if(this.validarFiltros()){
	                  this.aplicarFiltros();
	           	}},this
			);
			this.Cmp.id_proveedor.hide();
			
			this.addButton('btnReport', {
				text : '',
				iconCls : 'bpdf32',
				disabled : true,
				handler : function() {
					var rec = this.sm.getSelected();
					Phx.CP.loadingShow();
					Ext.Ajax.request({
						url : '../../sis_almacenes/control/Movimiento/generarReporteMovimiento',
						params : {
							'id_movimiento' : rec.data.id_movimiento
						},
						success : this.successExport,
						failure : this.conexionFailure,
						timeout : this.timeout,
						scope : this
					});
				},
				tooltip : '<b>Reporte de Movimiento</b><br/>Generar el reporte del Movimiento Seleccionado.'
			});
	
			//Botones
			this.addButton('btnCancelar', {
				text : 'Cancelar',
				iconCls : 'block',
				disabled : true,
				handler : this.onBtnCancelar,
				tooltip : '<b>Cancelar Movimiento</b>'
			});

			this.addButton('btnRevertir', {
				text : 'Revertir a Borrador',
				iconCls : 'breload2',
				disabled : true,
				handler : this.onBtnRevertir,
				tooltip : '<b>Revertir Movimiento</b><br>Revierte un movimiento finalizado a Borrador'
			});

			this.addButton('btnRevertirPreing', {
				text : 'Revertir Preingreso',
				iconCls : 'breload1',
				disabled : true,
				handler : this.onBtnRevertirPreing,
				tooltip : '<b>Revertir Preingreso</b><br>En caso de que el Ingreso haya sido generado desde un Preingreso, revierte todo el ingreso'
			});
			
			this.Cmp.id_depto_conta.setVisible(false);
			this.Cmp.id_depto_conta.disable();
			this.Cmp.id_depto_conta.allowBlank=true;
			
		},

		Atributos : [{
			config : {
				name : 'id_movimiento',
				labelSeparator : '',
				inputType : 'hidden'
			},
			type : 'Field',
			form : true
		},		
		{
            //configuracion del componente
            config:{
                    labelSeparator:'',
                    inputType:'hidden',
                    name: 'id_gestion'
            },
            type:'Field',
            form:true 
        }, {
			config : {
				name : 'tipo',
				fieldLabel : 'Tipo',
				allowBlank : false,
				triggerAction : 'all',
				lazyRender : true,
				mode : 'local',
				store : new Ext.data.ArrayStore({
					fields : ['codigo', 'nombre'],
					data : [['ingreso', 'Ingreso'], ['salida', 'Salida']]
				}),
				anchor : '100%',
				valueField : 'codigo',
				displayField : 'nombre',
				gwidth:60
			},
			type : 'ComboBox',
			id_grupo : 1,
			form : true,
			grid : true,
			filters: {
				pfiltro: 'movtip.tipo',
				type: 'string'
			}
		},  
		{
			config : {
				name : 'estado_mov',
				fieldLabel : 'Estado',
				allowBlank : false,
				anchor : '100%',
				gwidth : 100,
				maxLength : 10,
				scope:this,
				renderer: function(value, p, record){
					var aux;
					if(record.data.tipo=='salida'){
						aux='<b><font color="brown">';
					}
					else {
						aux='<b><font color="green">';
					}
					aux = aux +value+'</font></b>';
					return String.format('{0}', aux);
				}
			},
			type : 'TextField',
			filters : {
				pfiltro : 'mov.estado_mov',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_mov',
				fieldLabel : 'Fecha',
				allowBlank : false,
				gwidth : 100,
				format : 'd/m/Y',
				renderer: function(value, p, record){
					var aux,desc;
					if(record.data.tipo=='salida'){
						aux='<b><font color="brown">';
					}
					else {
						aux='<b><font color="green">';
					}
					desc=value ? value.dateFormat('d/m/Y h:i:s') : '';
					aux = aux +desc+'</font></b>';
					return String.format('{0}', aux);
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'mov.fecha_mov',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'id_movimiento_tipo',
				fieldLabel : 'Movimiento Tipo',
				allowBlank : false,
				emptyText : 'Movimiento Tipo...',
				store : new Ext.data.JsonStore({
					url : '../../sis_almacenes/control/MovimientoTipo/listarMovimientoTipo',
					id : 'id_movimiento_tipo',
					root : 'datos',
					sortInfo : {
						field : 'nombre',
						direction : 'ASC'
					},
					totalProperty : 'total',
					fields : ['id_movimiento_tipo', 'nombre', 'codigo'],
					remoteSort : true,
					baseParams : {
						par_filtro : 'movtip.nombre#movtip.codigo'
					}
				}),
				valueField : 'id_movimiento_tipo',
				displayField : 'nombre',
				gdisplayField : 'nombre_movimiento_tipo',
				tpl : '<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo}</p></div></tpl>',
				hiddenName : 'id_movimiento_tipo',
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
					var aux;
					if(record.data.tipo=='salida'){
						aux='<b><font color="brown">';
					}
					else {
						aux='<b><font color="green">';
					}
					aux = aux +record.data['nombre_movimiento_tipo']+'</font></b>';
					return String.format('{0}', aux);
				}
			},
			type : 'ComboBox',
			id_grupo : 0,
			filters : {
				pfiltro : 'movtip.nombre',
				type : 'string'
			},
			grid : true,
			form : true
		}, {
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
				renderer: function(value, p, record){
					var aux;
					if(record.data.tipo=='salida'){
						aux='<b><font color="brown">';
					}
					else {
						aux='<b><font color="green">';
					}
					aux = aux +record.data['nombre_almacen']+'</font></b>';
					return String.format('{0}', aux);
				}
			},
			type : 'ComboBox',
			id_grupo : 0,
			filters : {
				pfiltro : 'almo.nombre',
				type : 'string'
			},
			grid : true,
			form : true
		}, {
			config : {
				name : 'codigo',
				fieldLabel : 'Código',
				allowBlank : true,
				anchor : '100%',
				gwidth : 160,
				maxLength : 30,
				renderer: function(value, p, record){
					var aux;
					if(record.data.tipo=='salida'){
						aux='<b><font color="brown">';
					}
					else {
						aux='<b><font color="green">';
					}
					aux = aux +value+'</font></b>';
					return String.format('{0}', aux);
				}
			},
			type : 'TextField',
			filters : {
				pfiltro : 'mov.codigo',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
            config : {
                name : 'descripcion',
                fieldLabel : 'Descripción',
                allowBlank : true,
                anchor : '100%',
                gwidth : 250,
                maxLength : 1000,
                renderer: function(value, p, record){
					var aux;
					if(record.data.tipo=='salida'){
						aux='<b><font color="brown">';
					}
					else {
						aux='<b><font color="green">';
					}
					aux = aux +value+'</font></b>';
					return String.format('{0}', aux);
				}
            },
            type : 'TextArea',
            filters : {
                pfiltro : 'mov.descripcion',
                type : 'string'
            },
            id_grupo : 1,
            grid : true,
            form : true
        }, {
            config : {
                name : 'observaciones',
                fieldLabel : 'Observaciones',
                allowBlank : true,
                anchor : '100%',
                gwidth : 200,
                maxLength : 1000,
                renderer: function(value, p, record){
					var aux;
					if(record.data.tipo=='salida'){
						aux='<b><font color="brown">';
					}
					else {
						aux='<b><font color="green">';
					}
					aux = aux +value+'</font></b>';
					return String.format('{0}', aux);
				}
            },
            type : 'TextArea',
            filters : {
                pfiltro : 'mov.observaciones',
                type : 'string'
            },
            id_grupo : 1,
            grid : true,
            form : true
        }, {
			config : {
				name : 'solicitante',
				fieldLabel : 'Solicitante',
				allowBlank : false,
				triggerAction : 'all',
				lazyRender : true,
				mode : 'local',
				store : new Ext.data.ArrayStore({
					fields : ['codigo', 'nombre'],
					data : [['funcionario', 'Funcionario'], ['proveedor', 'Proveedor']]
				}),
				disabled : true,
				hidden : true,
				anchor : '99%',
				valueField : 'codigo',
				displayField : 'nombre'
			},
			type : 'ComboBox',
			id_grupo : 1,
			form : true,
			grid : false
		}, 
		//RCM: comentado para deshabilitar el filtro por tipo de movimiento
		/*{
   			config:{
       		    name:'id_funcionario',
       		    hiddenName: 'id_funcionario',
   				origen:'FUNCIONARIOCAR',
   				fieldLabel:'Funcionario',
   				allowBlank:false,
                gwidth:200,
   				valueField: 'id_funcionario',
   			    gdisplayField: 'nombre_funcionario',
   			    baseParams: { es_combo_solicitud : 'si',fecha: new Date(), id_movimiento_tipo:0 },
      			//renderer:function(value, p, record){return String.format('{0}', record.data['nombre_funcionario']);},
      			url:'../../sis_almacenes/control/Movimiento/listarFuncionarioMovimientoTipo',
      			renderer: function(value, p, record){
					var aux;
					if(record.data.tipo=='salida'){
						aux='<b><font color="brown">';
					}
					else {
						aux='<b><font color="green">';
					}
					aux = aux +record.data['nombre_funcionario']+'</font></b>';
					return String.format('{0}', aux);
				}
       	     },
   			type:'ComboRec',//ComboRec
   			id_grupo:0,
   			filters:{pfiltro:'fun.desc_funcionario1',type:'string'},
   		    grid:true,
   			form:true
		 },*/
		 
		 {
   			config:{
       		    name:'id_funcionario',
       		    hiddenName: 'id_funcionario',
   				origen:'FUNCIONARIO',
   				fieldLabel:'Funcionario',
   				allowBlank:false,
                gwidth:200,
   				valueField: 'id_funcionario',
   			    gdisplayField: 'nombre_funcionario',
   			    baseParams: { es_combo_solicitud : 'si',fecha: new Date(), id_movimiento_tipo:0 },
      			//renderer:function(value, p, record){return String.format('{0}', record.data['nombre_funcionario']);},
      			renderer: function(value, p, record){
					var aux;
					if(record.data.tipo=='salida'){
						aux='<b><font color="brown">';
					}
					else {
						aux='<b><font color="green">';
					}
					aux = aux +record.data['nombre_funcionario']+'</font></b>';
					return String.format('{0}', aux);
				}
       	     },
   			type:'ComboRec',//ComboRec
   			id_grupo:0,
   			filters:{pfiltro:'fun.desc_funcionario1',type:'string'},
   		    grid:true,
   			form:true
		 },
		 
		  {
			config : {
				name : 'id_proveedor',
				fieldLabel : 'Proveedor',
				allowBlank : false,
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
				//hidden : true,
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
				gwidth: 200,
				renderer: function(value, p, record){
					var aux;
					if(record.data.tipo=='salida'){
						aux='<b><font color="brown">';
					}
					else {
						aux='<b><font color="green">';
					}
					aux = aux +record.data['nombre_proveedor']+'</font></b>';
					return String.format('{0}', aux);
				}
			},
			type : 'ComboBox',
			id_grupo : 0,
			filters : {
				pfiltro : 'person.nombre_completo1',
				type : 'string'
			},
			grid : true,
			form : true
		}, {
            config : {
                name : 'id_almacen_dest',
                fieldLabel : 'Almacen Destino',
                allowBlank : true,
                emptyText : 'Almacen Destino...',
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
                hidden : true,
                valueField : 'id_almacen',
                displayField : 'nombre',
                gdisplayField : 'nombre_almacen_destino',
                hiddenName : 'id_almacen_dest',
                forceSelection : true,
                typeAhead : false,
                triggerAction : 'all',
                lazyRender : true,
                mode : 'remote',
                pageSize : 10,
                queryDelay : 1000,
                anchor : '99%',
                gwidth : 100,
                minChars : 2,
                renderer : function(value, p, record) {
                    return String.format('{0}', record.data['nombre_almacen_destino']);
                }
            },
            type : 'ComboBox',
            id_grupo : 0,
            filters : {
                pfiltro : 'almd.nombre',
                type : 'string'
            },
            grid : true,
            form : true
        }, {
            config : {
                name : 'id_movimiento_origen',
                fieldLabel : 'Movimiento Origen',
                allowBlank : false,
                emptyText : 'Movimiento Origen...',
                store : new Ext.data.JsonStore({
                    url : '../../sis_almacenes/control/Movimiento/listarMovimiento',
                    id : 'id_movimiento',
                    root : 'datos',
                    sortInfo : {
                        field : 'mov.id_movimiento',
                        direction : 'ASC'
                    },
                    totalProperty : 'total',
                    fields : ['id_movimiento', 'codigo'],
                    remoteSort : true,
                    baseParams : {
                        par_filtro : 'mov.codigo',
                        estado_mov : 'finalizado',
                        tipo : 'salida'
                    }
                }),
                disabled : true,
                hidden : true,
                valueField : 'id_movimiento',
                displayField : 'codigo',
                gdisplayField : 'codigo_origen',
                hiddenName : 'id_movimiento_origen',
                forceSelection : true,
                typeAhead : false,
                triggerAction : 'all',
                lazyRender : true,
                mode : 'remote',
                pageSize : 10,
                queryDelay : 1000,
                anchor : '99%',
                gwidth : 150,
                minChars : 2,
                renderer : function(value, p, record) {
                    return String.format('{0}', record.data['codigo_origen']);
                }
            },
            type : 'ComboBox',
            id_grupo : 0,
            filters : {
                pfiltro : 'movorig.codigo',
                type : 'string'
            },
            grid : true,
            form : true
        }, {
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
				renderer: function(value, p, record){
					var aux;
					if(record.data.tipo=='salida'){
						aux='<b><font color="brown">';
					}
					else {
						aux='<b><font color="green">';
					}
					aux = aux +record.data['nombre_depto']+'</font></b>';
					return String.format('{0}', aux);
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
			config : {
				name : 'usr_reg',
				fieldLabel : 'Usuario reg.',
				anchor : '80%',
				gwidth : 100,
			},
			type : 'TextField',
			id_grupo : 1,
			filters : {
				pfiltro : 'usu1.cuenta',
				type : 'string'
			},
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_reg',
				fieldLabel : 'Fecha creación',
				anchor : '80%',
				gwidth : 100,
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'mov.fecha_reg',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'usr_mod',
				fieldLabel : 'Usuario mod.',
				anchor : '80%',
				gwidth : 100,
			},
			type : 'TextField',
			id_grupo : 1,
			filters : {
				pfiltro : 'usu1.cuenta',
				type : 'string'
			},
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_mod',
				fieldLabel : 'Fecha Modif.',
				anchor : '80%',
				gwidth : 90,
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y h:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'mov.fecha_mod',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}],
		title : 'Movimientos',
		ActSave : '../../sis_almacenes/control/Movimiento/insertarMovimiento',
		ActDel : '../../sis_almacenes/control/Movimiento/eliminarMovimiento',
		ActList : '../../sis_almacenes/control/Movimiento/listarMovimiento',
		id_store : 'id_movimiento',
		fields : [{
			name : 'id_movimiento',
			type : 'numeric'
		}, {
			name : 'tipo',
			type : 'string'
		}, {
			name : 'id_movimiento_tipo',
			type : 'numeric'
		}, {
			name : 'nombre_movimiento_tipo',
			type : 'string'
		}, {
			name : 'id_funcionario',
			type : 'numeric'
		}, {
			name : 'nombre_funcionario',
			type : 'string'
		}, {
			name : 'id_proveedor',
			type : 'numeric'
		}, {
			name : 'nombre_proveedor',
			type : 'string'
		}, {
			name : 'id_almacen',
			type : 'numeric'
		}, {
			name : 'nombre_almacen',
			type : 'string'
		}, {
			name : 'id_almacen_dest',
			type : 'numeric'
		}, {
			name : 'nombre_almacen_destino',
			type : 'string'
		}, {
			name : 'fecha_mov',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s'
		}, {
			name : 'codigo',
			type : 'string'
		}, {
			name : 'descripcion',
			type : 'string'
		}, {
			name : 'observaciones',
			type : 'string'
		}, {
			name : 'id_movimiento_origen'
		}, {
			name : 'codigo_origen',
			type : 'string'
		}, {
			name : 'id_estado_wf',
			type : 'numeric'
		},{
			name : 'estado_mov',
			type : 'string'
		}, {
			name : 'usr_reg',
			type : 'string'
		}, {
			name : 'fecha_reg',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s'
		}, {
			name : 'usr_mod',
			type : 'string'
		}, {
			name : 'fecha_mod',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s'
		},
		{name : 'id_depto_conta',type : 'numeric'},
		{name : 'nombre_depto',type : 'string'},
			],
		sortInfo : {
			field : 'mov.fecha_mov DESC ,mov.fecha_mod',
			direction : 'DESC'
		},
		bdel : true,
		bsave : false,
		fwidth : '60%',
		fheight : '80%',
		south : {
			url : '../../../sis_almacenes/vista/movimientoDetalle/MovimientoDetalle.php',
			title : 'Detalle de Movimiento',
			height : '50%',
			cls : 'MovimientoDetalle'
		},
		onTipoSelect : function(e, component, index) {
			this.setFiltroMovTipo(e.value);
		},
		setFiltroMovTipo: function(pTipo){
			if (pTipo == 'ingreso') {
				//this.getComponente('solicitante').setVisible(false);
				//this.getComponente('solicitante').disable();
				this.Cmp.id_depto_conta.setVisible(true);
				this.Cmp.id_depto_conta.enable();
				this.Cmp.id_depto_conta.allowBlank=false;
			} else {
				//this.getComponente('solicitante').setVisible(true);
				//this.getComponente('solicitante').enable();
				this.Cmp.id_depto_conta.setVisible(false);
				this.Cmp.id_depto_conta.disable();
				this.Cmp.id_depto_conta.allowBlank=true;
			}
			this.getComponente('id_almacen_dest').setVisible(false);
			this.getComponente('id_movimiento_tipo').reset();
			this.getComponente('id_movimiento_tipo').lastQuery = null;
			this.getComponente('id_movimiento_tipo').store.baseParams.tipo = pTipo;			
		},
		onMovimientoTipoSelect : function(e, component, index) {
			if (this.getComponente('tipo').value.indexOf('salida') != -1 && component.data.nombre.toLowerCase().indexOf('transferencia') != -1) {
				this.getComponente('id_almacen_dest').reset();
				this.getComponente('id_almacen_dest').lastQuery = null;
				this.getComponente('id_almacen_dest').setVisible(true);
			} else if (this.getComponente('tipo').value.indexOf('ingreso') != -1 && component.data.nombre.toLowerCase().indexOf('devol') != -1) {
				this.getComponente('id_movimiento_origen').reset();
				this.getComponente('id_movimiento_origen').lastQuery = null;
				this.getComponente('id_movimiento_origen').enable();
				this.getComponente('id_movimiento_origen').setVisible(true);
			} else {
				this.getComponente('id_almacen_dest').setVisible(false);
				this.getComponente('id_movimiento_origen').disable();
				this.getComponente('id_movimiento_origen').setVisible(false);
			}
			
			//Setea el store del funcionario
			Ext.apply(this.Cmp.id_funcionario.store.baseParams,{id_movimiento_tipo: component.data.id_movimiento_tipo})
			this.Cmp.id_funcionario.setValue('');
			this.Cmp.id_funcionario.modificado=true;
		},
		onSolicitanteSelect : function(e, component, index) {
			if (e.value == 'funcionario') {
				this.getComponente('id_proveedor').disable();
				this.getComponente('id_proveedor').setVisible(false);

				this.getComponente('id_funcionario').reset();
				this.getComponente('id_funcionario').lastQuery = null;
				this.getComponente('id_funcionario').setVisible(true);
				this.getComponente('id_funcionario').enable();
			} else {
				this.getComponente('id_funcionario').disable();
				this.getComponente('id_funcionario').setVisible(false);

				this.getComponente('id_proveedor').reset();
				this.getComponente('id_proveedor').lastQuery = null;
				this.getComponente('id_proveedor').setVisible(true);
				this.getComponente('id_proveedor').enable();
			}
		},
		preparaMenu : function(n) {
			var tb = Phx.vista.Movimiento.superclass.preparaMenu.call(this);
			var data = this.getSelectedData();
			this.getBoton('btnReport').enable();
			if (data.estado_mov == 'finalizado' || data.estado_mov == 'cancelado') {				
				this.getBoton('btnCancelar').disable();
				if (data.estado_mov == 'finalizado') {
					this.getBoton('btnRevertir').enable();
				}
				this.getBoton('edit').disable();
				this.getBoton('del').disable();
			} else {
				this.getBoton('btnCancelar').enable();
				this.getBoton('btnRevertir').disable();
			}
			//Boton reversión Preingreso
			this.getBoton('btnRevertirPreing').hide();
			if(data.id_preingreso){
				if(data.estado_mov=='borrador'){
					this.getBoton('btnRevertirPreing').show();
				} 
			} 
			
			return tb;
		},
		liberaMenu : function() {
			var tb = Phx.vista.Movimiento.superclass.liberaMenu.call(this);
			this.getBoton('btnCancelar').disable();
   			this.getBoton('btnRevertir').disable();
			this.getBoton('btnReport').disable();
			this.getBoton('btnRevertirPreing').hide();
			return tb;
		},
		onBtnCancelar : function() {
			var rec = this.sm.getSelected();
			var data = rec.data;
			var global = this;
			Ext.Msg.confirm('Confirmación', '¿Está seguro de Cancelar este movimiento?', function(btn) {
				if (btn == "yes") {
					Ext.Ajax.request({
						url : '../../sis_almacenes/control/Movimiento/cancelarMovimiento',
						params : {
							'id_movimiento' : data.id_movimiento
						},
						success : global.successSave,
						failure : global.conexionFailure,
						timeout : global.timeout,
						scope : global
					});
				}
			});
		},
		onBtnRevertir : function() {
			var rec = this.sm.getSelected();
			var data = rec.data;
			var global = this;
			Ext.Msg.confirm('Confirmación', '¿Está seguro de Revertir este movimiento?', function(btn) {
				if (btn == "yes") {
					Ext.Ajax.request({
						url : '../../sis_almacenes/control/Movimiento/revertirMovimiento',
						params : {
							'id_movimiento' : data.id_movimiento,
							'id_almacen' : data.id_almacen,
							obs: 'Revertido por el usuario'
						},
						success : global.successSave,
						failure : global.conexionFailure,
						timeout : global.timeout,
						scope : global
					});
				}
			});
		},
		onButtonEdit : function() {
			Phx.vista.Movimiento.superclass.onButtonEdit.call(this);
			this.Cmp.tipo.disable();
			if (this.Cmp.tipo.value == 'salida') {
				this.Cmp.solicitante.enable();
				this.Cmp.solicitante.setVisible(true);
				if (this.Cmp.id_funcionario.value != null && this.Cmp.id_funcionario.value != undefined) {
					this.Cmp.solicitante.setValue('funcionario');
					this.Cmp.id_funcionario.enable();
					this.Cmp.id_funcionario.setVisible(true);
					this.Cmp.id_proveedor.disable();
					this.Cmp.id_proveedor.setVisible(false);
				} else if (this.Cmp.id_proveedor.value != null && this.Cmp.id_proveedor.value != undefined) {
					this.Cmp.solicitante.setValue('proveedor');
					this.Cmp.id_proveedor.enable();
					this.Cmp.id_proveedor.setVisible(true);
					this.Cmp.id_funcionario.disable();
					this.Cmp.id_funcionario.setVisible(false);
				}
				this.Cmp.id_movimiento_origen.disable();
				this.Cmp.id_movimiento_origen.setVisible(false);
				
				//Depto conta
				this.Cmp.id_depto_conta.setVisible(false);
				this.Cmp.id_depto_conta.disable();
				this.Cmp.id_depto_conta.allowBlank=true;
			} else if (this.Cmp.tipo.value == 'ingreso') {
				if (this.Cmp.id_movimiento_tipo.getRawValue().toLowerCase().indexOf('devol') != -1) {
					this.Cmp.id_movimiento_origen.enable();
					this.Cmp.id_movimiento_origen.setVisible(true);
				} else {
					this.Cmp.id_movimiento_origen.disable();
					this.Cmp.id_movimiento_origen.setVisible(false);
				}
				this.Cmp.solicitante.enable();
				this.Cmp.solicitante.setVisible(true);
				if (this.Cmp.id_funcionario.value != null && this.Cmp.id_funcionario.value != undefined) {
					this.Cmp.solicitante.setValue('funcionario');
					this.Cmp.id_funcionario.enable();
					this.Cmp.id_funcionario.setVisible(true);
					this.Cmp.id_proveedor.disable();
					this.Cmp.id_proveedor.setVisible(false);
				} else if (this.Cmp.id_proveedor.value != null && this.Cmp.id_proveedor.value != undefined) {
					this.Cmp.solicitante.setValue('proveedor');
					this.Cmp.id_proveedor.enable();
					this.Cmp.id_proveedor.setVisible(true);
					this.Cmp.id_funcionario.disable();
					this.Cmp.id_funcionario.setVisible(false);
				}
				
				//Depto conta
				this.Cmp.id_depto_conta.setVisible(true);
				this.Cmp.id_depto_conta.enable();
				this.Cmp.id_depto_conta.allowBlank=false;
			}
		},
		onButtonNew : function() {
			Phx.vista.Movimiento.superclass.onButtonNew.call(this);
			//valor por defecto
			this.Cmp.solicitante.setValue('Funcionario')
			
			this.Cmp.tipo.enable();
			this.Cmp.solicitante.enable();
			this.Cmp.solicitante.setVisible(true);
			this.Cmp.id_proveedor.disable();
			this.Cmp.id_proveedor.setVisible(false);
			this.Cmp.id_funcionario.enable();
			this.Cmp.id_funcionario.setVisible(true);
			this.Cmp.id_movimiento_origen.disable();
			this.Cmp.id_movimiento_origen.setVisible(false);
		},
		successSave : function(resp) {
			Phx.vista.Movimiento.superclass.successSave.call(this, resp);
			var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
			if (reg.ROOT.datos.alerts) {
				Phx.CP.loadWindows('../../../sis_parametros/vista/alarma/AlarmaFuncionario.php', 'Alarmas', {
					width : 800,
					height : 500
				}, null, this.idContenedor, 'AlarmaFuncionario');
			}
		},
		fin_requerimiento: function(){                   
            var d= this.sm.getSelected().data;
            Phx.CP.loadingShow();            
            Ext.Ajax.request({
                url:'../../sis_almacenes/control/Movimiento/finalizarMovimiento',
                params:{id_movimiento:d.id_movimiento, id_almacen:d.id_almacen,operacion:'verificar'},
                success:this.onFinalizarSol,
                failure: this.conexionFailure,
                timeout:this.timeout,
                scope:this
            });     
	},
	crearVentanaWF: function(){
		//Creación del formulario
   		this.formWF = new Ext.form.FormPanel({
            baseCls: 'x-plain',
            autoDestroy: true,
            layout: 'form',
            items: [{
                        xtype: 'combo',
                        name: 'id_tipo_estado',
                          hiddenName: 'id_tipo_estado',
                        fieldLabel: 'Siguiente Estado',
                        listWidth:280,
                        allowBlank: false,
                        emptyText:'Elija el estado siguiente',
                        store:new Ext.data.JsonStore(
                        {
                            url: '../../sis_workflow/control/TipoEstado/listarEstadoSiguiente',
                            id: 'id_tipo_estado',
                            root:'datos',
                            sortInfo:{
                                field:'tipes.codigo',
                                direction:'ASC'
                            },
                            totalProperty:'total',
                            fields: ['id_tipo_estado','codigo_estado','nombre_estado','tipo_asignacion'],
                            // turn on remote sorting
                            remoteSort: true,
                            baseParams:{par_filtro:'tipes.nombre_estado#tipes.codigo'}
                        }),
                        valueField: 'id_tipo_estado',
                        displayField: 'codigo_estado',
                        forceSelection:true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender:true,
                        mode:'remote',
                        pageSize:50,
                        queryDelay:500,
                        width:210,
                        gwidth:220,
                         listWidth:'280',
                        minChars:2,
                        tpl: '<tpl for="."><div class="x-combo-list-item"><p>{codigo_estado}</p>Prioridad: <strong>{nombre_estado}</strong> </div></tpl>'
                    
                    },
                    {
                        xtype: 'combo',
                        name: 'id_funcionario_wf',
                        hiddenName: 'id_funcionario_wf',
                        fieldLabel: 'Funcionario Resp.',
                        allowBlank: false,
                        emptyText:'Elija un funcionario',
                        listWidth:280,
                        store:new Ext.data.JsonStore(
                        {
                            url: '../../sis_workflow/control/TipoEstado/listarFuncionarioWf',
                            id: 'id_funcionario',
                            root:'datos',
                            sortInfo:{
                                field:'prioridad',
                                direction:'ASC'
                            },
                            totalProperty:'total',
                            fields: ['id_funcionario','desc_funcionario','prioridad'],
                            // turn on remote sorting
                            remoteSort: true,
                            baseParams:{par_filtro:'fun.desc_funcionario1'}
                        }),
                        valueField: 'id_funcionario',
                        displayField: 'desc_funcionario',
                        forceSelection:true,
                        typeAhead: false,
                        triggerAction: 'all',
                        lazyRender:true,
                        mode:'remote',
                        pageSize:50,
                        queryDelay:500,
                        width:210,
                        gwidth:220,
                         listWidth:'280',
                        minChars:2,
                        tpl: '<tpl for="."><div class="x-combo-list-item"><p>{desc_funcionario}</p>Prioridad: <strong>{prioridad}</strong> </div></tpl>'
                    
                    },{
                        name: 'obs',
                        xtype: 'textarea',
                        fieldLabel: 'Observaciones',
                        allowBlank: false,
                        anchor: '80%',
                        maxLength:500
                    }]
        });
        
        //Agarra los componentes en variables globales
        this.cmbFunWF =this.formWF.getForm().findField('id_funcionario_wf');
        this.cmbTipoEstWF =this.formWF.getForm().findField('id_tipo_estado');
        this.txtObs =this.formWF.getForm().findField('obs');
        
        //Eventos
        this.cmbFunWF.store.on('exception', this.conexionFailure);
        this.cmbTipoEstWF.store.on('exception', this.conexionFailure);
        this.cmbTipoEstWF.on('select',function(cmp,rec,ind){
        	if(rec.data.tipo_asignacion=='ninguno'){
        		this.cmbFunWF.allowBlank=true;
        		this.cmbFunWF.setValue('');
        		this.cmbFunWF.disable();
        	} else{
        		this.cmbFunWF.enable();
        		this.cmbFunWF.allowBlank=false;
	            Ext.apply(this.cmbFunWF.store.baseParams,{id_tipo_estado: this.cmbTipoEstWF.getValue()});
	            this.cmbFunWF.modificado=true;	
        	}
            
        },this);
        
        //Creación de la ventna
         this.winWF = new Ext.Window({
            title: 'Workflow',
            collapsible: true,
            maximizable: true,
            autoDestroy: true,
            width: 350,
            height: 200,
            layout: 'fit',
            plain: true,
            bodyStyle: 'padding:5px;',
            buttonAlign: 'center',
            items: this.formWF,
            modal:true,
            closeAction: 'hide',
            buttons: [{
                text: 'Guardar',
                handler:this.onWF,
                argument: this.opcionWF,
                scope:this
                
            },{
                text: 'Cancelar',
                handler:function(){this.winWF.hide()},
                scope:this
            }]
        });
   	},
   	onFinalizarSol:function(resp){
		Phx.CP.loadingHide();
        var d= this.sm.getSelected().data;
        var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
        var swWin=0;
        var swFun=0;
        var swEst=0;
		//console.log(reg)
        //Se verifica la respuesta de la verificación
        if(!reg.ROOT.error){
        	var data=reg.ROOT.datos;
        	//Verifica si hay alertas y pregunta si continuar
        	if(data.alertas!=''){
        		var v_aux = data.alertas+'\n\n¿Desea continuar de todos modos?';
        		if(!confirm(v_aux)){
        			return;
        		}
        	}
        	
        	//Obtiene la cantidad de estados posibles en el workflow
        	if(data.wf_cant_estados>1){
	       		swWin=1;
	       		swEst=1;
	       		swFun=1;
	       	}
	       	//Obtiene la cantidad de funcionarios posibles en el workflow 
        	if(data.wf_cant_funcionarios>1){
				swWin=1;
				swFun=1;
	       	} 
	       	//Verifica si hay que desplegar el formulario de WF
	       	if(swWin){
	       		//Habilita/Deshabilita los combos
	       		this.cmbTipoEstWF.disable();
	       		this.cmbFunWF.disable();
	       		this.txtObs.hide();
	       		this.cmbTipoEstWF.allowBlank=true;
	       		this.cmbFunWF.allowBlank=true;		
	       		this.txtObs.allowBlank=true;
	       		
	       		if(swEst){
	       			this.cmbTipoEstWF.enable();
	       			this.cmbTipoEstWF.allowBlank=false;		
	       		}
	       		if(swFun){
	       			this.cmbTipoEstWF.enable();
	       			this.cmbFunWF.enable();
	       			this.cmbTipoEstWF.allowBlank=false;
	       			this.cmbFunWF.allowBlank=false;		
	       		}
	       		//Setea parámetros del store de Estados
	       		Ext.apply(this.cmbTipoEstWF.store.baseParams,{id_tipo_proceso: data.id_tipo_proceso, id_tipo_estado_padre: data.id_tipo_estado_padre});
	       		
	       		//Setea parámetros del store de funcionarios
	       		Ext.apply(this.cmbFunWF.store.baseParams,{id_estado_wf: data.id_estado_wf, fecha: data.fecha, id_tipo_estado: data.wf_id_tipo_estado});

	       		//Muestra la ventana
	       		this.winWF.show();
	       	} else{
	       		//Se hace la llamda directa porque el WF no tiene bifurcaciones
	       		Phx.CP.loadingShow(); 
				Ext.Ajax.request({
					url:'../../sis_almacenes/control/Movimiento/finalizarMovimiento',
				  	params:{
				  		id_movimiento:d.id_movimiento,
				  		operacion:'siguiente',
				  		id_funcionario_wf:data.wf_id_funcionario,
				  		id_tipo_estado: data.wf_id_tipo_estado,
				  		id_almacen: d.id_almacen
				      },
				      success:this.successFinSol,
				      failure: this.conexionFailure,
				      timeout:this.timeout,
				      scope:this
				});
	       		
	       	}
        	
        	
    	} else{
            
            alert('ocurrio un error durante el proceso')
        }
    },
    successFinSol:function(resp){
        Phx.CP.loadingHide();
        if(this.winWF){
        	this.winWF.hide();
        }
        var reg = Ext.util.JSON.decode(Ext.util.Format.trim(resp.responseText));
        if(!reg.ROOT.error){
            this.reload();
        }else{
            alert('Ocurrió un error durante el proceso')
        }
	}, 
	
	onWF: function(res){
		//Llama a la función para ir al siguiente estado
   		Phx.CP.loadingShow(); 
   		var d= this.sm.getSelected().data;
		Ext.Ajax.request({
			url:'../../sis_almacenes/control/Movimiento/finalizarMovimiento',
		  	params:{
		  		id_movimiento:d.id_movimiento,
		  		operacion:'siguiente',
		  		id_tipo_estado: this.cmbTipoEstWF.getValue(),
		  		id_funcionario_wf:this.cmbFunWF.getValue(),
		  		id_almacen: d.id_almacen,
		  		obs: this.txtObs.getValue()
		      },
		      success:this.successFinSol,
		      failure: this.conexionFailure,
		      timeout:this.timeout,
		      scope:this
		});
	},
	
	opcionWF: function(){
		return {operacion:this.operacion};
	},
	onBtnRevertirPreing: function() {

		var rec = this.sm.getSelected();
		var data = rec.data;
		var global = this;
		Ext.Msg.confirm('Confirmación', '¿Está seguro de Revertir el Preingreso?', function(btn) {
			if (btn == "yes") {
				Ext.Ajax.request({
					url : '../../sis_almacenes/control/Movimiento/revertirPreingreso',
					params : {
						'id_movimiento' : data.id_movimiento,
						'id_almacen' : data.id_almacen,
						obs: 'Revertido por el usuario'
					},
					success : global.successSave,
					failure : global.conexionFailure,
					timeout : global.timeout,
					scope : global
				});
			}
		});
	},		
	
	cmbMovimientoTipo:new Ext.form.ComboBox({
        name: 'cmb_movimiento_tipo',
        fieldLabel: 'Filtrar',
        typeAhead: false,
        forceSelection: true,
        allowBlank: false,
        emptyText: 'Tipo de movimiento...',
        store: new Ext.data.JsonStore({
            url: '../../sis_parametros/control/Catalogo/listarCatalogoCombo',
            id: 'id_catalogo',
            root: 'datos',
            sortInfo: {
                field: 'descripcion',
                direction: 'ASC'
            },
            totalProperty: 'total',
            fields: ['id_catalogo','codigo','descripcion'],
            // turn on remote sorting
            remoteSort: true,
            baseParams: {
            	par_filtro: 'descripcion',
            	cod_subsistema:'ALM',
				catalogo_tipo:'tmovimiento__all_tipo_mov'
            }
        }),
        valueField: 'descripcion',
		displayField: 'descripcion',
		gdisplayField: 'catalogo',
		hiddenName: 'catalogo',
		forceSelection:true,
		typeAhead: false,
		triggerAction: 'all',
		lazyRender:true,
		mode:'remote',
		pageSize:10,
		queryDelay:1000,
		width:155,
		minChars:2
    }),
    validarFiltros:function(){
        if(this.cmbMovimientoTipo.isValid()){
            return true;
        }
        else{
            return false;
        }
        
    },
    aplicarFiltros: function(combo, record, index){
        this.store.baseParams.cmb_tipo_movimiento=this.cmbMovimientoTipo.getValue();
        this.load(); 
    }
    

})
</script>

