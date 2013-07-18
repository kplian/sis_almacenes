<?php
/**
 *@package pXP
 *@file gen-InventarioDet.php
 *@author  Ariel Ayaviri Omonte
 *@date 15-03-2013 21:26:02
 *@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
 */

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
	Phx.vista.InventarioDet = Ext.extend(Phx.gridInterfaz, {

		constructor : function(config) {
			this.bsave = true;
			if (config.nombreVista == 'EjecucionInventario') {
				this.Atributos[5].grid = false;
				this.Atributos[7].grid = false;
			}

			Phx.vista.InventarioDet.superclass.constructor.call(this, config);
			this.init();

			this.grid.getTopToolbar().disable();
			this.grid.getBottomToolbar().disable();
			this.store.removeAll();
		},
		Atributos : [{
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_inventario_det'
			},
			type : 'Field',
			form : true
		}, {
			config : {
				labelSeparator : '',
				inputType : 'hidden',
				name : 'id_inventario'
			},
			type : 'Field',
			form : true
		}, {
            config : {
                labelSeparator : '',
                inputType : 'hidden',
                name : 'id_almacen'
            },
            type : 'Field',
            form : true
        }, {
            config : {
                name : 'id_item',
                fieldLabel : 'Item',
                allowBlank : true,
                emptyText : 'Item...',
                store : new Ext.data.JsonStore({
                    url : '../../sis_almacenes/control/Item/listarItemNotBase',
                    id : 'id_item',
                    root : 'datos',
                    sortInfo : {
                        field : 'nombre',
                        direction : 'ASC'
                    },
                    totalProperty : 'total',
                    fields : ['id_item', 'nombre', 'codigo', 'desc_clasificacion'],
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
                gwidth : 100,
                minChars : 2,
                turl : '../../../sis_almacenes/vista/item/BuscarItem.php',
                tasignacion : true,
                tname : 'id_item',
                ttitle : 'Items',
                tdata : {},
                tcls : 'BuscarItem',
                pid : this.idContenedor,
                renderer : function(value, p, record) {
                    return String.format('{0}', record.data['nombre_item']);
                }
            },
            type : 'TrigguerCombo',
            id_grupo : 0,
            filters : {
                pfiltro : 'itm.nombre',
                type : 'string'
            },
            grid : true,
            form : true
        },{
            config : {
                name : 'id_clasificacion',
                fieldLabel : 'Clasificacion',
                allowBlank : true,
                emptyText : 'Clasificacion...',
                store : new Ext.data.JsonStore({
                    url : '../../sis_almacenes/control/Clasificacion/listarClasificacion',
                    id : 'id_clasificacion',
                    root : 'datos',
                    sortInfo : {
                        field : 'nombre',
                        direction : 'ASC'
                    },
                    totalProperty : 'total',
                    fields : ['id_clasificacion', 'nombre', 'codigo_largo'],
                    remoteSort : true,
                    baseParams : {
                        par_filtro : 'cla.nombre#cla.codigo_largo'
                    }
                }),
                valueField : 'id_clasificacion',
                displayField : 'nombre',
                tpl : '<tpl for="."><div class="x-combo-list-item"><p>Nombre: {nombre}</p><p>Código: {codigo_largo}</p></div></tpl>',
                hiddenName : 'id_clasificacion',
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
                turl : '../../../sis_almacenes/vista/clasificacion/BuscarClasificacion.php',
                tasignacion : true,
                tname : 'id_clasificacion',
                ttitle : 'Clasificacion',
                tdata : {},
                tcls : 'BuscarClasificacion',
                pid : this.idContenedor,
                renderer : function(value, p, record) {
                    return String.format('{0}', record.data['nombre_clasificaion']);
                }
            },
            type : 'TrigguerCombo',
            id_grupo : 0,
            filters : {
                pfiltro : 'itm.clasificacion',
                type : 'string'
            },
            grid : false,
            form : true
        }, 
        {
			config : {
				name : 'codigo_item',
				fieldLabel : 'Código',
				anchor : '100%',
				gwidth : 100,
			},
			type : 'TextField',
			filters : {
				pfiltro : 'itm.codigo',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'cantidad_sistema',
				fieldLabel : 'Cant. Sis.',
				allowBlank : true,
				anchor : '100%',
				gwidth : 100,
				maxLength : 1179650
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'dinv.cantidad_sistema',
				type : 'numeric'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'cantidad_real',
				fieldLabel : 'Cant.',
				allowBlank : true,
				anchor : '100%',
				gwidth : 100,
				maxLength : 1179650
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'dinv.cantidad_real',
				type : 'numeric'
			},
			id_grupo : 1,
			egrid : true,
			grid : true,
			form : true
		}, {
			config : {
				name : 'diferencia',
				fieldLabel : 'Diferencia',
				allowBlank : true,
				anchor : '100%',
				gwidth : 100,
				maxLength : 1179650
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'dinv.diferencia',
				type : 'numeric'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'observaciones',
				fieldLabel : 'Observaciones',
				allowBlank : true,
				anchor : '100%',
				gwidth : 100,
				maxLength : 1000
			},
			type : 'TextArea',
			filters : {
				pfiltro : 'dinv.observaciones',
				type : 'string'
			},
			id_grupo : 1,
			egrid : true,
			grid : true,
			form : true
		}, {
			config : {
				name : 'estado_reg',
				fieldLabel : 'Estado Reg.',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 10
			},
			type : 'TextField',
			filters : {
				pfiltro : 'dinv.estado_reg',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_reg',
				fieldLabel : 'Fecha creación',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				format : 'd/m/Y',
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y H:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'dinv.fecha_reg',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'usr_reg',
				fieldLabel : 'Creado por',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 4
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'usu1.cuenta',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'fecha_mod',
				fieldLabel : 'Fecha Modif.',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				format : 'd/m/Y',
				renderer : function(value, p, record) {
					return value ? value.dateFormat('d/m/Y H:i:s') : ''
				}
			},
			type : 'DateField',
			filters : {
				pfiltro : 'dinv.fecha_mod',
				type : 'date'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}, {
			config : {
				name : 'usr_mod',
				fieldLabel : 'Modificado por',
				allowBlank : true,
				anchor : '80%',
				gwidth : 100,
				maxLength : 4
			},
			type : 'NumberField',
			filters : {
				pfiltro : 'usu2.cuenta',
				type : 'string'
			},
			id_grupo : 1,
			grid : true,
			form : false
		}],
		title : 'Detalle Inventario',
		ActSave : '../../sis_almacenes/control/InventarioDet/insertarInventarioDet',
		ActDel : '../../sis_almacenes/control/InventarioDet/eliminarInventarioDet',
		ActList : '../../sis_almacenes/control/InventarioDet/listarInventarioDet',
		id_store : 'id_inventario_det',
		fields : [{
			name : 'id_inventario_det',
			type : 'numeric'
		}, {
			name : 'estado_reg',
			type : 'string'
		}, {
			name : 'id_item',
			type : 'numeric'
		}, {
			name : 'nombre_item',
			type : 'string'
		}, {
			name : 'codigo_item',
			type : 'string'
		}, {
			name : 'diferencia',
			type : 'numeric'
		}, {
			name : 'observaciones',
			type : 'string'
		}, {
			name : 'cantidad_real',
			type : 'numeric'
		}, {
			name : 'cantidad_sistema',
			type : 'numeric'
		}, {
			name : 'id_inventario',
			type : 'numeric'
		}, {
			name : 'fecha_reg',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s.u'
		}, {
			name : 'id_usuario_reg',
			type : 'numeric'
		}, {
			name : 'fecha_mod',
			type : 'date',
			dateFormat : 'Y-m-d H:i:s.u'
		}, {
			name : 'id_usuario_mod',
			type : 'numeric'
		}, {
			name : 'usr_reg',
			type : 'string'
		}, {
			name : 'usr_mod',
			type : 'string'
		}],
		sortInfo : {
			field : 'id_inventario_det',
			direction : 'ASC'
		},
		fwidth : 420,
		fheight : 320,
		loadValoresIniciales : function() {
			Phx.vista.InventarioDet.superclass.loadValoresIniciales.call(this);
			if (this.maestro.id_inventario != undefined) {
				this.getComponente('id_inventario').setValue(this.maestro.id_inventario);
				this.getComponente('id_almacen').setValue(this.maestro.id_almacen);
			}
		},
		onReloadPage : function(m) {
			this.maestro = m;

			if (this.nombreVista == 'OrdenInventario') {
				this.getComponente('cantidad_real').disable();
				this.getComponente('observaciones').disable();
				this.getBoton('save').hide();
				if (this.maestro.estado == 'borrador') {
					this.getBoton('edit').show();
					this.getBoton('del').show();
					this.getBoton('new').show();
				} else {
					this.getBoton('edit').hide();
					this.getBoton('del').hide();
					this.getBoton('new').hide();
				}
			} else if (this.nombreVista == 'EjecucionInventario') {
				this.getComponente('id_item').disable();
				this.getComponente('id_clasificacion').disable();
				if (this.maestro.estado == 'pendiente_ejecucion' || this.maestro.estado == 'pendiente_correccion') {
					this.getBoton('save').hide();
					this.getBoton('edit').hide();
					this.getBoton('del').hide();
					this.getBoton('new').hide();
				} else if (this.maestro.estado == 'ejecucion') {
					this.getBoton('save').show();
					this.getBoton('edit').show();
					this.getBoton('del').hide();
					this.getBoton('new').hide();
				}
			}

			this.store.baseParams = {
				id_inventario : this.maestro.id_inventario
			};
			this.load({
				params : {
					start : 0,
					limit : 50
				}
			})
		}
	})
</script>

