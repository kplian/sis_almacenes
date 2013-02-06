<?php
/**
 *@package pXP
 *@file    Item.php
 *@author  Gonzalo Sarmiento
 *@date    21-09-2012
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.Item = Ext.extend(Phx.gridInterfaz, {
		constructor : function(config) {
			this.maestro = config.maestro;
			Phx.vista.Item.superclass.constructor.call(this, config);
			this.init();
			this.tbar.items.get('b-new-' + this.idContenedor).hide();
			this.grid.getTopToolbar().disable();
			this.grid.getBottomToolbar().disable();
			this.store.removeAll();
			this.addButton('btnGenerarCodigo',
            {
                text: 'Generar Código',
                iconCls: 'blist',
                disabled: true,
                handler: this.btnGenerarCodigoHandler,
                tooltip: '<b>Actividades</b><br/>Generar Código del item'
            });
		},
		Atributos : [{
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_item'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				labelSerparator : '',
				inputType : 'hidden',
				name : 'id_clasificacion',
			},
			type : 'Field',
			form : true
		}, {
			config : {
				name : 'nombre',
				fieldLabel : 'Nombre',
				allowBlank : false,
				width : '100%',
				gwidth : 150,
				maxLength : 250
			},
			type : 'TextField',
			filters : {
				pfiltro : 'item.nombre',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'codigo',
				fieldLabel : 'Código',
				allowBlank : false,
				width : '100%',
				gwidth : 150,
				maxLength : 20
			},
			type : 'TextField',
			filters : {
				pfiltro : 'item.codigo',
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
				width : '100%',
				gwidth : 150,
				maxLength : 100
			},
			type : 'TextField',
			filters : {
				pfiltro : 'item.descripcion',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'palabras_clave',
				fieldLabel : 'Palabras clave',
				allowBlank : true,
				width : '100%',
				gwidth : 80,
				maxLength : 25
			},
			type : 'TextField',
			filters : {
				pfiltro : 'item.palabras_clave',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'codigo_fabrica',
				fieldLabel : 'Código de fábrica',
				allowBlank : true,
				width : '100%',
				gwidth : 100,
				maxLength : 10
			},
			type : 'TextField',
			filters : {
				pfiltro : 'item.codigo_fabrica',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}, {
			config : {
				name : 'numero_serie',
				fieldLabel : 'No. de Serie',
				allowBlank : true,
				width : '100%',
				gwidth : 90,
				maxLength : 20
			},
			type : 'TextField',
			filters : {
				pfiltro : 'item.numero_serie',
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
				width : '100%',
				gwidth : 100,
				maxLength : 200
			},
			type : 'TextArea',
			filters : {
				pfiltro : 'item.observaciones',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : true
		}],
		title : 'Item',
		ActSave : '../../sis_almacenes/control/Item/insertarItem',
		ActDel : '../../sis_almacenes/control/Item/eliminarItem',
		ActList : '../../sis_almacenes/control/Item/listarItem',
		id_store : 'id_item',
		fields : [{
			name : 'id_item'
		}, {
			name : 'id_clasificacion'
		}, {
			name : 'codigo',
			type : 'string'
		}, {
			name : 'nombre',
			type : 'string'
		}, {
			name : 'descripcion',
			type : 'string'
		}, {
			name : 'palabras_clave',
			type : 'string'
		}, {
			name : 'codigo_fabrica',
			type : 'string'
		}, {
			name : 'observaciones',
			type : 'string'
		}, {
			name : 'numero_serie',
			type : 'string'
		}],
		sortInfo : {
			field : 'id_item',
			direction : 'ASC'
		},
		bdel : true,
		bsave : false,
		fwidth : 400,
		loadValoresIniciales : function() {
			Phx.vista.Item.superclass.loadValoresIniciales.call(this);
			if (this.maestro.id_clasificacion != undefined) {
			    this.getComponente('id_clasificacion').setValue(this.maestro.id_clasificacion);
			}
		},
		onReloadPage : function(m) {
		    this.getBoton('btnGenerarCodigo').disable();
			this.maestro = m;
			var myParams = {
				start : 0,
				limit : 50
			};
			if (this.maestro.tipo_nodo == 'raiz' || this.maestro.tipo_nodo == 'hijo') {
				myParams.id_clasificacion = this.maestro.id_clasificacion;
				this.tbar.items.get('b-new-' + this.idContenedor).show();
			} else if (this.maestro.tipo_nodo == 'item') {
				myParams.id_item = this.maestro.id_item;
				this.tbar.items.get('b-new-' + this.idContenedor).hide();
			} else {
			    this.tbar.items.get('b-new-' + this.idContenedor).show();
				myParams.id_clasificacion = 'null';
			}
			this.load({
				params : myParams
			});
		},
		preparaMenu : function(n) {
			Phx.vista.Item.superclass.preparaMenu.call(this, n);
			var selectedRow = this.sm.getSelected();
			if(selectedRow.data.id_clasificacion != null && selectedRow.data.codigo == "") {
			    this.getBoton('btnGenerarCodigo').enable();
			} else {
			    this.getBoton('btnGenerarCodigo').disable();
			}
		},
		liberaMenu: function(n) {
		    Phx.vista.Item.superclass.liberaMenu.call(this, n);
		    this.getBoton('btnGenerarCodigo').disable();
		},
		successSave : function(resp) {
			Phx.vista.Item.superclass.successSave.call(this, resp);
			this.actualizarNodosClasificacion();
		},
		successDel : function(resp) {
		    Phx.vista.Item.superclass.successDel.call(this, resp);
		    this.actualizarNodosClasificacion();
		},
		actualizarNodosClasificacion : function () {
		    var selectedNode = Phx.CP.getPagina(this.idContenedorPadre).sm.getSelectedNode();
            if (!selectedNode.leaf) {
                selectedNode.attributes.estado = 'restringido';
                selectedNode.reload();
            } else {
                selectedNode.parentNode.attributes.estado = 'restringido';
                selectedNode.parentNode.reload();
            }
		},
		btnGenerarCodigoHandler: function() {
            var rec = this.sm.getSelected();
            var data = rec.data;
            var global = this;
            Ext.Msg.confirm('Confirmación',
                '¿Está seguro de generar el código para este item?', 
                function(btn) {
                    if (btn == "yes") {
                        Ext.Ajax.request({
                            url:'../../sis_almacenes/control/Item/generarCodigoItem',
                            params: {
                                'id_item': data.id_item, 
                                'id_clasificacion': data.id_clasificacion
                            },
                            success: global.successSave,
                            failure: global.conexionFailure,
                            timeout: global.timeout,
                            scope: global
                    });
                    }
                }
            );
        }
	}); 
</script>